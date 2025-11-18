# Spec: Agent Migration Strategy

**Capability**: agent-migration-strategy
**Status**: Draft
**Related**: hybrid-agent-pattern

## Overview

This spec defines requirements for migrating 10 existing task-oriented agents to the hybrid (role + workflows) pattern while maintaining backward compatibility.

## ADDED Requirements

### Requirement: Preserve Agent Names and Activation

Existing agent names and activation keywords MUST remain unchanged to maintain backward compatibility.

#### Scenario: Existing agent is migrated

**Given** an existing task-oriented agent is being migrated
**When** the agent is converted to hybrid pattern
**Then** the frontmatter `name` field MUST remain identical
**And** activation `description` MUST preserve key triggering phrases
**And** existing user workflows MUST continue to activate the agent

**Example**:
```yaml
# Before
---
name: write-unit-tests
description: Use when writing pytest unit tests...
---

# After (MUST preserve name)
---
name: write-unit-tests
description: Use when writing pytest unit tests for new or existing Python code
category: implementation
pattern_version: "1.0"
---
```

### Requirement: Convert Instructions to Role & Workflows

Existing prescriptive instructions MUST be reorganized into Role & Mindset + Specialized Workflows structure.

#### Scenario: Task agent converted to hybrid pattern

**Given** an existing agent has prescriptive "Your Task" section with steps
**When** the agent is migrated
**Then** prescriptive steps MUST be converted to:
1. **Role & Mindset** section capturing the agent's thinking approach
2. **Specialized Workflows** section with 3-5 distinct task workflows
3. Each workflow with "When to use", "Steps", and "Skills Invoked"

**Example**:
```markdown
# Before (Task-Oriented)
You are a specialist in writing pytest unit tests.

## Your Task
When the user asks you to write tests, you will:
### 1. Analyze Code
- Read the code to test
- Identify test cases
### 2. Write Tests
- Create test file
- Write test functions

# After (Hybrid)
## Role & Mindset
I am a pytest specialist focused on comprehensive test coverage and maintainability. I believe tests are documentation and should clearly express intent.

## Specialized Workflows

### Workflow: Write Unit Tests for New Code
**When to use**: Testing newly written Python code
**Steps**:
1. **Analyze code structure**: Read module, identify functions/classes to test
2. **Design test cases**: List happy paths, edge cases, error conditions
3. **Create test file**: Generate test_*.py with fixtures
4. **Write test functions**: Implement with pytest, parametrize, mocking
**Skills Invoked**: `pytest-patterns`, `type-safety`, `async-await-checker`

### Workflow: Add Tests to Existing Code
**When to use**: Improving coverage for legacy code
**Steps**: [Similar structure]
```

### Requirement: Extract Best Practices to Dedicated Section

Best practices scattered throughout instructions MUST be consolidated into dedicated Best Practices section.

#### Scenario: Agent has embedded guidance

**Given** an existing agent has best practices mixed with instructions
**When** the agent is migrated
**Then** all best practices MUST be extracted to a dedicated section
**And** formatted as checklist with ✅ and ❌ prefixes

**Example**:
```markdown
# Before (Scattered)
### 2. Write Tests
Use fixtures for setup. Avoid test interdependence. Always use parametrize for multiple cases.

# After (Consolidated)
## Best Practices
- ✅ Use fixtures for test setup and teardown
- ✅ Use parametrize for testing multiple input cases
- ✅ Write descriptive test names that express intent
- ❌ Avoid test interdependence (tests should run independently)
- ❌ Avoid asserting multiple unrelated things in one test
```

### Requirement: Add Boundaries Section

Migrated agents MUST define clear scope boundaries that weren't explicit before.

#### Scenario: Agent scope clarified

**Given** an existing agent is being migrated
**When** Boundaries section is added
**Then** it MUST clarify:
- What the agent WILL do (core responsibilities)
- What the agent WILL NOT do (out of scope, with references to other agents)

