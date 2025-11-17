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

# CLAUDE.md

This file provides comprehensive guidance to Claude Code when working in Ricardo's Python AI Engineering environment. This setup is optimized for building modern Python applications with FastAPI, AI agents, and best practices.

## Overview

This is a **Python AI Engineering development environment** designed for productive development of AI-powered applications, APIs, and intelligent systems. The setup emphasizes type safety, modern async patterns, comprehensive testing, and code quality automation.

**Key Philosophy:**

- Type-safe Python with full mypy validation
- Modern async/await patterns throughout
- Pydantic for all data validation
- Comprehensive pytest testing
- Automated code quality gates
- AI-first tool design patterns

## Architecture

**Development Environment Structure:**

```
project/
├── src/                           # Source code
│   ├── api/                       # FastAPI routes and endpoints
│   │   ├── v1/                    # API version 1
│   │   │   ├── routes/            # Route handlers
│   │   │   ├── models/            # Request/response models
│   │   │   └── dependencies.py    # FastAPI dependencies
│   │   └── middleware.py          # API middleware
│   ├── core/                      # Core application logic
│   │   ├── config.py              # Configuration (dynaconf)
│   │   ├── logging.py             # Logging setup
│   │   ├── errors.py              # Custom exceptions
│   │   └── security.py            # Security utilities
│   ├── agents/                    # AI agent implementations
│   │   ├── base.py                # Base agent class
│   │   ├── tools/                 # Agent tools
│   │   └── prompts/               # Prompt templates
│   ├── services/                  # Business logic services
│   │   ├── external/              # External API integrations
│   │   └── internal/              # Internal services
│   ├── models/                    # Pydantic data models
│   │   ├── domain/                # Domain models
│   │   └── api/                   # API models
│   └── database/                  # Database layer
│       ├── repositories/          # Data access patterns
│       └── migrations/            # Database migrations
├── tests/                         # Test suite
│   ├── unit/                      # Unit tests
│   ├── integration/               # Integration tests
│   └── conftest.py                # Pytest fixtures
├── docs/                          # Documentation (NEW)
│   ├── standards/                 # Coding standards
│   ├── workflows/                 # Development workflows
│   └── examples/                  # Code examples
├── data/                          # Local data storage
│   ├── operational.db             # Operational DuckDB
│   └── analytics.db               # Analytics DuckDB
├── pyproject.toml                 # Project dependencies
├── settings.toml                  # Dynaconf configuration
└── .env                           # Environment variables
```

## Quick Start

### Prerequisites

```bash
# Python 3.11+
python --version

# uv (recommended) or pip
curl -LsSf https://astral.sh/uv/install.sh | sh

# Optional: DuckDB CLI
brew install duckdb # macOS
```

### Initial Setup

```bash
# Install dependencies
uv sync # With uv (fast)
# or
pip install -e . # With pip

# Run quality checks
ruff check .
mypy .
pytest

# Start development
uvicorn src.api.main:app --reload
```

## Available Commands

The environment provides 5 specialized slash commands for common Python development tasks:

### /fix - Auto-fix Python Issues

Automatically fixes linting, formatting, and reports type errors:

```bash
/fix
```

**What it does:**

1. Runs `ruff check --fix .` to auto-fix linting issues
2. Runs `ruff format .` to format all Python code
3. Runs `mypy .` to report type checking errors

**Use when:**

- Before committing code
- After writing new features
- Cleaning up code quality issues
- Preparing for PR review

### /api - FastAPI Endpoint Development

Creates complete FastAPI endpoints with Pydantic models, validation, error handling, and documentation:

```bash
/api
```

**Creates:**

- FastAPI route handlers with proper decorators
- Pydantic request/response models
- Input validation with field constraints
- Comprehensive error handling
- OpenAPI documentation
- Example requests/responses

### /lint - Linting and Type Checking

Runs comprehensive code quality checks:

```bash
/lint
```

**What it does:**

1. `ruff check .` - Linting with modern rules
2. `mypy .` - Type checking validation
3. Reports all issues without auto-fixing

### /check - Comprehensive Quality Checks

Runs full test suite, coverage, and type checking:

```bash
/check
```

**What it does:**

1. `pytest` - Run all tests
2. `pytest --cov` - Coverage report
3. `mypy .` - Type checking
4. Reports test failures, coverage gaps, type errors

### /test - Run Pytest

Runs pytest with appropriate options:

```bash
/test                   # Run all tests
/test tests/test_api.py # Run specific file
/test --cov             # Run with coverage
/test -v                # Run verbose
/test -x                # Stop on first failure
```

