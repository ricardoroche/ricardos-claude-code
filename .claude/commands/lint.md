---
description: Run Python linting and type checking to identify code quality issues
---

Run comprehensive Python linting and type checking:

1. **Ruff Linter:**
   ```bash
   ruff check .
   ```
   - Checks for code quality issues
   - Identifies unused imports
   - Finds potential bugs
   - Enforces style guidelines

2. **Type Checking with mypy:**
   ```bash
   mypy .
   ```
   - Validates type hints
   - Finds type inconsistencies
   - Ensures type safety

**What this checks:**
- ✅ Code style compliance
- ✅ Unused variables and imports
- ✅ Potential bugs and anti-patterns
- ✅ Type hint correctness
- ✅ Import organization
- ✅ Complexity issues

**Usage:**
```bash
/lint
```

**Best for:**
- Code reviews
- Before committing
- Identifying quality issues
- Ensuring type safety

**Note:** This command only reports issues. Use `/fix` to automatically fix issues where possible.
