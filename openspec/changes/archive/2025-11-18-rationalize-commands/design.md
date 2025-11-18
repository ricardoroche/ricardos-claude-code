# Design: Command Rationalization Architecture

## Context

This plugin currently has 9 slash commands competing with 32 agents and 29 skills for user attention. The commands were created before the agent/skill ecosystem matured, resulting in significant overlap and confusion about which interface to use. Additionally, automation hooks (PostToolUse, PreToolUse) now provide automatic invocation of many command operations.

**Key insight**: Commands are best suited for **structured workflow orchestration** with **external CLI tool integration**, not simple tool invocations that can be automated or requested naturally.

## Goals

1. **Minimize command surface area** to only essential workflow orchestration
2. **Eliminate project-specific commands** that assume specific tooling (ruff, pytest)
3. **Reduce redundancy** between commands, agents, skills, and hooks
4. **Preserve unique value** where commands provide orchestration agents can't replicate
5. **Maintain user productivity** through better automation and natural language interface

## Non-Goals

- Not changing the agent or skill ecosystem (32 agents, 29 skills remain)
- Not removing automation hooks (they're working well)
- Not changing the OpenSpec workflow (it's the model for what commands should be)
- Not adding new commands (minimizing, not expanding)

## Architecture Decisions

### Decision 1: Keep Only OpenSpec Commands

**Rationale**: OpenSpec commands (`/openspec:proposal`, `/openspec:apply`, `/openspec:archive`) demonstrate the ideal command pattern:

1. **External CLI orchestration**: They wrap the `openspec` CLI tool with specific flags (`--strict`, `--yes`)
2. **Workflow enforcement**: They enforce a structured lifecycle (create → implement → archive)
3. **Validation and safety**: They validate change IDs, prevent mistakes, run strict validation
4. **Complementary to agents**: The `spec-writer` agent creates proposal content; commands orchestrate the process
5. **Non-project-specific**: They work in any project using OpenSpec

**Alternatives considered**:
- **Keep all commands**: Rejected—too much overlap with agents/skills
- **Remove all commands**: Rejected—OpenSpec workflow orchestration is valuable
- **Keep Python tool commands**: Rejected—they're project-specific and redundant with hooks

**Trade-offs**:
- ✅ Clear command philosophy (workflow orchestration only)
- ✅ Reduces user confusion (fewer commands to learn)
- ✅ Eliminates project-specific assumptions
- ❌ Users must adapt from command-driven to natural language workflows

### Decision 2: Replace Python Tool Commands with Natural Language + Automation

**Rationale**: Commands like `/fix`, `/lint`, `/check`, `/test` provide no unique value:

1. **Already automated**: Hooks auto-format on save, auto-test on test file edits, run quality gates pre-commit
2. **Project-specific**: They assume ruff/mypy/pytest are installed with specific configs
3. **Not composable**: Can't easily modify (e.g., "run only integration tests")
4. **Redundant with natural language**: Claude can run the same commands when asked naturally

**Replacement strategy**:

| Old Command | Replacement |
|-------------|-------------|
| `/fix` | PostToolUse hook auto-formats `.py` files<br>OR natural request: "Fix linting issues" |
| `/lint` | Natural request: "Check for linting errors"<br>OR ask before important changes |
| `/check` | PreToolUse hook runs on `git commit`<br>OR natural request: "Run all quality checks" |
| `/test [path]` | PostToolUse hook auto-runs tests on test file edits<br>OR natural request: "Run tests for auth" |

**Alternatives considered**:
- **Make commands detect available tooling**: Rejected—adds complexity, doesn't solve composability
- **Add tool-agnostic commands**: Rejected—still less flexible than natural language
- **Keep commands alongside automation**: Rejected—confusing to have two ways to do same thing

**Trade-offs**:
- ✅ More flexible (users can compose variations naturally)
- ✅ Tool-agnostic (works with any linter/formatter/test framework)
- ✅ Better automation (hooks reduce manual invocation need)
- ❌ Less predictable for users who prefer explicit commands
- ❌ Breaking change (muscle memory for command users)

### Decision 3: Remove `/new-task` in Favor of Requirements Analyst Agent

**Rationale**: The `/new-task` command is a static template prompt that provides surface-level task analysis. The `requirements-analyst` agent provides:

1. **Contextual analysis**: Reads codebase, understands current architecture
2. **Specialized workflows**: 5 workflows for different analysis needs (requirements discovery, PRD creation, success metrics, stakeholder analysis, feasibility)
3. **Interactive discovery**: Asks follow-up questions, validates assumptions
4. **AI/ML specialization**: Understands data requirements, model constraints, evaluation criteria
5. **Skills integration**: Activates related skills for comprehensive guidance

**Comparison**:

| Aspect | `/new-task` Command | `requirements-analyst` Agent |
|--------|---------------------|------------------------------|
| Depth | Surface-level template | Deep contextual analysis |
| Interaction | One-shot prompt | Interactive discovery |
| Context | None | Reads codebase, specs |
| Specialization | Generic | AI/ML focused |
| Output | Checklist + estimates | PRD, requirements, risks, validation |

**Alternatives considered**:
- **Keep both**: Rejected—redundant and confusing
- **Improve command template**: Rejected—can't match agent's contextual depth
- **Make command invoke agent**: Rejected—unnecessary indirection (just invoke agent directly)

**Trade-offs**:
- ✅ Richer, more contextual analysis
- ✅ Better for complex tasks (AI/ML projects)
- ✅ Interactive (can ask clarifying questions)
- ❌ Users must learn to invoke agent naturally instead of via command

### Decision 4: Remove `/api` in Favor of Implement-Feature Agent + FastAPI Skill

**Rationale**: The `/api` command is a static template for FastAPI endpoints. The combination of `implement-feature` agent + `fastapi-patterns` skill provides:

1. **Complete implementation**: Not just scaffolding, but full endpoint + service layer + tests + docs
2. **Context-aware**: Integrates with existing codebase patterns
3. **Automatic activation**: `fastapi-patterns` skill activates on API code, provides guidance
4. **Best practices**: Enforces async/await, error handling, validation, security
5. **Flexibility**: Can create variations (GraphQL, WebSocket, SSE) not hardcoded in template

**Comparison**:

| Aspect | `/api` Command | `implement-feature` + `fastapi-patterns` |
|--------|----------------|------------------------------------------|
| Output | Template only | Complete feature implementation |
| Context | None | Reads existing code patterns |
| Testing | Not included | Full pytest suite |
| Customization | Static template | Adapts to requirements |
| Activation | Manual command | Automatic (skill triggers) |

**Alternatives considered**:
- **Improve template**: Rejected—still static, can't match agent's flexibility
- **Add more templates**: Rejected—proliferates commands for each variation
- **Make command invoke agent**: Rejected—just ask for feature naturally

**Trade-offs**:
- ✅ Complete feature implementation (not just template)
- ✅ Context-aware (matches existing patterns)
- ✅ More flexible (can handle variations)
- ❌ Slightly higher cognitive load (describe what you want vs. fill template)

## Implementation Plan

### Phase 1: Remove Redundant Commands
1. Delete 6 Python tool command files
2. Update README to remove command references
3. Add "Before/After" migration guide
4. Update CLAUDE.md examples to show natural language patterns

### Phase 2: Update Documentation
1. Emphasize agent/skill ecosystem as primary interface
2. Document natural language patterns for common operations
3. Update plugin.json metadata (command count)
4. Create migration guide for existing users

### Phase 3: Validation
1. Test natural language equivalents in real Python project
2. Verify automation hooks work as expected
3. Verify OpenSpec commands still function
4. Run `openspec validate rationalize-commands --strict`

## Migration Strategy

### User Communication

**Announcement**: "We're streamlining the plugin to focus on agents, skills, and automation. 6 commands are being removed in favor of natural language requests and better automation."

**Migration guide** (in README):

```markdown
## Migrating from Commands to Natural Language

### Task Analysis
- **Before**: `/new-task "Add authentication"`
- **After**: "Help me analyze this task: Add authentication"
- **Why**: The `requirements-analyst` agent provides deeper, contextual analysis

### API Creation
- **Before**: `/api` → fill template
- **After**: "Create a FastAPI endpoint for user login with JWT"
- **Why**: The `implement-feature` agent creates complete features, not just templates

### Linting & Formatting
- **Before**: `/fix`
- **After**: Auto-formatting on save (PostToolUse hook) OR "Fix linting issues"
- **Why**: Automation handles most cases; natural language handles exceptions

### Running Tests
- **Before**: `/test tests/test_auth.py`
- **After**: Auto-runs on test file save (PostToolUse hook) OR "Run the auth tests"
- **Why**: Automation reduces manual invocation need

### Quality Checks
- **Before**: `/check`
- **After**: Auto-runs on commit (PreToolUse hook) OR "Run all quality checks"
- **Why**: Pre-commit gate catches issues automatically

### OpenSpec (Unchanged)
- **Before**: `/openspec:proposal`, `/openspec:apply`, `/openspec:archive`
- **After**: Same (these provide unique workflow orchestration)
```

### Rollout Plan

1. **Release**: Merge rationalization change to main
2. **Update marketplace**: New version with updated command list
3. **Announce**: Publish blog post or changelog explaining changes
4. **Support**: Monitor issues for users needing help with transition

### Rollback Plan

If migration causes major issues:
1. Revert the commit removing commands
2. Mark commands as deprecated in next release
3. Provide longer transition period
4. Gather user feedback on pain points

## Monitoring & Success Metrics

### Success Criteria

**Quantitative**:
- Plugin installation/usage doesn't decline post-change
- Support requests related to missing commands are minimal (<5% of issues)
- Natural language usage increases (measured via telemetry if available)

**Qualitative**:
- User feedback indicates clearer mental model
- New users report easier onboarding (fewer commands to learn)
- Advanced users report greater flexibility with natural language

### Monitoring

- Track GitHub issues for migration problems
- Monitor plugin marketplace ratings/reviews
- Collect user feedback via discussions or surveys

## Risks & Mitigations

### Risk: User pushback from command removal

**Likelihood**: Medium
**Impact**: Medium
**Mitigation**:
- Clear migration guide with examples
- Emphasize improved automation as benefit
- Highlight agent/skill richness as upgrade

### Risk: Natural language less consistent than commands

**Likelihood**: Low
**Impact**: Low
**Mitigation**:
- Skills provide consistent guidance
- Agents have clear triggers and patterns
- Users can use explicit tool syntax if needed ("run `pytest -v`")

### Risk: Plugin perceived as "less featured"

**Likelihood**: Low
**Impact**: Low
**Mitigation**:
- Emphasize 32 agents + 29 skills as feature set
- Position automation hooks as advanced capability
- OpenSpec commands demonstrate thoughtfulness

## Future Considerations

### When to Add New Commands

Only add commands that meet **all** criteria:
1. **External CLI orchestration**: Wraps a CLI tool with specific workflow
2. **Complex workflow**: Multi-step process with validation/safety checks
3. **Not project-specific**: Works across different projects
4. **Complements agents**: Provides orchestration agents can't replicate
5. **Non-automatable**: Can't be handled by hooks or natural language

**Examples that would qualify**:
- `/deploy:preview` - Orchestrates multi-step preview deployment with validation
- `/migration:plan` - Analyzes schema changes and plans database migration
- `/security:audit` - Runs security checks with specific tool integrations

**Examples that would NOT qualify**:
- `/format` - Already automated (PostToolUse hook)
- `/build` - Simple tool invocation (natural language handles it)
- `/docker:run` - Project-specific configuration

### Integration with Future Features

**If plugin gains telemetry**:
- Monitor which natural language patterns users adopt
- Identify common requests that could benefit from specialized agents
- Measure impact of command removal on user engagement

**If Claude Code adds command discoverability**:
- Focus on making OpenSpec commands highly discoverable
- Ensure command descriptions clearly communicate their unique value
- Consider adding interactive command picker for OpenSpec workflow

**If automation hooks gain more capabilities**:
- Explore replacing more manual operations with hooks
- Consider pre-PR hooks (lint + test before creating PR)
- Add conditional hooks (run full tests only on main branch)
