# Agent Development Guide

This guide explains how to create, adapt, and maintain agents following the hybrid agent pattern.

## Table of Contents

1. [Hybrid Agent Pattern](#hybrid-agent-pattern)
2. [Creating a New Agent](#creating-a-new-agent)
3. [Workflow-Skill Trigger Language](#workflow-skill-trigger-language)
4. [Good vs Poor Agent Structure](#good-vs-poor-agent-structure)
5. [Testing Your Agent](#testing-your-agent)
6. [Maintenance Guidelines](#maintenance-guidelines)

## Hybrid Agent Pattern

The hybrid agent pattern combines the best of role-based and task-based approaches:

- **Role & Mindset**: High-level thinking approach and behavioral principles
- **Specialized Workflows**: Step-by-step task guidance with code examples
- **Skill Integration**: Explicit references to skills triggered by workflows
- **Clear Boundaries**: Will/Will Not sections defining scope

### Why Hybrid?

| Pattern | Strengths | Weaknesses |
|---------|-----------|------------|
| Pure Role-Based | Flexible, reusable across contexts | Too vague for specific tasks |
| Pure Task-Based | Prescriptive, clear steps | Rigid, limited reusability |
| **Hybrid** | **Flexible AND prescriptive** | Slightly more complex |

## Creating a New Agent

### Step 1: Use the Template

Start with `.claude/templates/hybrid-agent-template.md`:

```bash
cp .claude/templates/hybrid-agent-template.md .claude/agents/your-agent-name.md
```

### Step 2: Fill in Frontmatter

```yaml
---
name: your-agent-name
description: Brief one-sentence description for activation
category: architecture|implementation|quality|operations|analysis|communication
pattern_version: "1.0"
model: sonnet  # or opus, haiku
color: orange  # or red, green, blue, purple, yellow, cyan, pink
---
```

**Category Guidelines**:
- **architecture**: High-level system design and planning
- **implementation**: Hands-on code writing and feature building
- **quality**: Code review, testing, performance, security
- **operations**: Deployment, monitoring, optimization, maintenance
- **analysis**: Research, requirements gathering, planning
- **communication**: Documentation, teaching, knowledge transfer

**Model Selection**:
- `sonnet`: Default for most agents (reasoning, code generation, analysis)
- `opus`: Complex multi-step reasoning (rarely needed)
- `haiku`: Fast operations where speed matters more than depth

### Step 3: Define Role & Mindset

Write 2-3 paragraphs describing:
1. **Who this agent is**: The role they play
2. **How they think**: Their approach and principles
3. **Why they matter**: The value they provide

**Example (Good)**:
```markdown
## Role & Mindset

You are an ML System Architect who designs scalable, maintainable AI/LLM systems.
Your thinking prioritizes reliability, observability, and cost-effectiveness over
premature optimization. You understand that AI systems have unique challenges:
non-deterministic outputs, latency sensitivity, and evolving model capabilities.

Your approach is measurement-driven. Before recommending architectures, you gather
requirements around scale, latency, cost, and accuracy trade-offs. You design
systems that can evolve as models improve and as teams learn what users actually need.

You bring clarity to ambiguous AI projects by establishing clear success metrics,
fallback strategies, and monitoring approaches before any code is written.
```

**Example (Poor)**:
```markdown
## Role & Mindset

You help build ML systems. You know about ML and can help with architecture.
```

Why poor? Too vague, no personality, no principles, no value proposition.

### Step 4: Define Triggers

List 3-5 clear activation patterns:

**Example (Good)**:
```markdown
## Triggers

When to activate this agent:
- User asks "design ML system" or "architect AI application"
- User mentions scaling LLM applications or production AI systems
- User needs technology selection for AI/ML projects
- User asks about system design for RAG, agents, or LLM APIs
```

**Example (Poor)**:
```markdown
## Triggers

- ML stuff
- When user needs help
```

Why poor? Too vague, not actionable for keyword matching.

### Step 5: Define Focus Areas

List 3-5 core domains with brief descriptions:

```markdown
## Focus Areas

Core domains of expertise:
- **LLM Application Architecture**: API design, async patterns, streaming, token management
- **Vector Database Integration**: Choosing, configuring, and optimizing vector stores
- **Observability**: Tracing, logging, metrics for AI systems (latency, cost, quality)
- **Cost Optimization**: Model selection, caching strategies, fallback patterns
```

### Step 6: Create Workflows

Create **3-5 specialized workflows** per agent. Each workflow should:

1. Have a clear "When to use" scenario
2. Include 5-10 actionable steps
3. Include code examples or specific guidance
4. List skills invoked at the end

**Example (Good)**:
```markdown
### Workflow: Design RAG System

**When to use**: User needs to implement retrieval-augmented generation

**Steps**:
1. **Define requirements**
   - Document latency budget (p50, p99)
   - Identify data sources and update frequency
   - Establish accuracy/precision targets

2. **Select vector database**
   ```python
   # Consider: Pinecone (managed), Qdrant (self-hosted), pgvector (PostgreSQL)
   # Key factors: scale, latency, cost, operational overhead
   ```

3. **Design chunking strategy**
   - Use semantic boundaries (paragraphs, sections)
   - Target 200-500 tokens per chunk
   - Include metadata for filtering

4. **Implement retrieval**
   ```python
   from openai import AsyncOpenAI

   async def retrieve(query: str, top_k: int = 5) -> list[str]:
       # Generate query embedding
       embedding = await client.embeddings.create(input=query, model="text-embedding-3-small")

       # Query vector database
       results = await vector_db.search(embedding.data[0].embedding, top_k=top_k)
       return [r.text for r in results]
   ```

5. **Add reranking for precision**
   - Use cross-encoder or LLM for reranking top results
   - Filter by relevance threshold
   - Log retrieval metrics (precision, recall)

6. **Generate with context**
   - Construct prompt with retrieved chunks
   - Stream response for better UX
   - Track token usage and costs

7. **Add evaluation**
   - Create eval dataset with question/answer pairs
   - Track retrieval precision and answer quality
   - Monitor user feedback signals

**Skills Invoked**: `rag-design-patterns`, `llm-app-architecture`, `async-await-checker`, `observability-logging`, `evaluation-metrics`
```

**Example (Poor)**:
```markdown
### Workflow: Build RAG

**Steps**:
1. Add vector database
2. Do embeddings
3. Query and get results
4. Use LLM

**Skills Invoked**: Some AI skills
```

Why poor? No context, no code examples, vague steps, no skills listed.

### Step 7: Document Skills Integration

```markdown
## Skills Integration

**Primary Skills** (always relevant):
- `rag-design-patterns` - Core RAG architecture patterns and best practices
- `llm-app-architecture` - General LLM application patterns (async, streaming, error handling)
- `observability-logging` - Tracking latency, costs, quality metrics

**Secondary Skills** (context-dependent):
- `evaluation-metrics` - When building eval pipelines
- `fastapi-patterns` - When implementing REST APIs
- `pytest-patterns` - When writing tests
```

### Step 8: Define Outputs

```markdown
## Outputs

Typical deliverables:
- System architecture diagram (markdown or ASCII art)
- Technology selection with rationale (vector DB, LLM provider, frameworks)
- Cost and latency estimates with assumptions
- Monitoring and alerting plan
- Fallback and error handling strategy
```

### Step 9: Establish Best Practices

```markdown
## Best Practices

Key principles to follow:
- ✅ Measure first: profile latency and costs before optimizing
- ✅ Design for observability: add tracing and metrics from day one
- ✅ Plan for failure: LLM APIs fail, have fallbacks and retries
- ✅ Start simple: use managed services before self-hosting
- ❌ Avoid premature optimization: don't build complex caching before measuring
- ❌ Avoid vendor lock-in: use abstractions for LLM providers
- ❌ Don't skip evaluation: build eval pipeline early
```

### Step 10: Define Boundaries

```markdown
## Boundaries

**Will:**
- Design system architecture for AI/LLM applications
- Select technologies and provide rationale
- Create observability and monitoring plans
- Estimate costs and performance characteristics
- Recommend scaling strategies

**Will Not:**
- Implement the system (see llm-app-engineer)
- Write production code (see implement-feature)
- Perform security audits (see security-engineer)
- Deploy infrastructure (see mlops-ai-engineer)
- Train or fine-tune models (see evaluation-engineer)
```

### Step 11: Link Related Agents

```markdown
## Related Agents

- **llm-app-engineer** - Implements the architecture you design
- **rag-architect** - More specialized for RAG-specific systems
- **mlops-ai-engineer** - Handles deployment and operations
- **evaluation-engineer** - Builds evaluation pipelines
- **security-engineer** - Reviews security aspects
```

## Workflow-Skill Trigger Language

Skills auto-activate based on keywords and patterns in your workflow text. Use these intentionally:

### Trigger Language Patterns

| Skill | Trigger Keywords | Example Usage |
|-------|------------------|---------------|
| `fastapi-patterns` | FastAPI, endpoint, route, API, router | "Create FastAPI endpoint with async handler" |
| `async-await-checker` | async, await, asyncio, concurrent | "Use async/await for database calls" |
| `pydantic-models` | Pydantic, BaseModel, validation, schema | "Define Pydantic request/response models" |
| `pytest-patterns` | pytest, test, fixture, mock, parametrize | "Write pytest tests with fixtures" |
| `type-safety` | type hint, typing, mypy, annotation | "Add type hints to all functions" |
| `observability-logging` | logging, tracing, monitoring, metrics, OpenTelemetry | "Add structured logging and tracing" |
| `rag-design-patterns` | RAG, retrieval, vector, embedding, reranking | "Design RAG retrieval pipeline" |
| `llm-app-architecture` | LLM, AI application, model API, token, streaming | "Implement LLM streaming with async" |
| `agent-orchestration-patterns` | agent, tool calling, orchestration, multi-agent | "Build agent orchestration system" |

### Example: Multi-Skill Triggering

```markdown
### Workflow: Implement RAG API

**Steps**:
1. **Create FastAPI endpoint** ← Triggers `fastapi-patterns`
   - Use async handler for non-blocking I/O ← Triggers `async-await-checker`

2. **Define Pydantic models** ← Triggers `pydantic-models`
   - Add request validation and type hints ← Triggers `type-safety`

3. **Implement RAG retrieval** ← Triggers `rag-design-patterns`
   - Query vector database with embeddings ← Continues `rag-design-patterns`
   - Stream LLM response ← Triggers `llm-app-architecture`

4. **Add observability** ← Triggers `observability-logging`
   - Log retrieval metrics and LLM costs
   - Add OpenTelemetry tracing

5. **Write pytest tests** ← Triggers `pytest-patterns`
   - Mock LLM API calls and vector database
   - Use fixtures for test data

**Skills Invoked**: `fastapi-patterns`, `async-await-checker`, `pydantic-models`, `type-safety`, `rag-design-patterns`, `llm-app-architecture`, `observability-logging`, `pytest-patterns`
```

### Intentional Triggering

- **Be explicit**: Use skill trigger keywords naturally in your workflow steps
- **Be specific**: Reference concrete technologies and patterns, not generic terms
- **List invoked skills**: Always list skills at the end of each workflow
- **Cross-reference**: Ensure skills listed match the language used in steps

## Good vs Poor Agent Structure

### Good Example: Focused, Clear, Actionable

```markdown
---
name: evaluation-engineer
description: Design and implement evaluation pipelines for AI/LLM systems
category: quality
pattern_version: "1.0"
model: sonnet
color: yellow
---

# Evaluation Engineer

## Role & Mindset

You are an Evaluation Engineer who builds measurement systems for AI applications.
You believe "you can't improve what you don't measure" and establish eval pipelines
early in the development cycle. You understand that LLM outputs are non-deterministic
and require both automated metrics and human evaluation.

Your approach is dataset-driven. You create diverse, representative eval sets that
capture edge cases and failure modes. You combine multiple evaluation methods:
model-based judges, rule-based checks, and human review.

You design eval systems that scale: easy to add new test cases, fast to run, and
clear on what passed/failed and why.

## Triggers

When to activate this agent:
- User needs to evaluate LLM application quality
- User asks about creating test datasets or benchmarks
- User mentions A/B testing or model comparison
- User needs evaluation metrics or quality gates

## Focus Areas

Core domains of expertise:
- **Eval Dataset Creation**: Building diverse, representative test sets
- **Automated Evaluation**: LLM judges, rule-based checks, statistical metrics
- **Human Evaluation**: Designing effective human review workflows
- **Continuous Evaluation**: CI/CD integration, regression detection

## Specialized Workflows

### Workflow: Create Evaluation Dataset

**When to use**: Starting a new AI project or improving existing eval coverage

**Steps**:
1. **Gather real examples**
   - Export user interactions from logs
   - Sample diverse use cases and edge cases
   - Include failure cases and ambiguous inputs

2. **Create ground truth**
   ```python
   from pydantic import BaseModel

   class EvalCase(BaseModel):
       input: str
       expected_output: str | None = None  # May be None for open-ended tasks
       evaluation_criteria: list[str]
       tags: list[str]  # ["edge_case", "common", "failure_mode"]
   ```

3. **Organize by category**
   - Group by use case, difficulty, or failure mode
   - Ensure balanced representation
   - Target 50-100 cases for initial dataset

4. **Version control**
   - Store in JSON or JSONL format
   - Track in git for reproducibility
   - Document creation methodology

**Skills Invoked**: `pydantic-models`, `type-safety`, `git-workflow-standards`

### Workflow: Implement Automated Evaluation

[... more workflows ...]

## Skills Integration

**Primary Skills**:
- `evaluation-metrics` - Core evaluation patterns and metrics
- `pydantic-models` - Defining eval case schemas
- `pytest-patterns` - Running evals as tests

**Secondary Skills**:
- `llm-app-architecture` - When building LLM judges
- `observability-logging` - Tracking eval results over time

## Outputs

Typical deliverables:
- Evaluation dataset (JSONL or JSON) with version control
- Automated eval pipeline (pytest or CI/CD integration)
- Eval metrics dashboard (pass rate, score distribution)
- Regression detection alerts

## Best Practices

Key principles to follow:
- ✅ Start eval dataset early, grow it continuously
- ✅ Use multiple evaluation methods (automated + human)
- ✅ Version control eval datasets like code
- ✅ Make evals fast to run (< 5 minutes for CI/CD)
- ❌ Avoid single-metric evaluation (use multiple perspectives)
- ❌ Don't skip edge cases and failure modes
- ❌ Don't rely only on automated metrics for subjective tasks

## Boundaries

**Will:**
- Design evaluation methodology and metrics
- Create and maintain evaluation datasets
- Build automated evaluation pipelines
- Set up continuous evaluation in CI/CD
- Analyze eval results and identify issues

**Will Not:**
- Implement model improvements (see llm-app-engineer)
- Deploy evaluation infrastructure (see mlops-ai-engineer)
- Perform model training (out of scope)
- Fix application bugs (see debug-test-failure)

## Related Agents

- **llm-app-engineer** - Implements fixes based on eval findings
- **mlops-ai-engineer** - Deploys eval pipeline to production
- **ai-product-analyst** - Defines success metrics and criteria
- **technical-ml-writer** - Documents evaluation methodology
```

### Poor Example: Vague, Unfocused, Missing Details

```markdown
---
name: ai-helper
description: Helps with AI stuff
category: implementation
pattern_version: "1.0"
model: sonnet
color: blue
---

# AI Helper

## Role & Mindset

You help with AI projects. You know about AI and can assist with various tasks.

## Triggers

When to activate this agent:
- User needs AI help
- Any AI-related question

## Focus Areas

- AI things
- ML stuff
- Models

## Specialized Workflows

### Workflow: Help with AI

**Steps**:
1. Understand what user wants
2. Do the AI thing
3. Make it work
4. Test

**Skills Invoked**: AI skills

## Skills Integration

**Primary Skills**: Various AI skills

## Outputs

- Code
- Docs

## Best Practices

- Do good work
- Follow best practices

## Boundaries

**Will:** Help with AI

**Will Not:** Non-AI stuff

## Related Agents

- Other agents
```

**Why poor?**
- Vague role and mindset
- No specific triggers
- Generic focus areas
- Workflows lack detail, code examples, and specific skills
- Best practices are platitudes
- Boundaries don't clarify scope
- Related agents not named

## Testing Your Agent

### 1. Activation Testing

Test if your agent activates on correct prompts:

```bash
# In Claude Code, try these prompts:
# For evaluation-engineer:
"I need to create an evaluation dataset for my LLM app"
"How do I set up automated evaluation?"
"Help me implement A/B testing for model comparison"

# Verify the agent activates and provides relevant workflows
```

### 2. Workflow Testing

Test each workflow independently:

```bash
# For each workflow:
1. Trigger the agent with workflow-specific prompt
2. Verify workflow is selected
3. Check that steps are clear and actionable
4. Confirm code examples work
5. Verify skills are triggered
```

### 3. Skill Triggering Testing

Verify workflows trigger declared skills:

```bash
# Check skill activation:
1. Run workflow in Claude Code
2. Monitor which skills activate (check logs)
3. Confirm skills listed match actual triggers
4. Update workflow language if skills don't trigger
```

### 4. Boundary Testing

Test that agent respects boundaries:

```bash
# For evaluation-engineer:
"Can you deploy my evaluation pipeline to production?"
# Should refuse and suggest mlops-ai-engineer

"Can you fix the bugs my eval found?"
# Should refuse and suggest debug-test-failure or llm-app-engineer
```

## Maintenance Guidelines

### When to Update Agents

- **Skill changes**: When new skills are added that this agent should use
- **Pattern evolution**: When best practices change in the domain
- **User feedback**: When users report confusion or missing functionality
- **Related agents change**: When related agents are added, removed, or renamed

### How to Update Agents

1. **Keep pattern version current**: Update `pattern_version` if hybrid pattern evolves
2. **Update skill references**: Ensure all skill names are current
3. **Refine workflows**: Add code examples, clarify vague steps
4. **Update boundaries**: Adjust as agents specialize or new agents are added
5. **Test after changes**: Re-run activation and workflow tests

### Consistency Checks

Run these checks before committing agent changes:

```bash
# 1. Validate frontmatter
- [ ] name matches filename
- [ ] description is one sentence
- [ ] category is valid
- [ ] pattern_version is current
- [ ] model and color are set

# 2. Validate structure
- [ ] Role & Mindset is 2-3 paragraphs
- [ ] Triggers has 3-5 clear patterns
- [ ] Focus Areas has 3-5 domains
- [ ] Has 3-5 specialized workflows
- [ ] Each workflow has "When to use" and "Skills Invoked"
- [ ] Skills Integration section is complete
- [ ] Outputs section lists deliverables
- [ ] Best Practices has ✅ and ❌ items
- [ ] Boundaries has Will/Will Not
- [ ] Related Agents lists specific agents

# 3. Validate content
- [ ] No generic placeholders ("stuff", "things")
- [ ] Code examples are valid and runnable
- [ ] Skill names reference real skills
- [ ] Related agent names reference real agents
- [ ] Workflows have sufficient detail
- [ ] Trigger keywords are specific and actionable
```

### Pattern Evolution

As the hybrid pattern evolves:

1. **Version updates**: Increment `pattern_version` when pattern changes
2. **Migration guide**: Document what changed and how to update
3. **Batch updates**: Update all agents when pattern changes significantly
4. **Backward compatibility**: Maintain old pattern temporarily during transition

## Summary

Creating excellent agents requires:

1. **Clear role and mindset** - Define who the agent is and how they think
2. **Specific triggers** - Enable accurate activation on user prompts
3. **Detailed workflows** - Provide actionable steps with code examples
4. **Intentional skill triggering** - Use language that activates relevant skills
5. **Well-defined boundaries** - Clarify what agent will/won't do
6. **Related agent links** - Enable handoffs and collaboration

Follow this guide to create agents that are:
- **Discoverable**: Users can find them via triggers
- **Actionable**: Workflows provide clear steps
- **Consistent**: Follow hybrid pattern structure
- **Maintainable**: Easy to update as patterns evolve
- **Effective**: Trigger right skills at right time

**Next Steps**:
- Review `.claude/templates/hybrid-agent-template.md` for structure
- Study existing agents in `.claude/agents/` for examples
- Test your agent with real prompts
- Gather user feedback and iterate
