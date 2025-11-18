# Documentation Structure

## ADDED Requirements

### Requirement: CLAUDE.md must contain only essential AI assistant instructions

CLAUDE.md MUST contain only essential AI assistant instructions and minimal project context with:
- OpenSpec instructions block (managed)
- Minimal project context (~15 lines)
- Essential AI behavior guidelines (~10 lines)

This keeps context window usage minimal (~450 tokens), freeing context for actual code and conversations.

#### Scenario: AI Assistant Loads CLAUDE.md Context

**Given** Claude Code starts a new session in the plugin repository

**When** CLAUDE.md is loaded into context

**Then** the context should consume ~400-500 tokens

**And** it should provide essential AI instructions

**And** it should reference where to find detailed documentation

**And** it should not duplicate content from README.md or skill files

---

### Requirement: README.md must contain all user-facing documentation

README.md MUST contain all user-facing documentation including:
- Plugin overview
- Installation instructions
- Quick start guide
- Detailed command reference with usage examples
- Agent activation and usage guide
- Configuration and setup instructions
- MCP server recommendations
- Common workflows and how-tos

Users expect setup and usage documentation in README.md, not in AI context files.

#### Scenario: User Reads Plugin Documentation

**Given** a user wants to learn how to use the plugin

**When** they open README.md

**Then** they should find complete command usage documentation

**And** they should find how to invoke and use agents

**And** they should find configuration instructions

**And** they should find common workflow examples

**And** they should not need to read CLAUDE.md

---

### Requirement: Each skill file must document its own patterns with code examples

Each skill file MUST document its own patterns, guidelines, and code examples including:
- Pattern description
- When it applies (activation triggers)
- Guidelines and rules
- Code examples (good and bad patterns)
- References to comprehensive docs

Skills should be self-documenting; patterns load only when relevant code is detected.

#### Scenario: Skill Activates on Relevant Code

**Given** a Python file contains Pydantic model definitions

**When** the `pydantic-models` skill activates

**Then** the skill file should provide complete pattern documentation

**And** it should include code examples

**And** it should not require referencing CLAUDE.md

---

### Requirement: docs/ directory must contain comprehensive reference documentation

A `docs/` directory MUST contain comprehensive reference documentation with the following structure:
```
docs/
├── python-patterns.md    # Comprehensive Python pattern examples
├── best-practices.md     # Detailed best practices guide
└── architecture.md       # Project structure and design decisions
```

This separates user reference documentation from AI context and README quick-start content.

#### Scenario: Developer Needs Comprehensive Pattern Reference

**Given** a developer wants detailed Python pattern examples

**When** they navigate to the `docs/` directory

**Then** they should find `python-patterns.md` with comprehensive examples

**And** examples should cover type safety, Pydantic, async/await, error handling, FastAPI, testing, and security

**And** content should be more detailed than skill files

**And** content should cross-reference relevant skills

---

### Requirement: Each command file must contain complete usage documentation

Each `.claude/commands/*.md` file MUST contain complete usage documentation including:
- Command description
- What it does (detailed operations)
- When to use it
- Usage examples with expected output

Commands should be self-documenting; usage details should not be duplicated in CLAUDE.md.

#### Scenario: User Wants to Learn Command Usage

**Given** a user wants to understand how `/fix` works

**When** they read `.claude/commands/fix.md`

**Then** they should find complete command documentation

**And** they should find usage examples

**And** they should find information about when to use it

**And** they should not need to reference CLAUDE.md

---

### Requirement: All CLAUDE.md content must be migrated with no information loss

All content from the original CLAUDE.md MUST be migrated to appropriate locations with no information loss. Migration map:
- OpenSpec instructions → CLAUDE.md (kept)
- Project context → CLAUDE.md (condensed) + README.md (detailed)
- Command listings → README.md
- Command usage → README.md + command files
- Agent descriptions → README.md
- Agent patterns → Agent files
- Skill listings → Removed (auto-discovered)
- Python development patterns → Skills + docs/python-patterns.md
- Configuration guides → README.md
- MCP recommendations → README.md + docs/
- Best practices → docs/best-practices.md
- Common workflows → README.md

Ensure no documentation is lost during restructuring.

#### Scenario: Documentation Content Audit

**Given** the restructuring is complete

**When** auditing documentation content

**Then** every section from original CLAUDE.md should exist in new locations

**And** no code examples should be missing

**And** no usage instructions should be missing

**And** no configuration guidance should be missing

**And** cross-references should connect related content

---

### Requirement: New skill files must be created for undocumented patterns

New skill files MUST be created for patterns that don't have dedicated skills:
1. `fastapi-patterns.md` - FastAPI endpoint structure and best practices
2. `type-safety.md` - Type hints and mypy patterns

All patterns should have skill-based documentation rather than being in CLAUDE.md.

#### Scenario: FastAPI Pattern Guidance

**Given** a developer is creating a FastAPI endpoint

**When** the `fastapi-patterns` skill activates

**Then** it should provide endpoint structure guidance

**And** it should include examples of proper routing, validation, error handling

**And** it should reference docs/python-patterns.md for comprehensive examples

---

### Requirement: Documentation files must cross-reference each other

Documentation files MUST cross-reference each other appropriately following this pattern:
- CLAUDE.md → References README.md and skill files
- README.md → References docs/ and command files
- Skills → Reference docs/python-patterns.md
- docs/ → Reference relevant skills

Help users and AI navigate distributed documentation.

#### Scenario: Finding Related Documentation

**Given** a user reads a skill file

**When** they need more comprehensive examples

**Then** the skill should reference docs/python-patterns.md

**And** the reference should be a direct link or clear path

---

## REMOVED Requirements

None - this change adds structure and redistributes content but doesn't remove capabilities.
