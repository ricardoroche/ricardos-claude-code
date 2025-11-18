# agent-migration-strategy Specification

## Purpose
TBD - created by archiving change agent-system-restructure. Update Purpose after archive.
## Requirements
### Requirement: Preserve Agent Names and Activation

Existing agent names and activation keywords MUST remain unchanged to maintain backward compatibility.

#### Scenario: Existing agent is migrated

**Given** an existing task-oriented agent is being migrated
**When** the agent is converted to hybrid pattern
**Then** the frontmatter `name` field MUST remain identical
**And** activation `description` MUST preserve key triggering phrases
**And** existing user workflows MUST continue to activate the agent

**Example**:
```yaml
# Before
---
name: write-unit-tests
description: Use when writing pytest unit tests...
---

# After (MUST preserve name)
---
name: write-unit-tests
description: Use when writing pytest unit tests for new or existing Python code
category: implementation
pattern_version: "1.0"
---
```

### Requirement: Convert Instructions to Role & Workflows

Existing prescriptive instructions MUST be reorganized into Role & Mindset + Specialized Workflows structure.

#### Scenario: Task agent converted to hybrid pattern

**Given** an existing agent has prescriptive "Your Task" section with steps
**When** the agent is migrated
**Then** prescriptive steps MUST be converted to:
1. **Role & Mindset** section capturing the agent's thinking approach
2. **Specialized Workflows** section with 3-5 distinct task workflows
3. Each workflow with "When to use", "Steps", and "Skills Invoked"

**Example**:
```markdown
# Before (Task-Oriented)
You are a specialist in writing pytest unit tests.

