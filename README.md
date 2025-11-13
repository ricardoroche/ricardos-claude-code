# Ricardo's Claude Code Setup

My personal Claude Code configuration for productive Python AI engineering. This plugin provides **6 slash commands**, **10 specialized AI agents**, **8 Python pattern skills**, and **7 MCP servers** to supercharge your AI development workflow.

## Quick Install

```bash
# Step 1: Add the marketplace
/plugin marketplace add ricardoroche/ricardos-claude-code

# Step 2: Install the plugin
/plugin install ricardos-claude-code
```

## What's Inside

### 🐍 Python AI Commands (6)

- `/primer` - Prime Claude with project context using Serena semantic code retrieval
- `/fix` - Auto-fix Python issues (ruff, black, mypy)
- `/api` - FastAPI endpoint development with validation
- `/lint` - Python linting and type checking
- `/check` - Quality checks (tests, coverage, types)
- `/test` - Run pytest with appropriate options

### 🤖 Specialized AI Agents (10)

**Code Quality & Review**

- **code-reviewer** - Comprehensive Python code review with security analysis and performance optimization
- **write-unit-tests** - Pytest test generation with good coverage
- **debug-test-failure** - Python test debugging and fixes
- **fix-pr-comments** - Systematically address PR feedback

**Development & Architecture**

- **implement-feature** - Python feature implementation with FastAPI/Strands patterns
- **add-agent-tool** - Add tools to AI agents following best design patterns
- **upgrade-dependency** - Python dependency management and migrations
- **optimize-db-query** - SQL/DuckDB query optimization
- **deep-research-agent** - In-depth research and analysis
- **technical-writer** - Technical documentation and writing

### 📚 Python Pattern Skills (8)

Reusable patterns for consistent code quality:

- **dynaconf-config** - Configuration management patterns
- **async-await-checker** - Async/await best practices
- **structured-errors** - Error handling patterns
- **pydantic-models** - Data validation patterns
- **tool-design-pattern** - AI tool design guidelines
- **docstring-format** - Python documentation standards
- **pii-redaction** - PII handling patterns
- **pytest-patterns** - Testing best practices

### 🔌 MCP Servers (7)

Pre-configured Model Context Protocol servers:

- **serena** - Semantic code retrieval with symbol-level understanding (powers /primer)
- **memory** - Persistent context across sessions
- **context7** - Up-to-date library documentation
- **duckdb-operational** - Operational database access
- **duckdb-analytics** - Analytics database access
- **linear** - Issue tracking integration
- **notion** - Documentation workspace integration

### ⚡ Automated Quality Gates

Smart automation with external hook scripts:

**Pre-Commit Hooks:**
- Code quality checks (linting, type checking) before commits
- Test suite validation before commits
- Dependency security scanning

**Post-Edit Hooks:**
- Auto-format Python files with black/ruff after edits
- Auto-run pytest when test files are modified
- Dependency sync when pyproject.toml changes

All hooks support auto-approve permissions for streamlined workflow.

## Installation

### From GitHub (Recommended)

```bash
# Add marketplace
/plugin marketplace add ricardoroche/ricardos-claude-code

# Install plugin
/plugin install ricardos-claude-code
```

### From Local Clone (for development)

```bash
git clone https://github.com/ricardoroche/ricardos-claude-code.git
cd ricardos-claude-code

# Add as local marketplace
/plugin marketplace add /path/to/ricardos-claude-code

# Install plugin
/plugin install ricardos-claude-code
```

## Best For

- Python AI engineers
- FastAPI developers
- Strands AI framework users
- ML/AI application developers
- Full-stack Python engineers
- Teams working with LLM-powered applications

## Usage Examples

### Fixing Code Issues

```bash
/fix
# Automatically runs ruff, black, and mypy to fix common issues
```

### Creating an API Endpoint

```bash
/api
# Claude will scaffold a complete FastAPI endpoint with Pydantic models, validation, and error handling
```

### Running Quality Checks

```bash
/check
# Runs comprehensive quality checks: tests, coverage, type checking
```

### Generating Tests

Just ask Claude:
- "Write unit tests for this function"
- "I need test coverage for this module"

The write-unit-tests agent automatically activates and creates pytest-based tests following best practices.

### Using Skills

Skills are automatically referenced when Claude detects relevant patterns:

```python
# When working with config, dynaconf-config skill activates
# When writing Pydantic models, pydantic-models skill guides the implementation
# When handling errors, structured-errors skill ensures consistency
```

## Documentation Structure

This plugin includes comprehensive documentation in the `/docs` directory:

- **workflows/** - Development workflows and automation guides
- **standards/** - Code quality standards and best practices
- **examples/** - Example implementations and use cases

See the [Documentation Index](docs/RESTRUCTURING_SUMMARY.md) for detailed information on commands, agents, skills, and MCP server configurations.

## Philosophy

This setup emphasizes:

- **Type Safety**: Full type hints with mypy validation
- **Best Practices**: Modern Python patterns (async/await, Pydantic, pytest)
- **Productivity**: Automated formatting, testing, and quality gates
- **AI Engineering**: Patterns optimized for LLM-powered applications
- **Code Quality**: Enforced through hooks and automated checks
- **Consistency**: Skills ensure patterns are followed across the codebase

## Requirements

- Claude Code 2.0.13+
- Python 3.11+
- Works with any Python project (optimized for FastAPI + Strands)

## MCP Server Setup

After installation, MCP servers are pre-configured in `.mcp.json`. The setup includes:

**Core Servers** (no configuration needed):
- **memory** - Persistent context storage
- **serena** - Semantic code retrieval (powers /primer command)
- **context7** - Up-to-date library documentation

**Database Servers** (auto-configured for local DuckDB):
- **duckdb-operational** - Operational database at `data/operational.db`
- **duckdb-analytics** - Analytics database at `data/analytics.db`

**Integration Servers** (require authentication on first use):
- **linear** - Linear issue tracking via SSE endpoint
- **notion** - Notion workspace via OAuth

See [docs/workflows/mcp-servers.md](docs/workflows/mcp-servers.md) for detailed configuration instructions.

## Customization

After installation, customize:

- Commands: Edit files in `.claude/commands/`
- Agents: Edit files in `.claude/agents/`
- Skills: Edit files in `.claude/skills/`
- Hooks: Modify `.claude/settings.json`

## Contributing

Feel free to:

- Fork and customize for your needs
- Submit issues or suggestions
- Share your improvements

## License

MIT - Use freely in your projects

## Author

Created by Ricardo Roche

---

**Note**: This is my personal setup refined for Python AI engineering. Commands and patterns are optimized for FastAPI + Strands workflows but work great with any modern Python stack.
