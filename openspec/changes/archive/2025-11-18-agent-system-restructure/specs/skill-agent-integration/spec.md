# Spec: Skill-Agent Integration

**Capability**: skill-agent-integration
**Status**: Draft
**Related**: hybrid-agent-pattern, all skill specs

## Overview

This spec defines how skills auto-activate from agent workflows through trigger language, creating emergent best-practice enforcement.

## ADDED Requirements

### Requirement: Trigger Language Mechanism

Agent workflows MUST use language that naturally triggers relevant skills.

#### Scenario: Workflow mentions technology with associated skill

**Given** an agent workflow is being executed
**When** the workflow text contains skill trigger keywords
**Then** Claude Code runtime activates the corresponding skill
**And** the skill provides pattern enforcement during workflow execution

**Example Flow**:
```
User: "Implement API endpoint for RAG queries"
  ↓
Agent: llm-app-engineer activates
  ↓
Workflow: "Build FastAPI endpoint with async handlers"
  ↓
Skills Triggered: fastapi-patterns, async-await-checker
  ↓
Enforcement: Skills guide implementation with best practices
```

### Requirement: Explicit Skill Invocation Declaration

All agent workflows MUST explicitly list skills they invoke.

#### Scenario: Workflow declares skill dependencies

**Given** an agent workflow is defined
**When** the workflow steps are written
**Then** the workflow MUST end with "Skills Invoked:" section
**And** list all skills triggered by the workflow's language

**Format**:
```markdown
### Workflow: [Name]

**When to use**: [Scenario]

**Steps**:
1. [Step mentioning technology/pattern]
2. [Step mentioning technology/pattern]

**Skills Invoked**: `skill-1`, `skill-2`, `skill-3`
```

**Example**:
```markdown
### Workflow: Implement RAG Endpoint

**When to use**: Building API endpoint for RAG queries

**Steps**:
1. **Create FastAPI router with async handlers**
   - Design endpoint with Pydantic request/response models
   - Add type hints for all parameters
   - Implement streaming for long responses

2. **Integrate vector database retrieval**
   - Query vector store with embedding
   - Implement reranking logic
   - Handle retrieval errors gracefully

3. **Add observability logging**
   - Log request ID, query, retrieval results
   - Track latency and token usage
   - Redact PII from logs

**Skills Invoked**: `fastapi-patterns`, `async-await-checker`, `pydantic-models`, `type-safety`, `rag-design-patterns`, `observability-logging`, `pii-redaction`
```

### Requirement: Skill Trigger Keyword Specification

All skills MUST explicitly declare trigger keywords in frontmatter or dedicated section.

#### Scenario: Skill defines activation triggers

**Given** a skill is being created
**When** the skill file is written
**Then** it MUST include "Trigger Keywords" section
**And** list keywords/phrases that activate this skill

**Example**:
```markdown
---
name: fastapi-patterns
description: Automatically applies when building FastAPI applications
category: python
---

# FastAPI Patterns

**Trigger Keywords**: FastAPI, endpoint, router, API route, async handler, path parameter, query parameter

**Agent Integration**: Used by implement-feature, llm-app-engineer, backend-architect
```

### Requirement: Skill-Agent Cross-Reference

Skills and agents MUST cross-reference each other.

#### Scenario: Bidirectional linking

**Given** a skill is used by multiple agents  
**When** the skill file is created  
**Then** it MUST list agents in the "Agent Integration" section  
**And** when an agent file is created for an agent that uses multiple skills  
**Then** it MUST list those skills in the "Skills Integration" section

**Example Cross-Reference**:

**In skill file** (rag-design-patterns/SKILL.md):
```markdown
**Agent Integration**: Used by rag-architect, llm-app-engineer, evaluation-engineer
```

**In agent file** (rag-architect.md):
```markdown
## Skills Integration

**Primary Skills**:
- `rag-design-patterns` - Core RAG architecture patterns
- `llm-app-architecture` - LLM integration patterns
```

### Requirement: Multi-Skill Workflow Support

Agent workflows MAY trigger multiple skills simultaneously.

#### Scenario: Complex workflow activates many skills

**Given** a workflow involves multiple technologies
**When** the workflow is executed
**Then** all relevant skills activate together
**And** skills provide complementary guidance

**Example**:
```markdown
2. **Implement async API endpoint with validation**
   - Create FastAPI router with async handler
   - Define Pydantic models for request/response
   - Add comprehensive type hints
   - Implement OpenTelemetry tracing
   - Write pytest tests with async fixtures

**Skills Invoked**: `fastapi-patterns`, `async-await-checker`, `pydantic-models`, `type-safety`, `observability-logging`, `pytest-patterns`
```

### Requirement: Skill Activation Priority

When multiple skills trigger, they MUST work together without conflicts.

#### Scenario: Skills provide complementary guidance

**Given** multiple skills activate for a workflow step
**When** patterns overlap (e.g., async-await-checker + fastapi-patterns both mention async)
**Then** skills MUST provide complementary, non-conflicting guidance
**And** each skill focuses on its domain expertise

