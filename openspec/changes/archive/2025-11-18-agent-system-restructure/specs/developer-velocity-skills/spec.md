# Spec: Developer Velocity Skills

**Capability**: developer-velocity-skills
**Status**: Draft
**Related**: All agent specs

## Overview

This spec defines 4 new developer velocity skills that improve workflow efficiency with git standards, CLI tools, OpenSpec conventions, and documentation templates.

## ADDED Requirements

### Requirement: git-workflow-standards Skill MUST be created

A skill MUST be created for git workflow best practices.

#### Scenario: Code involves git operations

**Trigger Keywords**: "git", "commit", "branch", "PR", "pull request", "merge"

**Pattern Coverage**:
- ✅ Conventional commit messages
- ✅ Branch naming conventions
- ✅ PR description templates
- ✅ Atomic commits
- ✅ Merge vs rebase strategies
- ✅ .gitignore patterns for Python
- ❌ Avoid vague commit messages
- ❌ Avoid committing secrets or PII
- ❌ Avoid massive commits

**Used By**: fix-pr-comments, mlops-ai-engineer, all agents (workflow context)

### Requirement: cli-tool-patterns Skill MUST be created

A skill MUST be created for CLI tool design with Python.

#### Scenario: Code involves CLI creation

**Trigger Keywords**: "CLI", "command-line", "argparse", "click", "typer", "terminal"

**Pattern Coverage**:
- ✅ Click/Typer for modern CLIs
- ✅ Help text and documentation
- ✅ Input validation
- ✅ Error handling and exit codes
- ✅ Progress indicators
- ✅ Configuration file support
- ❌ Avoid raw sys.argv parsing
- ❌ Avoid missing help text
- ❌ Avoid poor error messages

**Used By**: llm-app-engineer, python-ml-refactoring-expert, technical-ml-writer

### Requirement: openspec-conventions Skill MUST be created

A skill MUST be created for OpenSpec formatting and best practices.

#### Scenario: Code involves OpenSpec files

**Trigger Keywords**: "OpenSpec", "proposal", "spec", "requirement", "scenario"

**Pattern Coverage**:
- ✅ Proposal structure (proposal.md, design.md, tasks.md)
- ✅ Spec delta format (ADDED/MODIFIED/REMOVED)
- ✅ Scenario writing (Given/When/Then)
- ✅ Requirement naming conventions
- ✅ Cross-referencing specs
- ❌ Avoid vague requirements
- ❌ Avoid missing test scenarios
- ❌ Avoid circular spec dependencies

**Used By**: requirements-analyst, ai-product-analyst, system-architect, ml-system-architect

### Requirement: documentation-templates Skill MUST be created

A skill MUST be created for documentation structure and templates.

#### Scenario: Code involves writing documentation

**Trigger Keywords**: "documentation", "README", "API docs", "guide", "tutorial"

**Pattern Coverage**:
- ✅ README structure (installation, usage, examples)
- ✅ API documentation with examples
- ✅ Tutorial structure (progressive learning)
- ✅ Changelog maintenance
- ✅ Architecture decision records (ADRs)
- ❌ Avoid missing code examples
- ❌ Avoid outdated documentation
- ❌ Avoid unclear installation steps

**Used By**: technical-writer, technical-ml-writer, learning-guide, ml-system-architect

## Skill Structure Requirements

### Requirement: Skills MUST Follow Standard Pattern

All 4 skills MUST follow skill structure with category: "velocity".

## MODIFIED Requirements

None

## REMOVED Requirements

None

## Validation

### Validation Rules

1. **4 skills created**: All exist
2. **Structure compliance**: Standard pattern
3. **Category**: All have `category: "velocity"`

### Test Scenarios

#### Test: Directories exist

**Then** directories:
- `.claude/skills/git-workflow-standards/`
- `.claude/skills/cli-tool-patterns/`
- `.claude/skills/openspec-conventions/`
- `.claude/skills/documentation-templates/`

## Migration Impact

### New Files

4 new skill directories

### Integration

Improves cross-cutting workflows:
- git-workflow-standards: All agents benefit from git guidance
- cli-tool-patterns: CLI-heavy implementations
- openspec-conventions: Requirements/planning agents
- documentation-templates: Communication agents

## Implementation Notes

### Priority

1. **git-workflow-standards** - Universal applicability
2. **documentation-templates** - Supports 3 communication agents
3. **openspec-conventions** - Critical for this plugin's workflow
4. **cli-tool-patterns** - Nice-to-have for CLI tools

### Special Considerations

**openspec-conventions skill**:
- Should reference actual OpenSpec docs
- Include examples from this very proposal
- Help users create well-structured proposals

## References

- All agent specs (these are cross-cutting)
- OpenSpec docs: `openspec/AGENTS.md`
