<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# Claude Code Plugin for Python AI/Data Engineering

This plugin provides comprehensive tools for productive Python development with AI assistance. It includes commands, specialized agents, reusable skills, and automation hooks optimized for modern Python projects focusing on AI and data engineering.

## What This Plugin Provides

### Commands (6)

- `/primer` - Prime Claude with project context using semantic code retrieval
- `/fix` - Auto-fix Python issues (ruff format, ruff check --fix, mypy reporting)
- `/api` - FastAPI endpoint development with Pydantic models and validation
- `/lint` - Run Python linting and type checking (ruff check, mypy)
- `/check` - Comprehensive quality checks (pytest, coverage, mypy)
- `/test [path]` - Run pytest with appropriate options

### Specialized Agents (8)

**Code Quality & Review:**
- **code-reviewer** - Comprehensive Python code review with security and performance analysis
- **write-unit-tests** - Generate pytest unit tests with fixtures, mocking, and parametrization
- **debug-test-failure** - Debug failing Python tests and identify root causes
- **fix-pr-comments** - Systematically address PR review feedback

**Development & Architecture:**
- **implement-feature** - Complete feature implementation with FastAPI, Pydantic, testing
- **add-agent-tool** - Add tools to AI agents following design patterns
- **upgrade-dependency** - Python dependency management and migration handling
- **optimize-db-query** - SQL/DuckDB query optimization for performance

### Pattern Skills (8)

Reusable patterns that activate automatically when relevant code is detected:
- **dynaconf-config** - Configuration management patterns
- **async-await-checker** - Async/await best practices validation
- **structured-errors** - Error handling and exception patterns
- **pydantic-models** - Data validation model patterns
- **tool-design-pattern** - AI agent tool design guidelines
- **docstring-format** - Python documentation standards
- **pii-redaction** - PII handling and logging safety
- **pytest-patterns** - Testing best practices

### Automated Hooks

**Pre-Tool-Use Hooks:**
- Pre-commit quality gate (linting, type checking, tests before commits)

**Post-Tool-Use Hooks:**
- Auto-format Python files after editing (ruff format, ruff check --fix)
- Auto-sync dependencies after pyproject.toml changes (uv sync or pip install)
- Auto-run tests after test file modifications

## Python Development Guidelines

This plugin promotes modern Python best practices optimized for AI and data engineering projects.

### Type Safety First

All code should include comprehensive type hints:

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


class PaymentService:
    """Service for handling payments."""

    api_key: str
    base_url: str
    timeout: int = 30


async def fetch_user_data(user_id: str) -> UserData:
    """Fetch user data asynchronously."""
    pass
```

**Type Checking:**
- Run mypy in strict mode
- No `Any` types without justification
- Type hints required on all public functions

### Pydantic for Data Validation

Use Pydantic models for all data validation and serialization:

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

### Async/Await Patterns

Use async/await for all I/O operations:

```python
import httpx


async def fetch_data(url: str) -> dict:
    """Fetch data from external API."""
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        response.raise_for_status()
        return response.json()


# Parallel async operations
async def fetch_multiple(urls: list[str]) -> list[dict]:
    """Fetch multiple URLs concurrently."""
    async with httpx.AsyncClient() as client:
        tasks = [client.get(url) for url in urls]
        responses = await asyncio.gather(*tasks)
        return [r.json() for r in responses]