## Specialized AI Agents

The environment includes 8 specialized agents for different development tasks. Agents automatically activate when relevant work is detected.

### Code Quality & Review Agents

#### 1. code-reviewer

**Purpose:** Comprehensive Python code review with best practices validation

**Triggers:** When reviewing code, PRs, or requesting code quality feedback

**What it reviews:**

- Type hints coverage and correctness
- Docstring completeness and format
- Pydantic model design
- Error handling patterns
- Security issues (PII exposure, SQL injection, etc.)
- Async/await correctness
- Test coverage
- Code organization and structure

#### 2. write-unit-tests

**Purpose:** Generate comprehensive pytest-based unit tests

**Triggers:** When asked to write tests, improve coverage, or test new code

**What it creates:**

- Pytest test functions with descriptive names
- Fixtures for common test data
- Mocked external dependencies
- Parametrized tests for multiple scenarios
- Async test support with `pytest.mark.asyncio`
- Assertion messages for clarity
- Edge case and error scenario tests

#### 3. debug-test-failure

**Purpose:** Debug failing Python tests and identify root causes

**Triggers:** When tests are failing or need debugging

**What it does:**

- Analyzes pytest output and tracebacks
- Identifies assertion failures
- Checks fixture issues
- Verifies mock configurations
- Debugs async test problems
- Suggests fixes with code examples

#### 4. fix-pr-comments

**Purpose:** Systematically address PR review feedback

**Triggers:** When working on PR comments or review feedback

**What it does:**

- Analyzes all PR comments
- Creates implementation plan
- Addresses each comment systematically
- Ensures no comment is missed
- Provides summary of changes made

### Development & Architecture Agents

#### 5. implement-feature

**Purpose:** Complete feature implementation with FastAPI, Pydantic, testing, and documentation

**Triggers:** When implementing new features, endpoints, or major functionality

**What it implements:**

- FastAPI endpoints with proper structure
- Pydantic request/response models
- Business logic services
- Error handling and validation
- Security measures (authentication, rate limiting)
- Comprehensive tests
- API documentation

**Implementation pattern:**

1. Defines Pydantic models with validation
2. Implements business logic in service layer
3. Creates FastAPI endpoint with proper decorators
4. Adds configuration and error handling
5. Writes comprehensive tests
6. Updates documentation

#### 6. add-agent-tool

**Purpose:** Add tools to AI agents following best design patterns

**Triggers:** When creating new agent tools or enhancing agent capabilities

**What it creates:**

- Pydantic input schemas with field descriptions
- Tool function with `@tool` decorator
- Comprehensive docstrings
- Input validation
- Structured JSON responses
- Error handling with request IDs
- Logging (with PII redaction)
- Tool tests

#### 7. upgrade-dependency

**Purpose:** Python dependency management, upgrades, and migration handling

**Triggers:** When upgrading packages, handling dependency conflicts, or migrating APIs

**What it does:**

- Analyzes current dependencies
- Checks for breaking changes
- Updates pyproject.toml
- Fixes deprecated API usage
- Updates type hints if needed
- Runs tests to verify compatibility
- Documents migration steps

#### 8. optimize-db-query

**Purpose:** SQL and DuckDB query optimization for performance

**Triggers:** When working with database queries, performance issues, or analytics

**What it optimizes:**

- SQL query performance
- Index recommendations
- Query plan analysis
- N+1 query problems
- Batch operations
- DuckDB-specific optimizations

## Python Pattern Skills

Skills are reusable patterns that automatically apply when relevant code is detected. The environment includes 8 comprehensive skills covering dynaconf configuration, async/await patterns, structured errors, Pydantic models, tool design, docstring format, PII redaction, and pytest patterns.

For detailed documentation on each skill, see:

- [Python Standards](docs/standards/python-standards.md)
- [FastAPI Patterns](docs/standards/fastapi-patterns.md)
- [Testing Guidelines](docs/standards/testing-guidelines.md)

## MCP Server Integration

The environment includes 6 pre-configured Model Context Protocol servers:

### 1. memory - Persistent Context

Store and retrieve context across Claude Code sessions

**Use cases:** Project-specific patterns, architecture decisions, previous conversations

### 2. context7 - Semantic Code Retrieval

Semantic search across codebase for relevant context

**Use cases:** Find similar code patterns, locate related implementations, discover existing utilities

### 3. duckdb-operational - Operational Database

Store and query operational data (user data, transactions, state)

**Database:** `./data/operational.db`

