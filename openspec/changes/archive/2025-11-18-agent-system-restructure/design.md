# Design Document: Agent System Restructure & AI/LLM Expansion

**Change ID:** `2025-11-18-agent-system-restructure`
**Date:** 2025-11-18

## Overview

This document details the architectural decisions, design patterns, and implementation approach for restructuring the Claude Code plugin's agent system.

## Design Principles

### 1. Hybrid Pattern: Best of Both Worlds

**Principle**: Combine role-based mindset with task-specific workflows

**Rationale**:
- **Role-based** provides flexibility and reusability across contexts
- **Task-specific workflows** provide prescriptive guidance users need
- **Hybrid** approach maintains value of existing task agents while adding role consistency

**Trade-offs**:
- ✅ More comprehensive than pure role-based
- ✅ More flexible than pure task-based
- ❌ Slightly more complex structure
- ❌ Requires careful workflow scoping

### 2. Skill-Workflow Integration

**Principle**: Agent workflows written with language that triggers specific skills

**Rationale**:
- Skills auto-activate based on code patterns and keywords
- Workflows that mention "async/await", "FastAPI endpoints", "Pydantic models" automatically trigger relevant skills
- Creates emergent behavior where agents naturally invoke best practices

**Example**:
```markdown
### Workflow: Implement RAG System

1. **Design retrieval architecture**
   - Create vector store with embedding model
   - Design chunking strategy with semantic boundaries
   - Implement reranking for precision

2. **Build FastAPI endpoints**
   - Create async endpoint for query processing
   - Add Pydantic models for request/response validation
   - Implement streaming for long responses

3. **Add evaluation metrics**
   - Track retrieval precision/recall
   - Monitor generation quality
   - Log user feedback signals
```

This workflow would trigger:
- `rag-design-patterns` (mentions "RAG", "vector store", "embedding")
- `fastapi-patterns` (mentions "FastAPI endpoints", "async endpoint")
- `pydantic-models` (mentions "Pydantic models")
- `observability-logging` (mentions "Log", "Track", "Monitor")
- `evaluation-metrics` (mentions "evaluation metrics", "precision/recall")

### 3. Progressive Disclosure

**Principle**: Agents provide overview, workflows provide detail, skills provide enforcement

**Hierarchy**:
1. **Agent Role & Mindset** → High-level thinking approach (2-3 paragraphs)
2. **Agent Workflows** → Step-by-step task guidance (5-10 steps per workflow)
3. **Skill Patterns** → Detailed code examples and anti-patterns (comprehensive)

**Rationale**: Users can work at different levels of abstraction based on their needs

### 4. Clear Boundaries

**Principle**: Every agent explicitly states what it Will and Will Not do

**Rationale**:
- Prevents scope creep and confusion
- Helps users choose the right agent
- Enables future agent specialization

**Example**:
```markdown
## Boundaries

**Will:**
- Design secure authentication flows
- Review code for OWASP Top 10 vulnerabilities
- Recommend security best practices for AI systems

**Will Not:**
- Perform actual penetration testing
- Audit infrastructure (see mlops-ai-engineer)
- Implement security features (see llm-app-engineer)
```

## Architecture

### Agent Structure (Hybrid Pattern)

