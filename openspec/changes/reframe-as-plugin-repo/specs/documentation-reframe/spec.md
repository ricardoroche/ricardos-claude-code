# Documentation Reframe

## Overview

Reframe README.md and openspec/project.md to accurately describe this as a Claude Code plugin repository for Python AI/data engineering, not as a project using the plugin.

## MODIFIED Requirements

### Requirement: README describes plugin installation and usage

**Rationale:** Users need to understand this is a reusable plugin they can install in any Python project, not a template or example project.

#### Scenario: User reads README to understand repository purpose

**Given** a user discovers the ricardos-claude-code repository
**When** they read the README.md
**Then** the opening section should clearly state this is a Claude Code plugin
**And** it should describe what the plugin provides (commands, agents, skills, hooks)
**And** it should NOT describe it as a specific project or application

#### Scenario: User wants to install the plugin

**Given** a user wants to use the plugin in their Python project
**When** they read the installation section
**Then** they should find clear instructions using `/plugin marketplace add` and `/plugin install`
**And** the instructions should work for any Python project
**And** there should be no project-specific setup requirements

#### Scenario: Developer wants to contribute to the plugin

**Given** a developer wants to improve the plugin
**When** they read the contributing section
**Then** they should understand this is plugin development
**And** they should know how to test changes locally
**And** they should understand how to add/modify commands, agents, or skills

## MODIFIED Requirements

### Requirement: openspec/project.md MUST provide plugin development context

The openspec/project.md file MUST describe this repository as a Claude Code plugin development project and provide appropriate context for plugin development.

**Rationale:** Future AI-assisted work on this repository needs to understand it's developing a plugin, not a project using a plugin.

#### Scenario: AI agent reads project context

**Given** an AI agent is working on this repository
**When** it reads openspec/project.md
**Then** the "Purpose" section should describe this as a Claude Code plugin repository
**And** the "Tech Stack" should reflect plugin development tools and patterns
**And** the "Project Conventions" should cover plugin development best practices

#### Scenario: AI agent needs to understand the domain

**Given** an AI agent is implementing a new command or agent
**When** it consults openspec/project.md for domain context
**Then** it should find guidance on Claude Code plugin structure
**And** it should find patterns for commands, agents, skills, and hooks
**And** it should NOT find project-specific application logic

## REMOVED Requirements

### Requirement: Documentation describes specific project architecture

**Rationale:** As a plugin, there is no specific project architecture - the plugin provides reusable components for any Python project.

#### Scenario: Documentation references project-specific setup

**Given** documentation files describe repository contents
**When** they discuss architecture or setup
**Then** they should NOT reference specific applications or services
**And** they should NOT include project-specific API keys or credentials
**And** they should NOT describe specific database schemas or paths

## ADDED Requirements

### Requirement: Documentation SHALL separate plugin guidelines from project usage

Documentation SHALL clearly distinguish between plugin-provided capabilities and project-level configuration requirements.

**Rationale:** Clear separation helps users understand what the plugin provides vs. what they configure in their projects.

#### Scenario: User reads documentation about Python patterns

**Given** a user wants to understand the Python patterns this plugin promotes
**When** they read the documentation
**Then** patterns should be described as general best practices
**And** examples should be generic and reusable
**And** it should be clear these are recommendations, not requirements

#### Scenario: User configures the plugin in their project

**Given** a user has installed the plugin
**When** they want to customize behavior for their project
**Then** documentation should explain how to override or extend plugin behavior
**And** it should be clear what's plugin-level vs. project-level configuration

## Impact

**Files to Modify:**
- `README.md` - Complete rewrite focusing on plugin purpose, installation, usage, and contribution
- `openspec/project.md` - Revise to reflect plugin development context
- `.claude-plugin/MCP-SERVERS.md` - Move to docs/ and reframe as recommendations

**Related Capabilities:**
- `mcp-configuration-removal` - README must reflect that MCP servers are not included
- `context-generalization` - CLAUDE.md must align with this reframing
