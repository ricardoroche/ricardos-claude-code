# Feature Development Workflow

Complete PRP (Prompt-Response-Pattern) workflow for implementing new features in Python FastAPI applications.

## Workflow Overview

**Prompt:**
```
"Implement [feature name] with [specific requirements]"
```

**Sequence:**
1. `implement-feature` agent activates
2. Creates Pydantic models in `src/models/`
3. Implements service layer in `src/services/`
4. Creates FastAPI endpoint in `src/api/v1/routes/`
5. Adds error handling and validation
6. Runs `/fix` to ensure code quality
7. Delegates to `write-unit-tests` for test coverage
8. `write-unit-tests` creates comprehensive test suite
9. Runs `/check` to verify tests pass
10. Ready for commit

## Expected Pattern

```python
# Models
src/models/api/feature_models.py
- FeatureRequest(BaseModel)
- FeatureResponse(BaseModel)
- Comprehensive validation

# Service
src/services/feature_service.py
- FeatureService class
- Async methods
- Error handling
- Type hints

# API
src/api/v1/routes/features.py
- Router with proper decorators
- Dependency injection
- OpenAPI documentation

# Tests
tests/unit/test_feature_service.py
tests/integration/test_feature_api.py
- Success scenarios
- Error scenarios
- Edge cases
- 85%+ coverage
```

## Success Criteria

- All files created and properly structured
- Type checking passes (`mypy .`)
- Linting passes (`ruff check .`)
- All tests pass (`pytest`)
- Coverage ≥ 85%
- Documentation complete

## Example Implementation

### Step 1: Pydantic Models

```python
from pydantic import BaseModel, Field, field_validator
from typing import Optional
from datetime import datetime
from decimal import Decimal

class PaymentRequest(BaseModel):
    """Payment creation request."""

    amount: Decimal = Field(
        ...,
        gt=0,
        decimal_places=2,
        description="Payment amount in USD"
    )
    currency: str = Field(
        default="USD",
        pattern="^[A-Z]{3}$",
        description="Three-letter currency code"
    )
    payment_method_id: str = Field(
        ...,
        description="Payment method to charge"
    )
    description: Optional[str] = Field(
        None,
        max_length=500,
        description="Payment description"
    )

    @field_validator('amount')
    @classmethod
    def validate_amount(cls, v: Decimal) -> Decimal:
        if v > Decimal("10000"):
            raise ValueError("Amount exceeds maximum")
        return v.quantize(Decimal("0.01"))

    class Config:
        json_schema_extra = {
            "example": {
                "amount": "99.99",
                "currency": "USD",
                "payment_method_id": "pm_123",
                "description": "Order #12345"
            }
        }

class PaymentResponse(BaseModel):
    """Payment response."""
    payment_id: str
    status: str
    amount: Decimal
    created_at: datetime
```

### Step 2: Service Layer

```python
from typing import Optional
import httpx
from decimal import Decimal
import logging

logger = logging.getLogger(__name__)

class PaymentService:
    """Service for handling payment operations."""

    def __init__(self, api_key: str):
        self.api_key = api_key
        self.base_url = "https://api.stripe.com/v1"

    async def create_payment(
        self,
        request: PaymentRequest,
        user_id: str
    ) -> PaymentResponse:
        """
        Create a new payment.

        Args:
            request: Payment request data
            user_id: User identifier for audit trail

        Returns:
            PaymentResponse with transaction details

        Raises:
            PaymentError: If payment processing fails
        """
        request_id = str(uuid.uuid4())

        try:
            async with httpx.AsyncClient() as client:
                response = await client.post(
                    f"{self.base_url}/charges",
                    headers={"Authorization": f"Bearer {self.api_key}"},
                    json={
                        "amount": int(request.amount * 100),
                        "currency": request.currency,
                        "source": request.payment_method_id,
                        "metadata": {"user_id": user_id}
                    },
                    timeout=30.0
                )
                response.raise_for_status()

                logger.info(
                    f"Payment created | request_id={request_id} | "
                    f"amount={request.amount}"
                )

                return PaymentResponse.model_validate(response.json())

        except httpx.HTTPStatusError as e:
            logger.error(
                f"Payment failed | request_id={request_id}",
                exc_info=True
            )
            raise PaymentError("Payment processing failed") from e
```

