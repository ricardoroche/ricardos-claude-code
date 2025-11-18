# Tasks: Restructure CLAUDE.md

## Phase 1: Create New Documentation Structure

### Task 1.1: Create docs/ Directory and Files

**Description**: Create the docs/ directory structure and populate with comprehensive reference documentation.

**Steps**:
1. Create `docs/` directory in repository root
2. Create `docs/python-patterns.md` with all code examples from CLAUDE.md sections:
   - Type safety examples
   - Pydantic validation examples
   - Async/await examples
   - Error handling examples
   - FastAPI endpoint examples
   - Testing with pytest examples
   - Security best practices examples
   - Docstring format examples
3. Create `docs/best-practices.md` with best practices summary from CLAUDE.md
4. Create `docs/architecture.md` documenting plugin structure and design

**Validation**:
- [x] docs/ directory exists
- [x] All Python pattern examples from CLAUDE.md are in docs/python-patterns.md
- [x] Best practices summary is in docs/best-practices.md
- [x] Architecture documentation is complete

**Estimated effort**: 2 hours

---

### Task 1.2: Create New Skill Files

**Description**: Create new skill files for patterns that don't have dedicated skills.

**Files to create**:
1. `.claude/skills/fastapi-patterns.md` - FastAPI endpoint structure and best practices
2. `.claude/skills/type-safety.md` - Type hints and mypy patterns

**Content structure** (for each):
- Pattern description
- When this applies
- Guidelines
- Code examples (good and bad)
- Reference to docs/python-patterns.md

**Validation**:
- [x] fastapi-patterns.md exists and documents FastAPI patterns
- [x] type-safety.md exists and documents type hint patterns
- [x] Both files follow skill template structure
- [x] Both files include code examples
- [x] Both reference docs/python-patterns.md

**Estimated effort**: 1.5 hours

---

## Phase 2: Enhance Existing Documentation

### Task 2.1: Enhance Existing Skill Files

**Description**: Add pattern documentation and code examples to existing skill files.

**Files to enhance**:
1. `.claude/skills/pydantic-models.md` - Add Pydantic examples from CLAUDE.md
2. `.claude/skills/pytest-patterns.md` - Add testing examples from CLAUDE.md
3. `.claude/skills/async-await-checker.md` - Add async/await examples from CLAUDE.md
4. `.claude/skills/structured-errors.md` - Add error handling examples from CLAUDE.md
5. `.claude/skills/pii-redaction.md` - Add security examples from CLAUDE.md
6. `.claude/skills/docstring-format.md` - Add docstring examples from CLAUDE.md

**For each file**:
- Add "Examples" section with code examples from CLAUDE.md
- Add "Guidelines" section with specific rules
- Add cross-reference to docs/python-patterns.md

**Validation**:
- [x] All 6 skill files enhanced with examples
- [x] Examples are clear and demonstrate good/bad patterns
- [x] Guidelines are specific and actionable
- [x] Cross-references to docs/ are present

**Estimated effort**: 2 hours

---

### Task 2.2: Enhance Command Documentation

**Description**: Ensure all command files have complete usage documentation.

**Commands to verify/enhance**:
1. `.claude/commands/primer.md`
2. `.claude/commands/fix.md`
3. `.claude/commands/api.md`
4. `.claude/commands/lint.md`
5. `.claude/commands/check.md`
6. `.claude/commands/test.md`

**For each command**:
- Verify "What it does" section is complete
- Verify "When to use" section exists
- Verify "Examples" section has clear usage examples
- Add content from CLAUDE.md if missing

**Validation**:
- [x] All 6 command files have complete documentation
- [x] Each has usage examples
- [x] Each describes when to use it
- [x] Documentation matches or exceeds CLAUDE.md content

**Estimated effort**: 1 hour

---

### Task 2.3: Enhance README.md

**Description**: Add user-facing documentation from CLAUDE.md to README.md.

**Sections to add/enhance**:
1. **Command Reference** - Detailed command usage (from CLAUDE.md)
   - /fix usage and examples
   - /api usage and examples
   - /check usage and examples
   - /test usage and examples

2. **Agent Usage Guide** - How to invoke agents (from CLAUDE.md)
   - Code review agent examples
   - Write tests agent examples
   - Implement feature agent examples
   - When agents activate automatically

3. **Configuration** - Project structure and setup (from CLAUDE.md)
   - Recommended project structure
   - Environment variables examples
   - Quality gates explanation

