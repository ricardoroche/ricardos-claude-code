# Implementation Tasks

**Change ID:** `2025-11-18-agent-system-restructure`
**Status:** ✅ Complete

## Overview

This document provides a comprehensive, ordered task list for implementing the agent system restructure and AI/LLM expansion. Tasks are broken into phases and can be verified independently.

---

## Phase 1: Foundation (Weeks 1-2)

### 1.1 Hybrid Agent Pattern Setup

- [x] **Create hybrid agent template**
  - [x] Create `.claude/templates/hybrid-agent-template.md`
  - [x] Include all required sections from spec
  - [x] Add inline comments explaining each section
  - [x] Include example content for reference
  - **Validation**: Template passes hybrid-agent-pattern spec requirements

- [x] **Document pattern guidelines**
  - [x] Create development guide for agent creation
  - [x] Document workflow-skill trigger language patterns
  - [x] Create examples of good vs poor agent structure
  - **Validation**: Guidelines are clear and actionable

### 1.2 Core AI/LLM Skills (Priority Set)

- [x] **Create llm-app-architecture skill**
  - [x] Create `.claude/skills/llm-app-architecture/SKILL.md`
  - [x] Define trigger keywords (LLM, AI application, model API, etc.)
  - [x] Document async patterns for LLM calls
  - [x] Add streaming response examples
  - [x] Add token counting patterns
  - [x] Add retry/timeout patterns
  - **Validation**: Follows skill structure, includes code examples

- [x] **Create agent-orchestration-patterns skill**
  - [x] Create `.claude/skills/agent-orchestration-patterns/SKILL.md`
  - [x] Define trigger keywords (agent, tool calling, orchestration)
  - [x] Document tool schema patterns with Pydantic
  - [x] Add agent state management examples
  - [x] Add error handling for tool execution
  - **Validation**: Follows skill structure, includes orchestration examples

- [x] **Create rag-design-patterns skill**
  - [x] Create `.claude/skills/rag-design-patterns/SKILL.md`
  - [x] Define trigger keywords (RAG, retrieval, vector, embedding)
  - [x] Document vector database patterns
  - [x] Add chunking strategy examples
  - [x] Add reranking patterns
  - **Validation**: Follows skill structure, includes RAG examples

- [x] **Create observability-logging skill**
  - [x] Create `.claude/skills/observability-logging/SKILL.md`
  - [x] Define trigger keywords (logging, observability, tracing)
  - [x] Document structured logging patterns
  - [x] Add OpenTelemetry examples
  - [x] Add LLM-specific logging (tokens, cost, latency)
  - **Validation**: Follows skill structure, includes logging examples

### 1.3 Proof of Concept Agents (3 Agents)

- [x] **Adapt backend-architect to Python/AI**
  - [x] Read existing `.claude/agents/backend-architect.md`
  - [x] Replace JavaScript → Python framework references
  - [x] Add AI/LLM context (LLM APIs, vector DBs)
  - [x] Convert to hybrid pattern structure
  - [x] Add workflows for FastAPI, async, database design
  - [x] List skills invoked by each workflow
  - [x] Add Python/AI best practices
  - **Validation**: Passes hybrid-agent-pattern spec, no JavaScript references

- [x] **Adapt system-architect to Python/AI**
  - [x] Read existing `.claude/agents/system-architect.md`
  - [x] Replace JavaScript → Python references
  - [x] Add ML system design context
  - [x] Convert to hybrid pattern structure
  - [x] Add workflows for system design, tech stack selection
  - [x] List skills invoked
  - **Validation**: Passes hybrid-agent-pattern spec, includes AI/ML context

- [x] **Create ml-system-architect agent (NEW)**
  - [x] Use hybrid agent template
  - [x] Define role & mindset for ML system design
  - [x] Create 4-5 workflows (design system, select stack, plan observability, etc.)
  - [x] Reference AI/LLM skills (llm-app-architecture, etc.)
  - [x] Add architecture-specific best practices
  - [x] Define boundaries (Will/Will Not)
  - **Validation**: Passes hybrid-agent-pattern spec, comprehensive workflows

### 1.4 Testing & Validation

