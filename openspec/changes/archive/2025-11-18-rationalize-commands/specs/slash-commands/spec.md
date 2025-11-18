# Slash Commands Specification Changes

## ADDED Requirements

### Requirement: Command Inventory Limited to OpenSpec Workflow

The plugin SHALL expose exactly **3** slash commands dedicated to OpenSpec workflow orchestration:
- `/openspec:proposal` - Scaffold new OpenSpec change with validation
- `/openspec:apply` - Implement approved OpenSpec change with task tracking
- `/openspec:archive` - Archive deployed change and update specs

#### Scenario: Command inventory
- **WHEN** a user lists available commands
- **THEN** only the 3 OpenSpec commands are returned

#### Scenario: Legacy commands removed
- **WHEN** a user looks for `/new-task`, `/api`, `/fix`, `/lint`, `/check`, or `/test`
- **THEN** none of them are available
- **AND** documentation points to natural language or automation-hook alternatives

### Requirement: Command Philosophy

Slash commands SHALL only be added when they meet **all** of the following criteria:
1. External CLI orchestration (wraps a CLI tool with specific flags/workflow)
2. Complex workflow (multi-step process with validation/safety checks)
3. Not project-specific (works across different projects and configurations)
4. Complements agents (provides orchestration agents can't replicate)
5. Non-automatable (can't be handled by hooks or natural language)

#### Scenario: Command addition evaluation
- **WHEN** a new command is proposed
- **THEN** it must satisfy all 5 criteria
- **AND** documentation must explain why each criterion is met

#### Scenario: Command vs agent decision
- **WHEN** deciding between command and agent
- **THEN** prefer agent if operation is:
  - Simple tool invocation (e.g., `ruff check`)
  - Project-specific configuration (e.g., assumes pytest installed)
  - Better served by natural language composition (e.g., "run only integration tests")
  - Automatable via hooks (e.g., format on save)

#### Scenario: Command vs hook decision
- **WHEN** deciding between command and automation hook
- **THEN** prefer hook if operation:
  - Should run automatically (e.g., format on save, test on test file edit)
  - Has clear trigger condition (e.g., before git commit)
  - Doesn't need user interaction or confirmation
  - Benefits from being invisible to user

### Requirement: Natural Language Operation Guidance

The plugin SHALL document natural language patterns for common operations that were previously commands.

#### Scenario: Task analysis guidance
- **WHEN** documentation describes task analysis
- **THEN** it provides natural language patterns:
  - "Help me analyze this task: [description]"
  - "Break down this feature into implementation steps"
  - "What are the risks and constraints for [task]?"
- **AND** explains that `requirements-analyst` agent will activate

#### Scenario: API creation guidance
- **WHEN** documentation describes API endpoint creation
- **THEN** it provides natural language patterns:
  - "Create a FastAPI endpoint for [feature]"
  - "Add a POST endpoint to handle [operation]"
  - "Implement CRUD endpoints for [resource]"
- **AND** explains that `implement-feature` agent and `fastapi-patterns` skill will activate

#### Scenario: Code quality guidance
- **WHEN** documentation describes code quality operations
- **THEN** it provides natural language patterns:
  - "Fix linting issues" (or rely on auto-format hook)
  - "Check for type errors"
  - "Run all quality checks"
- **AND** explains available automation hooks

#### Scenario: Testing guidance
- **WHEN** documentation describes test operations
- **THEN** it provides natural language patterns:
  - "Run tests for [module]"
  - "Run the full test suite with coverage"
  - "Run only the failing tests"
- **AND** explains auto-test hook on test file edits

### Requirement: Command Migration Documentation

The plugin README SHALL include a migration guide for users transitioning from removed commands.

#### Scenario: Before/after examples
- **WHEN** migration guide is displayed
- **THEN** it provides before/after table:
  - Old command → New approach
  - Explanation of why new approach is better
  - Link to relevant agent or skill documentation

#### Scenario: Breaking change visibility
- **WHEN** plugin is updated with removed commands
- **THEN** changelog clearly marks command removal as BREAKING
- **AND** links to migration guide
- **AND** explains rationale for removal

#### Scenario: Rollback documentation
- **WHEN** users need previous version
- **THEN** documentation provides instructions to:
  - Pin plugin to previous version (if supported)
  - Access archived command files in git history
  - Report issues if migration is problematic

### Requirement: OpenSpec Command Preservation

The plugin SHALL preserve all 3 OpenSpec workflow commands without modification.

#### Scenario: Proposal command
- **WHEN** `/openspec:proposal` is invoked
- **THEN** it scaffolds proposal structure
- **AND** reads context from project.md and existing specs
- **AND** validates with `openspec validate <id> --strict`
- **AND** provides structured guardrails

#### Scenario: Apply command
- **WHEN** `/openspec:apply` is invoked
- **THEN** it reads proposal, design, and tasks
- **AND** enforces sequential task completion
- **AND** updates task checkboxes after completion
- **AND** tracks progress in conversation

#### Scenario: Archive command
- **WHEN** `/openspec:archive` is invoked
- **THEN** it validates change ID
- **AND** runs `openspec archive <id> --yes`
- **AND** verifies specs were updated
- **AND** confirms change moved to archive directory

### Requirement: Automation Hook Documentation

The plugin SHALL clearly document automation hooks as alternatives to manual commands.

#### Scenario: Auto-format documentation
- **WHEN** user reads about code formatting
- **THEN** documentation explains PostToolUse hook:
  - Triggers on `.py` file writes/edits
  - Runs `ruff format` automatically
  - No manual command needed
- **AND** shows how to disable if needed (modify `.claude/settings.json`)

#### Scenario: Auto-test documentation
- **WHEN** user reads about testing
- **THEN** documentation explains PostToolUse hook:
  - Triggers on test file writes/edits
  - Runs relevant tests automatically
  - Provides immediate feedback
- **AND** shows how to run tests manually when needed

#### Scenario: Pre-commit gate documentation
- **WHEN** user reads about quality checks
- **THEN** documentation explains PreToolUse hook:
  - Triggers on `git commit` commands
  - Runs lint + type check + tests
  - Blocks commit if checks fail
- **AND** shows how to skip with `CLAUDE_SKIP_CHECKS=1` env var

### Requirement: Plugin Interface Hierarchy

The plugin SHALL present its capabilities in the following priority order:
1. **Agents** (32) - Primary interface for complex, contextual tasks
2. **Skills** (29) - Automatic guidance for code patterns
3. **Automation Hooks** - Invisible quality improvements
4. **Commands** (3) - Structured workflow orchestration only

#### Scenario: Documentation hierarchy
- **WHEN** README is displayed
- **THEN** it presents sections in order:
  1. Agents (with categories and examples)
  2. Skills (with triggering patterns)
  3. Automation Hooks (with triggers)
  4. Commands (OpenSpec workflow only)

#### Scenario: Getting started guide
- **WHEN** new user reads getting started
- **THEN** it emphasizes natural language interface first:
  - "Just ask Claude what you want"
  - "Agents activate automatically based on your request"
  - "Skills guide code generation patterns"
- **AND** mentions commands as optional workflow tools

#### Scenario: Feature count messaging
- **WHEN** plugin is described
- **THEN** messaging highlights:
  - "32 specialized agents for every development task"
  - "29 pattern skills for code quality"
  - "Automatic code formatting, testing, and quality gates"
- **NOT**: "X slash commands available"
