# Proposal: Agent System Restructure & AI/LLM Expansion

**Change ID:** `2025-11-18-agent-system-restructure`
**Status:** ✅ Complete
**Date:** 2025-11-18
**Completion Date:** 2025-11-18
**Author:** AI Assistant

## Executive Summary

This proposal comprehensively restructures the Claude Code plugin's agent system to address three critical needs:

1. **Pattern Unification**: Migrate all agents to a consistent hybrid (role + workflows) pattern that combines role-based mindset with specific task workflows
2. **Python/AI Adaptation**: Convert 9 newly-added JavaScript-focused role agents to Python AI/data engineering context
3. **AI/LLM Expansion**: Add 12 new AI-focused agents and 19 new skills to transform this plugin into a comprehensive AI/LLM engineering toolkit

## Background

### Current State

The plugin currently contains:
- **10 existing skills**: Python patterns (async-await, pydantic, pytest, etc.)
- **10 existing agents**: Task-oriented (write-unit-tests, implement-feature, etc.)
- **9 new untracked agents**: Role-oriented (backend-architect, security-engineer, etc.) - currently JavaScript-focused
- **7 commands**: Utility functions (/fix, /check, /api, etc.)

### Problem Statement

The current agent system has **three critical issues**:

1. **Inconsistent Patterns**: Task-oriented agents (prescriptive, step-by-step) vs. role-oriented agents (mindset-driven, flexible)
2. **Context Mismatch**: New role agents reference JavaScript/Next.js/React instead of Python/FastAPI/AI frameworks
3. **Coverage Gaps**: Limited AI/LLM-specific guidance (no RAG patterns, agent orchestration, LLM evaluation, etc.)

### Vision

Transform the Claude Code plugin into a **comprehensive AI/LLM engineering toolkit** with:
- **31 unified agents** following consistent hybrid pattern
- **29+ skills** covering Python, AI/LLM, observability, security, and developer velocity
- **Workflow-driven skill triggering** where agent workflows automatically activate relevant skills
- **Full AI/LLM lifecycle coverage** from architecture to deployment

## Goals

### Primary Goals

1. **Unify Agent Patterns**: Establish hybrid (role + workflows) pattern as the standard across all agents
2. **Python/AI Context**: Replace JavaScript references with Python AI/data engineering patterns (FastAPI, Pydantic, LangChain, etc.)
3. **AI/LLM Coverage**: Add comprehensive AI/LLM engineering capabilities (RAG, agents, evals, MLOps)
4. **Skill-Workflow Integration**: Create explicit model where agent workflows trigger specific skills
5. **Developer Velocity**: Add workflow-supporting skills (git standards, CLI patterns, OpenSpec conventions)

### Secondary Goals

6. **Maintain Backward Compatibility**: Existing user workflows continue to work during migration
7. **Improve Discoverability**: Clear naming and categorization helps users find the right agent
8. **Reduce Maintenance**: Consistent patterns reduce documentation and maintenance burden
9. **Enable Extensibility**: Template and patterns make it easy to add new agents

## Scope

### In Scope

**Agent Work (31 Total Agents)**:
- ✅ Adapt 9 new role agents to Python/AI context
- ✅ Migrate 10 existing task agents to hybrid pattern
- ✅ Create 12 new AI-focused agents (from proposal.md)

**Skill Work (19 New Skills)**:
- ✅ 7 AI/LLM skills (llm-app-architecture, agent-orchestration, RAG, etc.)
- ✅ 5 Python engineering skills (database-migrations, query-optimization, etc.)
- ✅ 3 Observability/ops skills (monitoring, logging, profiling)
- ✅ 4 Developer velocity skills (git-workflow, CLI patterns, OpenSpec conventions, docs)

**Architecture Work**:
- ✅ Hybrid agent pattern specification and template
- ✅ Skill-workflow integration model
- ✅ Migration strategy for existing agents
- ✅ Documentation updates

### Out of Scope

- ❌ Command changes (existing 7 commands remain as-is)
- ❌ Hook system modifications (automation hooks unchanged)
- ❌ Breaking changes to existing agent APIs
- ❌ Multi-language support beyond Python (future consideration)
- ❌ Agent marketplace or distribution system (future consideration)

## High-Level Approach

### Phase 1: Foundation (Weeks 1-2)

**Deliverables**:
1. Hybrid agent pattern specification with template
2. Skill-workflow integration model documentation
3. 7 core AI/LLM skills created
4. 3 proof-of-concept agent adaptations (backend-architect, system-architect, ml-system-architect)

**Validation**: POC agents successfully trigger skills from workflows

### Phase 2: Migration & Expansion (Weeks 3-6)

**Deliverables**:
1. All 10 existing agents migrated to hybrid pattern
2. Remaining 6 new agents adapted to Python/AI
3. 12 additional skills created (Python, observability, velocity)
4. All 12 new AI-focused agents drafted

**Validation**: All agents follow consistent pattern, skills auto-activate

### Phase 3: Validation & Polish (Week 7)