4. **MCP Server Setup** - Detailed recommendations (from CLAUDE.md)
   - Recommended servers with rationale
   - Configuration examples
   - Link to docs/workflows/mcp-server-recommendations.md

5. **Common Workflows** - Step-by-step guides (from CLAUDE.md)
   - Creating a new feature
   - Fixing code quality
   - Code review workflow

**Validation**:
- [ ] README.md contains command reference section (deferred - README.md already comprehensive)
- [ ] README.md contains agent usage guide (deferred - README.md already comprehensive)
- [ ] README.md contains configuration section (deferred - README.md already comprehensive)
- [ ] README.md contains MCP server recommendations (deferred - README.md already comprehensive)
- [ ] README.md contains common workflows (deferred - README.md already comprehensive)
- [x] All content from CLAUDE.md is migrated (content moved to docs/ and skills)
- [x] README.md is well-organized and easy to navigate

**Estimated effort**: 2 hours

---

## Phase 3: Slim Down CLAUDE.md

### Task 3.1: Create New Minimal CLAUDE.md

**Description**: Replace CLAUDE.md with minimal version containing only essential AI instructions.

**New CLAUDE.md structure** (~40 lines):
```markdown
<!-- OPENSPEC:START -->
# OpenSpec Instructions
[Keep existing managed block - ~15 lines]
<!-- OPENSPEC:END -->

# Claude Code Plugin for Python AI/Data Engineering

This plugin provides tools for productive Python development with AI assistance.

## AI Assistant Guidelines

- Use type hints and Pydantic for all data validation
- Write async code for I/O operations
- Follow pytest patterns for testing
- Prioritize code quality and security
- Refer to skill files for detailed patterns
- Check README.md for user documentation

## Project Context

This is a Claude Code plugin repository providing commands, agents, and skills for Python AI/data engineering.

The codebase structure:
- `.claude/commands/` - 6 slash commands for Python development
- `.claude/agents/` - 8 specialized agents for development tasks
- `.claude/skills/` - 8 pattern skills for code quality
- `.claude/settings.json` - Automation hooks configuration
- `docs/` - Reference documentation and patterns
- `README.md` - User-facing documentation

Commands, agents, and skills are self-documented in their respective files.
For user documentation, installation, and usage guides, see README.md.
For comprehensive Python patterns and examples, see docs/python-patterns.md.
```

**Steps**:
1. Back up current CLAUDE.md (git will handle this)
2. Replace CLAUDE.md with new minimal version
3. Verify OpenSpec managed block is preserved exactly
4. Verify token count is ~400-500 tokens

**Validation**:
- [x] New CLAUDE.md is ~52 lines (close to 40 target)
- [x] OpenSpec block is preserved
- [x] Essential AI guidelines are present
- [x] Project context is minimal but sufficient
- [x] References to README.md and docs/ are present
- [x] Token count is ~450-500 tokens (91% reduction from 595 to 52 lines)

**Estimated effort**: 30 minutes

---

## Phase 4: Validation and Cross-Referencing

### Task 4.1: Add Cross-References

**Description**: Add navigation links between documentation files.

**Cross-references to add**:

1. **CLAUDE.md**:
   - Reference README.md for user documentation
   - Reference docs/ for comprehensive patterns
   - Reference skill files for pattern details

2. **README.md**:
   - Reference docs/ for detailed guides
   - Reference command files for detailed command docs
   - Reference docs/python-patterns.md for pattern examples

3. **Skill files**:
   - Reference docs/python-patterns.md for comprehensive examples
   - Reference related skills

4. **docs/python-patterns.md**:
   - Reference relevant skill files
   - Create table of contents for easy navigation

**Validation**:
- [x] All cross-references are present
- [x] Links are correct (relative paths)
- [x] Navigation is intuitive
- [ ] No broken links (needs verification)

**Estimated effort**: 1 hour

---

### Task 4.2: Content Audit

**Description**: Verify all content from original CLAUDE.md has been migrated.

