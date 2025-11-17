# MCP Configuration Removal

## Overview

Remove MCP server configuration from plugin files. Plugins should not pre-configure MCP servers as this is project-specific and should be left to individual users/projects.

## REMOVED Requirements

### Requirement: Plugin provides MCP server configuration

**Rationale:** MCP server configuration is project-specific and should not be imposed by plugins. Different projects have different needs for MCP servers, database paths, and authentication credentials.

#### Scenario: User installs plugin and gets MCP servers

**Given** a user installs the ricardos-claude-code plugin
**When** the plugin is loaded by Claude Code
**Then** MCP servers should NOT be automatically configured
**And** users should configure MCP servers in their project's `.mcp.json` as needed

#### Scenario: Plugin manifest includes mcpServers

**Given** the plugin.json manifest file exists
**When** it is parsed by Claude Code
**Then** it should NOT contain an `mcpServers` section
**And** the plugin should focus on commands, agents, skills, and hooks only

#### Scenario: Root .mcp.json exists in plugin repository

**Given** the plugin repository contains a `.mcp.json` file
**When** users reference the repository
**Then** this file should be removed to avoid confusion
**And** `.mcp.json` should be added to `.gitignore`
**Because** MCP configuration is project-specific and doesn't belong in a plugin

## Impact

**Files to Modify:**
- `.claude-plugin/plugin.json` - Remove `mcpServers` section
- `.mcp.json` - Delete file
- `.gitignore` - Add `.mcp.json` entry

**Related Capabilities:**
- `documentation-reframe` - Documentation must be updated to reflect MCP servers are not included
- `context-generalization` - CLAUDE.md should not reference pre-configured MCP servers
