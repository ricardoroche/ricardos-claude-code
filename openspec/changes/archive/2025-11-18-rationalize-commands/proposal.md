# Change: Rationalize Slash Commands

## Executive Summary

Remove 8 of 9 slash commands in favor of agents, skills, and automation hooks. Keep only the OpenSpec workflow commands as they provide unique CLI orchestration value. All other commands are redundant, project-specific, or better served by direct user requests to Claude.

**Breaking Change:** Users must adapt from command-driven workflows (`/fix`, `/test`) to natural language requests ("fix linting", "run tests") or rely on existing automation hooks.

## Why

The current plugin has **9 slash commands** that overlap significantly with the **32 agents** and **29 skills** ecosystem:

1. **Commands duplicate agent capabilities**: `/new-task` overlaps with `requirements-analyst` and `ai-product-analyst` agents
2. **Commands duplicate skill capabilities**: `/api` is just a template that `fastapi-patterns` skill + `implement-feature` agent already handle better
3. **Commands assume project-specific tooling**: `/fix`, `/lint`, `/check`, `/test` all assume ruff/mypy/pytest are installed and configured—they fail in non-Python projects or projects using different tools
4. **Commands are better served by automation**: The `.claude/settings.json` hooks already auto-format on file write, auto-run tests on test file edits, and run quality gates pre-commit
5. **Commands don't compose well**: Users must remember specific command names instead of asking Claude naturally ("run the tests", "fix linting issues")
6. **Commands clutter the interface**: 9 commands dilute discoverability compared to 3-5 essential ones

The **OpenSpec commands** (`/openspec:proposal`, `/openspec:apply`, `/openspec:archive`) are the exception—they provide unique orchestration of the `openspec` CLI tool with guardrails, validation, and structured workflows that aren't easily replicated by natural language requests alone.

## What Changes

### Commands to Remove (6)

**Python Tool Commands:**
1. **`/new-task`** - Overlaps with `requirements-analyst` agent (systematic requirement analysis) and `ai-product-analyst` agent (task breakdown)
   - Users can simply ask: "Help me analyze this task and create an implementation plan"
   - The `requirements-analyst` agent provides deeper, more contextual analysis than a static command prompt

2. **`/api`** - Template-based command that's redundant with skills and agents
   - `fastapi-patterns` skill already activates when writing API code
   - `implement-feature` agent handles complete API endpoint creation with tests, validation, docs
   - Users can ask: "Create a FastAPI endpoint for..." and get better, context-aware results

3. **`/fix`** - Runs `ruff check --fix`, `ruff format`, `mypy`
   - **Already automated** via `.claude/settings.json` PostToolUse hook on `*.py` file writes/edits
   - Users can ask: "Fix the linting issues" and Claude will run the same commands
   - Project-specific (assumes ruff/mypy installed)

4. **`/lint`** - Runs `ruff check`, `mypy` (report-only)
   - Users can ask: "Check for linting issues" or "What are the type errors?"
   - Claude knows to run linting tools from context and skills
   - No unique value over natural language request

5. **`/check`** - Runs full quality gate (lint + type check + tests + coverage)
   - **Already automated** via `.claude/settings.json` PreToolUse hook on `git commit`
   - Users can ask: "Run all quality checks" or "Is the code ready to commit?"
   - Redundant with pre-commit hook automation

6. **`/test [path]`** - Runs pytest with coverage
   - **Already automated** via `.claude/settings.json` PostToolUse hook on test file writes/edits
   - Users can ask: "Run the tests" or "Run tests for auth module"
   - Claude can compose pytest commands based on user intent

### Commands to Keep (3)

**OpenSpec Workflow Commands:**
1. **`/openspec:proposal`** - Scaffold new OpenSpec change with validation
   - **Unique value**: Enforces structured proposal format, runs `openspec validate --strict`, provides guardrails
   - **CLI orchestration**: Coordinates multiple steps (scaffold + context reading + validation)
   - **Not easily replaced**: Natural language requests lack the structured workflow enforcement

2. **`/openspec:apply`** - Implement approved OpenSpec change with task tracking
   - **Unique value**: Enforces sequential task completion, syncs tasks.md checkboxes
   - **Workflow discipline**: Prevents skipping steps or losing track of progress
   - **Complements spec-writer agent**: Agent writes proposals, command applies them

3. **`/openspec:archive`** - Archive deployed change and update specs
   - **Unique value**: Runs `openspec archive <id> --yes` with proper ID validation
   - **Safety**: Prevents accidental archiving of wrong changes
   - **CLI integration**: Direct integration with openspec CLI tool

### Rationale for Keeping OpenSpec Commands

The OpenSpec commands provide **unique orchestration value** that agents alone don't provide:
- They enforce **structured workflows** (proposal → apply → archive lifecycle)
- They integrate with the **`openspec` CLI tool** in a way that requires specific flag combinations and validation
- They provide **guardrails** against common mistakes (archiving wrong change, skipping validation)
- They **complement the `spec-writer` agent** rather than duplicate it (agent creates content, commands orchestrate process)

## What's Not Changing

### Keeping Automation Hooks
All `.claude/settings.json` hooks remain:
- **PostToolUse on `*.py` writes/edits**: Auto-format with ruff
- **PostToolUse on test file writes/edits**: Auto-run relevant tests
- **PreToolUse on `git commit`**: Run full quality gate (lint + type + test)
- These hooks provide better UX than commands (automatic, context-aware)

