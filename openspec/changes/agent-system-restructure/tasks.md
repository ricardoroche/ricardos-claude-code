# Implementation Tasks

**Change ID:** `2025-11-18-agent-system-restructure`
**Status:** Ready for Implementation

## Overview

This document provides a comprehensive, ordered task list for implementing the agent system restructure and AI/LLM expansion. Tasks are broken into phases and can be verified independently.

---

## Phase 1: Foundation (Weeks 1-2)

### 1.1 Hybrid Agent Pattern Setup

- [ ] **Create hybrid agent template**
  - [ ] Create `.claude/templates/hybrid-agent-template.md`
  - [ ] Include all required sections from spec
  - [ ] Add inline comments explaining each section
  - [ ] Include example content for reference
  - **Validation**: Template passes hybrid-agent-pattern spec requirements

- [ ] **Document pattern guidelines**
  - [ ] Create development guide for agent creation
  - [ ] Document workflow-skill trigger language patterns
  - [ ] Create examples of good vs poor agent structure
  - **Validation**: Guidelines are clear and actionable

### 1.2 Core AI/LLM Skills (Priority Set)

- [ ] **Create llm-app-architecture skill**
  - [ ] Create `.claude/skills/llm-app-architecture/SKILL.md`
  - [ ] Define trigger keywords (LLM, AI application, model API, etc.)
  - [ ] Document async patterns for LLM calls
  - [ ] Add streaming response examples
  - [ ] Add token counting patterns
  - [ ] Add retry/timeout patterns
  - **Validation**: Follows skill structure, includes code examples

- [ ] **Create agent-orchestration-patterns skill**
  - [ ] Create `.claude/skills/agent-orchestration-patterns/SKILL.md`
  - [ ] Define trigger keywords (agent, tool calling, orchestration)
  - [ ] Document tool schema patterns with Pydantic
  - [ ] Add agent state management examples
  - [ ] Add error handling for tool execution
  - **Validation**: Follows skill structure, includes orchestration examples

- [ ] **Create rag-design-patterns skill**
  - [ ] Create `.claude/skills/rag-design-patterns/SKILL.md`
  - [ ] Define trigger keywords (RAG, retrieval, vector, embedding)
  - [ ] Document vector database patterns
  - [ ] Add chunking strategy examples
  - [ ] Add reranking patterns
  - **Validation**: Follows skill structure, includes RAG examples

- [ ] **Create observability-logging skill**
  - [ ] Create `.claude/skills/observability-logging/SKILL.md`
  - [ ] Define trigger keywords (logging, observability, tracing)
  - [ ] Document structured logging patterns
  - [ ] Add OpenTelemetry examples
  - [ ] Add LLM-specific logging (tokens, cost, latency)
  - **Validation**: Follows skill structure, includes logging examples

### 1.3 Proof of Concept Agents (3 Agents)

- [ ] **Adapt backend-architect to Python/AI**
  - [ ] Read existing `.claude/agents/backend-architect.md`
  - [ ] Replace JavaScript → Python framework references
  - [ ] Add AI/LLM context (LLM APIs, vector DBs)
  - [ ] Convert to hybrid pattern structure
  - [ ] Add workflows for FastAPI, async, database design
  - [ ] List skills invoked by each workflow
  - [ ] Add Python/AI best practices
  - **Validation**: Passes hybrid-agent-pattern spec, no JavaScript references

- [ ] **Adapt system-architect to Python/AI**
  - [ ] Read existing `.claude/agents/system-architect.md`
  - [ ] Replace JavaScript → Python references
  - [ ] Add ML system design context
  - [ ] Convert to hybrid pattern structure
  - [ ] Add workflows for system design, tech stack selection
  - [ ] List skills invoked
  - **Validation**: Passes hybrid-agent-pattern spec, includes AI/ML context

- [ ] **Create ml-system-architect agent (NEW)**
  - [ ] Use hybrid agent template
  - [ ] Define role & mindset for ML system design
  - [ ] Create 4-5 workflows (design system, select stack, plan observability, etc.)
  - [ ] Reference AI/LLM skills (llm-app-architecture, etc.)
  - [ ] Add architecture-specific best practices
  - [ ] Define boundaries (Will/Will Not)
  - **Validation**: Passes hybrid-agent-pattern spec, comprehensive workflows

