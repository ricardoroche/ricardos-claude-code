# mcp-configuration-removal Specification

## Purpose
TBD - created by archiving change reframe-as-plugin-repo. Update Purpose after archive.
## Requirements
### Requirement: Plugin SHALL NOT provide MCP server configuration

The plugin SHALL NOT include MCP server configuration in plugin.json or repository files.

**Rationale:** MCP server configuration is project-specific and should not be imposed by plugins. Different projects have different needs for MCP servers, database paths, and authentication credentials.

#### Scenario: User installs plugin

**Given** a user installs the ricardos-claude-code plugin
**When** the plugin is loaded by Claude Code
**Then** MCP servers MUST NOT be automatically configured
**And** users MUST configure MCP servers in their project's `.mcp.json` as needed

#### Scenario: Plugin manifest is parsed

**Given** the plugin.json manifest file exists
**When** it is parsed by Claude Code
**Then** it MUST NOT contain an `mcpServers` section
**And** the plugin MUST focus on commands, agents, skills, and hooks only

#### Scenario: Plugin repository structure is validated

**Given** the plugin repository contains files
**When** users examine the repository structure
**Then** there MUST NOT be a `.mcp.json` file in the repository
**And** `.mcp.json` MUST be in `.gitignore`
**Because** MCP configuration is project-specific and doesn't belong in a plugin