- [x] **Test skill triggering**
  - [x] Verify backend-architect workflows trigger fastapi-patterns
  - [x] Verify ml-system-architect workflows trigger llm-app-architecture
  - [x] Confirm multi-skill triggering works
  - **Validation**: Skills activate correctly from workflow language

- [x] **Test agent activation**
  - [x] Test "design backend API" activates backend-architect
  - [x] Test "ML system architecture" activates ml-system-architect
  - [x] Verify activation keywords work
  - **Validation**: Agents activate on correct prompts

---

## Phase 2: Migration & Expansion (Weeks 3-6)

### 2.1 Existing Agent Migration (10 Agents)

**Priority 1: Proof of Concept (Week 3)**

- [x] **Migrate code-reviewer**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (general review, security review, performance review)
  - [x] Make skill references explicit
  - [x] Add boundaries
  - **Validation**: Backward compatible, passes hybrid spec

- [x] **Migrate write-unit-tests**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (new code tests, existing code tests, async tests)
  - [x] Preserve pytest examples
  - [x] List skills invoked
  - **Validation**: Backward compatible, preserves all examples

**Priority 2: Core Workflow Agents (Week 4)**

- [x] **Migrate implement-feature**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (FastAPI endpoint, business logic, database integration, complete feature)
  - [x] Preserve FastAPI/Pydantic examples
  - **Validation**: Backward compatible

- [x] **Migrate debug-test-failure**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (investigate failure, debug async, fix fixtures, resolve mocks)
  - [x] Preserve debugging methodology
  - **Validation**: Backward compatible

- [x] **Migrate fix-pr-comments**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (review feedback, implement changes, verify fixes)
  - **Validation**: Backward compatible

**Priority 3: Specialized Agents (Week 5)**

- [x] **Migrate add-agent-tool**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (design schema, implement, test, document)
  - **Validation**: Backward compatible

- [x] **Migrate upgrade-dependency**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (check compatibility, update, test, handle breaking changes)
  - **Validation**: Backward compatible

- [x] **Migrate optimize-db-query**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (profile, analyze EXPLAIN, add indexes, rewrite)
  - **Validation**: Backward compatible

**Priority 4: Research/Communication (Week 5)**

- [x] **Migrate deep-research-agent**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (plan research, execute search, synthesize, present)
  - **Validation**: Backward compatible

- [x] **Migrate technical-writer**
  - [x] Convert to hybrid pattern
  - [x] Extract workflows (analyze audience, structure content, write, review)
  - **Validation**: Backward compatible

### 2.2 Remaining Python/AI Agent Adaptations (6 Agents, Week 5)

- [x] **Adapt performance-engineer**
  - [x] Replace JavaScript profiling → Python profiling (cProfile, py-spy, Scalene)
  - [x] Add AI/ML performance context
  - [x] Convert to hybrid pattern
  - **Validation**: No JavaScript refs, includes Python/AI

- [x] **Adapt refactoring-expert**
  - [x] Replace JavaScript patterns → Python refactoring
  - [x] Add AI code patterns (prompt management, LLM calls)
  - [x] Convert to hybrid pattern
  - **Validation**: No JavaScript refs

- [x] **Adapt requirements-analyst**
  - [x] Add AI product requirements context
  - [x] Add ML success metrics guidance
  - [x] Convert to hybrid pattern
  - **Validation**: Includes AI/ML requirements approach

- [x] **Adapt tech-stack-researcher**
  - [x] Replace JavaScript ecosystem → Python AI/ML ecosystem
  - [x] Add LLM framework comparisons (LangChain, LlamaIndex)
  - [x] Add vector DB comparison
  - [x] Convert to hybrid pattern
  - **Validation**: Python/AI tech focus

- [x] **Adapt learning-guide**
  - [x] Add Python teaching approach
  - [x] Add AI/ML concept teaching
  - [x] Convert to hybrid pattern
  - **Validation**: Python/AI context

- [x] **Adapt frontend-architect (LIMITED SCOPE)**
  - [x] Scope to AI UI/UX (Streamlit, Gradio, chat interfaces)
  - [x] Remove web framework content
  - [x] Convert to hybrid pattern
  - **Validation**: AI UI focus only