### 1.4 Testing & Validation

- [ ] **Test skill triggering**
  - [ ] Verify backend-architect workflows trigger fastapi-patterns
  - [ ] Verify ml-system-architect workflows trigger llm-app-architecture
  - [ ] Confirm multi-skill triggering works
  - **Validation**: Skills activate correctly from workflow language

- [ ] **Test agent activation**
  - [ ] Test "design backend API" activates backend-architect
  - [ ] Test "ML system architecture" activates ml-system-architect
  - [ ] Verify activation keywords work
  - **Validation**: Agents activate on correct prompts

---

## Phase 2: Migration & Expansion (Weeks 3-6)

### 2.1 Existing Agent Migration (10 Agents)

**Priority 1: Proof of Concept (Week 3)**

- [ ] **Migrate code-reviewer**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (general review, security review, performance review)
  - [ ] Make skill references explicit
  - [ ] Add boundaries
  - **Validation**: Backward compatible, passes hybrid spec

- [ ] **Migrate write-unit-tests**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (new code tests, existing code tests, async tests)
  - [ ] Preserve pytest examples
  - [ ] List skills invoked
  - **Validation**: Backward compatible, preserves all examples

**Priority 2: Core Workflow Agents (Week 4)**

- [ ] **Migrate implement-feature**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (FastAPI endpoint, business logic, database integration, complete feature)
  - [ ] Preserve FastAPI/Pydantic examples
  - **Validation**: Backward compatible

- [ ] **Migrate debug-test-failure**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (investigate failure, debug async, fix fixtures, resolve mocks)
  - [ ] Preserve debugging methodology
  - **Validation**: Backward compatible

- [ ] **Migrate fix-pr-comments**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (review feedback, implement changes, verify fixes)
  - **Validation**: Backward compatible

**Priority 3: Specialized Agents (Week 5)**

- [ ] **Migrate add-agent-tool**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (design schema, implement, test, document)
  - **Validation**: Backward compatible

- [ ] **Migrate upgrade-dependency**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (check compatibility, update, test, handle breaking changes)
  - **Validation**: Backward compatible

- [ ] **Migrate optimize-db-query**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (profile, analyze EXPLAIN, add indexes, rewrite)
  - **Validation**: Backward compatible

**Priority 4: Research/Communication (Week 5)**

- [ ] **Migrate deep-research-agent**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (plan research, execute search, synthesize, present)
  - **Validation**: Backward compatible

- [ ] **Migrate technical-writer**
  - [ ] Convert to hybrid pattern
  - [ ] Extract workflows (analyze audience, structure content, write, review)
  - **Validation**: Backward compatible

### 2.2 Remaining Python/AI Agent Adaptations (6 Agents, Week 5)

- [ ] **Adapt performance-engineer**
  - [ ] Replace JavaScript profiling → Python profiling (cProfile, py-spy, Scalene)
  - [ ] Add AI/ML performance context
  - [ ] Convert to hybrid pattern
  - **Validation**: No JavaScript refs, includes Python/AI

- [ ] **Adapt refactoring-expert**
  - [ ] Replace JavaScript patterns → Python refactoring
  - [ ] Add AI code patterns (prompt management, LLM calls)
  - [ ] Convert to hybrid pattern
  - **Validation**: No JavaScript refs

- [ ] **Adapt requirements-analyst**
  - [ ] Add AI product requirements context
  - [ ] Add ML success metrics guidance
  - [ ] Convert to hybrid pattern
  - **Validation**: Includes AI/ML requirements approach

- [ ] **Adapt tech-stack-researcher**
  - [ ] Replace JavaScript ecosystem → Python AI/ML ecosystem
  - [ ] Add LLM framework comparisons (LangChain, LlamaIndex)
  - [ ] Add vector DB comparison
  - [ ] Convert to hybrid pattern
  - **Validation**: Python/AI tech focus

- [ ] **Adapt learning-guide**
  - [ ] Add Python teaching approach
  - [ ] Add AI/ML concept teaching
  - [ ] Convert to hybrid pattern
  - **Validation**: Python/AI context

