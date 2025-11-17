# Claude Code Plugin for Python AI/Data Engineering

A comprehensive Claude Code plugin providing commands, specialized agents, pattern skills, and automation hooks for productive Python development in AI and data engineering projects.

## What's Included

### 6 Commands

- `/primer` - Prime Claude with project context using semantic code retrieval
- `/fix` - Auto-fix Python issues (ruff format, ruff check --fix, mypy)
- `/api` - FastAPI endpoint scaffolding with Pydantic models
- `/lint` - Python linting and type checking (ruff check, mypy)
- `/check` - Comprehensive quality checks (pytest, coverage, mypy)
- `/test` - Run pytest with appropriate options

### 8 Specialized Agents

**Code Quality & Review:**
- **code-reviewer** - Comprehensive Python code review with security and performance analysis
- **write-unit-tests** - Generate pytest unit tests with fixtures, mocking, and parametrization
- **debug-test-failure** - Debug failing Python tests and identify root causes
- **fix-pr-comments** - Systematically address PR review feedback

**Development & Architecture:**
- **implement-feature** - Complete feature implementation with FastAPI, Pydantic, and testing
- **add-agent-tool** - Add tools to AI agents following design patterns
- **upgrade-dependency** - Python dependency management and migration handling
- **optimize-db-query** - SQL/DuckDB query optimization for performance

### 8 Pattern Skills

Reusable patterns that automatically activate when relevant code is detected:
- **dynaconf-config** - Configuration management patterns
- **async-await-checker** - Async/await best practices validation
- **structured-errors** - Error handling and exception patterns
- **pydantic-models** - Data validation model patterns
- **tool-design-pattern** - AI agent tool design guidelines
- **docstring-format** - Python documentation standards
- **pii-redaction** - PII handling and logging safety
- **pytest-patterns** - Testing best practices

### Automated Hooks

**Pre-Tool-Use Hooks:**
- Pre-commit quality gate (linting, type checking, tests)

**Post-Tool-Use Hooks:**
- Auto-format Python files after editing
- Auto-sync dependencies after pyproject.toml changes
- Auto-run tests after test file modifications

## Installation

### From GitHub Marketplace

```bash
# Add the marketplace
/plugin marketplace add ricardoroche/ricardos-claude-code

# Install the plugin
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

## Quick Start

After installation, the plugin is immediately available in your Python projects:

```bash
# Fix code quality issues
/fix

# Create a new FastAPI endpoint
/api

# Run comprehensive quality checks
/check

# Run tests
/test
```

Agents activate automatically when relevant work is detected:
- "Write unit tests for this function" → activates write-unit-tests agent
- "Review this code" → activates code-reviewer agent
- "Implement user authentication" → activates implement-feature agent

## Best For

- Python AI engineers
- Data engineering teams
- FastAPI developers
- ML/AI application developers
- Teams building LLM-powered applications
- Full-stack Python engineers

## Philosophy

This plugin emphasizes:

- **Type Safety** - Full type hints with mypy validation
- **Best Practices** - Modern Python patterns (async/await, Pydantic, pytest)
- **Productivity** - Automated formatting, testing, and quality gates
- **AI Engineering** - Patterns optimized for LLM-powered applications
- **Code Quality** - Enforced through hooks and automated checks
- **Consistency** - Skills ensure patterns are followed across the codebase

## Configuration

### MCP Servers (Optional)

This plugin does not include MCP server configuration. Configure servers in your project's `.mcp.json` based on your needs.

**Recommended servers for Python AI/data engineering:**
- **memory** - Persistent context across sessions
- **context7** - Up-to-date library documentation
- **filesystem** - File operations
- **duckdb** - Query databases

See [MCP Server Recommendations](docs/workflows/mcp-server-recommendations.md) for configuration examples.

### Project-Level Customization

You can extend or override plugin behavior in your project's `.claude/` directory:

**Add project-specific commands:**
```bash
# Create command in your project
touch .claude/commands/my-command.md
```

**Add project-specific agents:**
```bash
# Create agent in your project
touch .claude/agents/my-agent.md
```

**Personal settings (gitignored):**
```json
// .claude/settings.local.json
{
  "permissions": {
    "allow": [
      "Bash(git checkout:*)",
      "Bash(make test:*)"
    ]
  }
}
```

## Requirements

- Claude Code 2.0.13+
- Python 3.11+
- Works with any Python project (optimized for FastAPI/AI projects)

## Documentation

See the `docs/` directory for detailed guides:
- [Standards](docs/standards/) - Code quality standards and best practices
- [Workflows](docs/workflows/) - Development workflows and automation guides
- [Examples](docs/examples/) - Example implementations and use cases

## Contributing

This is a plugin repository. Contributions should focus on improving commands, agents, skills, and hooks that benefit Python AI/data engineering projects.

### Development Setup

```bash
# Clone the repository
git clone https://github.com/ricardoroche/ricardos-claude-code.git
cd ricardos-claude-code

# Install as local plugin for testing
/plugin marketplace add /path/to/ricardos-claude-code
/plugin install ricardos-claude-code

# Make changes to commands, agents, or skills
# Test in a Python project

# Create pull request
```

### Adding a New Command

1. Create command file: `.claude/commands/my-command.md`
2. Add to `plugin.json` commands array
3. Test in a Python project
4. Document in README.md
5. Submit pull request

### Adding a New Agent

1. Create agent file: `.claude/agents/my-agent.md`
2. Add to `plugin.json` agents array
3. Test activation and behavior
4. Document in README.md
5. Submit pull request

### Adding a New Skill

1. Create skill file: `.claude/skills/my-skill.md`
2. Add to `plugin.json` skills array
3. Test automatic activation
4. Document pattern and usage
5. Submit pull request

### Guidelines

- Commands should be general-purpose for Python projects
- Agents should solve common Python development tasks
- Skills should encode reusable patterns
- No project-specific configuration
- No MCP server configuration
- Examples should be generic
- Documentation should be clear and comprehensive

## License

MIT - Use freely in your projects

## Author

Created by Ricardo Roche

---

**Note**: This is a Claude Code plugin, not a project template. Install it in your Python projects to get productive development tools and AI assistance.