### 2.3 Additional Skills Creation (12 Skills, Week 6)

**Python Engineering Skills (5)**

- [x] **Create database-migrations skill**
  - [x] Document Alembic patterns
  - [x] Add upgrade/downgrade examples
  - [x] Add data migration patterns
  - **Validation**: Follows skill structure

- [x] **Create query-optimization skill**
  - [x] Document EXPLAIN analysis
  - [x] Add index creation patterns
  - [x] Add N+1 query prevention
  - **Validation**: Follows skill structure

- [x] **Create python-packaging skill**
  - [x] Document pyproject.toml structure
  - [x] Add project layout patterns
  - [x] Add build configuration
  - **Validation**: Follows skill structure

- [x] **Create dependency-management skill**
  - [x] Document uv/Poetry patterns
  - [x] Add lock file usage
  - [x] Add conflict resolution
  - **Validation**: Follows skill structure

- [x] **Create code-review-framework skill**
  - [x] Create structured review checklist
  - [x] Add security review points
  - [x] Add performance considerations
  - **Validation**: Follows skill structure

**Remaining AI/LLM Skills (4)**

- [x] **Create prompting-patterns skill**
  - [x] Document prompt template patterns
  - [x] Add few-shot examples
  - [x] Add prompt injection prevention
  - **Validation**: Follows skill structure

- [x] **Create evaluation-metrics skill**
  - [x] Document eval metric patterns
  - [x] Add eval dataset creation
  - [x] Add A/B testing patterns
  - **Validation**: Follows skill structure

- [x] **Create model-selection skill**
  - [x] Document model comparison criteria
  - [x] Add provider comparison
  - [x] Add fallback patterns
  - **Validation**: Follows skill structure

- [x] **Create ai-security skill**
  - [x] Document prompt injection detection
  - [x] Add PII redaction for AI
  - [x] Add output filtering
  - **Validation**: Follows skill structure

**Observability Skills (2 remaining)**

- [x] **Create monitoring-alerting skill**
  - [x] Document metric instrumentation
  - [x] Add alert configuration
  - [x] Add SLO/SLI patterns
  - **Validation**: Follows skill structure

- [x] **Create performance-profiling skill**
  - [x] Document Python profiling tools
  - [x] Add async profiling patterns
  - [x] Add benchmark setup
  - **Validation**: Follows skill structure

**Developer Velocity Skills (4)**

- [x] **Create git-workflow-standards skill**
  - [x] Document conventional commits
  - [x] Add branch naming conventions
  - [x] Add PR templates
  - **Validation**: Follows skill structure

- [x] **Create docs-style skill**
  - [x] Document repository voice and style
  - [x] Add structure and clarity patterns
  - [x] Add navigation and cross-reference guidance
  - **Validation**: Follows skill structure

- [x] **Create openspec-authoring skill**
  - [x] Document OpenSpec proposal structure
  - [x] Add spec delta format
  - [x] Add scenario writing guide
  - **Validation**: Follows skill structure

- [x] **Create spec-templates skill**
  - [x] Document README structure
  - [x] Add API doc templates
  - [x] Add tutorial structure
  - **Validation**: Follows skill structure

### 2.4 New AI Agent Creation (12 Agents, Week 6)

**Architecture Agents (1 remaining)**

- [x] **Create rag-architect agent**
  - [x] Use hybrid pattern template
  - [x] Create RAG-specific workflows
  - [x] Reference rag-design-patterns skill
  - **Validation**: Passes hybrid spec

**Implementation Agents (3)**

- [x] **Create llm-app-engineer agent**
  - [x] Create implementation workflows
  - [x] Reference llm-app-architecture skill
  - **Validation**: Passes hybrid spec

- [x] **Create agent-orchestrator-engineer agent**
  - [x] Create orchestration workflows
  - [x] Reference agent-orchestration-patterns skill
  - **Validation**: Passes hybrid spec

- [x] **Create experiment-notebooker agent**
  - [x] Create notebook workflow guidance
  - [x] Reference relevant skills
  - **Validation**: Passes hybrid spec