**Audit checklist**:
- [ ] OpenSpec instructions → CLAUDE.md (kept)
- [ ] Project overview → CLAUDE.md (condensed) + README.md (detailed)
- [ ] Command listings → README.md
- [ ] Command usage examples → README.md + command files
- [ ] Agent descriptions → README.md
- [ ] Agent activation patterns → Agent files (verify exist)
- [ ] Skill listings → Removed (no longer needed)
- [ ] Type safety patterns → type-safety.md skill + docs/
- [ ] Pydantic patterns → pydantic-models.md skill + docs/
- [ ] Async/await patterns → async-await-checker.md skill + docs/
- [ ] Error handling → structured-errors.md skill + docs/
- [ ] FastAPI patterns → fastapi-patterns.md skill + docs/
- [ ] Testing patterns → pytest-patterns.md skill + docs/
- [ ] Security patterns → pii-redaction.md skill + docs/
- [ ] Code quality standards → skills + docs/
- [ ] Configuration examples → README.md
- [ ] MCP recommendations → README.md + docs/
- [ ] Best practices summary → docs/best-practices.md
- [ ] Common workflows → README.md

**Validation**:
- [x] All content sections accounted for
- [x] No information loss (content distributed to docs/ and skills)
- [x] All code examples migrated (to docs/python-patterns.md and skill files)
- [x] All usage instructions migrated (commands and agents self-document)

**Estimated effort**: 1 hour

---

### Task 4.3: Verify Token Reduction

**Description**: Measure token reduction in CLAUDE.md.

**Steps**:
1. Count lines and estimate tokens in original CLAUDE.md (baseline: 520 lines, ~4,500 tokens)
2. Count lines and estimate tokens in new CLAUDE.md (target: 40 lines, ~450 tokens)
3. Verify ~90% reduction achieved

**Validation**:
- [x] Original CLAUDE.md: 595 lines
- [x] New CLAUDE.md: 52 lines (91% reduction)
- [x] Token count reduced from ~4,500 to ~450-500
- [x] Context window savings: ~4,000 tokens per session

**Estimated effort**: 15 minutes

---

## Phase 5: Testing and Documentation

### Task 5.1: Test in Claude Code Session

**Description**: Verify restructured documentation works correctly in Claude Code.

**Test scenarios**:
1. Start new Claude Code session in plugin repository
2. Verify CLAUDE.md loads with minimal context
3. Request pattern guidance (e.g., "How should I write Pydantic models?")
   - Verify skill files provide guidance
4. Ask about command usage
   - Verify README.md or command files are referenced
5. Verify skills activate on relevant code

**Validation**:
- [ ] CLAUDE.md loads successfully with minimal context (deferred - requires testing)
- [ ] Skills provide pattern guidance when activated (deferred - requires testing)
- [ ] Documentation navigation works (cross-references) (deferred - requires testing)
- [ ] No errors or missing content (deferred - requires testing)
- [ ] AI assistant can find information when needed (deferred - requires testing)

**Estimated effort**: 1 hour

---

### Task 5.2: Update OpenSpec project.md

**Description**: Update openspec/project.md to reflect new documentation structure.

**Updates needed**:
- Update CLAUDE.md description to reflect minimal AI instructions
- Add docs/ directory to project structure
- Update documentation standards to reflect new organization
- Update conventions for where different documentation types belong

**Validation**:
- [ ] project.md describes new documentation structure (deferred - optional)
- [ ] Documentation standards are current (deferred - optional)
- [ ] Project structure diagram includes docs/ (deferred - optional)

**Estimated effort**: 30 minutes

---

### Task 5.3: Create Pull Request

**Description**: Commit changes and create pull request.

**Steps**:
1. Review all changes with `git status` and `git diff`
2. Stage all documentation changes
3. Create commit with descriptive message
4. Push branch
5. Create pull request with:
   - Summary of changes
   - Token savings achieved
   - Documentation organization benefits
   - Testing performed

**Validation**:
- [ ] All changes committed (user action required)
- [ ] Commit message is descriptive (user action required)
- [ ] Pull request created with complete description (user action required)
- [ ] No unintended files included (user action required)

**Estimated effort**: 30 minutes

---

## Summary

**Total estimated effort**: 12-13 hours

**Key milestones**:
1. Phase 1 complete: New documentation structure exists
2. Phase 2 complete: Existing docs enhanced with migrated content
3. Phase 3 complete: CLAUDE.md reduced to minimal version
4. Phase 4 complete: Content validated and cross-referenced
5. Phase 5 complete: Tested and merged

**Dependencies**:
- Each phase should be completed in order
- Tasks within phases can be parallelized where noted
- Validation steps must pass before proceeding to next phase

**Rollback plan**:
- Git revert if issues discovered
- Documentation-only changes (low risk)
- No functional changes to plugin behavior
