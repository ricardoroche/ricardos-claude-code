---
description: Auto-fix Python linting issues and format code with ruff and black
---

Auto-fix linting issues, format code, and run type checking:

1. **Run ruff to fix linting issues:**
   ```bash
   ruff check --fix .
   ```

2. **Format code with ruff:**
   ```bash
   ruff format .
   ```

3. **Run mypy for type checking:**
   ```bash
   mypy .
   ```

This command will automatically:
- Fix auto-fixable linting issues (unused imports, etc.)
- Format all Python code to match style guidelines
- Report any type checking errors that need manual attention

**Usage:**
```bash
/fix
```

**Best for:**
- Before committing code
- After writing new features
- Cleaning up code quality issues
