# Spec: AI/LLM Agent Expansion

**Capability**: ai-llm-agent-expansion
**Status**: Draft
**Related**: hybrid-agent-pattern, ai-llm-skills

## Overview

This spec defines requirements for creating 12 new AI/LLM-focused agents to expand the plugin's coverage of the AI/LLM engineering lifecycle.

## ADDED Requirements

### Requirement: ML System Architect Agent MUST be created

The ml-system-architect agent MUST be created for end-to-end ML/LLM system design.

#### Scenario: User needs ML system architecture

**Given** user requests "design ML system" or "LLM architecture"
**When** ml-system-architect agent activates
**Then** it provides workflows for:
- Designing new ML/LLM systems from requirements
- Selecting technology stack (frameworks, databases, infra)
- Planning data pipelines and model serving
- Designing observability and monitoring strategy
- Identifying risks and mitigations

**Skills Invoked**: `llm-app-architecture`, `python-ai-project-structure`, `observability-logging`, `model-selection`

### Requirement: RAG Architect Agent MUST be created

The rag-architect agent MUST be created specialized in RAG system design.

#### Scenario: User needs RAG system

**Given** user requests "design RAG system" or "implement retrieval"
**When** rag-architect agent activates
**Then** it provides workflows for:
- Designing RAG architecture (indexing, retrieval, generation)
- Selecting vector database and embedding model
- Designing chunking and preprocessing strategy
- Implementing reranking and filtering
- Optimizing retrieval precision and recall

**Skills Invoked**: `rag-design-patterns`, `llm-app-architecture`, `evaluation-metrics`, `observability-logging`

### Requirement: LLM App Engineer Agent MUST be created

The llm-app-engineer agent MUST be created for implementing LLM applications.

#### Scenario: User needs LLM application implementation

**Given** user requests "implement LLM app" or "build AI feature"
**When** llm-app-engineer agent activates
**Then** it provides workflows for:
- Implementing FastAPI endpoints for LLM operations
- Integrating LLM APIs (OpenAI, Anthropic, etc.)
- Building streaming response handlers
- Implementing prompt template management
- Adding error handling and retries

**Skills Invoked**: `llm-app-architecture`, `fastapi-patterns`, `async-await-checker`, `pydantic-models`, `structured-errors`

### Requirement: Agent Orchestrator Engineer MUST be created

The agent-orchestrator-engineer agent MUST be created for multi-agent systems.

#### Scenario: User needs agent orchestration

**Given** user requests "multi-agent system" or "agent orchestration"
**When** agent-orchestrator-engineer agent activates
**Then** it provides workflows for:
- Designing agent communication patterns
- Implementing tool-calling workflows
- Building agent coordination logic
- Managing agent state and context
- Debugging agent interactions

**Skills Invoked**: `agent-orchestration-patterns`, `tool-design-pattern`, `llm-app-architecture`, `observability-logging`

### Requirement: AI Product Analyst Agent MUST be created

The ai-product-analyst agent MUST be created for AI product requirements.

#### Scenario: User needs AI product planning

**Given** user requests "AI product requirements" or "ML feature planning"
**When** ai-product-analyst agent activates
**Then** it provides workflows for:
- Translating product ideas into AI capabilities
- Defining success metrics for ML features
- Assessing AI feasibility and risks
- Creating AI-specific PRDs
- Planning evaluation strategy

**Skills Invoked**: `evaluation-metrics`, `llm-app-architecture`, `documentation-templates`

### Requirement: Evaluation Engineer Agent MUST be created

The evaluation-engineer agent MUST be created for AI evaluation.

#### Scenario: User needs evaluation pipeline

**Given** user requests "evaluate model" or "build eval pipeline"
**When** evaluation-engineer agent activates
**Then** it provides workflows for:
- Designing evaluation metrics (accuracy, latency, cost)
- Building eval datasets and test suites
- Implementing automated evaluation pipelines
- Analyzing eval results and debugging failures
- A/B testing different models or prompts

**Skills Invoked**: `evaluation-metrics`, `pytest-patterns`, `observability-logging`, `prompting-patterns`

### Requirement: MLOps AI Engineer Agent MUST be created

The mlops-ai-engineer agent MUST be created for ML operations and deployment.

#### Scenario: User needs MLOps setup

