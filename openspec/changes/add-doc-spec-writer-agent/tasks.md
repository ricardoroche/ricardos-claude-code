# Implementation Tasks

**Change ID:** `add-doc-spec-writer-agent`
**Status:** Draft

## Overview
Work to add a doc-and-spec-writer agent with supporting documentation skills and OpenSpec validation.

## Tasks

- [ ] **Create doc-and-spec-writer agent**
  - [ ] Add `.claude/agents/spec-writer.md` using the hybrid agent pattern
  - [ ] Include workflows for OpenSpec packages, design docs/ADRs, README updates, and changelogs
  - [ ] Declare primary skills and ensure skill references exist
  - **Validation**: Agent structure passes hybrid-agent-pattern requirements

- [ ] **Add documentation support skills**
  - [ ] Add `docs-style` skill with voice, structure, and quality checklist
  - [ ] Add `spec-templates` skill with outlines for proposals, tasks, specs, ADRs, READMEs, changelogs
  - [ ] Add `openspec-authoring` skill covering metadata, ordering, scenarios, and validation
  - **Validation**: Each skill lists trigger keywords and agent integrations

- [ ] **Wire skills to agent**
  - [ ] Confirm agent workflows list relevant skills per workflow
  - [ ] Ensure skills reference the agent in Agent Integration sections
  - **Validation**: Cross-references are consistent and use backticked names

- [ ] **Quality and validation**
  - [ ] Run markdown lint/format checks if available
  - [ ] Run `openspec validate add-doc-spec-writer-agent --strict`
  - [ ] Address any validation findings before handoff