**Example**:
```markdown
## Boundaries

**Will:**
- Write comprehensive pytest unit tests
- Create fixtures and parametrized tests
- Mock external dependencies
- Test async functions with pytest-asyncio

**Will Not:**
- Debug failing tests (see debug-test-failure)
- Implement the code being tested (see implement-feature)
- Write integration or E2E tests (different scope)
- Fix PR review feedback (see fix-pr-comments)
```

### Requirement: Make Skill References Explicit

Implicit skill usage MUST be made explicit in Skills Integration section.

#### Scenario: Agent mentions patterns without skill references

**Given** an existing agent mentions patterns like "use pytest fixtures" or "add type hints"
**When** the agent is migrated
**Then** Skills Integration section MUST explicitly list skills:
- Skills naturally invoked by the agent's workflows
- How each skill supports the agent

**Example**:
```markdown
# Before (Implicit)
Write tests with fixtures, parametrize, and type hints. Use async for async code.

# After (Explicit)
## Skills Integration

**Primary Skills**:
- `pytest-patterns` - Guides fixture usage, parametrize, test structure
- `type-safety` - Ensures test functions have proper type hints
- `async-await-checker` - Verifies proper async test patterns

**Secondary Skills**:
- `pydantic-models` - When testing Pydantic validation
- `fastapi-patterns` - When testing FastAPI endpoints
```

### Requirement: Preserve Code Examples

Valuable code examples from existing agents MUST be preserved in workflows.

#### Scenario: Agent has detailed code examples

**Given** an existing agent contains helpful code examples
**When** the agent is migrated
**Then** code examples MUST be retained in appropriate workflow steps
**And** examples SHOULD be enhanced with skill trigger keywords

**Example**:
```markdown
# Before
### 2. Write Test Function
```python
def test_calculate_total():
    result = calculate_total([1, 2, 3])
    assert result == 6
```

# After
2. **Write test function with pytest patterns**
   ```python
   def test_calculate_total() -> None:  # type hint triggers type-safety skill
       """Test calculate_total with valid input."""  # docstring-format skill
       result: int = calculate_total([1, 2, 3])
       assert result == 6
   ```
   Use descriptive names and type hints for clarity.
```

## Agent-Specific Migration Requirements

### Requirement: write-unit-tests Migration

#### Scenario: write-unit-tests agent migrated

**Then** workflows MUST include:
- Workflow 1: Write tests for new code
- Workflow 2: Add tests to existing code
- Workflow 3: Write async tests
- Workflow 4: Write tests with mocking

**And** preserve:
- Pytest fixture patterns
- Parametrize examples
- Async test examples
- Mocking patterns

### Requirement: implement-feature Migration

#### Scenario: implement-feature agent migrated

**Then** workflows MUST include:
- Workflow 1: Implement new FastAPI endpoint
- Workflow 2: Add business logic with validation
- Workflow 3: Integrate with database
- Workflow 4: Complete feature with tests and docs

**And** preserve:
- FastAPI endpoint templates
- Pydantic model patterns
- Database integration examples
- Testing approach

### Requirement: debug-test-failure Migration

#### Scenario: debug-test-failure agent migrated

**Then** workflows MUST include:
- Workflow 1: Investigate pytest failure
- Workflow 2: Debug async test issues
- Workflow 3: Fix fixture-related failures
- Workflow 4: Resolve mock/patch problems

**And** preserve:
- Debugging methodology
- Common failure patterns
- Fix strategies

### Requirement: code-reviewer Migration

#### Scenario: code-reviewer agent migrated

**Then** workflows MUST include:
- Workflow 1: General Python code review
- Workflow 2: Security-focused review
- Workflow 3: Performance-focused review
- Workflow 4: Type safety and validation review

**And** preserve:
- Review checklist items
- Common issues to flag
- Security patterns

### Requirement: Other Agents Migration

For remaining agents, extract natural workflows from existing linear instructions:

