# observability-skills Specification

## Purpose
TBD - created by archiving change agent-system-restructure. Update Purpose after archive.
## Requirements
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