```markdown
---
name: agent-name
description: Brief one-sentence description for activation
category: architecture|implementation|quality|operations|analysis|communication
pattern_version: "1.0"
model: sonnet | opus | haiku
color: orange|red|green|blue|purple|yellow|cyan|pink
---

# Agent Name

## Role & Mindset

[2-3 paragraphs describing the agent's role, thinking approach, and core principles]

## Triggers

When to activate this agent:
- [Keyword or context pattern 1]
- [Keyword or context pattern 2]
- [Scenario description]

## Focus Areas

Core domains of expertise:
- **[Area 1]**: Brief description
- **[Area 2]**: Brief description
- **[Area 3]**: Brief description

## Specialized Workflows

### Workflow 1: [Task Name]

**When to use**: [Scenario description]

**Steps**:
1. **[Action]**: [Description]
   - [Detail with code example if needed]
   - [Best practice note]

2. **[Action]**: [Description]
   ...

**Skills Invoked**: `skill-1`, `skill-2`, `skill-3`

### Workflow 2: [Task Name]
[Similar structure]

### Workflow N: [Task Name]
[Similar structure]

## Skills Integration

**Primary Skills** (always relevant):
- `skill-name-1` - [How it supports this agent]
- `skill-name-2` - [How it supports this agent]

**Secondary Skills** (context-dependent):
- `skill-name-3` - [When it's needed]
- `skill-name-4` - [When it's needed]

## Outputs

Typical deliverables:
- [Output 1 with format description]
- [Output 2 with format description]

## Best Practices

Key principles to follow:
- ✅ [Best practice 1]
- ✅ [Best practice 2]
- ❌ Avoid [anti-pattern 1]
- ❌ Avoid [anti-pattern 2]

## Boundaries

**Will:**
- [Responsibility 1]
- [Responsibility 2]
- [Responsibility 3]

**Will Not:**
- [Out of scope 1] (see [other-agent])
- [Out of scope 2] (see [other-agent])

## Related Agents

- **[agent-name-1]** - [Relationship/handoff scenario]
- **[agent-name-2]** - [Relationship/handoff scenario]
```

### Skill Structure (Pattern Enforcement)

Skills maintain current structure with enhancement:

```markdown
---
name: skill-name
description: Automatically applies when [trigger]. Ensures [outcome].
category: python|ai-llm|observability|velocity|security
---

# Skill Name

**Trigger Keywords**: [keyword1], [keyword2], [keyword3]
**Agent Integration**: Used by [agent1], [agent2], [agent3]

When [context or code pattern detected]:

## ✅ Correct Pattern
[Code examples with explanations]

## ❌ Incorrect Pattern
[Anti-patterns with explanations]

## [Domain-Specific Sections]
...

## Best Practices Checklist
...

## Auto-Apply
When you detect [trigger], automatically:
1. [Action 1]
2. [Action 2]

## Related Skills
- [skill-1] - [relationship]
```

**New Additions**:
- `Trigger Keywords`: Explicit list for workflow integration
- `Agent Integration`: Which agents commonly use this skill
- `category`: For better organization

### Agent Categorization Model

| Category | Purpose | Agent Count | Examples |
|----------|---------|-------------|----------|
| **architecture** | High-level system design and planning | 5 | ml-system-architect, rag-architect, system-architect |
| **implementation** | Hands-on code writing and feature building | 7 | llm-app-engineer, agent-orchestrator-engineer, implement-feature |
| **quality** | Code review, testing, performance, security | 8 | code-reviewer, security-engineer, evaluation-engineer |
| **operations** | Deployment, monitoring, optimization, maintenance | 4 | mlops-ai-engineer, optimize-db-query, upgrade-dependency |
| **analysis** | Research, requirements gathering, planning | 4 | requirements-analyst, tech-stack-researcher, deep-research-agent |
| **communication** | Documentation, teaching, knowledge transfer | 3 | technical-ml-writer, learning-guide, experiment-notebooker |

### Skill-Workflow Trigger Mechanism

**How It Works**:

1. **Workflow Contains Trigger Language**: Agent workflow mentions "FastAPI", "async", "Pydantic models"
2. **Skill Watches for Keywords**: Each skill defines trigger keywords in frontmatter
3. **Automatic Activation**: Claude Code runtime activates skills when keywords detected in agent workflow execution
4. **Enforcement**: Skills provide guardrails and best practices during workflow execution

**Implementation in Agents**:

Workflows explicitly list triggered skills at the end:

```markdown
### Workflow: Build API Endpoint

**Steps**:
1. Design FastAPI route with async handler
2. Create Pydantic request/response models
3. Add OpenTelemetry tracing
4. Write pytest tests with fixtures

**Skills Invoked**: `fastapi-patterns`, `pydantic-models`, `async-await-checker`, `observability-logging`, `pytest-patterns`
```

This creates **explicit contract** between agents and skills.

## Agent Inventory Design

### 31 Total Agents (After Restructure)

#### Architecture Agents (5)

| Agent | Source | Status |
|-------|--------|--------|
| ml-system-architect | New | Create |
| rag-architect | New | Create |
| system-architect | New (untracked) | Adapt to Python/AI |
| backend-architect | New (untracked) | Adapt to Python/AI |
| frontend-architect | New (untracked) | Adapt to Python/AI (limited scope) |

