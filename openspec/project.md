# Project Context

## Purpose

This is a **Python AI Engineering development environment** designed for productive development of AI-powered applications, APIs, and intelligent systems. The setup emphasizes:

- Building modern Python applications with FastAPI
- Developing AI agents with proper tool design patterns
- Type safety and async/await patterns throughout
- Comprehensive testing and code quality automation
- AI-first development workflows

**Key Philosophy:** Type-safe Python with full mypy validation, modern async patterns, Pydantic for all data validation, comprehensive pytest testing, and automated code quality gates.

## Tech Stack

### Core Language & Runtime
- **Python 3.11+** - Primary language with modern type system
- **uv** - Fast Python package installer (preferred over pip)

### Web Framework & API
- **FastAPI** - Modern async web framework for building APIs
- **Uvicorn** - ASGI server for running FastAPI applications
- **Pydantic v2** - Data validation and serialization with type hints
- **httpx** - Async HTTP client for external API calls

### Code Quality & Type Safety
- **Ruff** - Fast Python linter and formatter (replaces black, isort, flake8)
- **mypy** - Static type checker running in strict mode
- **pytest** - Testing framework with async support
- **pytest-cov** - Code coverage measurement (80%+ minimum)
- **pytest-asyncio** - Async test support

### Database & Data
- **DuckDB** - Embedded analytical database (operational & analytics)
- **SQL** - Primary query language for data operations

### Configuration & Environment
- **Dynaconf** - Configuration management with environment support
- **python-dotenv** - Environment variable management

### AI & Integrations
- **Model Context Protocol (MCP)** - Standard protocol for AI tool integration
- **Anthropic Claude** - Primary AI model for agent development

### Development Tools
- **Git** - Version control with pre-commit hooks
- **GitHub CLI (gh)** - GitHub operations from command line

## Project Conventions

### Code Style

**Type Hints (Mandatory):**
```python
from decimal import Decimal
from typing import Optional, Dict, Any

def process_payment(
    amount: Decimal,
    user_id: str,
    metadata: Optional[Dict[str, Any]] = None
) -> PaymentResult:
    """Process a payment transaction."""
    pass
```

**Formatting:**
- **Ruff** handles all formatting (line length: 88 chars)
- **Import ordering:** Standard library → Third party → Local imports
- **Docstrings:** Google-style docstrings on all public functions/classes
- **Naming conventions:**
  - `snake_case` for functions, variables, methods
  - `PascalCase` for classes, Pydantic models
  - `UPPER_CASE` for constants
  - Private members: prefix with `_`

**Prohibited Patterns:**
- No `Any` types without justification
- No untyped function signatures
- No manual validation (use Pydantic)
- No sync code for I/O operations (use async/await)
- No bare `except:` clauses
- No emojis unless explicitly requested

### Architecture Patterns

**Layered Architecture:**
```
api/ (FastAPI routes)
  ↓
services/ (Business logic)
  ↓
repositories/ (Data access)
  ↓
database/ (DuckDB, SQL)
```

**Separation of Concerns:**
- **API Layer:** Route handlers, request/response models, validation
- **Service Layer:** Business logic, orchestration, external integrations
- **Repository Layer:** Data access patterns, queries
- **Models:** Pydantic schemas for validation and serialization

**Key Patterns:**
- **Dependency Injection:** FastAPI `Depends()` for services
- **Repository Pattern:** Abstract data access behind interfaces
- **Service Pattern:** Business logic in dedicated service classes
- **Factory Pattern:** Configuration and service initialization
- **Async/Await:** All I/O operations use async patterns

**AI Agent Design:**
- Base agent class with tool registry
- Tools follow Pydantic input schemas
- Structured JSON responses
- Request ID tracking for debugging
- PII redaction in logs

### Testing Strategy

**Coverage Requirements:**
- **Minimum:** 80% code coverage
- **Target:** 90%+ code coverage
- **All new code:** Must include tests

**Test Organization:**
```
tests/
├── unit/           # Fast, isolated unit tests
├── integration/    # API and service integration tests
└── conftest.py     # Shared fixtures
```

**Testing Patterns:**
```python
import pytest
from unittest.mock import AsyncMock, patch

@pytest.fixture
def payment_service():
    """Fixture providing payment service instance."""
    return PaymentService(api_key="test_key")

@pytest.mark.asyncio
async def test_create_payment_success(payment_service):
    """Test successful payment creation."""
    # Arrange: Mock external dependencies
    with patch("httpx.AsyncClient") as mock_client:
        mock_response = AsyncMock()
        mock_response.json.return_value = {"id": "pay_123"}

        # Act: Call the service
        result = await payment_service.create_payment(request)

        # Assert: Verify results
        assert result.payment_id == "pay_123"

@pytest.mark.parametrize("amount,error", [
    (Decimal("0"), "Amount must be positive"),
    (Decimal("-10"), "Amount must be positive"),
])
def test_validation_errors(amount, error):
    """Test validation with invalid inputs."""
    with pytest.raises(ValidationError, match=error):
        PaymentRequest(amount=amount)
```

