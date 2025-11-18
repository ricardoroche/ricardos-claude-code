# Spec: Python Engineering Skills

**Capability**: python-engineering-skills
**Status**: Draft
**Related**: agent-migration-strategy, ai-llm-agent-expansion

## Overview

This spec defines 5 new Python engineering skills that fill gaps in current skill coverage for existing and new agents.

## ADDED Requirements

### Requirement: database-migrations Skill MUST be created

A skill MUST be created for database migration patterns with SQLAlchemy and Alembic.

#### Scenario: Code involves database schema changes

**Trigger Keywords**: "migration", "Alembic", "schema change", "database evolution", "SQLAlchemy"

**Pattern Coverage**:
- ✅ Alembic migration file creation
- ✅ Upgrade and downgrade functions
- ✅ Data migration patterns
- ✅ Migration testing
- ✅ Rollback strategies
- ❌ Avoid irreversible migrations without warnings
- ❌ Avoid data loss in migrations
- ❌ Avoid missing downgrade functions

**Used By**: implement-feature, llm-app-engineer, mlops-ai-engineer

### Requirement: query-optimization Skill MUST be created

A skill MUST be created for SQL/DuckDB query optimization patterns.

#### Scenario: Code involves database queries

**Trigger Keywords**: "query", "SQL", "DuckDB", "EXPLAIN", "index", "performance"

**Pattern Coverage**:
- ✅ EXPLAIN analysis
- ✅ Index creation strategies
- ✅ Query rewriting for performance
- ✅ N+1 query prevention
- ✅ Connection pooling
- ✅ Async database operations
- ❌ Avoid SELECT * in production
- ❌ Avoid missing indexes on foreign keys
- ❌ Avoid queries in loops (N+1)

**Used By**: optimize-db-query, llm-app-engineer, performance-engineer

### Requirement: python-packaging Skill MUST be created

A skill MUST be created for Python project structure and packaging.

#### Scenario: Code involves project setup or package configuration

**Trigger Keywords**: "pyproject.toml", "package", "project structure", "setup", "distribution"

**Pattern Coverage**:
- ✅ pyproject.toml structure
- ✅ Project layout (src/ vs flat)
- ✅ Dependency specification
- ✅ Entry points and scripts
- ✅ Package metadata
- ✅ Build system configuration
- ❌ Avoid mixing poetry and requirements.txt
- ❌ Avoid version conflicts
- ❌ Avoid missing __init__.py

**Used By**: ml-system-architect, llm-app-engineer, python-ml-refactoring-expert

### Requirement: dependency-management Skill MUST be created

A skill MUST be created for Python dependency management with uv, Poetry, pip-tools.

#### Scenario: Code involves dependency operations

**Trigger Keywords**: "dependency", "requirements", "uv", "poetry", "pip", "version"

**Pattern Coverage**:
- ✅ Lock file usage (uv.lock, poetry.lock)
- ✅ Version constraint specification
- ✅ Dependency security scanning
- ✅ Virtual environment management
- ✅ Dependency conflict resolution
- ❌ Avoid unpinned versions in production
- ❌ Avoid nested dependencies without review
- ❌ Avoid mixing dependency managers

**Used By**: upgrade-dependency, mlops-ai-engineer, implement-feature

### Requirement: code-review-framework Skill MUST be created

A skill MUST be created for structured Python code review.

#### Scenario: Code review is being conducted

**Trigger Keywords**: "code review", "review checklist", "PR review", "quality check"

**Pattern Coverage**:
- ✅ Code review checklist (structure, readability, tests)
- ✅ Security review points
- ✅ Performance considerations
- ✅ Type safety validation
- ✅ Testing coverage assessment
- ✅ Documentation review
- ❌ Avoid approving without tests
- ❌ Avoid missing security implications
- ❌ Avoid ignoring type errors

**Used By**: code-reviewer, fix-pr-comments, python-ml-refactoring-expert

## Skill Structure Requirements

### Requirement: Skills MUST Follow Existing Pattern

All 5 new skills MUST follow existing skill structure.

**Required Sections**:
- Frontmatter (name, description, category: "python")
- Trigger Keywords
- Agent Integration
- ✅ Correct Pattern
- ❌ Incorrect Pattern
- Domain-specific sections
- Best Practices Checklist
- Auto-Apply
- Related Skills

## MODIFIED Requirements

None

## REMOVED Requirements

None

## Validation

### Validation Rules

1. **5 skills created**: All skills exist in `.claude/skills/`
2. **Structure compliance**: Follow existing skill pattern
3. **Trigger keywords**: Explicit triggers listed
4. **Code examples**: Both patterns shown with Python code
5. **Category**: All have `category: "python"`

### Test Scenarios

#### Test: Skill directories created

**Then** directories exist:
- `.claude/skills/database-migrations/`
- `.claude/skills/query-optimization/`
- `.claude/skills/python-packaging/`
- `.claude/skills/dependency-management/`
- `.claude/skills/code-review-framework/`

#### Test: Skills reference valid agents

**Given** skill lists agent usage
**When** agent existence checked
**Then** all referenced agents exist or will be created

## Migration Impact

### New Files

5 new skill directories, each with SKILL.md

### Integration

- Close gaps for existing agents (optimize-db-query, upgrade-dependency, code-reviewer)
- Support new agents (llm-app-engineer, mlops-ai-engineer)

## Implementation Notes

### Priority

1. **code-review-framework** - Supports code-reviewer agent immediately
2. **query-optimization** - Supports optimize-db-query agent
3. **dependency-management** - Supports upgrade-dependency agent
4. **database-migrations** - Common need for implement-feature
5. **python-packaging** - Project setup guidance

## References

- Existing skills: `.claude/skills/`
- Agent specs: `specs/ai-llm-agent-expansion/spec.md`, `specs/agent-migration-strategy/spec.md`