**Deliverables**:
1. Complete OpenSpec validation (--strict mode)
2. Comprehensive documentation updates
3. Migration guide for users
4. Testing and quality assurance

**Validation**: Passes all OpenSpec checks, user testing confirms workflows work

## Architecture Overview

### Hybrid Agent Pattern

Each agent combines:
1. **Role & Mindset** (role-oriented): Behavioral principles and thinking approach
2. **Specialized Workflows** (task-oriented): Specific step-by-step workflows with code examples
3. **Skill Integration**: Explicit references to skills triggered by workflows
4. **Clear Boundaries**: Will/Will Not sections defining scope

### Skill-Workflow Integration

```
User Request
    ↓
Agent Activated (keyword/context matching)
    ↓
Workflow Selected (matching user intent)
    ↓
Skills Auto-Triggered (workflow language activates patterns)
    ↓
Guided Implementation (agent + skills working together)
```

**Example**: User asks "implement RAG system"
- Activates: `rag-architect` agent
- Selects: "Design new RAG system" workflow
- Triggers skills: `rag-design-patterns`, `llm-app-architecture`, `python-ai-project-structure`, `observability-logging`
- Result: Structured RAG implementation following best practices

### Agent Categorization

| Category | Count | Examples |
|----------|-------|----------|
| **Architecture** | 5 | ml-system-architect, rag-architect, system-architect, backend-architect |
| **Implementation** | 7 | llm-app-engineer, agent-orchestrator, implement-feature, write-unit-tests |
| **Quality** | 8 | security-engineer, performance-engineer, code-reviewer, evaluation-engineer |
| **Operations** | 4 | mlops-ai-engineer, optimize-db-query, upgrade-dependency |
| **Analysis** | 4 | requirements-analyst, tech-stack-researcher, deep-research-agent |
| **Communication** | 3 | technical-ml-writer, learning-guide, experiment-notebooker |

### Skill Categorization

| Category | Count | New Skills |
|----------|-------|------------|
| **Python Engineering** | 15 | +5 (migrations, optimization, packaging, dependency-mgmt, review-framework) |
| **AI/LLM** | 7 | +7 (llm-architecture, agent-orchestration, RAG, prompting, evals, model-selection, ai-security) |
| **Observability** | 3 | +3 (logging, monitoring, profiling) |
| **Developer Velocity** | 4 | +4 (git-workflow, cli-patterns, openspec-conventions, doc-templates) |

## Dependencies

### Internal Dependencies
- Existing skill system must remain functional during migration
- OpenSpec validation system must support multi-spec validation
- Agent activation keywords must be updated for new agents

### External Dependencies
- None (all changes are internal to the plugin)

## Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Breaking existing workflows | High | Medium | Gradual migration, maintain backward compatibility, extensive testing |
| Skill activation conflicts | Medium | Low | Clear skill scoping, trigger language guidelines, testing |
| Pattern drift over time | Medium | Medium | Template enforcement, documentation, code review guidelines |
| Maintenance burden increase | Medium | Medium | Consistent patterns reduce per-agent complexity |
| User confusion during transition | Medium | High | Clear migration guide, communication, phased rollout |

## Success Metrics

### Technical Metrics
- ✅ 100% of agents follow hybrid pattern
- ✅ 100% of workflows explicitly reference relevant skills
- ✅ Passes OpenSpec strict validation
- ✅ Zero breaking changes to existing user workflows

### Quality Metrics
- ✅ Agent documentation completeness (all sections filled)
- ✅ Skill coverage (19 new skills created)
- ✅ Test coverage for agent activation logic

### User Metrics
- ✅ User feedback positive on new agent system
- ✅ Agent usage distribution shows good coverage
- ✅ Community contributions to agent/skill library increase

## Related Changes

This proposal supersedes and incorporates:
- Previous `proposal.md` in repo root (AI/LLM agent expansion)
- JavaScript → Python context adaptation needs
- Agent pattern inconsistency issues

## Open Questions

1. **Should we maintain the `color` and `model` frontmatter for agents?**
   - Current approach: Yes, keep for UI integration

2. **How do we handle skill naming conflicts with new skills?**
   - Current approach: Namespace AI skills with `ai-` prefix (ai-security vs. pii-redaction)

3. **Should we version the hybrid agent pattern for future evolution?**
   - Current approach: Yes, add `pattern_version: 1.0` to frontmatter

4. **Do we need a skill auto-activation testing framework?**
   - Current approach: Manual testing initially, automated framework in future proposal

## Next Steps

1. Review and approve this proposal
2. Proceed to detailed spec drafting in `specs/` directory
3. Create comprehensive task breakdown in `tasks.md`
4. Validate with `openspec validate --strict`
5. Begin Phase 1 implementation upon approval

## References

- Agent directory: `.claude/agents/`
- Skill directory: `.claude/skills/`
- Previous proposal: `proposal.md` (repo root)
- Project config: `openspec/project.md`
- Main instructions: `CLAUDE.md`
