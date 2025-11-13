# Agent Delegation Patterns

Sub-agent delegation is a powerful workflow pattern where agents hand off work to other specialized agents. This enables complex, multi-step workflows where each agent focuses on its area of expertise.

## When to Delegate

Recognize these patterns that indicate delegation is beneficial:

**Skill Boundaries:**
- Current agent reaches the edge of its expertise
- Task requires specialized knowledge another agent has
- Multiple distinct skill sets needed for complete solution

**Sequential Dependencies:**
- One task must complete before another can start
- Output from one step becomes input for the next
- Progressive refinement needed (implement → review → fix → test)

**Quality Assurance:**
- Implementation complete, needs peer review
- Code works but needs optimization
- Feature complete, needs documentation

**Scale and Complexity:**
- Task is too large for single agent
- Multiple components need parallel development
- Breaking down into manageable chunks improves quality

**Red Flags for Delegation:**
- When you see "now that X is done, we need Y"
- When different expertise domains are required
- When peer review would catch issues
- When specialized tools/knowledge are needed

## How to Delegate

**Step 1: Complete Your Work**
Before delegating, finish your current task completely:
- Implementation is functional (not half-done)
- Code compiles/runs without errors
- Basic validation complete
- Files are saved and committed if appropriate

**Step 2: Prepare Handoff Context**
Document what the next agent needs:
- What you accomplished
- What remains to be done
- Relevant file paths
- Important context or constraints
- Expected outcomes

**Step 3: Explicit Delegation**
Clearly communicate the handoff:
```
"Task completed: User authentication API implemented in src/api/v1/routes/auth.py

Delegation: Please delegate to write-unit-tests to create comprehensive test coverage for:
- Login endpoint (POST /api/v1/login)
- Logout endpoint (POST /api/v1/logout)
- Token refresh endpoint (POST /api/v1/refresh)

Test should cover:
- Success scenarios
- Invalid credentials
- Expired tokens
- Rate limiting
"
```

**Step 4: Monitor Handoff**
Ensure delegation succeeds:
- Verify next agent activates
- Confirm they have necessary context
- Be available for questions

## Delegation Examples

### 1. implement-feature → write-unit-tests

**When:** After implementing new functionality that needs test coverage

**Handoff Context:**
- Implementation file paths
- Models and service classes
- External dependencies to mock
- Business rules to test

### 2. code-reviewer → fix-pr-comments

**When:** Code review identifies issues that need systematic addressing

**Handoff Context:**
- Specific issues found with line numbers
- Priority ordering
- Files that need changes
- Validation rules to implement

### 3. debug-test-failure → optimize-db-query

**When:** Test failures reveal performance issues rather than logic bugs

**Handoff Context:**
- Performance bottleneck location
- Query patterns causing issues
- Expected performance target
- Test requirements

### 4. implement-feature → add-agent-tool

**When:** Feature implementation requires new AI agent capabilities

**Handoff Context:**
- Agent location and setup
- Tool specifications
- Data access patterns
- Security requirements

### 5. upgrade-dependency → debug-test-failure

**When:** Dependency upgrades break tests

**Handoff Context:**
- What was upgraded
- Breaking changes applied
- Test failure details
- Migration guide reference

## Handoff Context Template

Use this template for clear delegations:

```
=== DELEGATION HANDOFF ===

FROM: [Current Agent]
TO: [Target Agent]

COMPLETED:
- [What was accomplished]
- [Files modified/created]
- [Key decisions made]

REMAINING WORK:
- [Specific tasks for next agent]
- [Expected outcomes]
- [Success criteria]

CONTEXT:
- [Relevant files: with absolute paths]
- [Important constraints]
- [Business rules]
- [Testing requirements]

PRIORITY:
- [Critical items first]
- [Nice-to-haves last]

NOTES:
- [Anything else next agent should know]
- [Potential gotchas]
- [Questions to consider]
```

## Sequential Delegation Chains

Multiple agents working in sequence to complete complex workflows.

### Example: End-to-End Feature Development

```
User: "Build complete user profile system"

Chain:
1. implement-feature
   → Creates user profile API, models, service layer
   → Output: Working API endpoints

2. write-unit-tests
   → Creates comprehensive test suite
   → Output: 85%+ test coverage

3. code-reviewer
   → Reviews implementation and tests
   → Output: List of issues and improvements

4. fix-pr-comments
   → Addresses all review feedback
   → Output: Improved code passing review

5. technical-writer
   → Documents API and usage
   → Output: User guide and API docs

6. upgrade-dependency (if needed)
   → Ensures all dependencies current
   → Output: Updated, secure dependencies
```

## Peer Review Patterns

### Pattern 1: Implementation Review

```
1. implement-feature: Builds feature
2. code-reviewer: Reviews implementation
   - Finds issues
   - Suggests improvements
   - Validates patterns
3. implement-feature: Addresses feedback
4. code-reviewer: Confirms fixes
5. Ready for merge
```

### Pattern 2: Test-Driven Review

```
1. write-unit-tests: Writes tests first (TDD)
2. code-reviewer: Reviews test coverage
   - Are all scenarios covered?
   - Are tests well-structured?
3. implement-feature: Implements to pass tests
4. code-reviewer: Final review
5. Ready for merge
```

## Delegation Anti-Patterns

**Don't:**

1. **Delegate Incomplete Work**
   - Bad: "I started implementing X, now delegate to complete it"
   - Good: "Implementation complete, delegate for testing"

2. **Delegate Without Context**
   - Bad: "Fix the tests" (which tests? what's broken?)
   - Good: "12 tests failing in test_payment.py after Pydantic upgrade, see errors..."

3. **Circular Delegation**
   - Bad: A → B → A → B (infinite loop)
   - Good: A → B → C (forward progress)

4. **Over-Delegation**
   - Bad: Delegate every tiny subtask
   - Good: Delegate meaningful chunks

5. **Delegation for Avoidance**
   - Bad: Hit a hard problem, delegate to avoid
   - Good: Complete your expertise domain, then delegate

## Delegation Best Practices

1. **Clear Boundaries**: Know when your expertise ends
2. **Complete Your Work**: Finish your piece before delegating
3. **Rich Context**: Provide everything next agent needs
4. **Explicit Handoff**: Make delegation clear and intentional
5. **Sequential Not Parallel**: One agent at a time (usually)
6. **Measure Progress**: Each delegation should move forward
7. **Document Chain**: Track who did what
8. **Learn and Adapt**: Improve delegation patterns over time
