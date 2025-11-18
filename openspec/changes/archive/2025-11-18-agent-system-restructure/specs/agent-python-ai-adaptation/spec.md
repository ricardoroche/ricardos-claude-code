# Spec: Agent Python/AI Adaptation

**Capability**: agent-python-ai-adaptation
**Status**: Draft
**Related**: hybrid-agent-pattern, skill-agent-integration

## Overview

This spec defines requirements for adapting 9 newly-added role-oriented agents from JavaScript/web development context to Python AI/data engineering context. These agents currently reference Next.js, React, Supabase, and other JavaScript technologies.

## ADDED Requirements

### Requirement: Replace JavaScript Framework References

All JavaScript framework references MUST be replaced with Python AI/data engineering equivalents.

#### Scenario: Agent mentions JavaScript frameworks

**Given** an agent file contains JavaScript framework references
**When** the agent is adapted to Python context
**Then** framework references MUST be replaced according to this mapping:

| JavaScript Technology | Python AI/Data Engineering Equivalent |
|----------------------|-------------------------------------|
| Next.js, React | Streamlit, Gradio (for AI UIs) |
| Express, Fastify | FastAPI |
| TypeScript | Python with type hints |
| Node.js | Python with asyncio |
| npm, yarn, pnpm | uv, Poetry, pip |
| Jest, Vitest | pytest |
| ESLint, Prettier | ruff, black |
| Prisma | SQLAlchemy, Alembic |
| Supabase, Firebase | PostgreSQL, DuckDB |
| Zod | Pydantic |
| tRPC | FastAPI with Pydantic |
| Tailwind CSS | Streamlit components, Plotly |
| Vercel, Netlify | Modal, AWS Lambda, Cloud Run |

**Example**:
```markdown
# Before (JavaScript)
- Design Next.js API routes with TypeScript
- Use Zod for validation
- Deploy to Vercel

# After (Python/AI)
- Design FastAPI endpoints with type hints
- Use Pydantic for validation
- Deploy to Modal or AWS Lambda
```

### Requirement: Add AI/LLM Context

All adapted agents MUST include AI/LLM-specific context and workflows.

#### Scenario: Backend architect agent is adapted

**Given** the backend-architect agent is being adapted
**When** workflows are updated
**Then** they MUST include AI/LLM-specific considerations:
- LLM API integration patterns (OpenAI, Anthropic, etc.)
- Vector database selection for RAG systems
- Async patterns for LLM streaming responses
- Token counting and cost management
- Prompt template management
- AI-specific error handling (rate limits, timeouts)

**Example**:
```markdown
### Workflow: Design API Architecture

**Steps**:
1. **Design core endpoints**
   - Create FastAPI routers for LLM operations
   - Implement async handlers for streaming responses
   - Add Pydantic models with token limits

2. **Integrate vector database**
   - Select vector DB (Pinecone, Weaviate, Chroma)
   - Design embedding pipeline
   - Plan retrieval and reranking strategy

3. **Handle LLM-specific concerns**
   - Implement rate limiting and retry logic
   - Add token counting and cost tracking
   - Design prompt template management system

**Skills Invoked**: `fastapi-patterns`, `llm-app-architecture`, `async-await-checker`, `pydantic-models`
```

### Requirement: Reference Python AI Libraries

All adapted agents MUST reference appropriate Python AI/ML libraries.

#### Scenario: Agent workflows mention AI operations

**Given** an agent workflow involves AI/ML operations
**When** libraries are mentioned
**Then** they SHOULD include relevant Python AI libraries:

**LLM Frameworks**:
- LangChain, LlamaIndex (orchestration)
- Instructor, Outlines (structured generation)
- DSPy (prompt optimization)

**ML Frameworks**:
- PyTorch, TensorFlow (deep learning)
- scikit-learn (traditional ML)
- Transformers (Hugging Face)

**Vector Databases**:
- Pinecone, Weaviate, Qdrant (managed)
- Chroma, FAISS (local)

**Data Processing**:
- pandas, polars (dataframes)
- DuckDB (OLAP)
- NumPy (arrays)

**Observability**:
- LangSmith, LangFuse (LLM tracing)
- OpenTelemetry (general tracing)
- Weights & Biases (experiment tracking)

**Example**:
```markdown
3. **Select ML/LLM stack**
   - Choose orchestration framework (LangChain, LlamaIndex, or raw APIs)
   - Pick vector database (Pinecone for managed, Chroma for local)
   - Select observability tools (LangSmith for LLM traces, W&B for experiments)
```

### Requirement: Update Focus Areas for Python/AI

All adapted agents MUST update Focus Areas to reflect Python AI/data engineering priorities.

#### Scenario: Security engineer focus areas

