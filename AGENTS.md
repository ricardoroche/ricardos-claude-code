<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# Claude Code Agent Guidelines

This repository is a reusable Claude Code plugin package for Python AI/data engineering projects. Updates here should improve the plugin itself (commands, agents, skills, docs, automation) for downstream consumers—not add project-specific configuration.

## Plugin Overview

**32 Specialized Agents** (hybrid pattern: role + workflows)
**29 Pattern Skills** (auto-activated from workflows)
**6 Commands** (slash commands for common tasks)
**Automation Hooks** (pre/post-tool-use quality gates)

All agents follow a **unified hybrid pattern** (pattern_version: "1.0") that combines role-based mindset with specific task workflows, ensuring consistent structure and predictable skill triggering.

## Agent Categories

### Architecture (5 agents)
- **ml-system-architect** - ML/AI system design
- **rag-architect** - RAG system design
- **system-architect** - High-level system design
- **backend-architect** - Backend API architecture
- **frontend-architect** - AI UI/UX (Streamlit, Gradio)

### Implementation (7 agents)
- **llm-app-engineer** - LLM application development
- **agent-orchestrator-engineer** - Multi-agent systems
- **implement-feature** - Feature implementation
- **write-unit-tests** - Test generation
- **add-agent-tool** - Agent tool design
- **experiment-notebooker** - Jupyter notebook design
- **deep-research-agent** - Research and synthesis

### Quality (8 agents)
- **code-reviewer** - Code review
- **evaluation-engineer** - LLM evaluation pipelines
- **python-ml-refactoring-expert** - Python/ML refactoring
- **performance-and-cost-engineer-llm** - LLM optimization
- **security-and-privacy-engineer-ml** - AI security
- **performance-engineer** - Performance optimization
- **refactoring-expert** - Code refactoring
- **security-engineer** - Security audits

### Operations (4 agents)
- **mlops-ai-engineer** - ML deployment and monitoring
- **optimize-db-query** - Query optimization
- **upgrade-dependency** - Dependency management
- **debug-test-failure** - Test debugging

### Analysis (4 agents)
- **ai-product-analyst** - AI product requirements
- **requirements-analyst** - Requirements analysis
- **tech-stack-researcher** - Technology research
- **learning-guide** - Teaching and explanation

### Communication (4 agents)
- **technical-ml-writer** - ML documentation
- **technical-writer** - Technical documentation
- **spec-writer** - OpenSpec authoring
- **fix-pr-comments** - PR feedback resolution

## Skill Categories

### Python Engineering (15 skills)
type-safety, async-await-checker, pydantic-models, fastapi-patterns, pytest-patterns, structured-errors, docstring-format, dynaconf-config, tool-design-pattern, pii-redaction, database-migrations, query-optimization, python-packaging, dependency-management, code-review-framework

### AI/LLM (7 skills)
llm-app-architecture, agent-orchestration-patterns, rag-design-patterns, prompting-patterns, evaluation-metrics, model-selection, ai-security

### Observability (3 skills)
observability-logging, monitoring-alerting, performance-profiling

### Developer Velocity (4 skills)
git-workflow-standards, docs-style, openspec-authoring, spec-templates

## Hybrid Agent Pattern

All agents follow this structure (pattern_version: "1.0"):

1. **Role & Mindset** - Behavioral principles and thinking approach
2. **Triggers** (optional) - Keywords that activate the agent
3. **Focus Areas** - Key areas of expertise
4. **Specialized Workflows** - Step-by-step workflows with skill references
5. **Skills Integration** - Primary/secondary/contextual skills
6. **Outputs** - Expected deliverables
7. **Best Practices** - Do's and don'ts
8. **Boundaries** - Will/Will Not scope definitions
9. **Related Agents** - Handoff scenarios

## Workflow-Skill Integration Model

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

## Editing expectations

- Keep guidance generic so it works when installed into any Python project; avoid repo-specific paths or MCP server configs
- Maintain alignment with `CLAUDE.md` and `README.md` (plugin philosophy, type-safety/async/Pydantic/pytest/mypy/ruff focus)
- When adding or changing commands/agents/skills in `.claude/`, keep them self-documented and ensure docs stay accurate
- New agents must follow hybrid pattern (use `.claude/templates/hybrid-agent-template.md`)
- Hooks in `.claude/hooks/` and settings in `.claude/settings*.json` are part of the distributed plugin—change cautiously and document behavioral impacts
- Prefer examples that illustrate plugin use after installation (e.g., `/fix`, `/api`, `/check`, `/test`)

## Useful references

- `.claude/commands/`, `.claude/agents/`, `.claude/skills/` for current behaviors
- `.claude/templates/` for agent and skill templates
- `docs/` for standards, workflows, and examples (not project-scoped)
- `README.md` for installation/usage instructions; update it when changing plugin capabilities
- `openspec/changes/agent-system-restructure/` for pattern migration details
