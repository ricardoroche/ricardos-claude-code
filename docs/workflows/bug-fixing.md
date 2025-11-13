# Bug Investigation & Fix Workflow

Complete PRP workflow for debugging and fixing issues in Python applications.

## Workflow Overview

**Prompt:**
```
"Debug and fix [problem description]"
```

**Sequence:**
1. `debug-test-failure` agent activates
2. Reproduces the issue
3. Analyzes error messages and stack traces
4. Identifies root cause
5. Creates failing test demonstrating bug
6. Implements fix
7. Verifies test now passes
8. Runs full test suite (`/test`)
9. Runs quality checks (`/check`)
10. Delegates to `code-reviewer` for safety review
11. `code-reviewer` checks for side effects
12. Ready for commit

## Expected Pattern

```python
# New test (written first)
tests/test_bug_fix.py
def test_bug_reproduction():
    """Reproduce the reported bug."""
    # This test should fail before fix
    result = problematic_function()
    assert result == expected_value

# Fix implementation
src/module/problematic_file.py
- Root cause addressed
- Edge case handled
- Type safety maintained

# Updated tests
tests/test_bug_fix.py
- Test now passes
- Regression prevention
- Related scenarios tested
```

## Success Criteria

- Bug reproduced with failing test
- Root cause identified and documented
- Fix implemented and test passes
- No test regressions
- Code review confirms safety
- Documentation updated if needed

## Example: Fixing Payment Processing Bug

### Step 1: Reproduce the Issue

```python
# tests/test_payment_bug.py
import pytest
from decimal import Decimal

def test_payment_rounding_bug():
    """
    Reproduce bug where payment amounts are incorrectly rounded.

    Bug report: Payments of $99.995 are charged as $100.00 instead of $99.99
    """
    payment = PaymentRequest(
        amount=Decimal("99.995"),
        currency="USD",
        payment_method_id="pm_123"
    )

    # This test fails before fix - amount becomes 100.00
    assert payment.amount == Decimal("99.99")
```

### Step 2: Identify Root Cause

```python
# src/models/api/payment.py

# BEFORE (buggy code)
class PaymentRequest(BaseModel):
    amount: Decimal = Field(gt=0, description="Payment amount")

    # Problem: No quantization, Python rounds up
```

### Step 3: Implement Fix

```python
# src/models/api/payment.py

# AFTER (fixed code)
from pydantic import field_validator

class PaymentRequest(BaseModel):
    amount: Decimal = Field(gt=0, decimal_places=2, description="Payment amount")

    @field_validator('amount')
    @classmethod
    def quantize_amount(cls, v: Decimal) -> Decimal:
        """Round amount to 2 decimal places, rounding down."""
        from decimal import ROUND_DOWN
        return v.quantize(Decimal("0.01"), rounding=ROUND_DOWN)
```

### Step 4: Verify Fix

```bash
# Run the specific test
pytest tests/test_payment_bug.py -v

# Run full test suite
pytest tests/

# Quality checks
/check
```

### Step 5: Add Regression Tests

```python
# tests/test_payment_bug.py
@pytest.mark.parametrize("input_amount,expected_amount", [
    (Decimal("99.995"), Decimal("99.99")),   # Original bug
    (Decimal("99.994"), Decimal("99.99")),   # Round down
    (Decimal("99.999"), Decimal("99.99")),   # Round down
    (Decimal("100.00"), Decimal("100.00")),  # Exact
    (Decimal("0.001"), Decimal("0.00")),     # Very small
])
def test_payment_amount_rounding(input_amount, expected_amount):
    """Test that payment amounts are correctly rounded down."""
    payment = PaymentRequest(
        amount=input_amount,
        currency="USD",
        payment_method_id="pm_123"
    )
    assert payment.amount == expected_amount
```

## Common Bug Patterns

### 1. Async/Await Mistakes

```python
# BUG: Missing await
async def fetch_user(user_id: str):
    user = db.get_user(user_id)  # Should be: await db.get_user(user_id)
    return user

# FIX:
async def fetch_user(user_id: str) -> User:
    user = await db.get_user(user_id)
    return user

# TEST:
@pytest.mark.asyncio
async def test_fetch_user_awaits_properly():
    """Test that fetch_user properly awaits database call."""
    user = await fetch_user("user_123")
    assert user is not None
```