- [ ] **Adapt frontend-architect (LIMITED SCOPE)**
  - [ ] Scope to AI UI/UX (Streamlit, Gradio, chat interfaces)
  - [ ] Remove web framework content
  - [ ] Convert to hybrid pattern
  - **Validation**: AI UI focus only

### 2.3 Additional Skills Creation (12 Skills, Week 6)

**Python Engineering Skills (5)**

- [ ] **Create database-migrations skill**
  - [ ] Document Alembic patterns
  - [ ] Add upgrade/downgrade examples
  - [ ] Add data migration patterns
  - **Validation**: Follows skill structure

- [ ] **Create query-optimization skill**
  - [ ] Document EXPLAIN analysis
  - [ ] Add index creation patterns
  - [ ] Add N+1 query prevention
  - **Validation**: Follows skill structure

- [ ] **Create python-packaging skill**
  - [ ] Document pyproject.toml structure
  - [ ] Add project layout patterns
  - [ ] Add build configuration
  - **Validation**: Follows skill structure

- [ ] **Create dependency-management skill**
  - [ ] Document uv/Poetry patterns
  - [ ] Add lock file usage
  - [ ] Add conflict resolution
  - **Validation**: Follows skill structure

- [ ] **Create code-review-framework skill**
  - [ ] Create structured review checklist
  - [ ] Add security review points
  - [ ] Add performance considerations
  - **Validation**: Follows skill structure

**Remaining AI/LLM Skills (3)**

- [ ] **Create prompting-patterns skill**
  - [ ] Document prompt template patterns
  - [ ] Add few-shot examples
  - [ ] Add prompt injection prevention
  - **Validation**: Follows skill structure

- [ ] **Create evaluation-metrics skill**
  - [ ] Document eval metric patterns
  - [ ] Add eval dataset creation
  - [ ] Add A/B testing patterns
  - **Validation**: Follows skill structure

- [ ] **Create model-selection skill**
  - [ ] Document model comparison criteria
  - [ ] Add provider comparison
  - [ ] Add fallback patterns
  - **Validation**: Follows skill structure

- [ ] **Create ai-security skill**
  - [ ] Document prompt injection detection
  - [ ] Add PII redaction for AI
  - [ ] Add output filtering
  - **Validation**: Follows skill structure

**Observability Skills (2 remaining)**

- [ ] **Create monitoring-alerting skill**
  - [ ] Document metric instrumentation
  - [ ] Add alert configuration
  - [ ] Add SLO/SLI patterns
  - **Validation**: Follows skill structure

- [ ] **Create performance-profiling skill**
  - [ ] Document Python profiling tools
  - [ ] Add async profiling patterns
  - [ ] Add benchmark setup
  - **Validation**: Follows skill structure

**Developer Velocity Skills (4)**

- [ ] **Create git-workflow-standards skill**
  - [ ] Document conventional commits
  - [ ] Add branch naming conventions
  - [ ] Add PR templates
  - **Validation**: Follows skill structure

- [ ] **Create cli-tool-patterns skill**
  - [ ] Document Click/Typer patterns
  - [ ] Add help text best practices
  - [ ] Add error handling
  - **Validation**: Follows skill structure

- [ ] **Create openspec-conventions skill**
  - [ ] Document OpenSpec proposal structure
  - [ ] Add spec delta format
  - [ ] Add scenario writing guide
  - **Validation**: Follows skill structure

- [ ] **Create documentation-templates skill**
  - [ ] Document README structure
  - [ ] Add API doc templates
  - [ ] Add tutorial structure
  - **Validation**: Follows skill structure

### 2.4 New AI Agent Creation (12 Agents, Week 6)

**Architecture Agents (2 remaining)**

- [ ] **Create rag-architect agent**
  - [ ] Use hybrid pattern template
  - [ ] Create RAG-specific workflows
  - [ ] Reference rag-design-patterns skill
  - **Validation**: Passes hybrid spec

**Implementation Agents (3)**

- [ ] **Create llm-app-engineer agent**
  - [ ] Create implementation workflows
  - [ ] Reference llm-app-architecture skill
  - **Validation**: Passes hybrid spec

- [ ] **Create agent-orchestrator-engineer agent**
  - [ ] Create orchestration workflows
  - [ ] Reference agent-orchestration-patterns skill
  - **Validation**: Passes hybrid spec

