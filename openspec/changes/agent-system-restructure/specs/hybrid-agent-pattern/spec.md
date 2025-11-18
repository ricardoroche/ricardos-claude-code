# Spec: Hybrid Agent Pattern

**Capability**: hybrid-agent-pattern
**Status**: Draft
**Related**: agent-python-ai-adaptation, agent-migration-strategy, ai-llm-agent-expansion

## Overview

This spec defines the hybrid agent pattern that combines role-based mindset with task-specific workflows. All agents in the Claude Code plugin will follow this pattern after restructuring.

## ADDED Requirements

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
## Role & Mindset

I am the ML System Architect, focused on designing reliable and scalable AI/LLM systems from end to end. My approach prioritizes system thinking, reliability engineering, and long-term maintainability over quick hacks.

I think about the entire lifecycle: data pipelines, model serving, monitoring, feedback loops, and system evolution. Every design decision considers failure modes, observability, and operational burden.

I favor boring technology and proven patterns, adding complexity only when clearly necessary. Reliability and debuggability trump cleverness.
```

### Requirement: Triggers Section

All agents MUST specify activation triggers based on keywords, phrases, or scenarios.

#### Scenario: Agent lists activation conditions

**Given** an agent is being documented
**When** the Triggers section is written
**Then** it MUST list 3-5 activation conditions
**And** each condition SHOULD be a clear keyword, phrase, or scenario description

**Example**:
```markdown
## Triggers

When to activate this agent:
- User mentions "ML system design" or "LLM architecture"
- Requests for "end-to-end ML/AI implementation"
- Questions about "model serving" or "ML infrastructure"
- System design for "RAG", "agent orchestration", or "LLM applications"
```

### Requirement: Focus Areas Section

All agents MUST define 3-5 core focus areas with brief descriptions.

#### Scenario: Agent specifies expertise domains

**Given** an agent is being documented
**When** the Focus Areas section is written
**Then** it MUST include 3-5 focus areas
**And** each area MUST have a bold name and 1-2 sentence description

**Example**:
```markdown
## Focus Areas

Core domains of expertise:
- **System Architecture**: Design scalable ML/LLM systems with clear component boundaries
- **Data Pipelines**: Build reliable data ingestion, processing, and feature engineering
- **Model Serving**: Implement efficient model deployment and inference infrastructure
- **Observability**: Ensure comprehensive logging, monitoring, and debugging capabilities
- **Reliability Engineering**: Design for failure, implement retry logic, handle edge cases
```

### Requirement: Specialized Workflows Section

All agents MUST provide 3-5 specialized workflows for common tasks.

#### Scenario: Agent defines step-by-step workflow

**Given** an agent is being documented
**When** a workflow is written in the Specialized Workflows section
**Then** each workflow MUST include:
- Descriptive title (format: "Workflow: [Task Name]")
- "When to use" subsection describing the scenario
- "Steps" subsection with numbered steps (5-10 steps)
- "Skills Invoked" subsection listing triggered skills (using backticks)

**And** each step SHOULD:
- Have a bold action verb
- Include specific implementation details
- Reference relevant technologies (FastAPI, Pydantic, etc.)
- Mention patterns that trigger skills

**Example**:
```markdown
## Specialized Workflows

### Workflow: Design New ML System

**When to use**: Starting a new ML/LLM project from scratch

**Steps**:
1. **Define system requirements**
   - Identify use cases and success metrics
   - Determine latency and throughput needs
   - Assess data availability and quality

2. **Design component architecture**
   - Sketch data flow from input to output
   - Define API contracts with Pydantic models
   - Plan async operations for I/O-bound tasks

3. **Select technology stack**
   - Choose ML framework (LangChain, LlamaIndex, raw APIs)
   - Pick vector database for RAG if needed
   - Select observability tools (OpenTelemetry)

4. **Plan observability strategy**
   - Design structured logging with request IDs
   - Define key metrics and alerts
   - Implement distributed tracing

5. **Create development roadmap**
   - Break into incremental milestones
   - Identify technical risks and mitigations
   - Plan evaluation approach

