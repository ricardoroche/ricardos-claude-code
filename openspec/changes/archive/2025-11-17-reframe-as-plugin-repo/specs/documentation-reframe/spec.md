# Documentation Reframe

## Overview

Reframe README.md and openspec/project.md to accurately describe this as a Claude Code plugin repository for Python AI/data engineering, not as a project using the plugin.

## ADDED Requirements

### Requirement: README SHALL describe plugin installation and usage

The README.md file SHALL clearly describe this as a reusable Claude Code plugin and provide installation instructions.

**Rationale:** Users need to understand this is a reusable plugin they can install in any Python project, not a template or example project.

#### Scenario: User reads README to understand repository purpose

**Given** a user discovers the ricardos-claude-code repository
**When** they read the README.md
**Then** the opening section MUST clearly state this is a Claude Code plugin
**And** it MUST describe what the plugin provides (commands, agents, skills, hooks)
**And** it MUST NOT describe it as a specific project or application

#### Scenario: User wants to install the plugin

**Given** a user wants to use the plugin in their Python project
**When** they read the installation section
**Then** they MUST find clear instructions using `/plugin marketplace add` and `/plugin install`
**And** the instructions MUST work for any Python project
**And** there MUST be no project-specific setup requirements

#### Scenario: Developer wants to contribute to the plugin

**Given** a developer wants to improve the plugin
**When** they read the contributing section
**Then** they MUST understand this is plugin development
**And** they MUST know how to test changes locally
**And** they MUST understand how to add/modify commands, agents, or skills

### Requirement: openspec/project.md SHALL provide plugin development context

The openspec/project.md file SHALL describe this repository as a Claude Code plugin development project and provide appropriate context for plugin development.

**Rationale:** Future AI-assisted work on this repository needs to understand it's developing a plugin, not a project using a plugin.

#### Scenario: AI agent reads project context

**Given** an AI agent is working on this repository
**When** it reads openspec/project.md
**Then** the "Purpose" section MUST describe this as a Claude Code plugin repository
**And** the "Tech Stack" MUST reflect plugin development tools and patterns
**And** the "Project Conventions" MUST cover plugin development best practices

#### Scenario: AI agent needs to understand the domain

**Given** an AI agent is implementing a new command or agent
**When** it consults openspec/project.md for domain context
**Then** it MUST find guidance on Claude Code plugin structure
**And** it MUST find patterns for commands, agents, skills, and hooks
**And** it MUST NOT find project-specific application logic

### Requirement: Documentation SHALL NOT describe specific project architecture

Documentation SHALL NOT include references to specific project applications, services, credentials, or schemas.

**Rationale:** As a plugin, there is no specific project architecture - the plugin provides reusable components for any Python project.

#### Scenario: Documentation references architecture

**Given** documentation files describe repository contents
**When** they discuss architecture or setup
**Then** they MUST NOT reference specific applications or services
**And** they MUST NOT include project-specific API keys or credentials
**And** they MUST NOT describe specific database schemas or paths

### Requirement: Documentation SHALL separate plugin guidelines from project usage

Documentation SHALL clearly distinguish between plugin-provided capabilities and project-level configuration requirements.

**Rationale:** Clear separation helps users understand what the plugin provides vs. what they configure in their projects.

#### Scenario: User reads documentation about Python patterns

**Given** a user wants to understand the Python patterns this plugin promotes
**When** they read the documentation
**Then** patterns MUST be described as general best practices
**And** examples MUST be generic and reusable
**And** it MUST be clear these are recommendations, not requirements

#### Scenario: User configures the plugin in their project

**Given** a user has installed the plugin
**When** they want to customize behavior for their project
**Then** documentation MUST explain how to override or extend plugin behavior
**And** it MUST be clear what's plugin-level vs. project-level configuration

## Impact

**Files to Modify:**
- `README.md` - Complete rewrite focusing on plugin purpose, installation, usage, and contribution
- `openspec/project.md` - Revise to reflect plugin development context
- `.claude-plugin/MCP-SERVERS.md` - Move to docs/ and reframe as recommendations

**Related Capabilities:**
- `mcp-configuration-removal` - README must reflect that MCP servers are not included
- `context-generalization` - CLAUDE.md must align with this reframing
