# Python Development Patterns

Comprehensive code examples and patterns for Python AI and data engineering projects.

## Table of Contents

1. [Type Safety](#type-safety)
2. [Pydantic Data Validation](#pydantic-data-validation)
3. [Async/Await Patterns](#asyncawait-patterns)
4. [Error Handling](#error-handling)
5. [FastAPI Endpoints](#fastapi-endpoints)
6. [Testing with pytest](#testing-with-pytest)
7. [Security Best Practices](#security-best-practices)
8. [Docstrings](#docstrings)
9. [Code Quality Standards](#code-quality-standards)

---

## Type Safety

All code should include comprehensive type hints for better IDE support, documentation, and error catching.

### Function Type Hints

```python
from decimal import Decimal
from typing import Any, Dict, List, Optional


def process_transaction(
    amount: Decimal,
    user_id: str,
    metadata: Optional[Dict[str, Any]] = None
) -> TransactionResult:
    """Process a transaction with validation."""
    pass
```

### Class Attributes

```python
class PaymentService:
    """Service for handling payments."""

    api_key: str
    base_url: str
    timeout: int = 30
```

### Async Functions

```python
async def fetch_user_data(user_id: str) -> UserData:
    """Fetch user data asynchronously."""
    pass
```

### Type Checking Requirements

- Run mypy in strict mode
- No `Any` types without justification
- Type hints required on all public functions
- Use generic types for collections: `list[str]`, `dict[str, int]`

---

## Pydantic Data Validation

Use Pydantic models for all data validation and serialization to ensure type safety and data integrity.

### Basic Model

```python
from decimal import Decimal
from pydantic import BaseModel, Field, field_validator


class PaymentRequest(BaseModel):
    """Payment creation request."""

    amount: Decimal = Field(
        ...,
        gt=0,
        decimal_places=2,
        description="Payment amount"
    )
    currency: str = Field(default="USD", pattern="^[A-Z]{3}$")

    @field_validator("amount")
    @classmethod
    def validate_amount(cls, v: Decimal) -> Decimal:
        """Validate amount is within acceptable range."""
        if v > Decimal("10000"):
            raise ValueError("Amount exceeds maximum")
        return v.quantize(Decimal("0.01"))

    class Config:
        json_schema_extra = {
            "example": {
                "amount": "99.99",
                "currency": "USD"
            }
        }
```

### Field Validation

```python
from pydantic import EmailStr, field_validator
import re


class UserRegistration(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8, max_length=100)

    @field_validator("password")
    @classmethod
    def validate_password(cls, v: str) -> str:
        """Ensure password meets security requirements."""
        if not re.search(r"[A-Z]", v):
            raise ValueError("Password must contain uppercase letter")
        if not re.search(r"[0-9]", v):
            raise ValueError("Password must contain number")
        return v
```

### Benefits

- Automatic validation on instantiation
- JSON serialization/deserialization
- OpenAPI schema generation
- Type safety with IDE support

---

## Async/Await Patterns

Use async/await for all I/O operations to maximize concurrency and performance.

### Basic Async HTTP Request

```python
import httpx


async def fetch_data(url: str) -> dict:
    """Fetch data from external API."""
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        response.raise_for_status()
        return response.json()
```

### Parallel Async Operations

```python
async def fetch_multiple(urls: list[str]) -> list[dict]:
    """Fetch multiple URLs concurrently."""
    async with httpx.AsyncClient() as client:
        tasks = [client.get(url) for url in urls]
        responses = await asyncio.gather(*tasks)
        return [r.json() for r in responses]
```

### Best Practices

- Always use `async with` for context managers
- Use `asyncio.gather()` for parallel operations
- Handle exceptions in async code properly
- Add timeouts to prevent hanging operations
- Never use blocking I/O in async functions

---

## Error Handling

Define specific exceptions and handle them appropriately for better error reporting and debugging.

### Custom Exception Hierarchy

```python
class ServiceError(Exception):
    """Base service error."""
    pass


class RateLimitError(ServiceError):
    """Rate limit exceeded."""
    pass


class ValidationError(ServiceError):
    """Data validation failed."""
    pass
```

### Exception Handling

```python
# Handle specific exceptions
try:
    result = await external_service.call()
except RateLimitError as e:
    logger.warning(f"Rate limited: {e}")
    await asyncio.sleep(60)
    result = await external_service.call()
except ValidationError as e:
    logger.error(f"Validation failed: {e}")
    raise HTTPException(status_code=422, detail=str(e))
```

### Best Practices

- Never use bare `except:` clauses
- Catch specific exceptions, not generic `Exception`
- Log errors with appropriate severity
- Re-raise exceptions when appropriate
- Provide context in exception messages

---

## FastAPI Endpoints

FastAPI endpoint structure with proper validation, error handling, and documentation.

### Complete Endpoint Example

```python
from fastapi import APIRouter, Depends, HTTPException, status

router = APIRouter(prefix="/api/v1/users", tags=["users"])


@router.post(
    "/",
    response_model=UserResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a new user"
)
async def create_user(
    user: UserCreate,
    current_user: User = Depends(get_current_user),
    user_service: UserService = Depends()
) -> UserResponse:
    """
    Create a new user account.

    - **email**: Valid email address
    - **name**: User's full name
    """
    try:
        return await user_service.create(user)
    except DuplicateEmailError:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="Email already registered"
        )
```

### Best Practices

- Use dependency injection with `Depends()`
- Define response models for type safety
- Use appropriate status codes
- Document endpoints with docstrings
- Handle service layer exceptions and convert to HTTP exceptions
- Use router prefixes and tags for organization

---

## Testing with pytest

Write comprehensive tests with pytest to ensure code reliability and catch regressions.

### Basic Test Structure

```python
from decimal import Decimal
from unittest.mock import AsyncMock, patch
import pytest


@pytest.fixture
def payment_service():
    """Provide payment service instance for testing."""
    return PaymentService(api_key="test_key")


@pytest.mark.asyncio
async def test_create_payment_success(payment_service):
    """Test successful payment creation."""
    # Arrange
    with patch("httpx.AsyncClient") as mock_client:
        mock_response = AsyncMock()
        mock_response.json.return_value = {"id": "pay_123", "status": "succeeded"}
        mock_client.return_value.__aenter__.return_value.post.return_value = mock_response

        # Act
        result = await payment_service.create_payment(
            PaymentRequest(amount=Decimal("99.99"), currency="USD")
        )

        # Assert
        assert result.payment_id == "pay_123"
        assert result.status == "succeeded"
```

### Parametrized Tests

```python
@pytest.mark.parametrize("amount,error", [
    (Decimal("0"), "Amount must be positive"),
    (Decimal("-10"), "Amount must be positive"),
    (Decimal("10001"), "Amount exceeds maximum"),
])
def test_payment_validation_errors(amount, error):
    """Test payment validation with invalid amounts."""
    with pytest.raises(ValidationError, match=error):
        PaymentRequest(amount=amount, currency="USD")
```

### Best Practices

- Use fixtures for test data and dependencies
- Mock external dependencies (APIs, databases)
- Test both success and error paths
- Use `@pytest.mark.asyncio` for async tests
- Use `@pytest.mark.parametrize` for multiple test cases
- Follow Arrange-Act-Assert pattern
- Aim for 80%+ test coverage

---

## Security Best Practices

Implement security best practices to protect sensitive data and prevent vulnerabilities.

### Input Validation

Always validate user input with Pydantic models:

```python
from pydantic import EmailStr, field_validator
import re


class UserRegistration(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8, max_length=100)

    @field_validator("password")
    @classmethod
    def validate_password(cls, v: str) -> str:
        """Ensure password meets security requirements."""
        if not re.search(r"[A-Z]", v):
            raise ValueError("Password must contain uppercase letter")
        if not re.search(r"[0-9]", v):
            raise ValueError("Password must contain number")
        return v
```

### PII Redaction

Redact personally identifiable information in logs:

```python
import re


def redact_email(email: str) -> str:
    """Redact email for logging: user@example.com -> u***@example.com"""
    user, domain = email.split("@", 1)
    return f"{user[0]}***@{domain}"


def redact_phone(phone: str) -> str:
    """Redact phone for logging: +1234567890 -> +123***7890"""
    return f"{phone[:4]}***{phone[-4:]}"


# Use in logging
logger.info(f"Processing request for {redact_email(user.email)}")
```

### Security Checklist

- Validate all user input with Pydantic
- Redact PII in logs
- Use parameterized SQL queries
- Implement rate limiting on public APIs
- Use HTTPS for all external requests
- Never log sensitive data (passwords, tokens, API keys)
- Use environment variables for secrets
- Implement proper authentication and authorization

---

## Docstrings

Use clear, comprehensive docstrings following Google style.

### Function Docstring

```python
def process_data(data: list[dict], validate: bool = True) -> ProcessedData:
    """
    Process raw data with optional validation.

    Args:
        data: List of raw data dictionaries
        validate: Whether to validate data (default: True)

    Returns:
        ProcessedData object containing cleaned and structured data

    Raises:
        ValidationError: If validation fails and validate=True
        ProcessingError: If data processing fails
    """
    pass
```

### Class Docstring

```python
class PaymentService:
    """
    Service for handling payment operations.

    This service integrates with external payment providers
    and handles payment creation, verification, and refunds.

    Attributes:
        api_key: Payment provider API key
        base_url: Payment provider API base URL
        timeout: Request timeout in seconds (default: 30)
    """

    api_key: str
    base_url: str
    timeout: int = 30
```

### Best Practices

- Document all public functions and classes
- Use imperative mood ("Return" not "Returns")
- Document parameters, returns, and exceptions
- Include usage examples for complex functions
- Keep docstrings concise but complete

---

## Code Quality Standards

Enforce consistent code quality across the project.

### Formatting

- Use ruff for linting and formatting
- 88 character line length (Black compatible)
- Follow PEP 8 style guide
- Import ordering: standard library → third party → local

### Naming Conventions

- `snake_case` for functions, variables, methods
- `PascalCase` for classes, Pydantic models
- `UPPER_CASE` for constants
- Prefix private members with `_`

### Prohibited Patterns

- No `Any` types without justification
- No untyped function signatures
- No manual validation (use Pydantic)
- No sync code for I/O operations
- No bare `except:` clauses
- No emojis (unless explicitly requested)

### Quality Tools

- **ruff**: Linting and formatting
- **mypy**: Type checking
- **pytest**: Testing with coverage
- **pre-commit**: Automated quality gates

---

## References

For more information, see:

- [Type Safety Skill](../.claude/skills/type-safety.md)
- [Pydantic Models Skill](../.claude/skills/pydantic-models.md)
- [Async/Await Checker Skill](../.claude/skills/async-await-checker.md)
- [Structured Errors Skill](../.claude/skills/structured-errors.md)
- [FastAPI Patterns Skill](../.claude/skills/fastapi-patterns.md)
- [pytest Patterns Skill](../.claude/skills/pytest-patterns.md)
- [PII Redaction Skill](../.claude/skills/pii-redaction.md)
- [Docstring Format Skill](../.claude/skills/docstring-format.md)
- [Best Practices Guide](./best-practices.md)
