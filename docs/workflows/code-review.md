# Code Review Workflow

Complete workflow for conducting thorough Python code reviews with automated quality gates.

## Workflow Overview

**Prompt:**
```
"Review [file/PR/feature] for code quality"
```

**Sequence:**
1. `code-reviewer` agent activates
2. Analyzes code for patterns
3. Checks type hints coverage
4. Validates error handling
5. Reviews security (PII, injection, etc.)
6. Checks test coverage
7. Validates documentation
8. Generates prioritized feedback
9. If issues found: delegates to `fix-pr-comments`
10. `fix-pr-comments` addresses all feedback
11. `code-reviewer` verifies fixes
12. Ready for merge

## Review Checklist

### Code Quality
- [ ] Type hints on all functions
- [ ] Docstrings on public functions
- [ ] Variable names descriptive
- [ ] Functions are focused (single responsibility)
- [ ] No code duplication
- [ ] Consistent code style

### Logic & Correctness
- [ ] Logic is correct and clear
- [ ] Edge cases handled
- [ ] Error handling appropriate
- [ ] No off-by-one errors
- [ ] Null/None checks where needed

### Testing
- [ ] Tests for new functionality
- [ ] Tests for error cases
- [ ] Tests are meaningful (not just coverage)
- [ ] Mocks used appropriately
- [ ] Tests are maintainable

### Security
- [ ] No PII in logs
- [ ] Input validation present
- [ ] No SQL injection risks
- [ ] No hardcoded secrets
- [ ] Authentication/authorization checked

### Performance
- [ ] No obvious performance issues
- [ ] Database queries optimized
- [ ] No N+1 query problems
- [ ] Caching used appropriately
- [ ] Resource cleanup (connections, files)

### API Design
- [ ] Pydantic models well-designed
- [ ] Request/response schemas clear
- [ ] Error responses consistent
- [ ] API versioning considered
- [ ] OpenAPI docs accurate

## Example Review Report

```markdown
# Code Review Report

## Critical Issues (Must Fix)
- [ ] Missing input validation on payment amount (line 45)
- [ ] SQL injection vulnerability in query (line 102)
- [ ] PII exposed in error logs (line 78)

## High Priority (Should Fix)
- [ ] Missing type hints on 3 functions
- [ ] Inconsistent error handling
- [ ] Missing docstrings on public methods

## Medium Priority (Nice to Fix)
- [ ] Code formatting inconsistencies
- [ ] Import organization
- [ ] Variable naming could be clearer

## Positive Observations
- Good use of Pydantic for validation
- Comprehensive test coverage
- Clear API documentation
```

## Success Criteria

- All critical issues addressed
- High priority items fixed
- Code quality standards met
- Tests updated if needed
- Documentation accurate

## Common Issues to Look For

### 1. Missing Type Hints

```python
# BAD
def process_payment(amount, user_id):
    return create_charge(amount, user_id)

# GOOD
def process_payment(amount: Decimal, user_id: str) -> PaymentResult:
    """Process payment for user."""
    return create_charge(amount, user_id)
```

### 2. Poor Error Handling

```python
# BAD
try:
    result = api_call()
except:  # Too broad
    pass  # Silent failure

# GOOD
try:
    result = api_call()
except HTTPStatusError as e:
    logger.error(f"API call failed: {e}", exc_info=True)
    raise PaymentError("Payment service unavailable") from e
```

### 3. Security Issues

```python
# BAD - SQL Injection
query = f"SELECT * FROM users WHERE email = '{email}'"

# GOOD - Parameterized Query
query = "SELECT * FROM users WHERE email = ?"
result = db.execute(query, [email])

# BAD - PII in Logs
logger.info(f"User login: {user.email}")

# GOOD - PII Redacted
logger.info(f"User login: {redact_email(user.email)}")
```

### 4. No Tests

```python
# Every new function needs tests

# Implementation
def calculate_discount(amount: Decimal, percent: Decimal) -> Decimal:
    """Calculate discounted amount."""
    return amount * (1 - percent / 100)

# Tests needed
def test_calculate_discount_valid():
    assert calculate_discount(Decimal("100"), Decimal("10")) == Decimal("90")

def test_calculate_discount_zero():
    assert calculate_discount(Decimal("100"), Decimal("0")) == Decimal("100")

def test_calculate_discount_full():
    assert calculate_discount(Decimal("100"), Decimal("100")) == Decimal("0")
```

## Commands to Run

```bash
# Automated review
Use: `code-reviewer` agent for automated review

# Quality checks
/check

# Test validation
/test
```