```

### Error Handling

Define specific exceptions and handle them appropriately:

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

### FastAPI Endpoint Structure

When building APIs with FastAPI:

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

### Testing with pytest

Write comprehensive tests with pytest:

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

### Security Best Practices

**Input Validation:**
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

**PII Redaction:**
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

### Code Quality Standards

**Formatting:**
- Use ruff for linting and formatting (88 character line length)
- Follow PEP 8 style guide
- Import ordering: standard library → third party → local

**Naming Conventions:**
- `snake_case` for functions, variables, methods
- `PascalCase` for classes, Pydantic models
- `UPPER_CASE` for constants
- Prefix private members with `_`

**Docstrings:**
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

**Prohibited Patterns:**
- No `Any` types without justification
- No untyped function signatures
- No manual validation (use Pydantic)
- No sync code for I/O operations
- No bare `except:` clauses
- No emojis (unless explicitly requested)

## Command Usage

### /fix - Auto-fix Issues

Automatically fixes linting and formatting issues:
```bash
/fix
```

Runs:
1. `ruff check --fix .` - Fix linting issues
2. `ruff format .` - Format code
3. `mypy .` - Report type errors

Use before commits or when cleaning up code.

### /api - Create FastAPI Endpoint

Scaffolds a complete FastAPI endpoint:
```bash
/api
```

Creates:
- Pydantic request/response models
- FastAPI route handler with validation
- Error handling
- OpenAPI documentation
- Example requests/responses

### /check - Quality Gate

Runs comprehensive quality checks:
```bash
/check
```

Runs:
1. `pytest` - All tests
2. `pytest --cov` - Coverage report
3. `mypy .` - Type checking

Use before creating commits or pull requests.

### /test - Run Tests

Runs pytest with options:
```bash
/test                    # All tests
/test path/to/test.py    # Specific file
/test -v                 # Verbose
/test -x                 # Stop on first failure
/test --cov              # With coverage
```

## Agent Usage

Agents automatically activate when relevant work is detected, or you can request them explicitly.

### Code Review Agent

Request code review:
```
"Review this code for issues"
"Check this PR for problems"
```

Reviews:
- Type hints coverage
- Security issues (PII, injection, etc.)
- Performance problems
- Error handling
- Test coverage
- Code organization

### Write Tests Agent

Request test generation:
```
"Write unit tests for this function"
"I need test coverage for this module"
```

Creates:
- pytest test functions
- Fixtures for test data
- Mocked dependencies
- Parametrized tests
- Async test support

### Implement Feature Agent

Request feature implementation:
```
"Implement user authentication feature"
"Create payment processing endpoint"
```

Implements:
- Pydantic models
- Business logic services
- API endpoints (if applicable)
- Error handling
- Tests
- Documentation

## Configuration

### Project Structure

This plugin works best with Python projects following this structure:

```
project/
├── src/                    # Source code
│   ├── api/               # API layer (FastAPI)
│   ├── services/          # Business logic
│   ├── models/            # Pydantic models
│   └── database/          # Data access
├── tests/                 # Test suite
│   ├── unit/             # Unit tests
│   └── integration/      # Integration tests
├── pyproject.toml        # Dependencies
└── .mcp.json             # MCP server configuration (project-specific)
```

### Environment Setup

Example environment variables (adjust for your project):

```bash
# Application
ENV_FOR_DYNACONF=dev       # Environment (dev, staging, prod)
DEBUG=true                 # Debug mode

# External Services (examples)
EXTERNAL_API_KEY=xxx       # External service API key
DATABASE_URL=xxx           # Database connection string

# Logging
LOG_LEVEL=INFO             # Logging level
LOG_FORMAT=json            # json or text
```

### Quality Gates

Pre-commit hooks ensure code quality:
- Linting passes (ruff check)
- Type checking passes (mypy)
- Tests pass (pytest)

All checks must pass before commits are allowed.

## MCP Server Recommendations

This plugin does not include MCP server configuration. Configure servers in your project's `.mcp.json` file based on your needs.

**Recommended servers for Python AI/data engineering:**

- **memory** - Persistent context across sessions
- **context7** - Up-to-date library documentation
- **filesystem** - File operations
- **duckdb** - Query databases (configure with your database paths)

See the [MCP Server Guide](docs/workflows/mcp-server-recommendations.md) for configuration examples.

## Best Practices Summary

**Type Safety:**
- All functions have type hints
- Mypy runs in strict mode
- No `Any` without justification

**Code Quality:**
- Ruff for linting and formatting
- Pre-commit hooks enforce standards
- 80%+ test coverage minimum

**Testing:**
- Unit and integration tests
- Mock external dependencies
- Test success and error paths
- Use pytest fixtures

**Security:**
- PII redacted in logs
- Input validation with Pydantic
- Parameterized SQL queries
- Rate limiting on public APIs

**Async Patterns:**
- Use async/await for I/O
- Parallel operations with asyncio.gather
- Proper exception handling
- Timeout handling

## Common Workflows

### Creating a New Feature

1. Use `/primer` to understand codebase context
2. Implement feature (agent can help)
3. Write tests (write-unit-tests agent)
4. Run `/check` to verify quality
5. Commit changes

### Fixing Code Quality

1. Run `/check` to identify issues
2. Run `/fix` to auto-fix what's possible
3. Manually fix remaining issues
4. Run `/check` again to verify
5. Commit changes

### Code Review

1. Request code-reviewer agent
2. Address feedback
3. Run `/check` to verify fixes
4. Commit changes

---

This plugin is designed for maximum productivity in Python AI and data engineering. All commands, agents, and skills work together to maintain high code quality while moving fast.