### Keeping Agents & Skills
All 32 agents and 29 skills remain unchanged:
- `requirements-analyst` - Replaces `/new-task` functionality
- `implement-feature` - Replaces `/api` functionality (with more depth)
- `fastapi-patterns`, `pytest-patterns`, `type-safety` skills - Guide all code generation
- Agents provide richer, more contextual assistance than rigid commands

### Keeping Natural Language Interface
Users can still request command-like operations naturally:
- "Fix linting issues" → Claude runs `ruff check --fix`
- "Run the tests" → Claude runs `pytest`
- "Check types" → Claude runs `mypy`
- "Create a FastAPI endpoint for user registration" → `implement-feature` agent activates

## Impact

### Affected Components

**Removed Files:**
- `.claude/commands/new-task.md`
- `.claude/commands/fix.md`
- `.claude/commands/api.md`
- `.claude/commands/lint.md`
- `.claude/commands/check.md`
- `.claude/commands/test.md`

**Kept Files:**
- `.claude/commands/openspec/proposal.md`
- `.claude/commands/openspec/apply.md`
- `.claude/commands/openspec/archive.md`

**Affected Documentation:**
- `README.md` - Remove references to deleted commands
- `CLAUDE.md` - Update examples to show natural language requests
- `.claude-plugin/plugin.json` - Update command count metadata (if present)

### Migration Path for Users

**Before (Command-driven):**
```bash
/new-task "Add user authentication"
/api "Create login endpoint"
/fix
/test
/check
```

**After (Natural language + automation):**
```
"Help me analyze this task: Add user authentication"
"Create a FastAPI endpoint for user login with JWT tokens"
# [Code is auto-formatted on save via PostToolUse hook]
# [Tests auto-run when test files are saved]
"Run all quality checks" # Or just commit and pre-commit hook runs automatically
```

**For OpenSpec (unchanged):**
```bash
/openspec:proposal
/openspec:apply
/openspec:archive
```

### User Benefits

**Simpler mental model:**
- 3 commands to learn (OpenSpec workflow) instead of 9
- Natural language for everything else
- Less context switching between commands and conversation

**Better automation:**
- Hooks run automatically, no need to remember `/fix` before committing
- Tests run automatically when test files change
- Pre-commit gate catches issues before they reach git history

**More flexible:**
- Can ask for variations: "Run only the auth tests", "Check linting but skip types", "Format this file"
- Claude adapts to project context (detects which tools are available)
- Works in projects with different tooling (not hardcoded to ruff/pytest)

### Breaking Changes

**Users must adapt:**
1. Replace `/new-task` → Ask requirements-analyst naturally
2. Replace `/api` → Ask for endpoint creation naturally
3. Replace `/fix` → Ask to fix issues or rely on auto-format hook
4. Replace `/lint` → Ask to check linting
5. Replace `/check` → Ask to run quality checks or commit (pre-commit hook)
6. Replace `/test` → Ask to run tests or edit test file (auto-run hook)

**Migration is low-friction** because:
- Natural language is more intuitive than memorizing commands
- Automation hooks reduce need for manual commands
- OpenSpec commands (the most complex) are preserved

## Risks & Mitigations

### Risk: Users lose command muscle memory
**Mitigation**:
- Update README with "before/after" examples
- Document natural language patterns clearly
- Automation hooks reduce need for manual invocation

### Risk: Natural language is less predictable than commands
**Mitigation**:
- Skills guide Claude's behavior consistently
- Agents activate on clear triggers
- Users can still use explicit tool invocations ("run `pytest --cov`") if needed

### Risk: Plugin feels less "featured"
**Mitigation**:
- Emphasize 32 agents + 29 skills as the real feature set
- Position automation hooks as advanced capability
- OpenSpec commands show polish and thought leadership

## Validation

### Before Merging
- [ ] All command files removed from `.claude/commands/` (except openspec/)
- [ ] README updated with new usage patterns
- [ ] CLAUDE.md examples updated to natural language
- [ ] plugin.json metadata updated (if command count is tracked)
- [ ] Validate with `openspec validate rationalize-commands --strict`

### After Merging
- [ ] Test natural language equivalents in real Python project
- [ ] Verify automation hooks still work
- [ ] Verify OpenSpec commands still work
- [ ] Update plugin marketplace listing

## Open Questions

None. This proposal is decisive and opinionated by design.

## Decision Rationale

**Why keep OpenSpec commands but remove others?**

OpenSpec commands provide **unique orchestration value**:
1. They enforce **structured workflows** (proposal format, validation steps)
2. They integrate with **external CLI tool** (`openspec`) with specific flags
3. They provide **guardrails** (validate IDs, prevent wrong archives)
4. They **complement agents** (spec-writer writes proposals, commands orchestrate lifecycle)

Python tool commands (`/fix`, `/test`, etc.) provide **no unique value**:
1. They're **project-specific** (assume ruff/pytest installed)
2. They're **already automated** (hooks handle most cases)
3. They're **duplicative** (skills/agents provide same guidance)
4. They're **less flexible** than natural language (can't compose variations)

**Philosophy**: Commands should orchestrate **complex workflows** that require **specific sequencing** and **CLI tool integration**. Simple tool invocations belong in natural language requests or automation hooks.
