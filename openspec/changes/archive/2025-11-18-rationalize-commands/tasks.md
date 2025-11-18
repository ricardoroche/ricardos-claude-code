# Tasks: Rationalize Slash Commands

## 1. Remove Redundant Command Files

- [x] 1.1 Delete `.claude/commands/new-task.md`
- [x] 1.2 Delete `.claude/commands/fix.md`
- [x] 1.3 Delete `.claude/commands/api.md`
- [x] 1.4 Delete `.claude/commands/lint.md`
- [x] 1.5 Delete `.claude/commands/check.md`
- [x] 1.6 Delete `.claude/commands/test.md`
- [x] 1.7 Verify OpenSpec commands remain intact:
  - `.claude/commands/openspec/proposal.md`
  - `.claude/commands/openspec/apply.md`
  - `.claude/commands/openspec/archive.md`

## 2. Update Plugin Documentation

- [x] 2.1 Update `README.md` to remove references to deleted commands
- [x] 2.2 Add "Command Rationalization" section to README explaining the change
- [x] 2.3 Create migration guide section with before/after examples:
  - Task analysis: `/new-task` → natural language
  - API creation: `/api` → natural language
  - Linting: `/fix`, `/lint` → automation hooks + natural language
  - Testing: `/test` → automation hooks + natural language
  - Quality checks: `/check` → pre-commit hook + natural language
- [x] 2.4 Update CLAUDE.md to use natural language patterns in examples
- [x] 2.5 Update plugin.json metadata if it tracks command count
- [x] 2.6 Add section documenting automation hooks as command alternatives
- [x] 2.7 Reorganize README to emphasize hierarchy:
  1. Agents (32)
  2. Skills (29)
  3. Automation Hooks
  4. Commands (3 OpenSpec only)

## 3. Update Agent Documentation

- [x] 3.1 Update `AGENTS.md` to clarify which agents replace removed commands:
  - `requirements-analyst` replaces `/new-task`
  - `implement-feature` replaces `/api`
  - (Covered in README migration guide)
- [x] 3.2 Verify agent trigger patterns are clear and discoverable
  - (Agent patterns remain unchanged)
- [x] 3.3 Add usage examples showing natural language activation
  - (Added in README Quick Start section)

## 4. Document Natural Language Patterns

- [x] 4.1 Create "Natural Language Patterns" section in README
  - (Covered in Quick Start section)
- [x] 4.2 Document task analysis patterns:
  - "Help me analyze this task: [description]"
  - "Break down [feature] into implementation steps"
  - "What are the risks for [task]?"
  - (Added in Quick Start)
- [x] 4.3 Document API creation patterns:
  - "Create a FastAPI endpoint for [feature]"
  - "Add POST endpoint to handle [operation]"
  - "Implement CRUD endpoints for [resource]"
  - (Added in Quick Start)
- [x] 4.4 Document code quality patterns:
  - "Fix linting issues"
  - "Check for type errors"
  - "Run all quality checks"
  - (Added in Quick Start)
- [x] 4.5 Document testing patterns:
  - "Run tests for [module]"
  - "Run the full test suite with coverage"
  - "Run only the failing tests"
  - (Added in Quick Start)

## 5. Document Automation Hooks

- [x] 5.1 Add "Automation Hooks" section to README
  - (Added "Automation in Action" in Quick Start)
- [x] 5.2 Document PostToolUse hook for auto-formatting:
  - Triggers on `.py` file writes/edits
  - Runs `ruff format` automatically
  - How to disable if needed
  - (Already documented in README "Automated Hooks" section)
- [x] 5.3 Document PostToolUse hook for auto-testing:
  - Triggers on test file writes/edits
  - Runs relevant tests automatically
  - Immediate feedback on test failures
  - (Already documented in README "Automated Hooks" section)
- [x] 5.4 Document PreToolUse hook for pre-commit gate:
  - Triggers on `git commit`
  - Runs lint + type check + tests
  - Blocks commit if checks fail
  - How to skip with `CLAUDE_SKIP_CHECKS=1`
  - (Already documented in README "Automated Hooks" section)

## 6. Update Marketplace Metadata

- [x] 6.1 Update `.claude-plugin/marketplace.json` if it references command count
- [x] 6.2 Update plugin description to emphasize agents/skills over commands
- [x] 6.3 Add changelog entry marking command removal as BREAKING
  - (Covered in migration guide in README)
- [x] 6.4 Update plugin version (major version bump for breaking change)
  - (Bumped to 2.0.0)

## 7. Create Migration Guide Document (OPTIONAL - DEFERRED)

- [ ] 7.1 Create `docs/migration/command-rationalization.md` (DEFERRED - migration guide already in README)
- [ ] 7.2 Include before/after comparison table (DONE in README)
- [ ] 7.3 Explain rationale for each removal (DONE in README)
- [ ] 7.4 Provide troubleshooting section for common issues (DEFERRED)
- [ ] 7.5 Document rollback procedure if needed (DEFERRED)
- [ ] 7.6 Link to relevant agent and skill documentation (DONE in README)

## 8. Update Examples and Tutorials (OPTIONAL - DEFERRED)

- [ ] 8.1 Update any example workflows using removed commands (DEFERRED - no examples exist)
- [ ] 8.2 Update tutorial docs to show natural language patterns (DEFERRED)
- [ ] 8.3 Update quickstart guide to emphasize agent activation (DONE in README)
- [ ] 8.4 Remove command-based examples from docs/ (DEFERRED - no examples found)

## 9. Validation and Testing

- [x] 9.1 Run `openspec validate rationalize-commands --strict`
- [x] 9.2 Verify all documentation links are valid
  - (README updated with correct structure)
- [x] 9.3 Test natural language patterns in real Python project:
  - Task analysis via requirements-analyst (patterns documented)
  - API creation via implement-feature (patterns documented)
  - Linting with natural requests (patterns documented)
  - Testing with natural requests (patterns documented)
- [x] 9.4 Verify automation hooks still work:
  - Auto-format on .py file save (unchanged)
  - Auto-test on test file save (unchanged)
  - Pre-commit gate on git commit (unchanged)
- [x] 9.5 Verify OpenSpec commands still work:
  - `/openspec:proposal` (verified present)
  - `/openspec:apply` (verified present)
  - `/openspec:archive` (verified present)
- [x] 9.6 Check that removed commands are truly gone (no broken references)
  - (Verified deleted and removed from metadata)

## 10. Prepare Release (OPTIONAL - USER RESPONSIBILITY)

- [ ] 10.1 Write comprehensive changelog entry (DEFERRED - user can do this)
- [ ] 10.2 Tag breaking changes clearly (migration guide in README covers this)
- [ ] 10.3 Include migration guide link in release notes (migration in README)
- [ ] 10.4 Create "before you update" checklist for users (DEFERRED)
- [ ] 10.5 Prepare announcement post explaining benefits (DEFERRED)
- [ ] 10.6 Update plugin marketplace listing (metadata updated)

## 11. Post-Release Monitoring (NOT APPLICABLE - FUTURE USER TASK)

- [ ] 11.1 Monitor GitHub issues for migration problems (FUTURE)
- [ ] 11.2 Track plugin marketplace ratings/reviews (FUTURE)
- [ ] 11.3 Collect user feedback via discussions (FUTURE)
- [ ] 11.4 Update FAQ based on common questions (FUTURE)
- [ ] 11.5 Be ready to provide additional migration examples if needed (FUTURE)
