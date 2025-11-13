# Testing Guidelines

Comprehensive testing standards for Python applications using pytest.

## Test Organization

```
tests/
├── unit/                      # Fast, isolated tests
│   ├── test_models.py         # Pydantic model tests
│   ├── test_services.py       # Service logic tests
│   └── test_utils.py          # Utility function tests
├── integration/               # Tests with external dependencies
│   ├── test_api.py            # API endpoint tests
│   ├── test_database.py       # Database tests
│   └── test_external_api.py   # External API tests
└── conftest.py                # Shared fixtures
```

## Test Patterns

```python
import pytest
from unittest.mock import Mock, AsyncMock, patch
from decimal import Decimal
from httpx import HTTPStatusError

# Test fixtures
@pytest.fixture
def payment_service():
    """Fixture providing payment service instance."""
    return PaymentService(api_key="test_key")

@pytest.fixture
def valid_payment_request():
    """Fixture for valid payment request."""
    return PaymentRequest(
        amount=Decimal("99.99"),
        currency="USD",
        payment_method_id="pm_123"
    )

@pytest.fixture
async def db_session():
    """Fixture for database session with cleanup."""
    session = await create_test_session()
    yield session
    await session.close()

# Parametrized tests
@pytest.mark.parametrize("amount,expected_error", [
    (Decimal("0"), "Amount must be positive"),
    (Decimal("-10"), "Amount must be positive"),
    (Decimal("10001"), "Amount exceeds maximum"),
])
def test_payment_validation_errors(amount, expected_error):
    """Test payment amount validation with various invalid amounts."""
    with pytest.raises(ValidationError, match=expected_error):
        PaymentRequest(amount=amount, currency="USD", payment_method_id="pm_123")

# Async tests
@pytest.mark.asyncio
async def test_create_payment_success(payment_service, valid_payment_request):
    """Test successful payment creation."""
    with patch('payment_service.httpx.AsyncClient') as mock_client:
        # Setup mock
        mock_response = AsyncMock()
        mock_response.json.return_value = {
            "id": "pay_123",
            "status": "succeeded"
        }
        mock_client.return_value.__aenter__.return_value.post.return_value = mock_response

        # Execute
        result = await payment_service.create_payment(valid_payment_request, "user_123")

        # Assert
        assert result.payment_id == "pay_123"
        assert result.status == "succeeded"

# Error scenario tests
@pytest.mark.asyncio
async def test_create_payment_service_error(payment_service, valid_payment_request):
    """Test payment service error handling."""
    with patch('payment_service.httpx.AsyncClient') as mock_client:
        mock_response = Mock()
        mock_response.status_code = 503
        mock_client.return_value.__aenter__.return_value.post.side_effect = \
            HTTPStatusError("Service unavailable", request=Mock(), response=mock_response)

        with pytest.raises(PaymentServiceError, match="unavailable"):
            await payment_service.create_payment(valid_payment_request, "user_123")

# Test organization
class TestPaymentService:
    """Test suite for PaymentService."""

    def test_initialization(self):
        """Test service initialization."""
        service = PaymentService(api_key="test_key")
        assert service.api_key == "test_key"

    async def test_create_payment(self, payment_service):
        """Test payment creation."""
        pass

# Markers
@pytest.mark.slow
def test_large_batch_processing():
    """Test processing large batch (marked slow)."""
    pass

@pytest.mark.integration
async def test_external_api_integration():
    """Test integration with external API."""
    pass
```

## Coverage Requirements

```bash
# Run with coverage
pytest --cov=src --cov-report=html --cov-report=term

# Minimum coverage: 80%
# Target coverage: 90%+

# View HTML report
open htmlcov/index.html
```

## Test Fixtures

```python
# conftest.py
import pytest
from fastapi.testclient import TestClient

@pytest.fixture
def client():
    """Test client for API testing."""
    return TestClient(app)

@pytest.fixture
def test_user():
    """Test user fixture."""
    return User(
        id="user_123",
        email="test@example.com",
        created_at=datetime.now()
    )

@pytest.fixture
async def db_session():
    """Database session fixture with rollback."""
    async with AsyncSession() as session:
        yield session
        await session.rollback()
```

## Mocking External Services

```python
from unittest.mock import AsyncMock, patch

@pytest.mark.asyncio
async def test_external_api_call():
    """Test function that calls external API."""
    with patch('httpx.AsyncClient') as mock_client:
        # Setup mock response
        mock_response = AsyncMock()
        mock_response.status_code = 200
        mock_response.json.return_value = {"status": "success"}

        mock_client.return_value.__aenter__.return_value.get.return_value = mock_response

        # Call function that uses httpx
        result = await fetch_external_data()

        # Verify
        assert result["status"] == "success"
```

## Testing Pydantic Models

```python
def test_payment_request_validation():
    """Test PaymentRequest validation."""
    # Valid
    request = PaymentRequest(
        amount=Decimal("99.99"),
        currency="USD",
        payment_method_id="pm_123"
    )
    assert request.amount == Decimal("99.99")

    # Invalid amount
    with pytest.raises(ValidationError):
        PaymentRequest(
            amount=Decimal("-10"),
            currency="USD",
            payment_method_id="pm_123"
        )

    # Invalid currency
    with pytest.raises(ValidationError):
        PaymentRequest(
            amount=Decimal("99.99"),
            currency="INVALID",
            payment_method_id="pm_123"
        )
```

## Best Practices

1. **Descriptive Names**: Test names clearly state what they test
2. **Use Fixtures**: Common setup in fixtures
3. **Parametrize**: Multiple scenarios in one test
4. **Test Both Paths**: Success and error scenarios
5. **Mock External**: Mock external dependencies
6. **Async Marker**: Use `pytest.mark.asyncio` for async tests
7. **Organize Classes**: Group related tests in classes
8. **Mark Tests**: Add markers for slow/integration tests
9. **Coverage Goal**: Aim for 85%+ coverage
10. **Fast Tests**: Keep unit tests fast (< 1 second)

## Running Tests

```bash
# Run all tests
pytest

# Run specific file
pytest tests/test_api.py

# Run specific test
pytest tests/test_api.py::test_create_payment

# Run with coverage
pytest --cov=src --cov-report=term

# Run verbose
pytest -v

# Stop on first failure
pytest -x

# Run only fast tests
pytest -m "not slow"

# Run only integration tests
pytest -m integration
```

## Test Quality Checklist

- [ ] All new code has tests
- [ ] Tests cover success scenarios
- [ ] Tests cover error scenarios
- [ ] Tests cover edge cases
- [ ] External dependencies mocked
- [ ] Tests are fast (< 1s for unit tests)
- [ ] Tests are independent
- [ ] Tests have clear names
- [ ] Test coverage ≥ 85%
- [ ] All tests pass before commit
