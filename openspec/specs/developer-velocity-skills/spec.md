# developer-velocity-skills Specification

## Purpose
TBD - created by archiving change agent-system-restructure. Update Purpose after archive.
## Requirements
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