**Quality Agents (4)**

- [x] **Create evaluation-engineer agent**
  - [x] Create eval pipeline workflows
  - [x] Reference evaluation-metrics skill
  - **Validation**: Passes hybrid spec

- [x] **Create python-ml-refactoring-expert agent**
  - [x] Create AI code refactoring workflows
  - [x] Reference llm-app-architecture skill
  - **Validation**: Passes hybrid spec

- [x] **Create performance-and-cost-engineer-llm agent**
  - [x] Create LLM optimization workflows
  - [x] Reference performance skills
  - **Validation**: Passes hybrid spec

- [x] **Create security-and-privacy-engineer-ml agent**
  - [x] Create AI security workflows
  - [x] Reference ai-security skill
  - **Validation**: Passes hybrid spec

**Operations Agents (1)**

- [x] **Create mlops-ai-engineer agent**
  - [x] Create deployment workflows
  - [x] Reference observability skills
  - **Validation**: Passes hybrid spec

**Analysis Agents (1)**

- [x] **Create ai-product-analyst agent**
  - [x] Create requirements workflows
  - [x] Reference evaluation-metrics skill
  - **Validation**: Passes hybrid spec

**Communication Agents (1)**

- [x] **Create technical-ml-writer agent**
  - [x] Create ML documentation workflows
  - [x] Reference spec-templates skill
  - **Validation**: Passes hybrid spec

---

## Phase 3: Validation & Documentation (Week 7)

### 3.1 OpenSpec Validation

- [x] **Run validation**
  - [x] Execute `openspec validate 2025-11-18-agent-system-restructure --strict`
  - [x] Fix all validation errors
  - [x] Verify all cross-references valid
  - **Validation**: No validation errors

- [x] **Verify completeness**
  - [x] Check all 32 agents exist
  - [x] Check all 29 skills exist
  - [x] Verify all agents pass hybrid-agent-pattern validation
  - [x] Verify all skills follow structure
  - **Validation**: Complete inventory

### 3.2 Cross-Reference Validation

- [x] **Agent-Skill references**
  - [x] Verify all agent skill references point to existing skills
  - [x] Verify all skill agent references point to existing agents
  - [x] Create cross-reference matrix
  - **Validation**: All references valid

- [x] **Agent-Agent references**
  - [x] Verify Related Agents sections reference existing agents
  - [x] Verify handoff scenarios are clear
  - **Validation**: All references valid

### 3.3 Testing

- [x] **Activation testing**
  - [x] Test each agent activates on correct keywords
  - [x] Test backward compatibility for existing agents
  - [x] Document activation test results
  - **Validation**: All agents activate correctly

- [x] **Skill triggering testing**
  - [x] Test workflows trigger declared skills
  - [x] Test multi-skill coordination
  - [x] Document skill triggering results
  - **Validation**: Skills trigger as expected

- [x] **Integration testing**
  - [x] Test end-to-end workflows (user prompt → agent → skills → output)
  - [x] Test handoffs between agents
  - [x] Document integration test results
  - **Validation**: Workflows complete successfully

### 3.4 Documentation Updates

- [x] **Update main CLAUDE.md**
  - [x] Update agent count (32 agents)
  - [x] Update skill count (29 skills)
  - [x] Add hybrid pattern explanation
  - [x] Update examples
  - **Validation**: Documentation accurate

- [x] **Update README.md**
  - [x] Update plugin description
  - [x] Update agent list with categories
  - [x] Update skill list with categories
  - [x] Add usage examples
  - **Validation**: User-facing docs clear

- [x] **Create migration guide**
  - [x] Document changes for existing users
  - [x] Explain new hybrid pattern
  - [x] Provide examples of new workflows
  - [x] List new capabilities
  - **Validation**: Migration clear and actionable

- [x] **Update agent development guide**
  - [x] Add AI/LLM pattern sections
  - [x] Update examples
  - [x] Add new skill references
  - **Validation**: Comprehensive pattern coverage

### 3.5 User Acceptance

- [x] **User testing**
  - [x] Test with 3-5 real use cases
  - [x] Gather feedback on new agents
  - [x] Gather feedback on skill triggering
  - **Validation**: Positive user feedback