**Given** user requests "deploy model" or "ML infrastructure"
**When** mlops-ai-engineer agent activates
**Then** it provides workflows for:
- Setting up model serving infrastructure
- Implementing CI/CD for ML pipelines
- Configuring monitoring and alerting
- Managing model versions and rollbacks
- Optimizing deployment costs

**Skills Invoked**: `observability-logging`, `monitoring-alerting`, `llm-app-architecture`, `git-workflow-standards`

### Requirement: Python ML Refactoring Expert Agent MUST be created

The python-ml-refactoring-expert agent MUST be created for AI code refactoring.

#### Scenario: User needs AI codebase refactoring

**Given** user requests "refactor ML code" or "clean up AI codebase"
**When** python-ml-refactoring-expert agent activates
**Then** it provides workflows for:
- Refactoring prompt management code
- Extracting common LLM patterns
- Improving async/await usage
- Reducing code complexity in ML pipelines
- Migrating to better AI frameworks

**Skills Invoked**: `llm-app-architecture`, `async-await-checker`, `type-safety`, `code-review-framework`

### Requirement: Performance and Cost Engineer LLM Agent MUST be created

The performance-and-cost-engineer-llm agent MUST be created for LLM optimization.

#### Scenario: User needs LLM performance optimization

**Given** user requests "optimize LLM latency" or "reduce AI costs"
**When** performance-and-cost-engineer-llm agent activates
**Then** it provides workflows for:
- Profiling LLM application performance
- Implementing caching strategies
- Optimizing prompt tokens
- Batching requests for throughput
- Selecting cost-effective models

**Skills Invoked**: `llm-app-architecture`, `performance-profiling`, `model-selection`, `observability-logging`

### Requirement: Security and Privacy Engineer ML Agent MUST be created

The security-and-privacy-engineer-ml agent MUST be created for AI security.

#### Scenario: User needs AI security review

**Given** user requests "secure AI app" or "AI privacy review"
**When** security-and-privacy-engineer-ml agent activates
**Then** it provides workflows for:
- Auditing for prompt injection vulnerabilities
- Implementing PII redaction
- Securing model API endpoints
- Ensuring AI compliance (GDPR, AI Act)
- Reviewing for data leakage

**Skills Invoked**: `ai-security`, `pii-redaction`, `structured-errors`, `observability-logging`

### Requirement: Technical ML Writer Agent MUST be created

The technical-ml-writer agent MUST be created for AI documentation.

#### Scenario: User needs AI/ML documentation

**Given** user requests "document ML system" or "write AI docs"
**When** technical-ml-writer agent activates
**Then** it provides workflows for:
- Documenting ML model capabilities and limitations
- Writing prompt engineering guides
- Creating evaluation reports
- Documenting LLM API usage
- Writing AI system architecture docs

**Skills Invoked**: `documentation-templates`, `docstring-format`, `llm-app-architecture`

### Requirement: Experiment Notebooker Agent MUST be created

The experiment-notebooker agent MUST be created for exploratory ML work.

#### Scenario: User needs experimental analysis

**Given** user requests "experiment with model" or "prototype in notebook"
**When** experiment-notebooker agent activates
**Then** it provides workflows for:
- Setting up Jupyter notebooks for ML experiments
- Rapid prototyping with LLM APIs
- Analyzing eval results in notebooks
- Visualizing model performance
- Documenting experiment findings

**Skills Invoked**: `llm-app-architecture`, `evaluation-metrics`, `documentation-templates`, `type-safety`

## Agent Specifications

### Requirement: All New Agents MUST Follow Hybrid Pattern

All 12 new agents MUST conform to hybrid-agent-pattern spec.

#### Scenario: New agent created

**Given** a new AI/LLM agent is being created
**Then** it MUST include all required sections from hybrid-agent-pattern:
- Frontmatter (name, description, category, etc.)
- Role & Mindset
- Triggers
- Focus Areas
- Specialized Workflows (3-5)
- Skills Integration
- Outputs
- Best Practices
- Boundaries
- Related Agents

### Requirement: Agent Categorization MUST be assigned

All new agents MUST be assigned appropriate category.

