<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# Claude Code Plugin for Python AI/Data Engineering

This plugin provides comprehensive tools for productive Python development with AI assistance.

## AI Assistant Guidelines

When working in Python projects using this plugin:

- **Type Safety**: Use comprehensive type hints on all functions and classes
- **Data Validation**: Use Pydantic models for all data validation and serialization
- **Async Operations**: Use async/await for all I/O operations (HTTP, database, file operations)
- **Testing**: Write pytest tests with fixtures, parametrize, and proper mocking
- **Error Handling**: Define specific exception classes and handle errors appropriately
- **Security**: Redact PII in logs, validate all inputs, use parameterized queries
- **Code Quality**: Follow ruff formatting, run mypy for type checking, maintain 80%+ test coverage

## Project Context

This is a Claude Code plugin repository providing tools for Python development:

**Structure:**
- `.claude/commands/` - 6 slash commands for Python development tasks
- `.claude/agents/` - 8 specialized agents for complex workflows
- `.claude/skills/` - 10 pattern skills for code quality and best practices
- `.claude/settings.json` - Automation hooks for quality gates
- `docs/` - Comprehensive reference documentation and patterns
- `README.md` - User-facing documentation, setup, and usage guides

**Commands, agents, and skills are self-documented** in their respective files. Refer to them for detailed usage.

**For comprehensive Python patterns and examples**, see `docs/python-patterns.md`.

**For user documentation and setup guides**, see `README.md`.