**Given** security-engineer agent is being adapted
**When** Focus Areas section is updated
**Then** it MUST include AI/ML-specific security concerns:

**Before (Generic Web Security)**:
- Authentication and authorization
- XSS and CSRF prevention
- SQL injection protection
- HTTPS and certificate management

**After (AI/ML Security)**:
- **Prompt Injection Defense**: Protect against malicious prompts and jailbreaks
- **Data Privacy**: PII redaction, GDPR compliance for training data
- **Model Security**: Adversarial robustness, model extraction prevention
- **API Security**: Rate limiting, authentication for LLM endpoints
- **Compliance**: AI regulations (EU AI Act), responsible AI guidelines

**Example**:
```markdown
## Focus Areas

Core domains of expertise:
- **Prompt Injection Defense**: Detect and prevent malicious prompts, jailbreak attempts
- **Data Privacy & PII**: Ensure PII redaction in logs, training data compliance
- **Model Security**: Protect against adversarial inputs and model extraction
- **API Security**: Implement authentication, rate limiting for LLM endpoints
- **AI Compliance**: Navigate AI regulations and responsible AI frameworks
```

### Requirement: Add Python-Specific Best Practices

All adapted agents MUST include Python-specific best practices in their guidance.

#### Scenario: Agent provides implementation guidance

**Given** an agent is being adapted
**When** Best Practices section is updated
**Then** it MUST include Python-specific practices:
- Use type hints for all functions and classes
- Use async/await for I/O-bound operations
- Use Pydantic for data validation
- Use pytest for testing with fixtures
- Use ruff for linting and formatting
- Use mypy for static type checking
- Follow PEP 8 style guidelines

**Example**:
```markdown
## Best Practices

Key principles to follow:
- ✅ Use comprehensive type hints for all public APIs
- ✅ Use async/await for LLM API calls and database operations
- ✅ Validate all inputs with Pydantic models
- ✅ Write pytest tests with fixtures and parametrize
- ✅ Use structured logging with request IDs
- ✅ Implement graceful error handling for LLM failures
- ❌ Avoid blocking I/O in async contexts
- ❌ Avoid unvalidated user input in prompts
- ❌ Avoid missing error handling for rate limits
```

### Requirement: Update Skill References

All adapted agents MUST reference existing and planned Python/AI skills.

#### Scenario: Agent declares skill integration

**Given** an agent is being adapted
**When** Skills Integration section is updated
**Then** it MUST reference appropriate skills:

**Existing Skills**:
- `async-await-checker`, `pydantic-models`, `fastapi-patterns`, `pytest-patterns`
- `type-safety`, `docstring-format`, `structured-errors`, `pii-redaction`

**New AI/LLM Skills** (from this proposal):
- `llm-app-architecture`, `agent-orchestration-patterns`, `rag-design-patterns`
- `prompting-patterns`, `evaluation-metrics`, `model-selection`, `ai-security`

**New Supporting Skills** (from this proposal):
- `observability-logging`, `python-ai-project-structure`, `database-migrations`

**Example**:
```markdown
## Skills Integration

**Primary Skills** (always relevant):
- `fastapi-patterns` - API endpoint design and best practices
- `llm-app-architecture` - LLM application patterns and structure
- `type-safety` - Comprehensive type hints
- `pydantic-models` - Request/response validation

**Secondary Skills** (context-dependent):
- `rag-design-patterns` - When RAG is needed
- `agent-orchestration-patterns` - For multi-agent systems
- `observability-logging` - Production monitoring
- `ai-security` - Security-critical applications
```

## Agent-Specific Adaptation Requirements

### Requirement: Backend Architect → Python API/Data Architect

#### Scenario: Backend architect adapted for Python AI

**Given** backend-architect agent is being adapted
**Then** workflows MUST focus on:
- FastAPI application architecture
- Async I/O patterns for LLM operations
- Database selection (PostgreSQL, DuckDB)
- Vector database integration
- LLM API client design
- Streaming response patterns
- Background job processing (Celery, RQ)

**And** remove:
- Next.js API routes
- Supabase Edge Functions
- tRPC endpoints

### Requirement: Frontend Architect → AI UI/UX Specialist

#### Scenario: Frontend architect adapted for AI interfaces

**Given** frontend-architect agent is being adapted
**Then** workflows MUST focus on:
- Streamlit and Gradio for rapid AI prototypes
- Chat interface design patterns
- Streaming response UI patterns
- Token usage display and cost transparency
- Error handling for LLM failures
- Accessibility for AI-generated content

**And** remove:
- React component architecture
- Next.js routing
- Tailwind CSS patterns
- Client-side state management

**And** scope SHOULD be limited to:
- AI-specific UIs (chat, notebooks, dashboards)
- Python-based UI frameworks only