### 4. duckdb-analytics - Analytics Database

Store and query analytics data (metrics, reports, aggregations)

**Database:** `./data/analytics.db`

### 5. linear - Issue Tracking

Create and manage Linear issues for task tracking

**Configuration:** Requires `LINEAR_API_KEY` environment variable

### 6. notion - Documentation Workspace

Access and update project documentation in Notion

**Configuration:** Requires `NOTION_API_KEY` environment variable

## Automated Hooks

Smart automation that runs automatically based on file changes:

### Pre-Tool-Use Hooks

**Pre-Commit Quality Gate:**
Runs before `git commit` to ensure code quality:

```bash
# Automatically runs:
ruff check .   # Linting
mypy .         # Type checking
pytest --quiet # Tests
```

Purpose: Prevent committing code with linting errors, type errors, or test failures

### Post-Tool-Use Hooks

#### 1. Auto-Format Python Files

**Triggers:** After editing or creating `.py` files
**Actions:** Runs `ruff format` and `ruff check --fix`

#### 2. Auto-Sync Dependencies

**Triggers:** After editing `pyproject.toml`, `requirements.txt`, or `setup.py`
**Actions:** Runs `uv sync` or `pip install`

#### 3. Auto-Run Tests

**Triggers:** After editing test files
**Actions:** Runs `pytest` on the changed file

## Core Development Patterns

### Type Hints

All code must include comprehensive type hints:

```python
from decimal import Decimal
from typing import Any, Dict, Optional


def process_payment(
    amount: Decimal, user_id: str, metadata: Optional[Dict[str, Any]] = None
) -> PaymentResult:
    pass


class PaymentService:
    api_key: str
    base_url: str
    timeout: int = 30


async def fetch_user(user_id: str) -> User:
    pass
```

### Pydantic Models

```python
from decimal import Decimal

from pydantic import BaseModel, Field, field_validator


class PaymentRequest(BaseModel):
    """Payment creation request."""

    amount: Decimal = Field(
        ..., gt=0, decimal_places=2, description="Payment amount in USD"
    )
    currency: str = Field(default="USD", pattern="^[A-Z]{3}$")

    @field_validator("amount")
    @classmethod
    def validate_amount(cls, v: Decimal) -> Decimal:
        if v > Decimal("10000"):
            raise ValueError("Amount exceeds maximum")
        return v.quantize(Decimal("0.01"))

    class Config:
        json_schema_extra = {"example": {"amount": "99.99", "currency": "USD"}}
```

### Error Handling

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
        status_code=status.HTTP_402_PAYMENT_REQUIRED, detail="Insufficient funds"
    )
```

### Async/Await Patterns

```python
import httpx


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
```

### FastAPI Endpoint Structure

```python
from fastapi import APIRouter, Depends, status

router = APIRouter(prefix="/api/v1/payments", tags=["payments"])


@router.post(
    "/",
    response_model=PaymentResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a payment",
)
async def create_payment(
    payment: PaymentRequest,
    current_user: User = Depends(get_current_user),
    payment_service: PaymentService = Depends(),
) -> PaymentResponse:
    """
    Create a new payment.

    - **amount**: Payment amount (max $10,000)
    - **currency**: Three-letter currency code
    """
    return await payment_service.create_payment(payment, current_user.id)
```

### Testing Patterns

```python
from decimal import Decimal
from unittest.mock import AsyncMock, patch

import pytest


@pytest.fixture
def payment_service():
    """Fixture providing payment service instance."""
    return PaymentService(api_key="test_key")


@pytest.mark.asyncio
async def test_create_payment_success(payment_service):
    """Test successful payment creation."""
    with patch("httpx.AsyncClient") as mock_client:
        mock_response = AsyncMock()
        mock_response.json.return_value = {"id": "pay_123", "status": "succeeded"}
        mock_client.return_value.__aenter__.return_value.post.return_value = (
            mock_response
        )

        result = await payment_service.create_payment(payment_request, "user_123")

        assert result.payment_id == "pay_123"
        assert result.status == "succeeded"


@pytest.mark.parametrize(
    "amount,error",
    [
        (Decimal("0"), "Amount must be positive"),
        (Decimal("-10"), "Amount must be positive"),
        (Decimal("10001"), "Amount exceeds maximum"),
    ],
)
def test_payment_validation_errors(amount, error):
    """Test payment validation with invalid amounts."""
    with pytest.raises(ValidationError, match=error):
        PaymentRequest(amount=amount, currency="USD", payment_method_id="pm_123")
