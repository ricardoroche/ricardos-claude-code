# Python Best Practices Summary

Essential best practices for Python AI and data engineering projects.

## Table of Contents

1. [Type Safety](#type-safety)
2. [Code Quality](#code-quality)
3. [Testing](#testing)
4. [Security](#security)
5. [Async Patterns](#async-patterns)
6. [Documentation](#documentation)
7. [Development Workflow](#development-workflow)

---

## Type Safety

**Principles:**
- All functions have type hints
- Mypy runs in strict mode
- No `Any` without justification
- Use generic types for collections

**Implementation:**
```python
# Good
def process_items(items: list[str]) -> dict[str, int]:
    return {item: len(item) for item in items}

# Bad
def process_items(items):
    return {item: len(item) for item in items}
```

**Tools:**
- mypy for static type checking
- Type hints on all public functions
- Generic types: `list[T]`, `dict[K, V]`, `Optional[T]`

---

## Code Quality

**Principles:**
- Ruff for linting and formatting
- Pre-commit hooks enforce standards
- 88 character line length
- Follow PEP 8 style guide

**Naming Conventions:**
- `snake_case` for functions, variables, methods
- `PascalCase` for classes, Pydantic models
- `UPPER_CASE` for constants
- Prefix private members with `_`

**Import Ordering:**
1. Standard library imports
2. Third-party imports
3. Local application imports

**Prohibited Patterns:**
- No `Any` types without justification
- No untyped function signatures
- No manual validation (use Pydantic)
- No sync code for I/O operations
- No bare `except:` clauses

---

## Testing

**Principles:**
- Unit and integration tests
- Mock external dependencies
- Test success and error paths
- Use pytest fixtures
- 80%+ test coverage minimum

**Test Structure:**
```python
# Arrange-Act-Assert pattern
def test_payment_processing():
    # Arrange
    payment = PaymentRequest(amount=Decimal("99.99"))

    # Act
    result = process_payment(payment)

    # Assert
    assert result.status == "succeeded"
```

**Tools:**
- pytest for test framework
- pytest-cov for coverage reporting
- pytest-asyncio for async tests
- unittest.mock for mocking
- pytest.mark.parametrize for multiple test cases

**Coverage Requirements:**
- Minimum 80% line coverage
- Critical paths must have 100% coverage
- Test both success and error scenarios
- Mock external dependencies (APIs, databases)

---

## Security

**Principles:**
- PII redacted in logs
- Input validation with Pydantic
- Parameterized SQL queries
- Rate limiting on public APIs

**PII Handling:**
```python
# Always redact PII in logs
logger.info(f"User {redact_email(user.email)} logged in")

# Never log sensitive data
# Bad: logger.info(f"Password: {password}")
# Good: logger.info("Password validation successful")
```

**Input Validation:**
- Use Pydantic for all input validation
- Validate email addresses with EmailStr
- Enforce password complexity requirements
- Sanitize all user input

**API Security:**
- Implement rate limiting
- Use authentication and authorization
- Validate all request data
- Return appropriate error codes
- Never expose internal errors to users

**Secret Management:**
- Use environment variables for secrets
- Never commit secrets to version control
- Rotate API keys regularly
- Use secure secret storage (AWS Secrets Manager, etc.)

---

## Async Patterns

**Principles:**
- Use async/await for I/O
- Parallel operations with asyncio.gather
- Proper exception handling
- Timeout handling

**Async I/O:**
```python
# Good - async for I/O
async def fetch_data(url: str) -> dict:
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        return response.json()

# Bad - sync for I/O
def fetch_data(url: str) -> dict:
    response = requests.get(url)
    return response.json()
```

**Parallel Operations:**
```python
# Run multiple async operations concurrently
async def fetch_all(urls: list[str]) -> list[dict]:
    async with httpx.AsyncClient() as client:
        tasks = [client.get(url) for url in urls]
        responses = await asyncio.gather(*tasks)
        return [r.json() for r in responses]
```

**Best Practices:**
- Always use `async with` for context managers
- Add timeouts to prevent hanging
- Handle exceptions in async code
- Don't mix sync and async code
- Use asyncio.gather for parallel operations

---

## Documentation

**Principles:**
- Clear, comprehensive docstrings
- Follow Google style
- Document parameters, returns, exceptions
- Include usage examples

**Docstring Format:**
```python
def process_transaction(
    amount: Decimal,
    user_id: str,
    metadata: Optional[dict] = None
) -> TransactionResult:
    """
    Process a financial transaction.

    Args:
        amount: Transaction amount in base currency
        user_id: Unique user identifier
        metadata: Optional transaction metadata

    Returns:
        TransactionResult containing status and transaction ID

    Raises:
        ValidationError: If amount is invalid
        ServiceError: If external service fails
    """
    pass
```

**Documentation Standards:**
- Document all public functions and classes
- Use imperative mood ("Return" not "Returns")
- Keep docstrings concise but complete
- Include type information in docstrings for clarity

---

## Development Workflow

**Daily Workflow:**
1. Pull latest changes from main
2. Create feature branch
3. Implement feature with tests
4. Run `/fix` to auto-fix issues
5. Run `/check` to verify quality
6. Commit changes
7. Create pull request

**Before Committing:**
- Run `/fix` to auto-fix linting issues
- Run `/check` to verify tests pass
- Ensure type checking passes (mypy)
- Review code changes
- Write clear commit messages

**Pre-commit Checks:**
- Linting passes (ruff check)
- Type checking passes (mypy)
- Tests pass (pytest)
- Coverage meets minimum threshold

**Pull Request Checklist:**
- All tests pass
- Code review completed
- Documentation updated
- Breaking changes noted
- Migration guide provided (if needed)

---

## Quality Gates

**Continuous Quality:**
- Pre-commit hooks enforce standards
- Automated tests on every commit
- Type checking in CI/CD
- Coverage reporting

**Quality Metrics:**
- Test coverage: 80%+ minimum
- Type coverage: 100%
- Linting: 0 errors
- Security: 0 vulnerabilities

**Tools Integration:**
- ruff for linting and formatting
- mypy for type checking
- pytest for testing
- pytest-cov for coverage
- pre-commit for automation

---

## Related Documentation

- [Python Patterns Guide](./python-patterns.md) - Comprehensive code examples
- [Architecture Guide](./architecture.md) - Project structure and design
- [README](../README.md) - User documentation and setup
- [Skills Directory](../.claude/skills/) - Pattern-specific guidance

---

## Continuous Improvement

**Review and Update:**
- Review best practices quarterly
- Update based on team feedback
- Incorporate new tool capabilities
- Learn from production issues

**Stay Current:**
- Follow Python PEPs
- Monitor security advisories
- Update dependencies regularly
- Adopt new testing patterns

**Team Collaboration:**
- Share learnings in code reviews
- Document new patterns
- Update skills and documentation
- Mentor team members
