# Project Context

## Purpose

This is a **Claude Code plugin repository** for Python AI and data engineering. The repository contains commands, specialized agents, pattern skills, and automation hooks that enhance Claude Code's capabilities for Python development.

**Key Philosophy:** Provide reusable, general-purpose tools that help developers write better Python code with AI assistance. Focus on type safety, modern async patterns, comprehensive testing, and code quality automation.

## Tech Stack

### Plugin Development
- **Markdown** - Command, agent, and skill definitions
- **JSON** - Plugin manifest configuration (`plugin.json`)
- **OpenSpec** - Change management and specification system
- **Git** - Version control and collaboration

### Target Runtime (Projects Using This Plugin)
- **Python 3.11+** - Primary language
- **FastAPI** - Modern async web framework
- **Pydantic v2** - Data validation
- **pytest** - Testing framework
- **Ruff** - Linting and formatting
- **mypy** - Static type checking

## Project Conventions

### Plugin Structure

```
ricardos-claude-code/
├── .claude/                    # Plugin content
│   ├── commands/              # 6 slash commands
│   ├── agents/                # 8 specialized agents
│   ├── skills/                # 8 pattern skills
│   └── settings.json          # Hooks configuration
├── .claude-plugin/            # Plugin metadata
│   ├── plugin.json            # Manifest
│   └── marketplace.json       # Marketplace metadata
├── docs/                      # Documentation
│   ├── standards/             # Code standards
│   ├── workflows/             # Development workflows
│   └── examples/              # Usage examples
├── openspec/                  # Change management
│   ├── project.md             # This file
│   ├── AGENTS.md              # OpenSpec instructions
│   ├── specs/                 # Specifications
│   └── changes/               # Proposals
├── CLAUDE.md                  # AI context (general Python guidelines)
├── README.md                  # Plugin description
└── AGENTS.md                  # Agent quick reference
```

### File Naming Conventions

**Commands** (`.claude/commands/`):
- Use kebab-case: `fix.md`, `api.md`, `check.md`
- Name reflects command usage: `/fix`, `/api`, `/check`

**Agents** (`.claude/agents/`):
- Use kebab-case: `code-reviewer.md`, `write-unit-tests.md`
- Name describes agent purpose
- Should be descriptive and searchable

**Skills** (`.claude/skills/`):
- Use kebab-case: `pydantic-models.md`, `async-await-checker.md`
- Name describes pattern or behavior
- Should indicate what they validate or guide

### Documentation Standards

**Command Files:**
```markdown
# Command Name

Brief description of what the command does.

## What it does

Detailed list of operations.

## When to use

Scenarios where this command is helpful.

## Examples

Usage examples with expected output.
```

**Agent Files:**
```markdown
# Agent Name

One-line description.

## Purpose

What problem does this agent solve?

## When to activate

Triggers and keywords that should activate this agent.

## What it does

Detailed capabilities and approach.

## Examples

Sample interactions.
```

**Skill Files:**
```markdown
# Skill Name

Pattern or practice being enforced.

## When this applies

Code patterns that trigger this skill.

## Guidelines

Specific rules and patterns to follow.

## Examples

Good and bad examples.
```

### Git Workflow

**Branching:**
- `main` - Primary development branch
- `feature/description` - New features or enhancements
- `fix/description` - Bug fixes

**Commits:**
- Use conventional commit format
- Include context about what changed
- Reference issues when applicable

**Pull Requests:**
- Describe what changed and why
- Test changes in a Python project
- Update documentation if needed
- Get review before merging

### OpenSpec Usage

**When to create proposals:**
- Adding new commands, agents, or skills
- Changing plugin architecture
- Major documentation restructuring
- Breaking changes to plugin behavior

**When to skip proposals:**
- Fixing typos
- Minor documentation updates
- Bug fixes in existing commands/agents
- Example updates

## Domain Context

### Plugin Development

**Commands** are slash commands that execute specific development tasks:
- Must be general-purpose (work in any Python project)
- Should automate repetitive tasks
- Examples: `/fix`, `/api`, `/check`, `/test`

**Agents** are AI assistants specialized for specific development tasks:
- Activate automatically based on keywords or context
- Should solve complete problems (not just partial solutions)
- Examples: code-reviewer, write-unit-tests, implement-feature

**Skills** are reusable patterns that guide AI behavior:
- Activate automatically when relevant code is detected
- Encode best practices and conventions
- Examples: pydantic-models, async-await-checker, pytest-patterns

**Hooks** are automated triggers that run before/after tool use:
- Pre-tool-use: Quality gates (pre-commit checks)
- Post-tool-use: Auto-formatting, auto-testing

### Python Best Practices (for users of this plugin)

The plugin promotes:
- Type safety with mypy strict mode
- Async/await for I/O operations
- Pydantic for data validation
- pytest for testing
- Ruff for linting and formatting
- Security-first development (PII redaction, input validation)

### Target Users

**Primary:** Python AI/data engineers using Claude Code
**Secondary:** FastAPI developers, ML engineers, full-stack Python developers

**Not for:** Non-Python projects, frontend-only development, infrastructure-only projects

## Important Constraints

### Plugin Constraints

**No Project-Specific Configuration:**
- Plugins should not include `.mcp.json` (MCP servers are project-specific)
- No hardcoded API keys, credentials, or service URLs
- No specific database paths or schemas
- No organization-specific conventions

**General-Purpose Design:**
- Commands must work in any Python project
- Agents must solve common problems (not company-specific workflows)
- Skills must encode universal best practices
- Examples must use generic domains

**Documentation Requirements:**
- All commands, agents, and skills must be documented
- Examples must be clear and generic
- CLAUDE.md provides general Python guidance (not project instructions)
- README.md describes the plugin (not a project using it)

### Technical Constraints

**Plugin Format:**
- Commands, agents, skills are markdown files
- `plugin.json` defines plugin manifest
- No code execution in plugin (only configuration)

**Compatibility:**
- Must work with Claude Code 2.0.13+
- Target Python 3.11+ projects
- No dependencies on specific frameworks (FastAPI optional, not required)

**File Organization:**
- All plugin content in `.claude/` directory
- Metadata in `.claude-plugin/` directory
- Documentation in `docs/` and root
- OpenSpec in `openspec/` directory

## External Dependencies

### Development Tools

**OpenSpec:**
- Change management system
- Manages proposals and specifications
- Commands: `openspec list`, `openspec validate`, `openspec show`

**Git/GitHub:**
- Version control
- Pull request workflow
- Issue tracking

### Plugin Distribution

**Claude Code Marketplace:**
- Users install with `/plugin marketplace add` and `/plugin install`
- Plugin served from GitHub repository
- No build step required (markdown-based)

### Testing Context

**Testing plugins:**
- Install locally: `/plugin marketplace add /path/to/repo`
- Test in real Python projects
- Verify commands execute correctly
- Confirm agents activate appropriately
- Check skills provide good guidance

## Related Projects

This plugin can be used alongside:
- Other Claude Code plugins (filesystem, git, etc.)
- MCP servers configured at project level
- Project-specific commands and agents
- Personal settings and preferences

The plugin should not conflict with or override project-level configuration.