**Test Requirements:**
- Descriptive test names explaining what is tested
- Fixtures for common test data
- Mock external dependencies (APIs, databases)
- Test both success and error paths
- Async tests use `@pytest.mark.asyncio`
- Parametrize tests for multiple scenarios

### Git Workflow

**Branching Strategy:**
- `main` - Primary development branch
- Feature branches: `feature/description`
- Bug fixes: `fix/description`

**Pre-Commit Quality Gate:**
Automated hooks run before `git commit`:
```bash
ruff check .   # Linting
mypy .         # Type checking
pytest --quiet # Tests
```

**Commit must pass all checks before being allowed.**

**Commit Message Format:**
```
Add payment history endpoint

Implements new GET /api/v1/payments/history endpoint
with pagination and filtering support.

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

**Post-Tool Hooks:**
- Auto-format Python files after editing (ruff format + ruff check --fix)
- Auto-sync dependencies after pyproject.toml changes (uv sync)
- Auto-run tests after test file changes (pytest)

**Pull Request Requirements:**
- All tests passing
- Code coverage maintained/improved
- Type checking passes
- No linting errors
- Documentation updated

## Domain Context

### AI Agent Development

**Tool Design Pattern:**
- Pydantic input schemas with field descriptions
- `@tool` decorator for agent tools
- Structured JSON responses with consistent format
- Request ID tracking for debugging
- Comprehensive error handling with specific error types
- PII redaction in logs (emails, phone numbers, SSNs)

**Agent Architecture:**
- Base agent class with shared functionality
- Tool registry for dynamic tool loading
- Prompt templates in dedicated directory
- Context management across conversations

### API Development

**FastAPI Conventions:**
- API versioning: `/api/v1/`, `/api/v2/`
- RESTful resource naming
- Pydantic request/response models
- Proper HTTP status codes
- OpenAPI documentation with examples
- Authentication via `Depends(get_current_user)`
- Rate limiting on public endpoints

### Data Validation

**Pydantic Models:**
- All API inputs/outputs use Pydantic models
- Field validators for complex validation
- Custom types for domain concepts (Email, PhoneNumber, etc.)
- JSON schema generation for documentation
- Serialization to/from database formats

## Important Constraints

### Technical Constraints

**Type Safety:**
- All code must pass mypy strict mode
- No `Any` types without explicit justification
- Type hints required on all functions

**Code Quality:**
- Must pass ruff linting
- Must pass all tests with 80%+ coverage
- Pre-commit hooks must pass before commit

**Performance:**
- Async/await required for all I/O operations
- Database queries must be optimized (no N+1 queries)
- API response times < 200ms for standard operations

### Security Constraints

**PII Protection:**
- All PII must be redacted in logs
- Email, phone numbers, SSNs must never appear in logs
- User identifiable information requires explicit handling

**Input Validation:**
- All user inputs validated via Pydantic models
- SQL injection prevention via parameterized queries
- XSS prevention via proper response encoding
- OWASP Top 10 vulnerability awareness

**Authentication & Authorization:**
- Protected endpoints require authentication
- Rate limiting on public endpoints
- API keys stored in environment variables (never in code)

### Development Constraints

**No Emoji Policy:**
- Emojis prohibited in code, commits, and responses unless explicitly requested
- Exception: Commit footers (`🤖 Generated with Claude Code`)

**Documentation:**
- Public functions require docstrings
- Complex logic requires inline comments
- API endpoints require OpenAPI documentation
- Architecture decisions documented in docs/

## External Dependencies

### Integrated Services

**Linear (Issue Tracking):**
- Environment variable: `LINEAR_API_KEY`
- MCP server: `mcp-server-linear`
- Usage: Task tracking, issue management

**Notion (Documentation):**
- Environment variable: `NOTION_API_KEY`
- MCP server: `mcp-server-notion`
- Usage: Project documentation, knowledge base

**Stripe (Payments Example):**
- Environment variable: `STRIPE_API_KEY`
- Usage: Payment processing examples
- Test mode keys for development

### MCP Servers

**memory (context7/mcp-server-memory):**
- Persistent context across sessions
- Store project patterns and decisions

**context7 (context7/mcp-server-context):**
- Semantic code search
- Find similar implementations

**duckdb-operational:**
- Database: `./data/operational.db`
- Purpose: Operational data (users, transactions, state)

**duckdb-analytics:**
- Database: `./data/analytics.db`
- Purpose: Analytics and reporting

### Development Dependencies

**GitHub:**
- GitHub CLI (`gh`) for PR creation
- GitHub Actions for CI/CD (optional)

**Package Registry:**
- PyPI for Python packages
- uv for fast package installation
