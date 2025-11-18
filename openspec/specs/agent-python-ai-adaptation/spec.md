# agent-python-ai-adaptation Specification

## Purpose
TBD - created by archiving change agent-system-restructure. Update Purpose after archive.
## Requirements
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