#### Implementation Agents (7)

| Agent | Source | Status |
|-------|--------|--------|
| llm-app-engineer | New | Create |
| agent-orchestrator-engineer | New | Create |
| implement-feature | Existing | Migrate to hybrid |
| write-unit-tests | Existing | Migrate to hybrid |
| add-agent-tool | Existing | Migrate to hybrid |
| experiment-notebooker | New | Create |
| fix-pr-comments | Existing | Migrate to hybrid |

#### Quality Agents (8)

| Agent | Source | Status |
|-------|--------|--------|
| code-reviewer | Existing | Migrate to hybrid |
| security-engineer | New (untracked) | Adapt to Python/AI |
| performance-engineer | New (untracked) | Adapt to Python/AI |
| evaluation-engineer | New | Create |
| python-ml-refactoring-expert | New | Create |
| performance-and-cost-engineer-llm | New | Create |
| security-and-privacy-engineer-ml | New | Create |
| refactoring-expert | New (untracked) | Adapt to Python/AI |

#### Operations Agents (4)

| Agent | Source | Status |
|-------|--------|--------|
| mlops-ai-engineer | New | Create |
| optimize-db-query | Existing | Migrate to hybrid |
| upgrade-dependency | Existing | Migrate to hybrid |
| debug-test-failure | Existing | Migrate to hybrid |

#### Analysis Agents (4)

| Agent | Source | Status |
|-------|--------|--------|
| ai-product-analyst | New | Create |
| requirements-analyst | New (untracked) | Adapt to Python/AI |
| tech-stack-researcher | New (untracked) | Adapt to Python/AI |
| deep-research-agent | Existing | Migrate to hybrid |

#### Communication Agents (3)

| Agent | Source | Status |
|-------|--------|--------|
| technical-ml-writer | New | Create |
| learning-guide | New (untracked) | Adapt to Python/AI |
| technical-writer | Existing | Migrate to hybrid |

**Action Summary**:
- **Create**: 12 new AI-focused agents
- **Adapt**: 9 JavaScript-focused agents to Python/AI
- **Migrate**: 10 existing task agents to hybrid pattern

## Skill Inventory Design

### 29 Total Skills (After Expansion)

#### Python Engineering Skills (15)

**Existing (10)**:
- async-await-checker
- pydantic-models
- fastapi-patterns
- pytest-patterns
- type-safety
- docstring-format
- structured-errors
- tool-design-pattern
- dynaconf-config
- pii-redaction

**New (5)**:
- database-migrations (Alembic, SQLAlchemy patterns)
- query-optimization (SQL/DuckDB best practices)
- python-packaging (project structure, pyproject.toml)
- dependency-management (uv, Poetry, pip-tools)
- code-review-framework (structured review checklist)

#### AI/LLM Skills (7 New)

- llm-app-architecture (general LLM application patterns)
- agent-orchestration-patterns (multi-agent systems, tool calling)
- rag-design-patterns (RAG architecture and best practices)
- prompting-patterns (prompt engineering guidelines)
- evaluation-metrics (AI evaluation and testing)
- model-selection (choosing models and providers)
- ai-security (AI/LLM-specific security)

#### Observability Skills (3 New)

- observability-logging (structured logging, OpenTelemetry)
- monitoring-alerting (metrics, dashboards, alerts)
- performance-profiling (profiling tools and optimization)

#### Developer Velocity Skills (4 New)

- git-workflow-standards (branching, commits, PRs)
- cli-tool-patterns (CLI design best practices)
- openspec-conventions (OpenSpec formatting and patterns)
- documentation-templates (docs structure and examples)

## Migration Strategy

### Phase 1: Create Foundation

**Week 1**:
1. Finalize hybrid agent template
2. Create 3 proof-of-concept agents:
   - backend-architect (adapt existing)
   - system-architect (adapt existing)
   - ml-system-architect (create new)
3. Create 3 foundational AI/LLM skills:
   - llm-app-architecture
   - agent-orchestration-patterns
   - rag-design-patterns

**Week 2**:
4. Create 4 remaining AI/LLM skills
5. Test skill-workflow triggering mechanism
6. Document migration process

### Phase 2: Migrate & Expand

