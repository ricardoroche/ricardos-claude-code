---
description: Run pytest test suite with coverage and detailed output
argument-hint: test path or pattern (optional)
---

Run the pytest test suite with comprehensive options:

## Default Command:
```bash
pytest --verbose --tb=short --cov=. --cov-report=term-missing
```

## With Specific Test Path/Pattern:
```bash
pytest $1 --verbose --tb=short --cov=. --cov-report=term-missing
```

## Options Explained:

- `--verbose`: Show detailed test output
- `--tb=short`: Show short traceback on failures
- `--cov=.`: Generate coverage report for current directory
- `--cov-report=term-missing`: Show lines not covered by tests

## Usage Examples:

**Run all tests:**
```bash
/test
```

**Run specific test file:**
```bash
/test tests/test_api.py
```

**Run tests matching pattern:**
```bash
/test tests/test_api.py::test_create_user
```

**Run tests in directory:**
```bash
/test tests/unit/
```

## Test Output Includes:

- ✅ Test results (pass/fail)
- ✅ Execution time per test
- ✅ Code coverage percentage
- ✅ Lines missing coverage
- ✅ Detailed failure tracebacks

## Additional Pytest Options:

Add these flags as needed:
- `-k "pattern"`: Run tests matching pattern
- `-x`: Stop on first failure
- `--lf`: Run last failed tests
- `--ff`: Run failures first, then others
- `--pdb`: Drop into debugger on failure
- `-s`: Show print statements
- `--disable-warnings`: Hide warnings

**Best for:**
- Running test suites
- Checking test coverage
- Debugging failing tests
- Test-driven development
