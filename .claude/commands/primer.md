---
description: Prime Claude with comprehensive project context using Serena semantic code retrieval
---

# Project Context Primer

Prime Claude Code with comprehensive project understanding by gathering:

## 1. Project Structure Analysis

Use Serena MCP to understand the codebase structure:

**Ask Serena to:**
- List all main modules and their purposes
- Identify key entry points (main.py, app.py, __init__.py)
- Map out the project's architecture
- Find core abstractions and patterns

**Example queries:**
- "What are the main modules in this project?"
- "Show me the project's architecture and key components"
- "Where are the core business logic functions?"

## 2. Code Pattern Discovery

**Identify:**
- Common patterns used throughout the codebase
- How errors are handled
- How configuration is managed
- How logging is implemented
- Testing patterns and fixtures

**Example queries:**
- "How do we handle errors in this codebase?"
- "Show me the configuration management pattern"
- "What testing patterns do we use?"

## 3. API & Integration Points

**Find:**
- API endpoints and routes
- External service integrations
- Database models and schemas
- Authentication/authorization patterns

**Example queries:**
- "List all API endpoints"
- "What external services do we integrate with?"
- "Show me the database models"

## 4. Recent Changes & Context

**Review:**
- Recent git commits (last 10-20)
- Current branch and work in progress
- README and documentation files
- CLAUDE.md for project-specific guidelines

## 5. Development Environment

**Gather:**
- Python version requirements (pyproject.toml, .python-version)
- Dependencies and their purposes
- Environment variables needed (.env.example)
- Development setup instructions

## Primer Checklist

When starting work on a new task, prime Claude by:

- [ ] **Use Serena to understand codebase structure**
  - "Serena, what are the main modules in this project?"
  - "Show me the architecture and key abstractions"

- [ ] **Review project documentation**
  - Read README.md
  - Read CLAUDE.md (project-specific patterns)
  - Check for docs/ directory

- [ ] **Understand the specific area you'll work in**
  - "Where do we handle [feature area]?"
  - "Show me existing code related to [task]"

- [ ] **Identify patterns to follow**
  - "How do we structure API endpoints?"
  - "What's the error handling pattern?"
  - "Show me test examples for similar code"

- [ ] **Check dependencies and environment**
  - Review pyproject.toml
  - Check .env.example for required variables

## Example Primer Session

```
/primer

[Claude will then ask Serena:]

1. "Serena, give me an overview of this project's structure"
2. "What are the main entry points and how is the code organized?"
3. "Show me where we handle [relevant feature area for current task]"
4. "What patterns do we use for error handling and logging?"

[Claude will then read:]
- README.md
- CLAUDE.md
- Recent git log (last 20 commits)
- pyproject.toml for dependencies

[Result: Claude has full project context and is ready to work]
```

## When to Use /primer

**Use this command:**
- ✅ Starting a new task or feature
- ✅ Returning to a project after time away
- ✅ When Claude seems to lack project context
- ✅ Before making significant changes
- ✅ When onboarding to a new codebase

**Skip this command:**
- ❌ For quick one-off tasks
- ❌ When continuing immediate work
- ❌ For small fixes with known context

## Serena Tips

Serena creates an index first to read code efficiently and stores memory in `.serena/memories/` to understand the project better. This means:

1. **First use may take longer** - Serena builds its index
2. **Subsequent uses are fast** - Index is already built
3. **Serena understands semantics** - Ask "where do we handle authentication?" not just grep patterns
4. **Multi-language support** - Works with Python, JavaScript, TypeScript, Rust, Go, and more

## Advanced Primer Patterns

### For Large Codebases
Ask Serena to:
- "Give me a high-level architecture overview"
- "What are the top 5 most important modules?"
- "Show me the data flow from API to database"

### For API Development
Ask Serena to:
- "Show me all FastAPI endpoints"
- "What's the pattern for creating new endpoints?"
- "Where is authentication/authorization handled?"

### For Testing
Ask Serena to:
- "Show me the test structure"
- "What fixtures are available?"
- "Give me examples of tests for [feature type]"

### For Debugging
Ask Serena to:
- "Where is [function/class] called from?"
- "Show me the error handling for [feature]"
- "What depends on [module]?"

---

**Note**: The primer command helps Claude Code work more efficiently by reducing the need to read entire files. Serena's semantic understanding means Claude can focus on relevant code, saving tokens and time.
