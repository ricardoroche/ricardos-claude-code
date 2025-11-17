# Ricardo's Claude Code Setup

My personal Claude Code configuration for productive Python AI engineering and Data Engineering.

## Quick Install

```bash
# Step 1: Add the marketplace
/plugin marketplace add ricardoroche/ricardos-claude-code

# Step 2: Install the plugin
/plugin install ricardos-claude-code
```

## What's Inside

### Python AI Commands

- `/primer` - Prime Claude with project context using Serena semantic code retrieval
- `/fix` - Auto-fix Python issues (ruff, black, mypy)
- `/api` - FastAPI endpoint development with validation
- `/lint` - Python linting and type checking
- `/check` - Quality checks (tests, coverage, types)
- `/test` - Run pytest with appropriate options

### Specialized AI Agents

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

### Python Pattern Skills

Reusable patterns for consistent code quality:

- **dynaconf-config** - Configuration management patterns
- **async-await-checker** - Async/await best practices
- **structured-errors** - Error handling patterns
- **pydantic-models** - Data validation patterns
- **tool-design-pattern** - AI tool design guidelines
- **docstring-format** - Python documentation standards
- **pii-redaction** - PII handling patterns
- **pytest-patterns** - Testing best practices

### MCP Servers

Pre-configured Model Context Protocol servers that work across all projects:

- **memory** - Persistent context across sessions
- **serena** - Semantic code retrieval with symbol-level understanding (powers /primer)
- **context7** - Up-to-date library documentation
- **linear** - Issue tracking integration
- **notion** - Documentation workspace integration

**Note**: DuckDB servers are project-specific and must be configured in each project's `.mcp.json` with the correct database paths. See project-level configuration for examples.

### Automated Quality Gates

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

**Integration Servers** (require authentication on first use):

- **linear** - Linear issue tracking via SSE endpoint
- **notion** - Notion workspace via OAuth

**Project-Specific Servers**:

- **DuckDB** servers (operational/analytics) must be configured in each project's `.mcp.json` with project-specific database paths
- See your project's `.mcp.json` for examples of database configuration

See [docs/workflows/mcp-servers.md](docs/workflows/mcp-servers.md) for detailed configuration instructions.

## Configuration Hierarchy

This plugin provides **universal Python patterns** that work across all projects. Project-specific configuration is managed separately:

### Plugin Level (Universal)

- **Location**: `~/dev/personal/ricardos-claude-code/`
- **Purpose**: Generic Python development patterns, agents, commands
- **What's Here**: Hooks, auto-approve for read-only tools, universal env vars
- **Shared**: Not project-specific, works everywhere

### Project Level (Team)

- **Location**: `project/.claude/` (checked into git)
- **Purpose**: Project-specific agents, commands, skills
- **What's Here**: Project conventions, team workflows, service-specific config
- **Shared**: Yes, with entire team

### Personal Level (You)

- **Location**: `project/.claude/*.local.*` (gitignored)
- **Purpose**: Your personal dev preferences and permissions
- **What's Here**: Auto-approve overrides, dev workflows, personal notes
- **Shared**: No, personal only

### Setting Up Personal Config

Create personal configuration files in your project's `.claude/` directory:

**`settings.local.json`** - Personal permission overrides:

```json
{
  "permissions": {
    "allow": [
      "Bash(git checkout:*)",
      "Bash(make test:*)",
      "mcp__linear__list_issues"
    ]
  }
}
```

**`CLAUDE.local.md`** - Personal dev preferences:

```markdown
# My Personal Dev Preferences

## Development Environment

- **Editor**: VS Code / Neovim
- **Shell**: Fish / Zsh
- **Workflows**: Always use make commands

## Personal Notes

- Project-specific reminders
```

These files are automatically gitignored and won't be shared with your team.

### Validation

Use the `/config-status` command (if available in your project) to see the complete merged configuration from all levels.

## Customization

You can customize at any level:

**Plugin (Universal):**

- Commands: Edit files in `~/dev/personal/ricardos-claude-code/.claude/commands/`
- Agents: Edit files in `~/dev/personal/ricardos-claude-code/.claude/agents/`
- Skills: Edit files in `~/dev/personal/ricardos-claude-code/.claude/skills/`
- Hooks: Modify `~/dev/personal/ricardos-claude-code/.claude/settings.json`

**Project (Team):**

- Create project-specific agents in `project/.claude/agents/`
- Create project-specific commands in `project/.claude/commands/`
- Create project-specific skills in `project/.claude/skills/`

**Personal (You):**

- Add permissions in `project/.claude/settings.local.json`
- Add preferences in `project/.claude/CLAUDE.local.md`

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