### Requirement: Performance Engineer → Python/AI Performance Specialist

#### Scenario: Performance engineer adapted for Python AI workloads

**Given** performance-engineer agent is being adapted
**Then** workflows MUST focus on:
- Python profiling tools (cProfile, py-spy, Scalene)
- Async performance optimization
- LLM latency optimization (caching, batching)
- Database query optimization (EXPLAIN, indexes)
- Memory profiling for large models
- Token throughput optimization
- Vector search performance

**And** remove:
- JavaScript performance tools
- Bundle size optimization
- Client-side rendering optimization

### Requirement: Security Engineer → AI/ML Security Specialist

#### Scenario: Security engineer adapted for AI/ML security

**Given** security-engineer agent is being adapted
**Then** workflows MUST focus on:
- Prompt injection detection and prevention
- PII redaction in logs and responses
- Model API authentication and authorization
- Rate limiting for abuse prevention
- Input validation for LLM prompts
- Output filtering for harmful content
- OWASP LLM Top 10 vulnerabilities

**And** retain general security:
- SQL injection prevention
- Authentication/authorization
- HTTPS/TLS

### Requirement: Other Agents Adaptation

#### Scenario: Remaining agents adapted

**Given** other agents are being adapted
**Then** apply these context shifts:

| Agent | Python/AI Adaptations |
|-------|----------------------|
| **system-architect** | Add ML system design, distributed training, model serving |
| **refactoring-expert** | Python refactoring tools, AI code complexity patterns |
| **requirements-analyst** | AI product requirements, success metrics for ML |
| **tech-stack-researcher** | Python ML/AI ecosystem, model providers, vector DBs |
| **learning-guide** | Python teaching approach, AI/ML concepts |

## MODIFIED Requirements

None (these are adaptations, not modifications to existing requirements)

## REMOVED Requirements

None (adaptation adds context, doesn't remove requirements)

## Validation

### Validation Rules

1. **Zero JavaScript references**: No mentions of Next.js, React, npm, TypeScript (unless in comparison)
2. **Python technology coverage**: All workflows mention Python frameworks
3. **AI/LLM context**: At least one workflow addresses AI/LLM-specific concerns
4. **Skill references valid**: All referenced skills exist or are planned in this proposal
5. **Best practices Python-specific**: Include Python idioms and tools

### Test Scenarios

#### Test: Backend architect has no JavaScript

**Given** backend-architect.md is adapted
**When** content is validated
**Then** it MUST NOT contain: "Next.js", "React", "tRPC", "Supabase", "Vercel"
**And** it MUST contain: "FastAPI", "async", "Pydantic"

#### Test: Security engineer has AI-specific focus

**Given** security-engineer.md is adapted
**When** Focus Areas section is validated
**Then** it MUST contain at least one of: "prompt injection", "PII redaction", "model security", "AI compliance"

#### Test: All agents reference valid skills

**Given** any adapted agent
**When** Skills Integration section is validated
**Then** all referenced skills MUST exist in `.claude/skills/` OR be in this proposal's new skills list

## Migration Impact

### Affected Files

9 untracked agent files in `.claude/agents/`:
1. `backend-architect.md`
2. `frontend-architect.md`
3. `learning-guide.md`
4. `performance-engineer.md`
5. `refactoring-expert.md`
6. `requirements-analyst.md`
7. `security-engineer.md`
8. `system-architect.md`
9. `tech-stack-researcher.md`

### Migration Order

**Phase 1** (Proof of concept):
1. backend-architect (most code-focused)
2. system-architect (architectural focus)
3. security-engineer (specific AI security needs)

**Phase 2** (Remaining):
4. performance-engineer
5. refactoring-expert
6. requirements-analyst
7. tech-stack-researcher
8. learning-guide
9. frontend-architect (limited scope)

## Implementation Notes

### Common Replacements

Use search/replace for common patterns:

| Search | Replace |
|--------|---------|
| "Next.js" | "FastAPI" |
| "TypeScript" | "Python with type hints" |
| "Zod" | "Pydantic" |
| "npm install" | "uv add" or "poetry add" |
| "Jest" | "pytest" |
| ".ts files" | ".py files" |
| "API routes" | "FastAPI endpoints" |
| "Supabase" | "PostgreSQL" or "DuckDB" |

### AI Context Additions

For each agent, add workflows or sections covering:
- LLM API integration (if backend/implementation focused)
- Vector database usage (if data focused)
- Prompt management (if user-facing)
- AI observability (if operations focused)
- AI security (if security focused)

## References

- New agents: `.claude/agents/` (untracked files)
- Hybrid pattern spec: `specs/hybrid-agent-pattern/spec.md`
- AI skills spec: `specs/ai-llm-skills/spec.md`
- Design doc: `design.md`