**Example**:
- `fastapi-patterns`: "Use async handlers for I/O operations"
- `async-await-checker`: "Ensure all I/O calls use await"
- Result: Complementary guidance reinforces best practices

## Trigger Language Patterns

### Requirement: Common Trigger Patterns

Agent workflows MUST include a reference table of common trigger phrases mapped to skills to guide authors toward consistent language.

#### Scenario: Reference table is present for authors

**Given** an agent workflow is being authored  
**When** the author looks for guidance on trigger phrases  
**Then** the spec MUST provide a table mapping phrases to skills  
**And** those mappings MUST include the skills listed in the workflow

| Mention in Workflow | Triggers Skill |
|---------------------|----------------|
| "FastAPI", "endpoint", "router" | `fastapi-patterns` |
| "Pydantic", "models", "validation" | `pydantic-models` |
| "async", "await", "async def" | `async-await-checker` |
| "pytest", "test", "fixture" | `pytest-patterns` |
| "type hints", "typing" | `type-safety` |
| "logging", "observability", "tracing" | `observability-logging` |
| "LLM", "model API", "generation" | `llm-app-architecture` |
| "RAG", "retrieval", "vector" | `rag-design-patterns` |
| "agent", "tool calling", "orchestration" | `agent-orchestration-patterns` |
| "prompt", "template", "instruction" | `prompting-patterns` |
| "migration", "Alembic", "schema" | `database-migrations` |
| "query", "SQL", "EXPLAIN" | `query-optimization` |
| "PII", "redaction", "sensitive" | `pii-redaction`, `ai-security` |

### Requirement: Natural Language Triggers

Workflows MUST include natural-language examples that imply the technology or pattern to activate the appropriate skills.

#### Scenario: Natural-language examples guide authors

**Given** an agent author is writing a workflow  
**When** they look for examples of natural trigger language  
**Then** the spec MUST include examples that imply the intended skills  
**And** those examples MUST align with the skills declared in "Skills Invoked"

**Examples of Natural Triggers**:
- "Create API endpoint" → implies FastAPI → triggers `fastapi-patterns`
- "Validate user input" → implies Pydantic → triggers `pydantic-models`
- "Call LLM API" → implies async → triggers `async-await-checker`, `llm-app-architecture`
- "Add logging" → implies observability → triggers `observability-logging`

## MODIFIED Requirements

None (this is new integration model)

## REMOVED Requirements

None

## Validation

### Validation Rules

1. **Workflow skill declarations**: All workflows list "Skills Invoked"
2. **Skill trigger keywords**: All skills have explicit triggers
3. **Cross-references valid**: Agent→Skill and Skill→Agent references exist
4. **Trigger language present**: Workflow text contains trigger keywords for declared skills
5. **No orphaned skills**: Every skill referenced by at least one agent

### Test Scenarios

#### Test: Workflow triggers match declaration

**Given** workflow says:
```markdown
1. Create FastAPI endpoint with Pydantic models
**Skills Invoked**: `fastapi-patterns`, `pydantic-models`
```

**When** trigger keywords checked
**Then** workflow text contains "FastAPI" (triggers fastapi-patterns)
**And** workflow text contains "Pydantic" (triggers pydantic-models)

#### Test: Bidirectional references valid

**Given** rag-design-patterns skill lists "Used by: rag-architect"
**When** rag-architect agent is checked
**Then** agent's Skills Integration section includes `rag-design-patterns`

#### Test: No orphaned skills

**Given** all skills in `.claude/skills/`
**When** agent files are scanned
**Then** every skill is referenced by at least one agent's Skills Integration section

## Migration Impact

### Agent Updates

All agents (existing and new) need:
- ✅ Skills Integration section added
- ✅ Workflows updated with "Skills Invoked" declarations
- ✅ Workflow language reviewed for trigger keywords

### Skill Updates

All skills (existing and new) need:
- ✅ Trigger Keywords section added
- ✅ Agent Integration section added
- ✅ Category field in frontmatter

### Runtime Behavior

Claude Code system needs:
- ✅ Skill activation based on keyword matching
- ✅ Multi-skill coordination
- ✅ Agent-skill integration awareness

## Implementation Notes

### Trigger Detection Algorithm

Proposed approach:
1. Agent workflow text is parsed
2. Keywords extracted and matched against skill triggers
3. Matching skills activated for that workflow execution
4. Skills provide pattern guidance throughout execution

### Testing Strategy

1. **Unit tests**: Verify keyword matching logic
2. **Integration tests**: Confirm skills activate for agent workflows
3. **Validation tests**: Ensure cross-references are valid
4. **User tests**: Verify skills provide helpful guidance

### Documentation Needs

- User guide explaining skill-agent integration
- Developer guide for adding new skills/agents
- Examples of effective trigger language
- Troubleshooting guide for skill activation

## References

- Hybrid pattern: `specs/hybrid-agent-pattern/spec.md`
- All skill specs: `specs/ai-llm-skills/spec.md`, `specs/python-engineering-skills/spec.md`, etc.
- Design doc: `design.md`
