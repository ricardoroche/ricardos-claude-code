# skill-agent-integration Specification

## Purpose
Define how skills integrate with agents so workflows trigger the right skills through explicit declarations, trigger keywords, and cross-references.

## Requirements

### Requirement: Trigger Language Mechanism

Agent workflows MUST use language that naturally triggers relevant skills.

#### Scenario: Workflow mentions technology with associated skill

**Given** an agent workflow is being executed  
**When** the workflow text contains skill trigger keywords  
**Then** Claude Code runtime activates the corresponding skill  
**And** the skill provides pattern enforcement during workflow execution

### Requirement: Explicit Skill Invocation Declaration

All agent workflows MUST explicitly list skills they invoke.

#### Scenario: Workflow declares skill dependencies

**Given** an agent workflow is defined  
**When** the workflow steps are written  
**Then** the workflow MUST end with "Skills Invoked:" section  
**And** list all skills triggered by the workflow's language

### Requirement: Skill Trigger Keyword Specification

All skills MUST explicitly declare trigger keywords in frontmatter or dedicated section.

#### Scenario: Skill defines activation triggers

**Given** a skill is being created  
**When** the skill file is written  
**Then** it MUST include a "Trigger Keywords" section  
**And** list keywords/phrases that activate this skill

### Requirement: Skill-Agent Cross-Reference

Skills and agents MUST cross-reference each other.

#### Scenario: Bidirectional linking

**Given** a skill is used by multiple agents  
**When** the skill file is created  
**Then** it MUST list agents in the "Agent Integration" section  
**And** when an agent file is created for an agent that uses multiple skills  
**Then** it MUST list those skills in the "Skills Integration" section

### Requirement: Multi-Skill Workflow Support

Agent workflows MUST support triggering multiple skills simultaneously so combined guidance can run.

#### Scenario: Complex workflow activates many skills

**Given** a workflow involves multiple technologies  
**When** the workflow is executed  
**Then** all relevant skills activate together  
**And** skills provide complementary guidance

### Requirement: Skill Activation Priority

When multiple skills trigger, they MUST work together without conflicts.

#### Scenario: Skills provide complementary guidance

**Given** multiple skills activate for a workflow step  
**When** patterns overlap (e.g., async-await-checker + fastapi-patterns both mention async)  
**Then** skills MUST provide complementary, non-conflicting guidance  
**And** each skill focuses on its domain expertise

### Requirement: Common Trigger Patterns

Agent workflows MUST include a reference table of common trigger phrases mapped to skills to guide authors toward consistent language.

#### Scenario: Reference table is present for authors

**Given** an agent workflow is being authored  
**When** the author looks for guidance on trigger phrases  
**Then** the spec MUST provide a table mapping phrases to skills  
**And** those mappings MUST include the skills listed in the workflow

### Requirement: Natural Language Triggers

Workflows MUST include natural-language examples that imply the technology or pattern to activate the appropriate skills.

#### Scenario: Natural-language examples guide authors

**Given** an agent author is writing a workflow  
**When** they look for examples of natural trigger language  
**Then** the spec MUST include examples that imply the intended skills  
**And** those examples MUST align with the skills declared in "Skills Invoked"
