# Context Generalization

## Overview

Transform CLAUDE.md from project-specific instructions to general Python AI/data engineering guidelines that apply to any project using this plugin. The file should describe what the plugin provides and offer reusable best practices.

## ADDED Requirements

### Requirement: CLAUDE.md SHALL provide general Python development guidelines

The CLAUDE.md file SHALL offer universal guidance that helps AI assistants write better Python code in any project, not instructions specific to one codebase.

**Rationale:** As a plugin's context file, CLAUDE.md should provide reusable best practices applicable to any Python project.

#### Scenario: AI assistant reads CLAUDE.md for Python patterns

**Given** an AI assistant is working in a Python project with this plugin
**When** it consults CLAUDE.md for guidance
**Then** it MUST find general best practices for type hints, async/await, Pydantic, testing
**And** examples MUST use generic domain concepts (users, payments, etc.)
**And** there MUST be NO references to specific services, APIs, or schemas

#### Scenario: AI assistant learns about available commands

**Given** an AI assistant encounters a task that could use a command
**When** it reads the command descriptions in CLAUDE.md
**Then** it MUST understand what each command does in general terms
**And** it MUST know when to suggest using each command
**And** descriptions MUST NOT assume specific project structure

#### Scenario: AI assistant uses skill patterns

**Given** an AI assistant is writing Python code
**When** it references skill patterns from CLAUDE.md
**Then** skills MUST provide reusable patterns applicable to any project
**And** examples MUST be generic
**And** skills MUST explain the "why" behind patterns, not just the "what"

### Requirement: CLAUDE.md SHALL NOT contain project-specific configuration

The CLAUDE.md file SHALL NOT include project-specific configuration, environment variables, specific API services, or external dependencies.

**Rationale:** Project-specific configuration should be in project-level files, not in a reusable plugin's context file.

#### Scenario: Documentation references external services

**Given** CLAUDE.md describes development practices
**When** it mentions external services or APIs
**Then** it MUST NOT include specific API keys, credentials, or service configurations
**And** it MUST NOT reference project-specific databases or schemas
**And** examples of external services MUST be generic (e.g., "a payment API" not "Stripe")

#### Scenario: Documentation shows environment variable examples

**Given** CLAUDE.md discusses configuration
**When** it shows environment variable examples
**Then** they MUST be generic examples showing patterns
**And** they MUST NOT list specific required variables for a particular project
**And** they MUST demonstrate best practices, not prescribe specific setup

### Requirement: CLAUDE.md SHALL describe plugin capabilities

The CLAUDE.md file SHALL provide comprehensive descriptions of all plugin capabilities including commands, agents, skills, and hooks.

**Rationale:** Users need to understand what this plugin provides (commands, agents, skills, hooks) and how to use them.

#### Scenario: AI assistant learns about specialized agents

**Given** an AI assistant encounters a task that matches an agent's purpose
**When** it consults CLAUDE.md
**Then** it MUST find descriptions of all available agents
**And** each agent description MUST explain when to use it
**And** agent capabilities MUST be clearly documented
**And** examples MUST show general usage patterns

#### Scenario: AI assistant understands automation hooks

**Given** an AI assistant performs file operations
**When** it references hook information in CLAUDE.md
**Then** it MUST understand what hooks are configured
**And** it MUST know which operations trigger which hooks
**And** it MUST be aware of quality gates and automation

### Requirement: CLAUDE.md SHALL maintain managed OpenSpec block

The CLAUDE.md file SHALL preserve the OpenSpec managed instruction block at the beginning of the file.

**Rationale:** The OpenSpec instructions block should remain at the top to guide AI assistants on when to use OpenSpec.

#### Scenario: AI assistant works on a feature requiring OpenSpec

**Given** an AI assistant receives a complex feature request
**When** it reads CLAUDE.md
**Then** the OpenSpec instructions block MUST be present at the top
**And** it MUST explain when to use OpenSpec proposal workflow
**And** it MUST reference the correct OpenSpec documentation path

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