- [ ] **Create experiment-notebooker agent**
  - [ ] Create notebook workflow guidance
  - [ ] Reference relevant skills
  - **Validation**: Passes hybrid spec

**Quality Agents (4)**

- [ ] **Create evaluation-engineer agent**
  - [ ] Create eval pipeline workflows
  - [ ] Reference evaluation-metrics skill
  - **Validation**: Passes hybrid spec

- [ ] **Create python-ml-refactoring-expert agent**
  - [ ] Create AI code refactoring workflows
  - [ ] Reference llm-app-architecture skill
  - **Validation**: Passes hybrid spec

- [ ] **Create performance-and-cost-engineer-llm agent**
  - [ ] Create LLM optimization workflows
  - [ ] Reference performance skills
  - **Validation**: Passes hybrid spec

- [ ] **Create security-and-privacy-engineer-ml agent**
  - [ ] Create AI security workflows
  - [ ] Reference ai-security skill
  - **Validation**: Passes hybrid spec

**Operations Agents (1)**

- [ ] **Create mlops-ai-engineer agent**
  - [ ] Create deployment workflows
  - [ ] Reference observability skills
  - **Validation**: Passes hybrid spec

**Analysis Agents (1)**

- [ ] **Create ai-product-analyst agent**
  - [ ] Create requirements workflows
  - [ ] Reference evaluation-metrics skill
  - **Validation**: Passes hybrid spec

**Communication Agents (1)**

- [ ] **Create technical-ml-writer agent**
  - [ ] Create ML documentation workflows
  - [ ] Reference documentation-templates skill
  - **Validation**: Passes hybrid spec

---

## Phase 3: Validation & Documentation (Week 7)

### 3.1 OpenSpec Validation

- [ ] **Run validation**
  - [ ] Execute `openspec validate 2025-11-18-agent-system-restructure --strict`
  - [ ] Fix all validation errors
  - [ ] Verify all cross-references valid
  - **Validation**: No validation errors

- [ ] **Verify completeness**
  - [ ] Check all 31 agents exist
  - [ ] Check all 29 skills exist
  - [ ] Verify all agents pass hybrid-agent-pattern validation
  - [ ] Verify all skills follow structure
  - **Validation**: Complete inventory

### 3.2 Cross-Reference Validation

- [ ] **Agent-Skill references**
  - [ ] Verify all agent skill references point to existing skills
  - [ ] Verify all skill agent references point to existing agents
  - [ ] Create cross-reference matrix
  - **Validation**: All references valid

- [ ] **Agent-Agent references**
  - [ ] Verify Related Agents sections reference existing agents
  - [ ] Verify handoff scenarios are clear
  - **Validation**: All references valid

### 3.3 Testing

- [ ] **Activation testing**
  - [ ] Test each agent activates on correct keywords
  - [ ] Test backward compatibility for existing agents
  - [ ] Document activation test results
  - **Validation**: All agents activate correctly

- [ ] **Skill triggering testing**
  - [ ] Test workflows trigger declared skills
  - [ ] Test multi-skill coordination
  - [ ] Document skill triggering results
  - **Validation**: Skills trigger as expected

- [ ] **Integration testing**
  - [ ] Test end-to-end workflows (user prompt → agent → skills → output)
  - [ ] Test handoffs between agents
  - [ ] Document integration test results
  - **Validation**: Workflows complete successfully

### 3.4 Documentation Updates

- [ ] **Update main CLAUDE.md**
  - [ ] Update agent count (31 agents)
  - [ ] Update skill count (29 skills)
  - [ ] Add hybrid pattern explanation
  - [ ] Update examples
  - **Validation**: Documentation accurate

- [ ] **Update README.md**
  - [ ] Update plugin description
  - [ ] Update agent list with categories
  - [ ] Update skill list with categories
  - [ ] Add usage examples
  - **Validation**: User-facing docs clear

- [ ] **Create migration guide**
  - [ ] Document changes for existing users
  - [ ] Explain new hybrid pattern
  - [ ] Provide examples of new workflows
  - [ ] List new capabilities
  - **Validation**: Migration clear and actionable

