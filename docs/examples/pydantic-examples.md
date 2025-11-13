# Pydantic Model Examples

Practical examples of Pydantic models for validation, serialization, and API contracts.

## Basic Model

```python
from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

class User(BaseModel):
    """User model."""
    id: str
    email: str
    name: str
    age: Optional[int] = None
    created_at: datetime
    is_active: bool = True
```

## Model with Validation

```python
from pydantic import field_validator, EmailStr
from decimal import Decimal

class PaymentRequest(BaseModel):
    """Payment with validation."""

    amount: Decimal = Field(
        ...,
        gt=0,
        decimal_places=2,
        description="Payment amount"
    )
    email: EmailStr
    description: Optional[str] = Field(None, max_length=500)

    @field_validator('amount')
    @classmethod
    def validate_amount(cls, v: Decimal) -> Decimal:
        """Validate and quantize amount."""
        if v > Decimal("10000"):
            raise ValueError("Amount exceeds maximum")
        return v.quantize(Decimal("0.01"))
```

## Nested Models

```python
class Address(BaseModel):
    """Address model."""
    street: str
    city: str
    state: str = Field(..., pattern="^[A-Z]{2}$")
    zip_code: str = Field(..., pattern="^\\d{5}$")

class UserProfile(BaseModel):
    """User profile with nested address."""
    name: str
    email: EmailStr
    address: Address
    phone: Optional[str] = None
```

## Model with Custom Serialization

```python
from pydantic import field_serializer

class UserPublic(BaseModel):
    """User model with PII redaction."""
    id: str
    email: str
    phone: Optional[str] = None
    ssn: Optional[str] = None

    @field_serializer('email')
    def redact_email(self, value: str) -> str:
        """Redact email in serialization."""
        user, domain = value.split('@')
        return f"{user[0]}***@{domain}"

    @field_serializer('ssn')
    def redact_ssn(self, value: Optional[str]) -> Optional[str]:
        """Redact SSN in serialization."""
        if not value:
            return None
        return f"***-**-{value[-4:]}"
```

## Model with Computed Fields

```python
from pydantic import computed_field

class Product(BaseModel):
    """Product with computed total."""
    name: str
    price: Decimal
    tax_rate: Decimal = Decimal("0.08")

    @computed_field
    @property
    def total_price(self) -> Decimal:
        """Calculate total price including tax."""
        return (self.price * (1 + self.tax_rate)).quantize(Decimal("0.01"))
```

## Model with Examples

```python
class OrderCreate(BaseModel):
    """Order creation request."""

    items: List[str] = Field(..., min_length=1)
    total: Decimal = Field(..., gt=0)
    shipping_address: Address

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "items": ["item_1", "item_2"],
                    "total": "99.99",
                    "shipping_address": {
                        "street": "123 Main St",
                        "city": "San Francisco",
                        "state": "CA",
                        "zip_code": "94102"
                    }
                }
            ]
        }
    }
```

## Discriminated Unions

```python
from pydantic import Field, Discriminator
from typing import Literal, Union

class CreditCardPayment(BaseModel):
    """Credit card payment."""
    type: Literal["credit_card"]
    card_number: str
    cvv: str
    expiry: str

class BankTransferPayment(BaseModel):
    """Bank transfer payment."""
    type: Literal["bank_transfer"]
    account_number: str
    routing_number: str

Payment = Union[CreditCardPayment, BankTransferPayment]

class PaymentRequest(BaseModel):
    """Payment request with discriminated union."""
    amount: Decimal
    payment_method: Payment = Field(..., discriminator="type")
```

## Model Inheritance

```python
class BaseUser(BaseModel):
    """Base user model."""
    email: EmailStr
    name: str

class UserCreate(BaseUser):
    """User creation (includes password)."""
    password: str = Field(..., min_length=8)

class UserResponse(BaseUser):
    """User response (no password)."""
    id: str
    created_at: datetime
    is_active: bool
```

## Model with Before Validation

```python
from pydantic import model_validator

class SearchQuery(BaseModel):
    """Search query with preprocessing."""
    query: str
    filters: Optional[dict] = None

    @model_validator(mode='before')
    @classmethod
    def preprocess(cls, values: dict) -> dict:
        """Preprocess before validation."""
        # Normalize query
        if 'query' in values:
            values['query'] = values['query'].strip().lower()

        # Set default filters
        if 'filters' not in values:
            values['filters'] = {}

        return values
```

## Strict Mode

```python
class StrictUser(BaseModel):
    """User model with strict validation."""
    model_config = {"strict": True}

    id: int  # Must be int, no coercion from string
    email: str
    age: int
```

## Model for Database

```python
class UserDB(BaseModel):
    """User model for database."""
    model_config = {
        "from_attributes": True  # Allow creation from ORM models
    }

    id: str
    email: str
    password_hash: str
    created_at: datetime
    updated_at: datetime

# Usage with SQLAlchemy
user_orm = session.query(UserORM).first()
user = UserDB.model_validate(user_orm)
```
