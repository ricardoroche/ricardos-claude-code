# Design: CLAUDE.md Restructuring

## Architecture Decision

### Current State Analysis

**CLAUDE.md Structure** (520 lines, ~4-5k tokens):
```
├── OpenSpec Instructions (~15 lines)
├── Introduction (~10 lines)
├── What This Plugin Provides (~60 lines)
│   ├── Commands listing (6 commands)
│   ├── Agents listing (8 agents)
│   ├── Skills listing (8 skills)
│   └── Hooks listing
├── Python Development Guidelines (~250 lines)
│   ├── Type Safety First (~30 lines with examples)
│   ├── Pydantic Validation (~40 lines with examples)
│   ├── Async/Await Patterns (~30 lines with examples)
│   ├── Error Handling (~30 lines with examples)
│   ├── FastAPI Endpoints (~35 lines with examples)
│   ├── Testing with pytest (~45 lines with examples)
│   ├── Security Best Practices (~25 lines with examples)
│   └── Code Quality Standards (~15 lines)
├── Command Usage (~60 lines)
├── Agent Usage (~40 lines)
├── Configuration (~30 lines)
├── MCP Server Recommendations (~10 lines)
├── Best Practices Summary (~25 lines)
└── Common Workflows (~25 lines)
```

**Redundancy Analysis**:
- Commands: Documented in both CLAUDE.md and `.claude/commands/*.md` files
- Agents: Described in both CLAUDE.md and `.claude/agents/*.md` files
- Skills: Listed in CLAUDE.md but defined in `.claude/skills/*.md` files
- Python patterns: In CLAUDE.md but should be in respective skill files
- User documentation: In CLAUDE.md but should be in README.md

### Target State

**CLAUDE.md** (40 lines, ~400-500 tokens):
```
├── OpenSpec Instructions (~15 lines) [KEEP]
├── Minimal Project Context (~15 lines) [NEW - condensed]
└── AI Behavior Guidelines (~10 lines) [NEW - essential only]
```

**README.md** (enhanced):
```
├── Plugin Overview [EXISTS]
├── Installation [EXISTS]
├── Quick Start [EXISTS]
├── Command Reference [MOVE from CLAUDE.md]
├── Agent Guide [MOVE from CLAUDE.md]
├── Configuration [MOVE from CLAUDE.md]
├── MCP Setup [MOVE from CLAUDE.md]
└── Common Workflows [MOVE from CLAUDE.md]
```