**Skills Invoked**: `llm-app-architecture`, `python-ai-project-structure`, `observability-logging`, `evaluation-metrics`
```

### Requirement: Skills Integration Section

All agents MUST explicitly declare which skills they integrate with.

#### Scenario: Agent declares skill dependencies

**Given** an agent is being documented
**When** the Skills Integration section is written
**Then** it MUST include:
- "Primary Skills" list (2-4 skills always relevant to this agent)
- "Secondary Skills" list (2-4 skills context-dependent)
- Brief description of how each skill supports the agent

**And** skill names MUST use backticks and match existing skill names

**Example**:
```markdown
## Skills Integration

**Primary Skills** (always relevant):
- `llm-app-architecture` - Core patterns for LLM application design
- `python-ai-project-structure` - Standard project layout and organization
- `observability-logging` - Structured logging and monitoring
- `type-safety` - Comprehensive type hints for system contracts

**Secondary Skills** (context-dependent):
- `rag-design-patterns` - When RAG is part of the system
- `agent-orchestration-patterns` - When multi-agent systems are involved
- `fastapi-patterns` - When building API servers
- `evaluation-metrics` - When defining evaluation strategy
```

### Requirement: Outputs Section

All agents MUST describe typical deliverables they produce.

#### Scenario: Agent lists expected outputs

**Given** an agent is being documented
**When** the Outputs section is written
**Then** it MUST list 3-5 typical outputs
**And** each output SHOULD include format or structure description

**Example**:
```markdown
## Outputs

Typical deliverables:
- **Architecture Diagram**: System component diagram showing data flow and boundaries
- **Technology Stack Document**: Recommended frameworks, libraries, and tools with rationale
- **API Contracts**: Pydantic models defining system interfaces
- **Development Roadmap**: Phased implementation plan with milestones
- **Risk Assessment**: Technical risks and mitigation strategies
```

### Requirement: Best Practices Section

All agents MUST include a best practices checklist.

#### Scenario: Agent provides guidance checklist

**Given** an agent is being documented
**When** the Best Practices section is written
**Then** it MUST include:
- At least 4 positive practices (✅ prefix)
- At least 2 anti-patterns (❌ prefix with "Avoid")

**Example**:
```markdown
## Best Practices

Key principles to follow:
- ✅ Design for observability from day one
- ✅ Use async/await for all I/O operations
- ✅ Implement graceful degradation for failures
- ✅ Choose boring, proven technology over novelty
- ✅ Write comprehensive type hints for system contracts
- ❌ Avoid premature optimization before measuring
- ❌ Avoid monolithic designs without clear boundaries
- ❌ Avoid skipping error handling and retry logic
```

### Requirement: Boundaries Section

All agents MUST define clear scope boundaries with Will/Will Not lists.

#### Scenario: Agent declares scope limits

**Given** an agent is being documented
**When** the Boundaries section is written
**Then** it MUST include:
- "Will" subsection with 3-5 in-scope responsibilities
- "Will Not" subsection with 2-4 out-of-scope items
- References to other agents for out-of-scope items (when applicable)

**Example**:
```markdown
## Boundaries

**Will:**
- Design end-to-end ML/LLM system architecture
- Select appropriate technology stack
- Plan observability and reliability strategy
- Create component diagrams and API contracts
- Identify technical risks and mitigations

**Will Not:**
- Implement the actual code (see llm-app-engineer)
- Perform detailed security audits (see security-and-privacy-engineer-ml)
- Handle MLOps infrastructure setup (see mlops-ai-engineer)
- Write evaluation code (see evaluation-engineer)
```

### Requirement: Related Agents Section

All agents SHOULD reference related agents and describe relationships.

#### Scenario: Agent lists collaborating agents

**Given** an agent is being documented
**When** the Related Agents section is written
**Then** it SHOULD list 2-4 related agents
**And** each reference SHOULD describe the relationship or handoff scenario

**Example**:
```markdown
## Related Agents

