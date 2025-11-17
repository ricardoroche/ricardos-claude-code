# Change: Reframe Repository as Claude Code Plugin

## Why

Documentation currently describes this repository as if it were a specific project using the Claude Code plugin, when it's actually the plugin itself. This causes confusion about the repository's purpose and includes inappropriate configuration (MCP servers) that should be left to individual projects. We need to reframe all documentation to clearly present this as a reusable Claude Code plugin providing universal Python AI/data engineering guidelines.

## What Changes

- Rewrite CLAUDE.md to provide general Python development guidelines (not project-specific instructions)
- Update README.md to describe the plugin repository, installation, and contribution process
- Revise openspec/project.md to reflect plugin development context (not project usage)
- Remove MCP server configuration from `.mcp.json` and `plugin.json`
- Remove project-specific references (Stripe API keys, specific database paths, service configurations)
- Separate plugin-provided capabilities from project-level configuration in documentation
- Add `.mcp.json` to `.gitignore` to prevent project-specific files in plugin

## Impact

**Affected specs:**
- `documentation-reframe` - New capability for core documentation structure
- `mcp-configuration-removal` - New capability for plugin configuration boundaries
- `context-generalization` - New capability for CLAUDE.md content guidelines

**Affected files:**
- `CLAUDE.md` - Complete rewrite (general guidelines, not project-specific)
- `README.md` - Complete rewrite (plugin description, not project description)
- `openspec/project.md` - Major revision (plugin development context)
- `.mcp.json` - Remove file
- `.claude-plugin/plugin.json` - Remove `mcpServers` section
- `.gitignore` - Add `.mcp.json` entry
- `.claude-plugin/MCP-SERVERS.md` or `docs/` - Reframe as recommendations, not configuration

**User impact:**
- Users will understand this is a reusable plugin
- No confusion about MCP server configuration
- Clearer contribution guidelines for plugin development
- Better foundation for AI-assisted iteration on plugin features

**Migration:**
- Existing users: MCP servers should be configured in project-level `.mcp.json` files
- No breaking changes to commands, agents, skills, or hooks functionality