### Step 3: FastAPI Endpoint

```python
from fastapi import APIRouter, Depends, HTTPException, status
from typing import Annotated

router = APIRouter(prefix="/api/v1/payments", tags=["payments"])

def get_payment_service() -> PaymentService:
    return PaymentService(api_key=settings.stripe_api_key)

PaymentServiceDep = Annotated[PaymentService, Depends(get_payment_service)]

@router.post(
    "/",
    response_model=PaymentResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a payment",
    response_description="Payment created successfully"
)
async def create_payment(
    payment: PaymentRequest,
    current_user: User = Depends(get_current_user),
    payment_service: PaymentServiceDep
) -> PaymentResponse:
    """
    Create a new payment.

    - **amount**: Payment amount (max $10,000)
    - **currency**: Three-letter currency code
    - **payment_method_id**: Payment method to charge
    """
    try:
        return await payment_service.create_payment(payment, current_user.id)
    except PaymentError as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Payment processing failed"
        )
```

### Step 4: Tests

```python
import pytest
from decimal import Decimal
from unittest.mock import AsyncMock, patch

@pytest.fixture
def payment_service():
    return PaymentService(api_key="test_key")

@pytest.fixture
def valid_payment():
    return PaymentRequest(
        amount=Decimal("99.99"),
        currency="USD",
        payment_method_id="pm_123"
    )

@pytest.mark.asyncio
async def test_create_payment_success(payment_service, valid_payment):
    """Test successful payment creation."""
    with patch('httpx.AsyncClient') as mock_client:
        mock_response = AsyncMock()
        mock_response.json.return_value = {
            "id": "pay_123",
            "status": "succeeded",
            "amount": 9999,
            "created_at": "2025-01-15T10:30:00Z"
        }
        mock_client.return_value.__aenter__.return_value.post.return_value = mock_response

        result = await payment_service.create_payment(valid_payment, "user_123")

        assert result.payment_id == "pay_123"
        assert result.status == "succeeded"

@pytest.mark.parametrize("amount,error", [
    (Decimal("0"), "Amount must be positive"),
    (Decimal("-10"), "Amount must be positive"),
    (Decimal("10001"), "Amount exceeds maximum"),
])
def test_payment_validation_errors(amount, error):
    """Test payment validation with invalid amounts."""
    with pytest.raises(ValidationError, match=error):
        PaymentRequest(
            amount=amount,
            currency="USD",
            payment_method_id="pm_123"
        )
```

## Common Workflows

### 1. Creating a New API Endpoint

```bash
# Step 1: Use /api command
/api

# Step 2: Implement
# - Pydantic models in src/models/api/
# - Service logic in src/services/
# - FastAPI route in src/api/v1/routes/

# Step 3: Test
pytest tests/integration/test_api.py -v

# Step 4: Quality check
/check

# Step 5: Commit
git add .
git commit -m "Add payment history endpoint"
```

### 2. Implementing from Spec

```bash
# Step 1: Activate implement-feature agent
"Implement user payment history API from spec"

# Step 2: Agent implements:
# - Pydantic models
# - Service layer
# - FastAPI endpoint
# - Tests
# - Documentation

# Step 3: Review and test
pytest tests/ -v

# Step 4: Quality check
/check

# Step 5: Commit
git add .
git commit -m "Implement payment history feature"
```

## Best Practices

1. **Start with Models**: Define Pydantic models first for clear contracts
2. **Service Layer Logic**: Keep business logic in services, not endpoints
3. **Comprehensive Validation**: Use Pydantic validators for business rules
4. **Error Handling**: Catch specific exceptions, return appropriate HTTP codes
5. **Type Safety**: Full type hints on all functions and classes
6. **Documentation**: Docstrings on all public functions, OpenAPI docs on endpoints
7. **Test Coverage**: Aim for 85%+ coverage with unit and integration tests
8. **Security First**: Validate inputs, redact PII, use authentication