### 2. Type Errors

```python
# BUG: Type mismatch
def calculate_total(items: List[Dict]) -> int:
    return sum(item["price"] for item in items)  # Returns Decimal, not int

# FIX:
from decimal import Decimal

def calculate_total(items: List[Dict[str, Any]]) -> Decimal:
    return sum(Decimal(str(item["price"])) for item in items)

# TEST:
def test_calculate_total_returns_decimal():
    """Test that calculate_total returns Decimal type."""
    items = [{"price": 10.50}, {"price": 20.99}]
    result = calculate_total(items)
    assert isinstance(result, Decimal)
    assert result == Decimal("31.49")
```

### 3. Null/None Handling

```python
# BUG: No None check
def get_user_email(user_id: str) -> str:
    user = find_user(user_id)
    return user.email  # Crashes if user is None

# FIX:
def get_user_email(user_id: str) -> Optional[str]:
    """Get user email, returns None if user not found."""
    user = find_user(user_id)
    return user.email if user else None

# TEST:
def test_get_user_email_handles_not_found():
    """Test that get_user_email returns None for invalid user."""
    email = get_user_email("invalid_id")
    assert email is None
```

### 4. Off-by-One Errors

```python
# BUG: Wrong range
def get_last_n_items(items: List[Any], n: int) -> List[Any]:
    return items[-n-1:]  # Gets n+1 items

# FIX:
def get_last_n_items(items: List[Any], n: int) -> List[Any]:
    """Get last n items from list."""
    return items[-n:] if n > 0 else []

# TEST:
def test_get_last_n_items():
    """Test that get_last_n_items returns correct count."""
    items = [1, 2, 3, 4, 5]
    assert len(get_last_n_items(items, 3)) == 3
    assert get_last_n_items(items, 3) == [3, 4, 5]
```

## Debugging Techniques

### 1. Use Pytest Debugging

```bash
# Run with verbose output
pytest tests/test_file.py -v

# Stop on first failure
pytest tests/ -x

# Show local variables on failure
pytest tests/ -l

# Drop into debugger on failure
pytest tests/ --pdb

# Run specific test
pytest tests/test_file.py::test_function_name
```

### 2. Add Strategic Logging

```python
import logging

logger = logging.getLogger(__name__)

def problematic_function(data: dict) -> Result:
    logger.debug(f"Input data: {data}")

    result = process_data(data)
    logger.debug(f"Processed result: {result}")

    if result is None:
        logger.error("Processing returned None - investigating")

    return result
```

### 3. Isolate the Problem

```python
# Create minimal reproduction
def test_minimal_bug_reproduction():
    """Minimal test case that demonstrates the bug."""
    # Simplest possible code that shows the issue
    input_data = {"amount": 99.995}
    result = process_payment(input_data)
    assert result["charged_amount"] == 99.99  # Fails
```

## Error Investigation Checklist

- [ ] Can you reproduce the bug consistently?
- [ ] Do you have the complete error message and stack trace?
- [ ] Have you identified the specific line causing the issue?
- [ ] Do you understand why the bug occurs?
- [ ] Have you created a failing test?
- [ ] Have you verified the fix works?
- [ ] Have you checked for similar bugs elsewhere?
- [ ] Have you added regression tests?
- [ ] Does the full test suite still pass?
- [ ] Have you documented the root cause?

## Common Mistakes to Avoid

1. **Fixing Symptoms, Not Root Cause**
   - Don't just catch the exception - fix why it happens
   - Understand the underlying issue

2. **No Regression Test**
   - Always add a test that would have caught this bug
   - Prevent the bug from returning

3. **Breaking Other Tests**
   - Run full test suite after fix
   - Ensure no side effects

4. **Incomplete Fix**
   - Check for similar issues in related code
   - Fix all instances, not just one

5. **No Documentation**
   - Document why the bug occurred
   - Add comments explaining the fix

## Best Practices

1. **Write Test First**: Create failing test before implementing fix
2. **Minimal Changes**: Fix only what's necessary
3. **Root Cause Analysis**: Understand why it broke
4. **Regression Prevention**: Add tests to prevent recurrence
5. **Code Review**: Have someone verify the fix
6. **Documentation**: Update docs if behavior changed
7. **Learn from It**: Share knowledge about common bug patterns
