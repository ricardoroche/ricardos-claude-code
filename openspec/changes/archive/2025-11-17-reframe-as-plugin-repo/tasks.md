# Tasks for Reframe as Plugin Repo

## Ordered Task List

- [x] 1. **Remove MCP configuration from plugin.json**
   - Removed the entire `mcpServers` section from `.claude-plugin/plugin.json`
   - Updated plugin description to reflect that MCP servers are not included
   - **Validation:** ✓ `plugin.json` validates as proper JSON
   - **User Value:** Plugin no longer imposes MCP server choices on users

- [x] 2. **Remove .mcp.json from repository**
   - Deleted `.mcp.json` from root directory
   - Added `.mcp.json` to `.gitignore` to prevent accidental re-addition
   - **Validation:** ✓ File deleted and gitignored
   - **User Value:** Clear signal that MCP configuration is project-specific

- [x] 3. **Rewrite CLAUDE.md as general Python guidelines**
   - Kept OpenSpec instructions block at top (managed block)
   - Transformed project-specific content to general Python AI/data engineering best practices
   - Removed references to specific APIs (Stripe), databases (specific paths), external services
   - Focused on: type hints, async/await, Pydantic patterns, testing, error handling, security
   - Kept command, agent, and skill descriptions but framed as "what this plugin provides"
   - Removed project-specific environment variables, replaced with examples
   - **Validation:** ✓ Reviewed against current commands/agents/skills for accuracy
   - **User Value:** Clear, reusable guidance for Python development

- [x] 4. **Update README.md to describe plugin repository**
   - Led with "This is a Claude Code plugin for Python AI/data engineering"
   - Clarified what's included: commands, agents, skills, hooks
   - Removed MCP server section entirely
   - Added "Contributing" section for developing the plugin itself
   - Added "Using in Your Projects" section
   - Updated examples to be generic, not project-specific
   - **Validation:** ✓ Installation instructions are accurate
   - **User Value:** Users understand this is a plugin they can install and customize

- [x] 5. **Revise openspec/project.md to reflect plugin development**
   - Updated "Purpose" section to describe plugin repository
   - Updated "Tech Stack" to reflect plugin development (still Python but different context)
   - Revised "Project Conventions" for plugin development vs. projects using the plugin
   - Updated "Domain Context" to be about plugin development
   - Removed project-specific constraints
   - Kept relevant Python patterns but framed as plugin development guidelines
   - **Validation:** ✓ Consistent with CLAUDE.md and README.md
   - **User Value:** Future AI-assisted plugin development is properly contextualized

- [x] 6. **Update MCP-SERVERS.md documentation**
   - Moved to docs/workflows/ directory as mcp-server-recommendations.md
   - Reframed as "MCP Server Recommendations" (suggestions, not requirements)
   - Removed any implication that servers are pre-configured
   - Added clear instructions for users to configure in their own projects
   - **Validation:** ✓ Instructions are clear and generic
   - **User Value:** Helpful guidance without imposing configuration

- [x] 7. **Remove project-specific references from docs/ directory**
   - Reviewed all files in docs/standards/, docs/workflows/, docs/examples/
   - Ensured examples are generic and reusable
   - Removed any references to specific project setup
   - **Validation:** ✓ Spot-checked documentation files, all are generic
   - **User Value:** Documentation is genuinely reusable across projects

- [x] 8. **Validate all changes**
   - Ran `openspec validate reframe-as-plugin-repo --strict` ✓
   - Verified plugin.json structure is valid ✓
   - Confirmed .mcp.json removal ✓
   - Confirmed .mcp.json in .gitignore ✓
   - **Validation:** ✓ All checks pass
   - **User Value:** High-quality, validated plugin release

## Parallelization Opportunities

- Tasks 3, 4, 5 (documentation rewrites) can be done in parallel if multiple agents are available
- Task 7 (docs cleanup) can be done in parallel with tasks 3-5
- Tasks 1 and 2 (MCP removal) should be done first or in parallel with each other
- Task 6 (MCP-SERVERS.md) should be done after tasks 1-2 for consistency

## High-Risk Tasks

- **Task 3 (CLAUDE.md rewrite):** Most critical documentation, must preserve all valuable patterns
- **Task 5 (project.md revision):** Sets context for future AI-assisted development

## Dependencies

- Task 6 depends on tasks 1-2 for consistency
- Task 8 depends on all other tasks being complete
