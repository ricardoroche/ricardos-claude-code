# Context Generalization

## Overview

Transform CLAUDE.md from project-specific instructions to general Python AI/data engineering guidelines that apply to any project using this plugin. The file should describe what the plugin provides and offer reusable best practices.

## MODIFIED Requirements

### Requirement: CLAUDE.md provides general Python development guidelines

**Rationale:** As a plugin's context file, CLAUDE.md should offer universal guidance that helps AI assistants write better Python code in any project, not instructions specific to one codebase.

#### Scenario: AI assistant reads CLAUDE.md for Python patterns

**Given** an AI assistant is working in a Python project with this plugin
**When** it consults CLAUDE.md for guidance
**Then** it should find general best practices for type hints, async/await, Pydantic, testing
**And** examples should use generic domain concepts (users, payments, etc.)
**And** there should be NO references to specific services, APIs, or schemas

#### Scenario: AI assistant learns about available commands

**Given** an AI assistant encounters a task that could use a command
**When** it reads the command descriptions in CLAUDE.md
**Then** it should understand what each command does in general terms
**And** it should know when to suggest using each command
**And** descriptions should not assume specific project structure

#### Scenario: AI assistant uses skill patterns

**Given** an AI assistant is writing Python code
**When** it references skill patterns from CLAUDE.md
**Then** skills should provide reusable patterns applicable to any project
**And** examples should be generic
**And** skills should explain the "why" behind patterns, not just the "what"

## REMOVED Requirements

### Requirement: CLAUDE.md describes project-specific setup

**Rationale:** Project-specific configuration, environment variables, and external dependencies should not be in a plugin's CLAUDE.md.

#### Scenario: Documentation references project-specific services

**Given** CLAUDE.md describes development practices
**When** it mentions external services or APIs
**Then** it should NOT include specific API keys, credentials, or service configurations
**And** it should NOT reference project-specific databases or schemas
**And** examples of external services should be generic (e.g., "a payment API" not "Stripe")

#### Scenario: Documentation includes project-specific environment variables

**Given** CLAUDE.md discusses configuration
**When** it shows environment variable examples
**Then** they should be generic examples showing patterns
**And** they should NOT list specific required variables for a particular project
**And** they should demonstrate best practices, not prescribe specific setup

## ADDED Requirements

### Requirement: CLAUDE.md SHALL describe plugin capabilities

The CLAUDE.md file SHALL provide comprehensive descriptions of all plugin capabilities including commands, agents, skills, and hooks.

**Rationale:** Users need to understand what this plugin provides (commands, agents, skills, hooks) and how to use them.

#### Scenario: AI assistant learns about specialized agents

**Given** an AI assistant encounters a task that matches an agent's purpose
**When** it consults CLAUDE.md
**Then** it should find descriptions of all available agents
**And** each agent description should explain when to use it
**And** agent capabilities should be clearly documented
**And** examples should show general usage patterns

#### Scenario: AI assistant understands automation hooks

**Given** an AI assistant performs file operations
**When** it references hook information in CLAUDE.md
**Then** it should understand what hooks are configured
**And** it should know which operations trigger which hooks
**And** it should be aware of quality gates and automation

## MODIFIED Requirements

### Requirement: CLAUDE.md MUST maintain managed OpenSpec block

The CLAUDE.md file MUST preserve the OpenSpec managed instruction block at the beginning of the file.

**Rationale:** The OpenSpec instructions block should remain at the top to guide AI assistants on when to use OpenSpec.

#### Scenario: AI assistant works on a feature requiring OpenSpec

**Given** an AI assistant receives a complex feature request
**When** it reads CLAUDE.md
**Then** the OpenSpec instructions block should be present at the top
**And** it should explain when to use OpenSpec proposal workflow
**And** it should reference the correct OpenSpec documentation path

## Impact

**Files to Modify:**
- `CLAUDE.md` - Complete rewrite to generalize all content while preserving valuable patterns

**Sections to Transform:**
- **Overview** - Describe plugin purpose and philosophy
- **Commands** - List commands with general usage guidance
- **Agents** - Describe specialized agents and when to use them
- **Skills** - Document reusable Python patterns
- **Hooks** - Explain automation behavior
- **Python Patterns** - Provide general best practices with generic examples
- **Development Workflows** - General guidance applicable to any Python project

**Content to Remove:**
- Specific API keys, credentials, service names
- Project-specific database paths or schemas
- References to particular applications or services
- Project-specific environment variable lists
- Specific architectural decisions for a particular project

**Content to Preserve:**
- All valuable Python patterns and best practices
- Type hint guidelines
- Async/await patterns
- Pydantic validation patterns
- Testing strategies
- Security best practices
- Error handling approaches

**Related Capabilities:**
- `documentation-reframe` - Must align with README and project.md reframing
- `mcp-configuration-removal` - Must not reference MCP servers as pre-configured