- [ ] **Update docs/python-patterns.md**
  - [ ] Add AI/LLM pattern sections
  - [ ] Update examples
  - [ ] Add new skill references
  - **Validation**: Comprehensive pattern coverage

### 3.5 User Acceptance

- [ ] **User testing**
  - [ ] Test with 3-5 real use cases
  - [ ] Gather feedback on new agents
  - [ ] Gather feedback on skill triggering
  - **Validation**: Positive user feedback

- [ ] **Adjustment iteration**
  - [ ] Address user feedback
  - [ ] Fix any usability issues
  - [ ] Refine agent/skill content
  - **Validation**: User concerns addressed

---

## Phase 4: Deployment (Week 8)

### 4.1 Final Validation

- [ ] **Complete validation pass**
  - [ ] Re-run `openspec validate --strict`
  - [ ] Verify all tests pass
  - [ ] Check documentation completeness
  - **Validation**: Ready for deployment

### 4.2 Apply Change

- [ ] **Apply with OpenSpec**
  - [ ] Run `openspec apply 2025-11-18-agent-system-restructure`
  - [ ] Verify all files created/updated
  - [ ] Commit changes with clear message
  - **Validation**: Change applied successfully

### 4.3 Archive

- [ ] **Archive proposal**
  - [ ] Run `openspec archive 2025-11-18-agent-system-restructure`
  - [ ] Verify specs updated
  - [ ] Document completion
  - **Validation**: Proposal archived

---

## Summary Checklist

### Agent Inventory (31 Total)

**Adapted from JavaScript (9)**:
- [ ] backend-architect
- [ ] frontend-architect
- [ ] learning-guide
- [ ] performance-engineer
- [ ] refactoring-expert
- [ ] requirements-analyst
- [ ] security-engineer
- [ ] system-architect
- [ ] tech-stack-researcher

**Migrated from Task Pattern (10)**:
- [ ] write-unit-tests
- [ ] debug-test-failure
- [ ] implement-feature
- [ ] code-reviewer
- [ ] add-agent-tool
- [ ] upgrade-dependency
- [ ] optimize-db-query
- [ ] fix-pr-comments
- [ ] deep-research-agent
- [ ] technical-writer

**Created New AI-Focused (12)**:
- [ ] ml-system-architect
- [ ] rag-architect
- [ ] ai-product-analyst
- [ ] llm-app-engineer
- [ ] agent-orchestrator-engineer
- [ ] evaluation-engineer
- [ ] mlops-ai-engineer
- [ ] python-ml-refactoring-expert
- [ ] performance-and-cost-engineer-llm
- [ ] security-and-privacy-engineer-ml
- [ ] technical-ml-writer
- [ ] experiment-notebooker

### Skill Inventory (29 Total)

**Existing (10)**: async-await-checker, pydantic-models, fastapi-patterns, pytest-patterns, type-safety, docstring-format, structured-errors, tool-design-pattern, dynaconf-config, pii-redaction

**New AI/LLM (7)**:
- [ ] llm-app-architecture
- [ ] agent-orchestration-patterns
- [ ] rag-design-patterns
- [ ] prompting-patterns
- [ ] evaluation-metrics
- [ ] model-selection
- [ ] ai-security

**New Python Engineering (5)**:
- [ ] database-migrations
- [ ] query-optimization
- [ ] python-packaging
- [ ] dependency-management
- [ ] code-review-framework

**New Observability (3)**:
- [ ] observability-logging
- [ ] monitoring-alerting
- [ ] performance-profiling

**New Developer Velocity (4)**:
- [ ] git-workflow-standards
- [ ] cli-tool-patterns
- [ ] openspec-conventions
- [ ] documentation-templates

---

## Completion Criteria

- ✅ All 31 agents exist and pass hybrid-agent-pattern validation
- ✅ All 29 skills exist and follow structure pattern
- ✅ All cross-references valid (agent→skill, skill→agent, agent→agent)
- ✅ All validation tests pass
- ✅ Documentation complete and accurate
- ✅ User testing positive
- ✅ OpenSpec validation passes with --strict
- ✅ Change applied and archived

**Estimated Effort**: 7-8 weeks with 1-2 people working on implementation
**Risk Level**: Medium (large scope but well-specified)
**Impact**: High (transforms plugin into comprehensive AI/LLM engineering toolkit)
