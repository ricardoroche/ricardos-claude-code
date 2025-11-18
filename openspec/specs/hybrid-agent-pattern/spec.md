# hybrid-agent-pattern Specification

## Purpose
TBD - created by archiving change agent-system-restructure. Update Purpose after archive.
## Requirements
### Requirement: Agent Frontmatter Structure

All agent files MUST include standardized frontmatter with required fields.

#### Scenario: Creating new agent file

**Given** a new agent is being created
**When** the agent markdown file is written
**Then** it MUST include frontmatter with:
- `name` (string, kebab-case, unique)
- `description` (string, one-sentence activation description)
- `category` (enum: architecture|implementation|quality|operations|analysis|communication)
- `pattern_version` (string, currently "1.0")
- `model` (enum: sonnet|opus|haiku, default: sonnet)
- `color` (enum: orange|red|green|blue|purple|yellow|cyan|pink, for UI)

**Example**:
```yaml
---
name: ml-system-architect
description: Design end-to-end ML/LLM systems with focus on reliability and scalability
category: architecture
pattern_version: "1.0"
model: sonnet
color: blue
---
```

### Requirement: Role & Mindset Section

All agents MUST include a "Role & Mindset" section describing behavioral principles.

#### Scenario: Agent defines its thinking approach

**Given** an agent is being documented
**When** the Role & Mindset section is written
**Then** it MUST contain:
- 2-3 paragraphs describing the agent's role
- Core thinking principles and approach
- What makes this agent's perspective unique

**And** it SHOULD use first-person perspective ("I think about...", "My approach...")

**Example**:
```markdown

