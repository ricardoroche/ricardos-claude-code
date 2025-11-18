# Architecture Documentation

Project structure and design principles for the Claude Code Python plugin.

## Table of Contents

1. [Plugin Overview](#plugin-overview)
2. [Directory Structure](#directory-structure)
3. [Component Architecture](#component-architecture)
4. [Design Principles](#design-principles)
5. [Documentation Organization](#documentation-organization)
6. [Extension Points](#extension-points)

---

## Plugin Overview

This is a Claude Code plugin for Python AI and data engineering projects. It provides:

- **Commands**: Slash commands for common Python development tasks
- **Agents**: Specialized AI agents for complex development workflows
- **Skills**: Pattern-based guidance that activates contextually
- **Hooks**: Automated workflows triggered by tool usage

**Target Users:**
- Python developers building AI/ML applications
- Data engineers working with Python data pipelines
- Teams using FastAPI for API development
- Projects requiring high code quality and type safety

---

## Directory Structure

```
ricardos-claude-code/
├── .claude/                    # Claude Code plugin configuration
│   ├── commands/              # Slash commands (6 commands)
│   │   ├── primer.md         # Semantic code context retrieval
│   │   ├── fix.md            # Auto-fix linting and formatting
│   │   ├── api.md            # FastAPI endpoint scaffolding
│   │   ├── lint.md           # Run linting and type checking
│   │   ├── check.md          # Comprehensive quality checks
│   │   └── test.md           # Run pytest with options
│   ├── agents/                # Specialized agents (8 agents)
│   │   ├── code-reviewer.md         # Code review with security analysis
│   │   ├── write-unit-tests.md      # Generate pytest tests
│   │   ├── debug-test-failure.md    # Debug failing tests
│   │   ├── fix-pr-comments.md       # Address PR feedback
│   │   ├── implement-feature.md     # Feature implementation
│   │   ├── add-agent-tool.md        # Add tools to agents
│   │   ├── upgrade-dependency.md    # Dependency management
│   │   └── optimize-db-query.md     # Query optimization
│   ├── skills/                # Pattern skills (8 skills)
│   │   ├── dynaconf-config.md       # Configuration patterns
│   │   ├── async-await-checker.md   # Async/await best practices
│   │   ├── structured-errors.md     # Error handling patterns
│   │   ├── pydantic-models.md       # Data validation patterns
│   │   ├── tool-design-pattern.md   # AI agent tool design
│   │   ├── docstring-format.md      # Documentation standards
│   │   ├── pii-redaction.md         # PII handling patterns
│   │   ├── pytest-patterns.md       # Testing best practices
│   │   ├── fastapi-patterns.md      # FastAPI endpoint patterns
│   │   └── type-safety.md           # Type hints and mypy
│   └── settings.json          # Plugin settings and hooks
├── docs/                       # Reference documentation
│   ├── python-patterns.md     # Comprehensive code examples
│   ├── best-practices.md      # Best practices summary
│   └── architecture.md        # This file
├── openspec/                   # OpenSpec change management
│   ├── AGENTS.md              # OpenSpec instructions for AI
│   ├── project.md             # Project specifications
│   └── changes/               # Change proposals and history
├── CLAUDE.md                   # AI assistant instructions (minimal)
├── README.md                   # User documentation
└── .claude-plugin             # Plugin working directory
```

---

## Component Architecture

### Commands

Slash commands are user-invoked operations for common development tasks.

**Command Structure:**
```markdown
# Command Name

Brief description of what the command does.

## What it does

Detailed explanation of command behavior.

## When to use

Scenarios where this command is useful.

## Examples

Usage examples with expected output.
```

**Command Design Principles:**
- Single responsibility
- Clear, descriptive names
- Comprehensive documentation
- Error handling and user feedback

### Agents

Specialized agents handle complex, multi-step development workflows.

**Agent Structure:**
```markdown
# Agent Name

Description of agent capabilities.

## When to Use

Scenarios where this agent activates or should be invoked.

## What It Does

Detailed breakdown of agent behavior.

## Examples

Usage examples and outcomes.
```

**Agent Design Principles:**
- Domain-specific expertise
- Autonomous multi-step execution
- Clear scope and boundaries
- Comprehensive output

### Skills

Skills provide contextual pattern guidance based on code analysis.

**Skill Structure:**
```markdown
# Skill Name

Pattern description.

## When This Applies

Code patterns that trigger this skill.

## Guidelines

Specific rules and principles.

## Examples

Code examples demonstrating good and bad patterns.

## References

Links to comprehensive documentation.
```

**Skill Design Principles:**
- Pattern-based activation
- Contextual relevance
- Actionable guidance
- Cross-referenced documentation

### Hooks

Automated workflows triggered by tool usage.

**Hook Types:**
- **Pre-tool-use**: Execute before tool actions (e.g., pre-commit checks)
- **Post-tool-use**: Execute after tool actions (e.g., auto-format after edit)

**Hook Configuration:**
Located in `.claude/settings.json`:
```json
{
  "hooks": {
    "pre-tool-use": {
      "Bash(git commit*)": "quality-gate-check"
    },
    "post-tool-use": {
      "Edit": "auto-format-python",
      "Write": "auto-format-python"
    }
  }
}
```

**Hook Design Principles:**
- Non-intrusive automation
- Clear user feedback
- Configurable behavior
- Error handling

---

## Design Principles

### 1. Separation of Concerns

**Documentation Types:**
- **CLAUDE.md**: Minimal AI instructions only
- **README.md**: User-facing documentation and setup
- **docs/**: Comprehensive reference documentation
- **Component files**: Self-documenting commands, agents, skills

**Rationale:**
- Reduces AI context window usage
- Improves user experience (documentation in expected places)
- Easier maintenance (update in one place)

### 2. Self-Documenting Components

Each command, agent, and skill carries its own documentation:
- Activation conditions
- Behavior description
- Usage examples
- Cross-references to related documentation

**Benefits:**
- Discoverability
- Maintainability
- Consistency

### 3. Contextual Activation

Skills activate based on code patterns, not manual invocation:
- Analyze code for relevant patterns
- Provide guidance when applicable
- Avoid unnecessary context loading

**Benefits:**
- Efficient context usage
- Relevant guidance
- Non-intrusive assistance

### 4. Automation with Guardrails

Hooks automate workflows but provide clear feedback:
- Pre-commit quality gates prevent bad commits
- Post-edit auto-formatting maintains consistency
- Clear error messages guide users

**Benefits:**
- Consistent code quality
- Reduced manual work
- User control maintained

### 5. Type Safety First

All code emphasizes type safety:
- Comprehensive type hints
- Pydantic for validation
- Mypy in strict mode

**Benefits:**
- Catch errors early
- Better IDE support
- Self-documenting code

---

## Documentation Organization

### Context Window Optimization

**Problem:** Large CLAUDE.md files consume valuable context.

**Solution:** Distributed documentation strategy.

**Token Usage:**
- **Before**: CLAUDE.md ~4,500 tokens per session
- **After**: CLAUDE.md ~450 tokens per session
- **Savings**: ~4,000 tokens (90% reduction)

### Documentation Distribution

| Content Type | Location | Loaded When |
|--------------|----------|-------------|
| AI instructions | CLAUDE.md | Every session (minimal) |
| User documentation | README.md | Never (user-facing) |
| Command usage | Command files | When command invoked |
| Agent behavior | Agent files | When agent activated |
| Pattern guidance | Skill files | When relevant code detected |
| Reference docs | docs/ | When referenced |

### Cross-Referencing Strategy

Files reference each other for navigation:
- CLAUDE.md → README.md, docs/, skills
- README.md → docs/, command files
- Skills → docs/python-patterns.md
- docs/ → skill files

**Benefits:**
- Easy navigation
- No duplicate content
- Efficient context usage

---

## Extension Points

### Adding New Commands

1. Create `.claude/commands/new-command.md`
2. Document usage, examples, and behavior
3. Update README.md command reference
4. Test command invocation

### Adding New Agents

1. Create `.claude/agents/new-agent.md`
2. Document capabilities and activation scenarios
3. Update README.md agent reference
4. Test agent invocation

### Adding New Skills

1. Create `.claude/skills/new-skill.md`
2. Document pattern, guidelines, and examples
3. Add comprehensive examples to docs/python-patterns.md
4. Test skill activation on relevant code

### Adding New Hooks

1. Update `.claude/settings.json`
2. Define trigger pattern and handler
3. Test hook execution
4. Document in README.md if user-visible

---

## Development Workflow

### Plugin Development

1. Identify need (command, agent, skill, hook)
2. Design component following architecture principles
3. Implement with documentation
4. Test thoroughly
5. Update cross-references
6. Update README.md

### Quality Assurance

- All components must be self-documented
- Cross-references must be accurate
- Examples must be tested
- Token usage must be minimized

### Version Control

- Use OpenSpec for significant changes
- Document breaking changes
- Maintain changelog
- Test before merging

---

## Best Practices

### For Commands

- Single, clear purpose
- Comprehensive documentation
- Error handling
- User feedback

### For Agents

- Well-defined scope
- Autonomous execution
- Clear output format
- Error recovery

### For Skills

- Pattern-based activation
- Actionable guidance
- Good/bad examples
- Reference to comprehensive docs

### For Documentation

- Minimal AI context (CLAUDE.md)
- User-facing in README.md
- Comprehensive in docs/
- Cross-referenced everywhere

---

## Performance Considerations

### Context Window Management

- Keep CLAUDE.md minimal (~40 lines)
- Load skills only when relevant
- Load docs/ only when referenced
- Avoid duplication

### File Organization

- Related files grouped together
- Clear naming conventions
- Consistent structure
- Easy navigation

### Automation Efficiency

- Hooks execute quickly
- Clear feedback to users
- Fail gracefully
- Configurable behavior

---

## Future Enhancements

### Potential Additions

- More specialized agents (e.g., API documentation generator)
- Additional skills (e.g., database migration patterns)
- Enhanced hooks (e.g., auto-run tests on save)
- Integration with more tools (e.g., pytest plugins)

### Scalability

- Plugin can support additional commands without context bloat
- Skill system scales to many patterns
- Agent system supports complex workflows
- Documentation remains maintainable

---

## Related Documentation

- [Python Patterns Guide](./python-patterns.md) - Comprehensive code examples
- [Best Practices Guide](./best-practices.md) - Best practices summary
- [README](../README.md) - User documentation and setup
- [OpenSpec Project Spec](../openspec/project.md) - Detailed project specifications

---

## Maintenance

### Regular Updates

- Review documentation quarterly
- Update patterns based on feedback
- Add new examples as needed
- Deprecate outdated patterns

### Quality Checks

- Verify cross-references
- Test all examples
- Ensure consistency
- Monitor token usage

### Community Contributions

- Accept pattern submissions
- Review and integrate feedback
- Document new use cases
- Share learnings