| Agent | Category |
|-------|----------|
| ml-system-architect | architecture |
| rag-architect | architecture |
| ai-product-analyst | analysis |
| llm-app-engineer | implementation |
| agent-orchestrator-engineer | implementation |
| experiment-notebooker | implementation |
| evaluation-engineer | quality |
| python-ml-refactoring-expert | quality |
| performance-and-cost-engineer-llm | quality |
| security-and-privacy-engineer-ml | quality |
| mlops-ai-engineer | operations |
| technical-ml-writer | communication |

### Requirement: Agent Color MUST be assigned

All new agents MUST be assigned UI colors.

Suggested color scheme:
- **blue**: Architecture agents (ml-system-architect, rag-architect)
- **cyan**: Implementation agents (llm-app-engineer, agent-orchestrator-engineer)
- **pink**: Quality/review agents (evaluation-engineer, python-ml-refactoring-expert)
- **yellow**: Performance agents (performance-and-cost-engineer-llm)
- **red**: Security agents (security-and-privacy-engineer-ml)
- **purple**: Operations agents (mlops-ai-engineer)
- **green**: Communication/docs agents (technical-ml-writer, experiment-notebooker)
- **orange**: Analysis agents (ai-product-analyst)

## MODIFIED Requirements

None (these are new agents)

## REMOVED Requirements

None

## Validation

### Validation Rules

1. **12 agents created**: All agents listed in this spec exist
2. **Pattern compliance**: Each agent passes hybrid-agent-pattern validation
3. **Skill references**: All referenced skills exist or are in this proposal
4. **No duplicates**: No overlap with existing agent responsibilities
5. **Category assigned**: Each agent has valid category
6. **Color assigned**: Each agent has UI color

### Test Scenarios

#### Test: All 12 agents exist

**When** change is applied
**Then** files exist:
- `.claude/agents/ml-system-architect.md`
- `.claude/agents/rag-architect.md`
- `.claude/agents/ai-product-analyst.md`
- `.claude/agents/llm-app-engineer.md`
- `.claude/agents/agent-orchestrator-engineer.md`
- `.claude/agents/evaluation-engineer.md`
- `.claude/agents/mlops-ai-engineer.md`
- `.claude/agents/python-ml-refactoring-expert.md`
- `.claude/agents/performance-and-cost-engineer-llm.md`
- `.claude/agents/security-and-privacy-engineer-ml.md`
- `.claude/agents/technical-ml-writer.md`
- `.claude/agents/experiment-notebooker.md`

#### Test: Agent follows hybrid pattern

**Given** ml-system-architect.md
**When** validated against hybrid-agent-pattern
**Then** it passes all requirements

#### Test: Skills are valid

**Given** rag-architect agent references `rag-design-patterns`
**When** skill existence is checked
**Then** skill exists in `.claude/skills/rag-design-patterns/` OR is defined in `ai-llm-skills` spec

## Migration Impact

### New Files

12 new agent files in `.claude/agents/`

### No Breaking Changes

- ✅ Additive only (no existing agents modified)
- ✅ No naming conflicts
- ✅ Clear boundaries prevent overlap

## Implementation Notes

### Creation Order

**Phase 1** (Foundation):
1. ml-system-architect (central to AI systems)
2. llm-app-engineer (core implementation)
3. rag-architect (common use case)

**Phase 2** (Quality & Ops):
4. evaluation-engineer (testing AI)
5. mlops-ai-engineer (deployment)
6. security-and-privacy-engineer-ml (security)
7. performance-and-cost-engineer-llm (optimization)

**Phase 3** (Specialized):
8. agent-orchestrator-engineer (multi-agent)
9. python-ml-refactoring-expert (refactoring)
10. ai-product-analyst (planning)
11. technical-ml-writer (docs)
12. experiment-notebooker (exploration)

### Agent Boundaries

Clear handoffs between agents:
- **ml-system-architect** designs → **llm-app-engineer** implements
- **ai-product-analyst** defines → **ml-system-architect** architects
- **llm-app-engineer** builds → **evaluation-engineer** tests
- **evaluation-engineer** validates → **mlops-ai-engineer** deploys
- **rag-architect** specializes RAG → **llm-app-engineer** implements details

## References

- Hybrid pattern: `specs/hybrid-agent-pattern/spec.md`
- AI/LLM skills: `specs/ai-llm-skills/spec.md`
- Design doc: `design.md`
- Original proposal: repo root `proposal.md`
