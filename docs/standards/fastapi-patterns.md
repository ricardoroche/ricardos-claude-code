# FastAPI Patterns and Best Practices

Standard patterns for building FastAPI applications with proper structure, validation, and error handling.

## Endpoint Structure

```python
from fastapi import APIRouter, Depends, HTTPException, status
from typing import List

router = APIRouter(prefix="/api/v1/payments", tags=["payments"])

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
    payment_service: PaymentService = Depends()
) -> PaymentResponse:
    """
    Create a new payment.

    - **amount**: Payment amount (max $10,000)
    - **currency**: Three-letter currency code
    - **payment_method_id**: Payment method to charge
    """
    return await payment_service.create_payment(payment, current_user.id)
```

## Dependency Injection

```python
from fastapi import Depends
from typing import Annotated

# Service dependencies
def get_payment_service() -> PaymentService:
    return PaymentService()

PaymentServiceDep = Annotated[PaymentService, Depends(get_payment_service)]

# Database dependencies
async def get_db() -> AsyncGenerator[AsyncSession, None]:
    async with AsyncSession() as session:
        yield session

DbDep = Annotated[AsyncSession, Depends(get_db)]

# Usage
@router.post("/payments")
async def create_payment(
    data: PaymentRequest,
    service: PaymentServiceDep,
    db: DbDep
):
    pass
```

## Middleware

```python
from fastapi import Request
import time
import uuid

@app.middleware("http")
async def add_request_id(request: Request, call_next):
    """Add request ID to all requests."""
    request_id = str(uuid.uuid4())
    request.state.request_id = request_id

    response = await call_next(request)
    response.headers["X-Request-ID"] = request_id
    return response

@app.middleware("http")
async def log_requests(request: Request, call_next):
    """Log all requests with timing."""
    start_time = time.time()
    response = await call_next(request)
    duration = time.time() - start_time

    logger.info(
        f"{request.method} {request.url.path} | "
        f"status={response.status_code} | "
        f"duration={duration:.3f}s"
    )
    return response
```

## Error Handling

```python
from fastapi import HTTPException, status
from pydantic import BaseModel

# Custom exception hierarchy
class AppError(Exception):
    """Base application error."""
    pass

class ValidationError(AppError):
    """Data validation failed."""
    pass

class NotFoundError(AppError):
    """Resource not found."""
    pass

# Error response model
class ErrorResponse(BaseModel):
    error: str
    error_code: str
    request_id: str
    timestamp: str
    details: Optional[dict] = None

# Usage in FastAPI
@app.post("/payment")
async def create_payment(data: PaymentRequest):
    try:
        result = await payment_service.create(data)
        return result
    except ValidationError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={
                "error": str(e),
                "error_code": "VALIDATION_ERROR",
                "request_id": request_id
            }
        )
```

## Authentication

```python
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

security = HTTPBearer()

async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security)
) -> User:
    """Get current authenticated user from token."""
    token = credentials.credentials
    user = await verify_token(token)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid authentication credentials"
        )
    return user
```

## Rate Limiting

```python
from slowapi import Limiter
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)

@app.post("/api/login")
@limiter.limit("5/minute")
async def login(request: Request, credentials: LoginRequest):
    """Login endpoint with rate limiting."""
    pass
```

## Request/Response Models

```python
from pydantic import BaseModel, Field, EmailStr
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
    email: EmailStr = Field(..., description="Customer email")

    class Config:
        json_schema_extra = {
            "example": {
                "amount": "99.99",
                "currency": "USD",
                "email": "user@example.com"
            }
        }

class PaymentResponse(BaseModel):
    """Payment response."""
    payment_id: str
    status: str
    amount: Decimal
    created_at: datetime
```

## Background Tasks

```python
from fastapi import BackgroundTasks

def send_email_notification(email: str, payment_id: str):
    """Send payment confirmation email."""
    # Email sending logic
    pass

@router.post("/payments")
async def create_payment(
    payment: PaymentRequest,
    background_tasks: BackgroundTasks
):
    result = await payment_service.create(payment)

    # Send email in background
    background_tasks.add_task(
        send_email_notification,
        payment.email,
        result.payment_id
    )

    return result
```

## Testing FastAPI Endpoints

```python
from fastapi.testclient import TestClient

@pytest.fixture
def client():
    """Test client for API testing."""
    return TestClient(app)

def test_create_payment_success(client):
    """Test successful payment creation."""
    response = client.post(
        "/api/v1/payments",
        json={
            "amount": "99.99",
            "currency": "USD",
            "payment_method_id": "pm_123"
        },
        headers={"Authorization": "Bearer test_token"}
    )

    assert response.status_code == 201
    data = response.json()
    assert data["status"] == "succeeded"
    assert data["amount"] == "99.99"

def test_create_payment_unauthorized(client):
    """Test payment creation without auth."""
    response = client.post(
        "/api/v1/payments",
        json={"amount": "99.99"}
    )

    assert response.status_code == 401
```

## Best Practices

1. **Use Routers**: Organize endpoints by domain
2. **Type Everything**: Full type hints on all endpoints
3. **Validate Inputs**: Use Pydantic models
4. **Handle Errors**: Comprehensive error handling
5. **Document APIs**: OpenAPI docs on all endpoints
6. **Secure by Default**: Authentication, rate limiting
7. **Test Thoroughly**: Unit and integration tests
8. **Async All the Way**: Use async/await throughout
