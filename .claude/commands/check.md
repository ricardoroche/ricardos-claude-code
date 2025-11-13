---
description: Run complete quality gate checks (lint, type check, tests, coverage)
---

Run the complete quality gate before committing:

## Quality Checks Performed:

1. **Linting:**
   ```bash
   ruff check .
   ```
   - Code style validation
   - Potential bug detection

2. **Type Checking:**
   ```bash
   mypy .
   ```
   - Type safety validation
   - Type hint correctness

3. **Tests:**
   ```bash
   pytest --verbose --cov=. --cov-report=term-missing
   ```
   - Run all test suites
   - Generate coverage report
   - Identify missing test coverage

4. **Coverage Threshold:**
   - Ensure minimum coverage percentage
   - Report untested code

**What this validates:**
- ✅ All linting rules pass
- ✅ No type errors
- ✅ All tests pass
- ✅ Code coverage meets threshold
- ✅ No regressions introduced

**Usage:**
```bash
/check
```

**Best for:**
- Pre-commit validation
- CI/CD pipeline verification
- Pull request quality gates
- Release readiness checks

**Exit Codes:**
- 0: All checks passed
- Non-zero: One or more checks failed

**Recommended workflow:**
1. Make code changes
2. Run `/fix` to auto-fix issues
3. Run `/check` to validate everything
4. Commit if all checks pass
