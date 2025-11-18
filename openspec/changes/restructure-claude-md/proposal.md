# Restructure CLAUDE.md to Reduce Context Window Usage

## Problem

The current CLAUDE.md file contains approximately 520 lines (~4,000-5,000 tokens) of content that is loaded into every Claude Code session. This significantly impacts the context window budget and includes extensive redundancy:

1. **Command documentation duplication**: CLAUDE.md documents all 6 commands with detailed usage examples, even though each command has its own `.claude/commands/*.md` file
2. **Agent description duplication**: Lists and describes all 8 agents, duplicating content from `.claude/agents/*.md` files
3. **Skill listing redundancy**: Lists all 8 skills, which are already defined in `.claude/skills/*.md` files
4. **Extensive code examples**: Contains ~250 lines of Python development patterns with code examples that duplicate what skills should document
5. **User-facing documentation**: Includes configuration guides, workflows, and setup instructions that belong in README.md
6. **Best practices summaries**: Reference documentation that should be in a separate docs/ directory

**Current token usage**: ~4,000-5,000 tokens per session
**Impact**: Reduces available context for actual code and conversations by 2-3%

## Proposed Solution

Restructure documentation to reduce CLAUDE.md from ~520 lines to ~40 lines (90% reduction) while improving documentation organization and discoverability.

### Content Distribution Strategy

**CLAUDE.md (essential AI instructions only - ~40 lines)**:
- OpenSpec instructions block (~15 lines)
- Minimal project context (~15 lines)
- Brief AI behavior guidelines (~10 lines)

**README.md (user-facing documentation)**:
- Enhanced command reference with usage examples
- Agent invocation guide
- Configuration and setup instructions
- MCP server recommendations
- Common workflows
- Quick start guide

**.claude/ files (self-documenting components)**:
- Commands document their own usage
- Agents document their capabilities
- Skills document patterns with examples

**docs/ directory (reference documentation)**:
- `docs/python-patterns.md` - Comprehensive pattern library
- `docs/best-practices.md` - Detailed best practices
- `docs/architecture.md` - Project structure and design

### Benefits

1. **Dramatically reduced context usage**: Save ~3,500-4,500 tokens per session (90% reduction)
2. **Better documentation organization**: User docs in README, AI instructions in CLAUDE.md, patterns in skills
3. **Improved discoverability**: Users find setup/usage info in README, not buried in AI context
4. **Self-documenting components**: Skills, agents, and commands carry their own documentation
5. **Maintainability**: Update patterns in one place (skill files) instead of duplicating in CLAUDE.md

## Scope

### In Scope

1. Slim down CLAUDE.md to essential AI instructions only
2. Move user-facing documentation to README.md
3. Create docs/ directory with reference documentation
4. Enhance skill files with pattern documentation and examples
5. Ensure command files have complete usage documentation

### Out of Scope

- Changing plugin functionality or behavior
- Modifying agent or skill logic
- Adding new commands, agents, or skills
- Changing project structure beyond documentation

## Impact

**Users**: Better documentation organization, easier to find setup/usage information
**AI Assistant**: More available context for code and conversations
**Maintainers**: Clear separation of concerns, easier to update documentation
**New Contributors**: Clearer where different types of documentation belong

## Dependencies

None - this is a documentation restructuring with no code changes.

## Risks

**Low Risk**: Documentation restructuring only, no functional changes

Potential issues:
- Users may initially look for documentation in old locations
- Need to ensure no information is lost in migration

Mitigations:
- README.md will be enhanced with all user-facing content
- Skills will contain all pattern documentation
- Cross-reference between files where appropriate
