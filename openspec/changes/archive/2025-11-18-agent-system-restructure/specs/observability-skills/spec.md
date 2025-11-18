# Spec: Observability Skills

**Capability**: observability-skills
**Status**: Draft
**Related**: ai-llm-skills, python-engineering-skills

## Overview

This spec defines 3 new observability and operations skills for production monitoring, logging, and performance profiling.

## ADDED Requirements

### Requirement: observability-logging Skill MUST be created

A skill MUST be created for structured logging and observability patterns.

#### Scenario: Code involves logging or tracing

**Trigger Keywords**: "logging", "observability", "tracing", "OpenTelemetry", "structured logs", "request ID"

**Pattern Coverage**:
- ✅ Structured logging with JSON
- ✅ Request ID propagation
- ✅ OpenTelemetry tracing
- ✅ Log levels and contexts
- ✅ Sensitive data redaction in logs
- ✅ Correlation IDs for distributed systems
- ❌ Avoid print() statements
- ❌ Avoid logging sensitive data (PII, secrets)
- ❌ Avoid missing request context

**Used By**: llm-app-engineer, mlops-ai-engineer, ml-system-architect, rag-architect, agent-orchestrator-engineer, security-and-privacy-engineer-ml

### Requirement: monitoring-alerting Skill MUST be created

A skill MUST be created for monitoring and alerting setup.

#### Scenario: Code involves metrics or alerting

**Trigger Keywords**: "monitoring", "metrics", "alerting", "dashboard", "Prometheus", "Grafana"

**Pattern Coverage**:
- ✅ Metric instrumentation
- ✅ Counter, gauge, histogram patterns
- ✅ Alert threshold configuration
- ✅ SLO/SLI definition
- ✅ Dashboard design
- ❌ Avoid over-alerting (alert fatigue)
- ❌ Avoid missing critical metrics
- ❌ Avoid undefined SLOs

**Used By**: mlops-ai-engineer, performance-and-cost-engineer-llm, evaluation-engineer

### Requirement: performance-profiling Skill MUST be created

A skill MUST be created for Python performance profiling and optimization.

#### Scenario: Code involves performance analysis

**Trigger Keywords**: "profiling", "performance", "cProfile", "py-spy", "Scalene", "optimization", "bottleneck"

**Pattern Coverage**:
- ✅ cProfile for CPU profiling
- ✅ Memory profiling with Scalene
- ✅ Async profiling with py-spy
- ✅ Line profiling for hot paths
- ✅ Benchmark setup with pytest-benchmark
- ❌ Avoid premature optimization
- ❌ Avoid profiling without baseline
- ❌ Avoid missing async profiling

**Used By**: performance-engineer, performance-and-cost-engineer-llm, optimize-db-query

## Skill Structure Requirements

### Requirement: Skills MUST Follow Existing Pattern

All 3 skills MUST follow standard skill structure with category: "observability".

## MODIFIED Requirements

None

## REMOVED Requirements

None

## Validation

### Validation Rules

1. **3 skills created**: All exist in `.claude/skills/`
2. **Structure compliance**: Standard pattern
3. **Category**: All have `category: "observability"`

### Test Scenarios

#### Test: Directories exist

**Then** directories:
- `.claude/skills/observability-logging/`
- `.claude/skills/monitoring-alerting/`
- `.claude/skills/performance-profiling/`

## Migration Impact

### New Files

3 new skill directories

### Integration

Critical for production AI/LLM systems:
- observability-logging used by 6+ agents
- monitoring-alerting for MLOps
- performance-profiling for optimization

## Implementation Notes

### Priority

1. **observability-logging** - Most cross-agent usage (CRITICAL)
2. **monitoring-alerting** - MLOps essential
3. **performance-profiling** - Performance optimization

### AI/LLM-Specific Additions

observability-logging should include:
- LLM-specific structured logs (prompt, response, tokens, latency, cost)
- LangSmith/LangFuse integration patterns
- Weights & Biases logging for experiments

## References

- AI/LLM skills: `specs/ai-llm-skills/spec.md`
- Existing skills: `.claude/skills/`