**docs/** (new directory):
```
docs/
├── python-patterns.md [NEW - from CLAUDE.md examples]
├── best-practices.md [MOVE from CLAUDE.md]
└── architecture.md [NEW - project structure]
```

**.claude/skills/** (enhanced):
```
Each skill file expanded with:
├── Pattern description
├── When it activates
├── Guidelines
└── Code examples [MOVE from CLAUDE.md]
```

## Content Distribution Matrix

| Content Type | Current Location | Target Location | Reasoning |
|--------------|------------------|-----------------|-----------|
| OpenSpec instructions | CLAUDE.md | CLAUDE.md | Essential AI instructions |
| Project overview | CLAUDE.md | CLAUDE.md (condensed) + README.md | Brief context for AI, full for users |
| Command listings | CLAUDE.md | README.md | User-facing documentation |
| Command usage examples | CLAUDE.md | README.md + command files | Users need examples, commands self-document |
| Agent descriptions | CLAUDE.md | README.md | User-facing documentation |
| Agent activation patterns | CLAUDE.md | Agent files | Self-documenting components |
| Skill listings | CLAUDE.md | Remove (auto-discovered) | Plugin system handles discovery |
| Type safety patterns | CLAUDE.md | Skills + docs/ | Patterns belong in skill files |
| Pydantic patterns | CLAUDE.md | `pydantic-models.md` skill | Self-documenting pattern |
| Async/await patterns | CLAUDE.md | `async-await-checker.md` skill | Self-documenting pattern |
| Error handling patterns | CLAUDE.md | `structured-errors.md` skill | Self-documenting pattern |
| FastAPI patterns | CLAUDE.md | New skill + docs/ | Needs dedicated skill |
| Testing patterns | CLAUDE.md | `pytest-patterns.md` skill | Self-documenting pattern |
| Security patterns | CLAUDE.md | `pii-redaction.md` + docs/ | Distributed across security skills |
| Code quality standards | CLAUDE.md | Skills + docs/ | Enforcement in skills, reference in docs |
| Configuration examples | CLAUDE.md | README.md | User-facing setup guide |
| MCP recommendations | CLAUDE.md | README.md + docs/ | User configuration guide |
| Best practices summary | CLAUDE.md | docs/best-practices.md | Reference documentation |
| Common workflows | CLAUDE.md | README.md | User how-to guide |

## Implementation Strategy

### Phase 1: Create New Structures

1. Create `docs/` directory
2. Create `docs/python-patterns.md` with all code examples from CLAUDE.md
3. Create `docs/best-practices.md` with best practices summary
4. Create `docs/architecture.md` with project structure explanation

### Phase 2: Enhance Existing Files

1. Enhance README.md with:
   - Command reference section (from CLAUDE.md)
   - Agent usage guide (from CLAUDE.md)
   - Configuration section (from CLAUDE.md)
   - Common workflows (from CLAUDE.md)

2. Enhance skill files with pattern documentation:
   - `pydantic-models.md` ← Pydantic examples from CLAUDE.md
   - `pytest-patterns.md` ← Testing examples from CLAUDE.md
   - `async-await-checker.md` ← Async/await examples from CLAUDE.md
   - `structured-errors.md` ← Error handling examples from CLAUDE.md
   - Create `fastapi-patterns.md` ← FastAPI examples from CLAUDE.md
   - Create `type-safety.md` ← Type hints examples from CLAUDE.md

3. Ensure command files have complete documentation

### Phase 3: Slim Down CLAUDE.md

1. Replace entire CLAUDE.md with minimal version:
   - Keep OpenSpec block (managed)
   - Add concise project context (15 lines)
   - Add essential AI guidelines (10 lines)
   - Remove everything else

### Token Savings Calculation

**Before**:
- CLAUDE.md: ~4,500 tokens
- Total context consumed: ~4,500 tokens

**After**:
- CLAUDE.md: ~450 tokens
- README.md: Not in AI context (user-facing only)
- docs/: Not in AI context (referenced when needed)
- Skills: Only loaded when relevant code detected
- Total base context: ~450 tokens

**Savings**: ~4,000 tokens per session (~90% reduction)

## Pattern Documentation in Skills

### Skill Enhancement Template

Each skill file should follow this structure:

```markdown
# Skill Name

Brief description of the pattern or practice.

## When This Applies

- Specific code patterns that trigger this skill
- File types or contexts where this is relevant

## Guidelines

Core principles and rules:
- Guideline 1
- Guideline 2
- Guideline 3

## Examples

### Good Example
\`\`\`python
# Code demonstrating correct pattern
\`\`\`

### Bad Example
\`\`\`python
# Code demonstrating anti-pattern
\`\`\`

### Common Patterns
\`\`\`python
# Additional pattern examples
\`\`\`

## References

- Link to docs/python-patterns.md for comprehensive examples
- External documentation links
```

### Skills to Create/Enhance

**Existing Skills to Enhance**:
1. `pydantic-models.md` - Add Pydantic validation patterns from CLAUDE.md
2. `pytest-patterns.md` - Add testing examples from CLAUDE.md
3. `async-await-checker.md` - Add async/await patterns from CLAUDE.md
4. `structured-errors.md` - Add error handling patterns from CLAUDE.md
5. `pii-redaction.md` - Add security examples from CLAUDE.md
6. `docstring-format.md` - Add docstring examples from CLAUDE.md

**New Skills to Create**:
1. `fastapi-patterns.md` - FastAPI endpoint structure and best practices
2. `type-safety.md` - Type hints and mypy patterns

## Trade-offs and Considerations

### Trade-offs

**Pro**:
- ✅ Significant context savings (90% reduction)
- ✅ Better separation of concerns (AI vs user documentation)
- ✅ Self-documenting components (skills carry their patterns)
- ✅ Easier maintenance (update patterns in one place)
- ✅ Improved user experience (documentation in expected places)

**Con**:
- ⚠️ More files to maintain (distributed documentation)
- ⚠️ Users may initially look in old places
- ⚠️ Skills must be well-organized to be discoverable

### Considerations

**Skills vs. CLAUDE.md**:
- Skills are loaded contextually (only when relevant code is detected)
- CLAUDE.md is loaded in every session
- Therefore, patterns belong in skills, not CLAUDE.md

**README.md vs. docs/**:
- README.md: Quick start, common tasks, basic reference
- docs/: Comprehensive guides, detailed examples, architecture

**User Documentation Location**:
- Users expect setup/usage in README.md
- CLAUDE.md is for AI assistant behavior, not user guides
- Current CLAUDE.md mixes these concerns

**Pattern Documentation Strategy**:
- Minimal examples in skill files (activation + key patterns)
- Comprehensive examples in docs/python-patterns.md
- Cross-reference between skills and docs/

## Validation

### Success Criteria

1. ✅ CLAUDE.md reduced to ~40 lines (~400-500 tokens)
2. ✅ All command usage documentation in README.md or command files
3. ✅ All agent descriptions in README.md or agent files
4. ✅ All Python patterns documented in skills or docs/
5. ✅ All user-facing content in README.md or docs/
6. ✅ No information loss (everything migrated)
7. ✅ Cross-references maintained between files

### Testing

1. Verify CLAUDE.md is loaded correctly and provides minimal context
2. Verify README.md contains all user documentation
3. Verify skills activate correctly and provide pattern guidance
4. Verify docs/ files are comprehensive and cross-referenced
5. Verify no broken links or missing content

### Rollback Plan

If issues arise:
1. Git revert to previous CLAUDE.md
2. No functional changes, so low risk
3. Documentation can be iteratively improved