| Agent | Key Workflows to Extract |
|-------|-------------------------|
| **add-agent-tool** | Design tool schema, Implement function, Add tests, Document |
| **upgrade-dependency** | Check compatibility, Update pyproject.toml, Run tests, Handle breaking changes |
| **optimize-db-query** | Profile query, Analyze EXPLAIN, Add indexes, Rewrite query |
| **fix-pr-comments** | Review feedback, Implement changes, Run checks, Verify fixes |
| **deep-research-agent** | Plan research, Execute search, Synthesize findings, Present results |
| **technical-writer** | Analyze audience, Structure content, Write docs, Review and refine |

## MODIFIED Requirements

None (this is additive migration, not modification)

## REMOVED Requirements

None (preserves all existing functionality)

## Validation

### Validation Rules

1. **Name preservation**: Agent name unchanged
2. **Activation preservation**: Key trigger phrases remain in description
3. **Content coverage**: All original content reorganized, not lost
4. **Example preservation**: Code examples retained
5. **Pattern compliance**: Follows hybrid-agent-pattern spec
6. **Skill references**: All referenced skills exist

### Test Scenarios

#### Test: Backward compatibility preserved

**Given** write-unit-tests agent before and after migration
**When** user prompt triggers "write unit tests for my function"
**Then** agent activates in both old and new versions
**And** produces comparable output

#### Test: No content loss

**Given** existing agent has 15 code examples
**When** agent is migrated to hybrid pattern
**Then** all 15 examples appear in workflows
**And** no guidance is lost

#### Test: Skill integration correct

**Given** migrated agent mentions "pytest fixtures"
**When** Skills Integration section is checked
**Then** `pytest-patterns` skill is listed

## Migration Impact

### Affected Files

10 existing agent files in `.claude/agents/`:
1. `write-unit-tests.md`
2. `debug-test-failure.md`
3. `implement-feature.md`
4. `code-reviewer.md`
5. `add-agent-tool.md`
6. `upgrade-dependency.md`
7. `optimize-db-query.md`
8. `fix-pr-comments.md`
9. `deep-research-agent.md`
10. `technical-writer.md`

### Migration Order

**Phase 1** (Proof of concept):
1. code-reviewer (well-structured, good model)
2. write-unit-tests (most used, good test case)

**Phase 2** (Core workflow agents):
3. implement-feature (complex, many workflows)
4. debug-test-failure (systematic approach)
5. fix-pr-comments (PR workflow)

**Phase 3** (Specialized agents):
6. add-agent-tool (specific task)
7. upgrade-dependency (specific task)
8. optimize-db-query (specific task)

**Phase 4** (Research/communication):
9. deep-research-agent (already well-structured)
10. technical-writer (documentation focused)

### Backward Compatibility

- ✅ Agent names unchanged
- ✅ Activation patterns preserved
- ✅ Output quality maintained or improved
- ✅ All examples and guidance retained
- ✅ Skill integration additive (not breaking)

## Implementation Notes

### Migration Process

For each agent:

1. **Read existing agent** fully
2. **Extract role/mindset** from introduction
3. **Identify natural workflows** (3-5 distinct tasks)
4. **Reorganize steps** into workflow structure
5. **Consolidate best practices** into dedicated section
6. **Add boundaries** (Will/Will Not)
7. **List skill integration** (make implicit explicit)
8. **Preserve all examples** in appropriate workflows
9. **Add Related Agents** section
10. **Validate** against hybrid-agent-pattern spec

### Quality Checklist

Before completing migration:
- [ ] All original content accounted for
- [ ] Code examples preserved with enhancements
- [ ] Skill references made explicit
- [ ] Boundaries clearly defined
- [ ] Related agents listed
- [ ] Passes hybrid-agent-pattern validation
- [ ] Activation testing confirms backward compatibility

## References

- Existing agents: `.claude/agents/` (tracked files)
- Hybrid pattern: `specs/hybrid-agent-pattern/spec.md`
- Design doc: `design.md`