```

### Security Patterns

```python
# Input Validation
import re

from pydantic import field_validator


class UserRegistration(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8, max_length=100)

    @field_validator("password")
    @classmethod
    def validate_password(cls, v: str) -> str:
        if not re.search(r"[A-Z]", v):
            raise ValueError("Password must contain uppercase letter")
        return v


# PII Redaction
def redact_email(email: str) -> str:
    """Redact email: user@example.com -> u***@example.com"""
    user, domain = email.split("@", 1)
    return f"{user[0]}***@{domain}"


logger.info(f"Processing payment for {redact_email(user_email)}")
```

## Detailed Documentation

For comprehensive guides and examples, see:

### Standards

- [Python Standards](docs/standards/python-standards.md) - Type hints, docstrings, error handling, code quality
- [FastAPI Patterns](docs/standards/fastapi-patterns.md) - Endpoint structure, middleware, authentication, rate limiting
- [Testing Guidelines](docs/standards/testing-guidelines.md) - Test organization, fixtures, coverage requirements

### Workflows

- [Feature Development](docs/workflows/feature-development.md) - Complete PRP workflow for implementing features
- [Bug Fixing](docs/workflows/bug-fixing.md) - Debug and fix workflow with regression prevention
- [Code Review](docs/workflows/code-review.md) - Code review checklist and common issues
- [Agent Delegation](docs/workflows/agent-delegation.md) - Sub-agent delegation patterns and handoffs

### Examples

- [API Endpoint Examples](docs/examples/api-endpoint-examples.md) - CRUD, payments, uploads, search, batch operations
- [Pydantic Model Examples](docs/examples/pydantic-examples.md) - Validation, nested models, serialization
- [Async/Await Examples](docs/examples/async-examples.md) - Parallel calls, timeouts, error handling, testing

## Environment Variables

```bash
# Application
ENV_FOR_DYNACONF=dev # Environment (dev, staging, production)
PYTHONPATH=src:.     # Python path
DEBUG=true           # Debug mode

# Database
OPERATIONAL_DB_PATH=./data/operational.db
ANALYTICS_DB_PATH=./data/analytics.db

# External Services
STRIPE_API_KEY=sk_test_...
LINEAR_API_KEY=lin_api_...
NOTION_API_KEY=secret_...

# Logging
LOG_LEVEL=INFO  # Logging level
LOG_FORMAT=json # json or text

# Testing
PYTEST_TIMEOUT=30 # Test timeout seconds
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

**AI Patterns:**

- Tools follow tool-design-pattern
- Structured JSON responses
- Request ID tracking
- Comprehensive error handling

## Common Workflows

### Creating a New API Endpoint

```bash
# 1. Use /api command
/api

# 2. Implement (models, service, route)

# 3. Test
pytest tests/integration/test_api.py -v

# 4. Quality check
/check

# 5. Commit
git add .
git commit -m "Add payment history endpoint"
```

### Fixing Code Quality Issues

```bash
# 1. Run quality checks
/check

# 2. Auto-fix what's possible
/fix

# 3. Fix remaining issues manually

# 4. Verify all checks pass
/check

# 5. Commit
git add .
git commit -m "Fix code quality issues"
```

### Implementing a Feature from Spec

```bash
# 1. Activate implement-feature agent
"Implement user payment history API from spec"

# 2. Agent implements (models, service, endpoint, tests, docs)

# 3. Review and test
pytest tests/ -v

# 4. Quality check
/check

# 5. Commit
git add .
git commit -m "Implement payment history feature"
```

## Important Notes

- **Always use type hints** - No untyped code allowed
- **Pydantic for validation** - Never validate manually
- **Async by default** - Use async/await for I/O operations
- **Test everything** - Aim for 90%+ coverage
- **Security first** - Always redact PII, validate inputs
- **Quality gates** - Pre-commit hooks must pass
- **Structured responses** - Use Pydantic models for API responses
- **Error handling** - Specific exceptions with proper HTTP status codes

## Getting Help

**Commands:**

- `/fix` - Auto-fix issues
- `/check` - Verify quality
- `/api` - Create endpoints
- `/test` - Run tests
- `/lint` - Check code

**Agents:**

- Ask for code review
- Request feature implementation
- Debug test failures
- Add agent tools
- Optimize queries

**Documentation:**

- See `docs/` directory for detailed guides
- Each workflow has step-by-step instructions
- Examples show practical implementations

---

This setup is designed for maximum productivity in Python AI engineering. All commands, agents, and skills work together to maintain high code quality while moving fast.
