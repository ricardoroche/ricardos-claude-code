# Python Development Standards

Comprehensive coding standards for Python development with type safety, testing, and quality automation.

## Type Hints

**All code must include comprehensive type hints:**

```python
from typing import Optional, List, Dict, Any, Union
from decimal import Decimal

# Function signatures
def process_payment(
    amount: Decimal,
    user_id: str,
    metadata: Optional[Dict[str, Any]] = None
) -> PaymentResult:
    pass

# Class attributes
class PaymentService:
    api_key: str
    base_url: str
    timeout: int = 30

# Variables (when not obvious)
users: List[User] = []
config: Dict[str, Any] = {}
result: Optional[PaymentResult] = None

# Async functions
async def fetch_user(user_id: str) -> User:
    pass

# Generators
def get_payments() -> Generator[Payment, None, None]:
    pass

# Type aliases for clarity
UserId = str
Timestamp = int
PaymentDict = Dict[str, Union[str, Decimal]]
```

**mypy configuration:**
```toml
# pyproject.toml
[tool.mypy]
python_version = "3.11"
strict = true
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
```

## Docstrings

**All public functions, classes, and modules require docstrings:**

```python
def calculate_discount(
    amount: Decimal,
    discount_percent: Decimal,
    max_discount: Optional[Decimal] = None
) -> Decimal:
    """
    Calculate discounted amount with optional maximum discount.

    Args:
        amount: Original amount before discount
        discount_percent: Discount percentage (0-100)
        max_discount: Optional maximum discount amount cap

    Returns:
        Final amount after applying discount

    Raises:
        ValueError: If discount_percent is negative or > 100

    Example:
        >>> calculate_discount(Decimal("100"), Decimal("10"))
        Decimal("90.00")
    """
    pass
```

## Error Handling

**Use structured exceptions and proper error handling:**

```python
# Define custom exceptions
class PaymentError(Exception):
    """Base payment error."""
    pass

class InsufficientFundsError(PaymentError):
    """Payment declined due to insufficient funds."""
    pass

# Handle specific exceptions
try:
    result = await payment_service.charge(amount, payment_method)
except InsufficientFundsError as e:
    logger.warning(f"Payment declined: {e}")
    raise HTTPException(
        status_code=status.HTTP_402_PAYMENT_REQUIRED,
        detail="Insufficient funds"
    )
except PaymentError as e:
    logger.error(f"Payment error: {e}", exc_info=True)
    raise HTTPException(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        detail="Payment processing failed"
    )
```

## Code Quality Standards

### Linting Configuration

```toml
# pyproject.toml
[tool.ruff]
line-length = 100
target-version = "py311"

select = [
    "E",   # pycodestyle errors
    "W",   # pycodestyle warnings
    "F",   # pyflakes
    "I",   # isort
    "B",   # flake8-bugbear
    "C4",  # flake8-comprehensions
    "UP",  # pyupgrade
]

ignore = [
    "E501",  # line too long (handled by formatter)
]

[tool.ruff.isort]
known-first-party = ["src"]
```

### Pre-Commit Standards

**All code must pass before commit:**
- Ruff linting (no errors)
- Mypy type checking (strict mode)
- Pytest (all tests passing)
- Code formatted with ruff format

## Async/Await Patterns

```python
import httpx
from typing import List

# Correct: await async functions
async def fetch_data(url: str) -> dict:
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        return response.json()

# Correct: async endpoint
@app.get("/users")
async def get_users() -> List[User]:
    users = await db.fetch_all("SELECT * FROM users")
    return users

# Wrong: missing await
async def bad_example():
    response = httpx.get("https://api.example.com")  # Missing async!
```

## Security Patterns

### Input Validation

```python
from pydantic import BaseModel, Field, field_validator
import re

class UserRegistration(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8, max_length=100)

    @field_validator('password')
    @classmethod
    def validate_password(cls, v: str) -> str:
        """Validate password strength."""
        if not re.search(r'[A-Z]', v):
            raise ValueError('Password must contain uppercase letter')
        if not re.search(r'[a-z]', v):
            raise ValueError('Password must contain lowercase letter')
        if not re.search(r'\d', v):
            raise ValueError('Password must contain digit')
        return v
```

### PII Redaction

```python
def redact_email(email: str) -> str:
    """Redact email for logging: user@example.com -> u***@example.com"""
    if '@' not in email:
        return "***"
    user, domain = email.split('@', 1)
    return f"{user[0]}***@{domain}"

# Usage in logging
logger.info(
    f"Processing payment for user {redact_email(user_email)}"
)
```

## Best Practices Summary

**Type Safety:**
- All functions have type hints
- Mypy runs in strict mode
- No `Any` types without justification

**Code Quality:**
- Ruff for linting and formatting
- Pre-commit hooks enforce standards
- All code passes /check before commit

**Testing:**
- 80%+ test coverage minimum
- Unit and integration tests
- Mock external dependencies
- Test success and error paths

**Documentation:**
- Docstrings on all public functions
- Type hints for clarity
- OpenAPI docs for all endpoints
- README updated with features

**Security:**
- PII redacted in logs
- Input validation with Pydantic
- Authentication on protected endpoints
- Rate limiting on public endpoints
