# ai-llm-skills Specification

## Purpose
TBD - created by archiving change agent-system-restructure. Update Purpose after archive.
## Requirements
### Requirement: llm-app-architecture Skill MUST be created

A skill MUST be created for LLM application architecture patterns.

#### Scenario: Code involves LLM application structure

**Trigger Keywords**: "LLM", "AI application", "model API", "inference", "generation"

**Pattern Coverage**:
- ✅ Async API calls to LLM providers
- ✅ Streaming response handling
- ✅ Token counting and cost tracking
- ✅ Retry logic with exponential backoff
- ✅ Prompt template management
- ✅ Response validation and parsing
- ❌ Avoid blocking LLM calls
- ❌ Avoid missing timeout configuration
- ❌ Avoid untracked token usage

**Used By**: ml-system-architect, llm-app-engineer, rag-architect, agent-orchestrator-engineer

### Requirement: agent-orchestration-patterns Skill MUST be created

A skill MUST be created for multi-agent and tool-calling patterns.

#### Scenario: Code involves agent orchestration

**Trigger Keywords**: "agent", "tool calling", "multi-agent", "orchestration", "workflow"

**Pattern Coverage**:
- ✅ Tool schema design with Pydantic
- ✅ Agent communication patterns
- ✅ State management for agents
- ✅ Error handling in tool execution
- ✅ Parallel vs sequential execution
- ❌ Avoid circular agent dependencies
- ❌ Avoid missing tool input validation
- ❌ Avoid unhandled tool failures

**Used By**: agent-orchestrator-engineer, ml-system-architect, llm-app-engineer

### Requirement: rag-design-patterns Skill MUST be created

A skill MUST be created for RAG system design and implementation.

#### Scenario: Code involves RAG operations

**Trigger Keywords**: "RAG", "retrieval", "vector", "embedding", "semantic search"

**Pattern Coverage**:
- ✅ Vector database selection and configuration
- ✅ Chunking strategies (semantic, fixed-size)
- ✅ Embedding model selection
- ✅ Retrieval strategies (dense, sparse, hybrid)
- ✅ Reranking and filtering
- ✅ Context window management
- ❌ Avoid naive chunking (character limits without semantics)
- ❌ Avoid missing relevance evaluation
- ❌ Avoid overloading context window

**Used By**: rag-architect, llm-app-engineer, evaluation-engineer

### Requirement: prompting-patterns Skill MUST be created

A skill MUST be created for prompt engineering best practices.

#### Scenario: Code involves prompt construction

**Trigger Keywords**: "prompt", "instruction", "few-shot", "system message", "template"

**Pattern Coverage**:
- ✅ Structured prompt templates
- ✅ Few-shot example selection
- ✅ System message design
- ✅ Input validation before prompting
- ✅ Output format specification
- ✅ Prompt injection prevention
- ❌ Avoid unvalidated user input in prompts
- ❌ Avoid vague instructions
- ❌ Avoid missing output format specification

**Used By**: llm-app-engineer, evaluation-engineer, technical-ml-writer

### Requirement: evaluation-metrics Skill MUST be created

A skill MUST be created for AI evaluation and testing patterns.

#### Scenario: Code involves model evaluation

**Trigger Keywords**: "evaluation", "metrics", "benchmark", "test suite", "accuracy"

**Pattern Coverage**:
- ✅ Defining eval metrics (accuracy, latency, cost)
- ✅ Creating eval datasets
- ✅ Implementing eval pipelines with pytest
- ✅ Statistical significance testing
- ✅ A/B testing setup
- ✅ Regression detection
- ❌ Avoid single-metric evaluation
- ❌ Avoid small eval sets (<100 examples)
- ❌ Avoid missing edge case coverage

**Used By**: evaluation-engineer, ml-system-architect, ai-product-analyst, rag-architect

### Requirement: model-selection Skill MUST be created

A skill MUST be created for choosing models and providers.

#### Scenario: Code involves model selection decisions

**Trigger Keywords**: "model selection", "provider", "OpenAI", "Anthropic", "local model"

**Pattern Coverage**:
- ✅ Model capability assessment (reasoning, speed, cost)
- ✅ Provider comparison (API reliability, latency, pricing)
- ✅ Fallback model configuration
- ✅ Cost-performance trade-offs
- ✅ Local vs cloud model decisions
- ❌ Avoid single provider lock-in without fallback
- ❌ Avoid ignoring latency requirements
- ❌ Avoid over-provisioning expensive models

**Used By**: ml-system-architect, performance-and-cost-engineer-llm, ai-product-analyst

### Requirement: ai-security Skill MUST be created

A skill MUST be created for AI/ML-specific security patterns.

#### Scenario: Code involves AI security considerations

**Trigger Keywords**: "AI security", "prompt injection", "PII", "adversarial", "model security"

**Pattern Coverage**:
- ✅ Prompt injection detection and prevention
- ✅ PII redaction in prompts and responses
- ✅ Input validation for user prompts
- ✅ Output filtering for harmful content
- ✅ Rate limiting for abuse prevention
- ✅ Audit logging for AI operations
- ❌ Avoid direct user input to prompts
- ❌ Avoid missing PII detection
- ❌ Avoid unmonitored AI endpoints

**Used By**: security-and-privacy-engineer-ml, llm-app-engineer, mlops-ai-engineer