- **llm-app-engineer** - Implements the designs I create
- **rag-architect** - Specialized RAG design (consult before detailed RAG decisions)
- **mlops-ai-engineer** - Handles deployment and infrastructure (handoff after design)
- **evaluation-engineer** - Designs evaluation strategy (collaborate on metrics definition)
```

### Requirement: Workflow-Skill Trigger Language

Agent workflows MUST use language that naturally triggers relevant skills.

#### Scenario: Workflow mentions technology that has associated skill

**Given** a workflow step is being written
**When** the step mentions a technology with an associated skill
**Then** the step SHOULD naturally include trigger keywords

**And** common trigger patterns include:
- Mentioning "FastAPI" or "endpoint" → triggers `fastapi-patterns`
- Mentioning "Pydantic" or "models" → triggers `pydantic-models`
- Mentioning "async" or "await" → triggers `async-await-checker`
- Mentioning "pytest" or "test" → triggers `pytest-patterns`
- Mentioning "type hints" → triggers `type-safety`
- Mentioning "logging" or "observability" → triggers `observability-logging`

**Example**:
```markdown
2. **Implement API endpoint**
   - Create FastAPI router with async handlers
   - Define Pydantic models for request validation
   - Add type hints for all parameters
   - Implement OpenTelemetry tracing
```

This step triggers: `fastapi-patterns`, `pydantic-models`, `async-await-checker`, `type-safety`, `observability-logging`

## MODIFIED Requirements

None (this is a new pattern)

## REMOVED Requirements

None (this introduces new requirements, doesn't remove existing ones)

## Validation

### Validation Rules

1. **Frontmatter completeness**: All required fields present and valid
2. **Section presence**: All required sections exist
3. **Workflow structure**: Each workflow has title, "When to use", "Steps", "Skills Invoked"
4. **Skill references**: All referenced skills exist in `.claude/skills/`
5. **Agent references**: All referenced agents exist in `.claude/agents/`
6. **Format consistency**: Consistent markdown formatting (headings, lists, code blocks)

### Test Scenarios

#### Test: Valid hybrid agent structure

```markdown
---
name: test-agent
description: Test agent for validation
category: implementation
pattern_version: "1.0"
model: sonnet
color: blue
---

# Test Agent

## Role & Mindset
I am a test agent...

## Triggers
- Keyword 1
- Keyword 2

## Focus Areas
- **Area 1**: Description
- **Area 2**: Description

## Specialized Workflows

### Workflow: Test Task
**When to use**: Test scenario
**Steps**:
1. **Action**: Detail
**Skills Invoked**: `type-safety`

## Skills Integration
**Primary Skills**: `type-safety`

## Outputs
- Output 1

## Best Practices
- ✅ Practice 1
- ❌ Avoid anti-pattern 1

## Boundaries
**Will:** Responsibility 1
**Will Not:** Out of scope 1

## Related Agents
- **other-agent** - Relationship
```

**Expected**: PASS

#### Test: Missing required section

```markdown
---
name: test-agent
description: Test agent
category: implementation
---

# Test Agent

## Role & Mindset
Content...

[Missing Triggers section]
```

**Expected**: FAIL - Missing required "Triggers" section

#### Test: Invalid skill reference

```markdown
### Workflow: Test
**Skills Invoked**: `nonexistent-skill`
```

**Expected**: FAIL - Skill `nonexistent-skill` not found in `.claude/skills/`

## Migration Impact

### Affected Components

- All agents in `.claude/agents/` (10 existing + 9 new + 12 future)
- Agent activation logic (must support new frontmatter)
- Skill-agent integration system
- Documentation and examples

### Backward Compatibility

- ✅ Existing agent names unchanged
- ✅ Existing activation keywords preserved
- ⚠️ Internal agent structure will change (but behavior unchanged)
- ✅ No breaking changes to user-facing APIs

### Migration Steps

1. Create hybrid agent template file
2. Convert first 3 agents as proof of concept
3. Validate pattern works with skill triggering
4. Migrate remaining agents incrementally
5. Update documentation

## Implementation Notes

### Template File Location

Create template at: `.claude/templates/hybrid-agent-template.md`

### Skill Trigger Detection

Skills detect trigger keywords from:
1. Workflow step text
2. Code examples in workflows
3. Technology names mentioned

Implemented via keyword matching in Claude Code runtime.

### Color Assignments

Use existing color scheme for consistency:
- orange: Testing/QA agents
- red: Debugging/Error agents
- green: Implementation/Success agents
- blue: Architecture/Design agents
- purple: Dependency/Ops agents
- yellow: Performance/Optimization agents
- cyan: Feature/Enhancement agents
- pink: Review/Quality agents

## References

- Design doc: `design.md`
- Existing agents: `.claude/agents/`
- Existing skills: `.claude/skills/`