**Weeks 3-4** (Existing Agent Migration):
7. Migrate quality agents (code-reviewer, debug-test-failure)
8. Migrate implementation agents (implement-feature, write-unit-tests)
9. Migrate operations agents (optimize-db-query, upgrade-dependency)
10. Migrate remaining agents (deep-research-agent, technical-writer, etc.)

**Weeks 5-6** (New Agent Adaptation & Creation):
11. Adapt remaining 6 role agents to Python/AI
12. Create remaining 9 new AI-focused agents
13. Create 12 new supporting skills (Python, observability, velocity)

### Phase 3: Validate & Polish

**Week 7**:
14. OpenSpec validation (--strict)
15. Documentation updates
16. User testing and feedback
17. Final adjustments

### Backward Compatibility

**Guaranteed**:
- ✅ Existing agent names remain unchanged
- ✅ Existing agent activation keywords unchanged
- ✅ Existing skill auto-activation unchanged
- ✅ Command interfaces unchanged
- ✅ Hook system unchanged

**Changes**:
- ✅ Agent internal structure enhanced (backward compatible)
- ✅ New skills added (non-breaking)
- ✅ New agents added (additive only)

## Testing Strategy

### Agent Testing

1. **Activation Testing**: Verify agents activate on correct keywords/contexts
2. **Workflow Testing**: Ensure each workflow produces expected outputs
3. **Skill Triggering**: Verify workflows trigger correct skills
4. **Boundary Testing**: Confirm agents respect Will/Will Not boundaries

### Skill Testing

1. **Pattern Detection**: Verify skills activate on correct trigger keywords
2. **Enforcement Testing**: Confirm skills catch anti-patterns
3. **Integration Testing**: Verify skill-agent coupling works correctly

### Migration Testing

1. **Regression Testing**: Existing workflows still work after migration
2. **Comparison Testing**: Old vs. new agent output comparison
3. **User Acceptance Testing**: Real users validate new patterns

## Implementation Plan

See `tasks.md` for detailed task breakdown.

**High-Level Phases**:
1. ✅ Scaffold proposal structure (complete)
2. ✅ Draft proposal and design docs (complete)
3. 🔄 Draft all spec deltas (in progress)
4. ⏳ Create comprehensive task list
5. ⏳ Validate with OpenSpec
6. ⏳ Begin implementation

## Open Design Questions

### 1. Skill Namespace Strategy

**Question**: Should we namespace AI/LLM skills to avoid conflicts?

**Options**:
- A. Prefix with `ai-` (e.g., `ai-security` vs. `pii-redaction`)
- B. Prefix with `llm-` (e.g., `llm-security`)
- C. No prefix, rely on full names (e.g., `security-and-safety-ml`)

**Decision**: **Option C** - Use descriptive full names. Clear and self-documenting.

### 2. Agent Model Defaults

**Question**: What should be default model for different agent types?

**Proposal**:
- Architecture agents: `sonnet` (requires reasoning)
- Implementation agents: `sonnet` (requires code generation)
- Quality agents: `sonnet` (requires analysis)
- Operations agents: `haiku` (can be faster for routine tasks)
- Analysis agents: `sonnet` (requires research)
- Communication agents: `haiku` (can be faster for docs)

**Decision**: **Start with `sonnet` for all**, optimize later based on usage data

### 3. Workflow Granularity

**Question**: How many workflows per agent?

**Proposal**: **3-5 specialized workflows** per agent
- Too few (1-2): Agent too narrow
- Too many (6+): Agent too complex, hard to maintain

**Decision**: **3-5 workflows** as guideline, flexible based on agent scope

### 4. Frontend Agent Scope

**Question**: Should frontend-architect agent be in Python AI plugin?

**Options**:
- A. Keep and adapt to Python UI frameworks (Streamlit, Gradio)
- B. Keep but focus on LLM UI/UX patterns (chatbots, streaming)
- C. Remove entirely (out of scope)

**Decision**: **Option B** - Keep with focus on AI/LLM UIs (Streamlit, Gradio, chat interfaces)

## References

- Existing agents: `.claude/agents/`
- Existing skills: `.claude/skills/`
- OpenSpec project: `openspec/project.md`
- Previous proposal: `proposal.md` (repo root)