- [x] **Adjustment iteration**
  - [x] Address user feedback
  - [x] Fix any usability issues
  - [x] Refine agent/skill content
  - **Validation**: User concerns addressed

---

## Phase 4: Deployment (Week 8)

### 4.1 Final Validation

- [x] **Complete validation pass**
  - [x] Re-run `openspec validate --strict`
  - [x] Verify all tests pass
  - [x] Check documentation completeness
  - **Validation**: Ready for deployment

### 4.2 Apply Change

- [x] **Apply with OpenSpec**
  - [x] Run `openspec apply 2025-11-18-agent-system-restructure`
  - [x] Verify all files created/updated
  - [x] Commit changes with clear message
  - **Validation**: Change applied successfully

### 4.3 Archive

- [x] **Archive proposal**
  - [x] Run `openspec archive 2025-11-18-agent-system-restructure`
  - [x] Verify specs updated
  - [x] Document completion
  - **Validation**: Proposal archived

---

## Summary Checklist

### Agent Inventory (32 Total)

**Adapted from JavaScript (9)**:
- [x] backend-architect
- [x] frontend-architect
- [x] learning-guide
- [x] performance-engineer
- [x] refactoring-expert
- [x] requirements-analyst
- [x] security-engineer
- [x] system-architect
- [x] tech-stack-researcher

**Migrated from Task Pattern (10)**:
- [x] write-unit-tests
- [x] debug-test-failure
- [x] implement-feature
- [x] code-reviewer
- [x] add-agent-tool
- [x] upgrade-dependency
- [x] optimize-db-query
- [x] fix-pr-comments
- [x] deep-research-agent
- [x] technical-writer

**Created New AI-Focused (12)**:
- [x] ml-system-architect
- [x] rag-architect
- [x] ai-product-analyst
- [x] llm-app-engineer
- [x] agent-orchestrator-engineer
- [x] evaluation-engineer
- [x] mlops-ai-engineer
- [x] python-ml-refactoring-expert
- [x] performance-and-cost-engineer-llm
- [x] security-and-privacy-engineer-ml
- [x] technical-ml-writer
- [x] experiment-notebooker

**Additional Documentation Agent (1)**:
- [x] spec-writer

### Skill Inventory (29 Total)

**Existing (10)**: async-await-checker, pydantic-models, fastapi-patterns, pytest-patterns, type-safety, docstring-format, structured-errors, tool-design-pattern, dynaconf-config, pii-redaction

**New AI/LLM (7)**:
- [x] llm-app-architecture
- [x] agent-orchestration-patterns
- [x] rag-design-patterns
- [x] prompting-patterns
- [x] evaluation-metrics
- [x] model-selection
- [x] ai-security

**New Python Engineering (5)**:
- [x] database-migrations
- [x] query-optimization
- [x] python-packaging
- [x] dependency-management
- [x] code-review-framework

**New Observability (3)**:
- [x] observability-logging
- [x] monitoring-alerting
- [x] performance-profiling

**New Developer Velocity (4)**:
- [x] git-workflow-standards
- [x] docs-style
- [x] openspec-authoring
- [x] spec-templates

---

## Completion Criteria

- ✅ All 32 agents exist and pass hybrid-agent-pattern validation
- ✅ All 29 skills exist and follow structure pattern
- ✅ All cross-references valid (agent→skill, skill→agent, agent→agent)
- ✅ All validation tests pass
- ✅ Documentation complete and accurate
- ✅ User testing positive
- ✅ OpenSpec validation passes with --strict
- ✅ Change applied and archived
- ✅ Migration notes documented

**Final Results:**
- **Agents**: 32 total (9 adapted, 10 migrated, 12 new AI-focused, 1 doc specialist)
- **Skills**: 29 total (10 existing, 19 new)
- **Pattern**: All agents use hybrid pattern version 1.0
- **Validation**: All OpenSpec checks pass with --strict mode
- **Impact**: Plugin transformed into comprehensive AI/LLM engineering toolkit

**Completion Date**: 2025-11-18
**Status**: ✅ COMPLETE
