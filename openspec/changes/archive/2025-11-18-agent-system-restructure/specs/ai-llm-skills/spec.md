# Spec: AI/LLM Skills

**Capability**: ai-llm-skills
**Status**: Draft
**Related**: hybrid-agent-pattern, ai-llm-agent-expansion

## Overview

This spec defines 7 new AI/LLM-focused skills that provide pattern enforcement and best practices for AI/ML engineering.

## ADDED Requirements

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

## Skill Structure Requirements

### Requirement: All Skills MUST Follow Pattern

All 7 new skills MUST follow existing skill structure pattern.

#### Scenario: New skill created

**Then** skill file MUST include:
- Frontmatter with `name`, `description`, `category: "ai-llm"`
- Trigger Keywords section
- Agent Integration section (lists agents that use this skill)
- ✅ Correct Pattern section with code examples
- ❌ Incorrect Pattern section with anti-patterns
- Domain-specific guidance sections
- Best Practices Checklist
- Auto-Apply section
- Related Skills section

**Example Structure**:
```markdown
---
name: llm-app-architecture
description: Automatically applies when building LLM applications. Ensures proper async patterns, token management, and error handling.
category: ai-llm
---

# LLM App Architecture

**Trigger Keywords**: LLM, AI application, model API, inference, generation
**Agent Integration**: Used by ml-system-architect, llm-app-engineer, rag-architect

When designing or implementing LLM applications:

## ✅ Correct Pattern

### Async API Calls with Retry
```python
import anthropic
from tenacity import retry, stop_after_attempt, wait_exponential

@retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1, min=2, max=10))
async def call_llm(prompt: str) -> str:
    """Call LLM API with retry logic."""
    async with anthropic.AsyncAnthropic() as client:
        message = await client.messages.create(
            model="claude-3-5-sonnet-20241022",
            max_tokens=1024,
            messages=[{"role": "user", "content": prompt}]
        )
        return message.content[0].text
```

## ❌ Incorrect Pattern

### Blocking LLM Call
```python
# Bad: Blocking call in async context
def call_llm(prompt):
    client = anthropic.Anthropic()
    message = client.messages.create(...)  # Blocks event loop
    return message.content[0].text
```

[Additional sections...]

## Best Practices Checklist
- ✅ Use async/await for all LLM API calls
- ✅ Implement retry logic with exponential backoff
- ✅ Track token usage and costs
- ✅ Set timeouts for LLM calls
- ✅ Validate responses before using

## Auto-Apply
When you detect LLM integration, automatically:
1. Use async patterns for API calls
2. Add retry logic for transient failures
3. Implement token counting
4. Add structured error handling

## Related Skills
- `async-await-checker` - Ensures proper async/await usage
- `structured-errors` - Error handling patterns
- `pydantic-models` - Response validation
```

## MODIFIED Requirements

None (these are new skills)

## REMOVED Requirements

None

## Validation

### Validation Rules

1. **7 skills created**: All skills listed exist in `.claude/skills/`
2. **Structure compliance**: Follow existing skill pattern
3. **Trigger keywords**: Each skill has explicit triggers
4. **Agent integration**: Lists agents that use the skill
5. **Code examples**: Both correct and incorrect patterns shown
6. **Category**: All have `category: "ai-llm"`

### Test Scenarios

#### Test: Skill directory structure

**When** ai-llm skills are created
**Then** directories exist:
- `.claude/skills/llm-app-architecture/`
- `.claude/skills/agent-orchestration-patterns/`
- `.claude/skills/rag-design-patterns/`
- `.claude/skills/prompting-patterns/`
- `.claude/skills/evaluation-metrics/`
- `.claude/skills/model-selection/`
- `.claude/skills/ai-security/`

**And** each contains `SKILL.md`

#### Test: Skill references valid agents

**Given** llm-app-architecture skill lists "Used by ml-system-architect"
**When** agent existence checked
**Then** ml-system-architect agent exists (will be created in this proposal)

## Migration Impact

### New Files

7 new skill directories in `.claude/skills/`, each with `SKILL.md`

### Integration Points

- Agents reference these skills in Skills Integration sections
- Skills auto-activate based on trigger keywords in agent workflows
- Skills cross-reference related skills

### No Breaking Changes

- ✅ Additive only
- ✅ No modifications to existing skills
- ✅ No naming conflicts

## Implementation Notes

### Creation Priority

Based on cross-agent usage (from design doc):

1. **llm-app-architecture** (used by 8+ agents) - HIGHEST PRIORITY
2. **evaluation-metrics** (used by 6+ agents)
3. **agent-orchestration-patterns** (used by 4+ agents)
4. **rag-design-patterns** (specialized but critical)
5. **ai-security** (used by 5+ agents for security)
6. **prompting-patterns** (cross-cutting pattern)
7. **model-selection** (strategic decision support)

### Code Example Standards

All skill code examples MUST:
- Use Python 3.10+ syntax
- Include type hints
- Show async/await patterns where applicable
- Include docstrings
- Demonstrate Pydantic validation
- Show error handling

### Relationship to Existing Skills

These AI/LLM skills **extend** existing Python skills:
- `llm-app-architecture` extends `fastapi-patterns` and `async-await-checker`
- `ai-security` extends `pii-redaction` and `structured-errors`
- `agent-orchestration-patterns` extends `tool-design-pattern`
- `evaluation-metrics` extends `pytest-patterns`

## References

- Existing skills: `.claude/skills/`
- AI agents: `specs/ai-llm-agent-expansion/spec.md`
- Design doc: `design.md`
