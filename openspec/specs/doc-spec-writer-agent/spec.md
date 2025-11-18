# Spec: Doc & Spec Writer Agent

**Capability**: doc-spec-writer-agent
**Status**: Accepted
**Related**: hybrid-agent-pattern, skill-agent-integration

## Purpose

Define a hybrid-pattern documentation agent that authors OpenSpec materials and core documentation (design docs, ADRs, READMEs, changelogs) using dedicated documentation skills and OpenSpec conventions for Python projects using this plugin.

## Requirements

### Requirement: Agent metadata and structure follow hybrid pattern

The doc-and-spec-writer agent MUST include required frontmatter and sections defined by the hybrid agent pattern.

#### Scenario: Creating the doc-and-spec-writer agent file

**Given** the agent file `.claude/agents/spec-writer.md` is being authored  
**When** the frontmatter is added  
**Then** it MUST include `name`, `description`, `category`, `pattern_version`, `model`, and `color`  
**And** the body MUST contain Role & Mindset, Triggers, Focus Areas, Specialized Workflows, Skills Integration, Outputs, Best Practices, Boundaries, and Related Agents sections.

### Requirement: Workflows cover OpenSpec packages and documentation deliverables

The agent MUST provide workflows for OpenSpec change packages, design docs/ADRs, README updates, and changelog drafting with outline-first behavior.

#### Scenario: User requests a new OpenSpec change package

**Given** a user asks for a proposal/spec/tasks for a new capability  
**When** the agent responds  
**Then** it MUST gather context from `openspec/AGENTS.md`, `openspec/project.md`, and active specs/changes  
**And** it MUST outline sections in the order Executive Summary → Background → Goals → Scope/Non-Goals → Approach → Risks & Mitigations → Validation → Open Questions  
**And** it MUST add spec deltas using `## ADDED|MODIFIED|REMOVED Requirements` with at least one `#### Scenario:` per requirement.

#### Scenario: User requests a design doc or ADR

**Given** a user wants to make a decision record  
**When** the agent drafts the document  
**Then** it MUST negotiate missing context (problem, constraints, stakeholders) before finalizing  
**And** it MUST use templates that include status, context, decision, consequences, and alternatives  
**And** it MUST keep language generic for any Python project using this plugin.

#### Scenario: User needs README or changelog updates

**Given** documentation updates are requested  
**When** the agent proposes changes  
**Then** it MUST audit existing docs for gaps  
**And** it MUST structure updates with clear headings, examples, and verification steps  
**And** changelog entries MUST group changes by impact and call out migrations when applicable.

### Requirement: Skill integration is explicit and uses doc-specific skills

The agent MUST declare `openspec-authoring`, `spec-templates`, and `docs-style` as primary skills, and reference secondary skills only when relevant.

#### Scenario: Agent defines skill integration

**Given** the Skills Integration section is written  
**When** the primary and secondary skills are listed  
**Then** it MUST include the three documentation skills noted above as primary  
**And** all skill names MUST exist in `.claude/skills/` and appear in workflow "Skills Invoked" lists.

### Requirement: Tooling boundaries and validation are enforced

The agent MUST limit itself to allowed tools (read_file, glob, grep, patch/write), use markdown lint/format checks when available, and recommend `openspec validate` for change packages.

#### Scenario: Agent prepares deliverables

**Given** the agent finishes drafting a spec or doc  
**When** it suggests validation  
**Then** it MUST recommend running `openspec validate <change-id> --strict` for change packages  
**And** it MUST mention optional markdown lint/format checks  
**And** it MUST avoid proposing destructive commands (e.g., git reset) or non-approved tools.
