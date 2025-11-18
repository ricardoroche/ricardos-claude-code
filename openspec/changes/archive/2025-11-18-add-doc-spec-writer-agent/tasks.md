# Implementation Tasks

**Change ID:** `add-doc-spec-writer-agent`
**Status:** Draft

## Overview
Work to add a doc-and-spec-writer agent with supporting documentation skills and OpenSpec validation.

## Tasks

- [x] **Create doc-and-spec-writer agent**
  - [x] Add `.claude/agents/spec-writer.md` using the hybrid agent pattern
  - [x] Include workflows for OpenSpec packages, design docs/ADRs, README updates, and changelogs
  - [x] Declare primary skills and ensure skill references exist
  - **Validation**: Agent structure passes hybrid-agent-pattern requirements

- [x] **Add documentation support skills**
  - [x] Add `docs-style` skill with voice, structure, and quality checklist
  - [x] Add `spec-templates` skill with outlines for proposals, tasks, specs, ADRs, READMEs, changelogs
  - [x] Add `openspec-authoring` skill covering metadata, ordering, scenarios, and validation
  - **Validation**: Each skill lists trigger keywords and agent integrations

- [x] **Wire skills to agent**
  - [x] Confirm agent workflows list relevant skills per workflow
  - [x] Ensure skills reference the agent in Agent Integration sections
  - **Validation**: Cross-references are consistent and use backticked names

- [x] **Quality and validation**
  - [x] Run markdown lint/format checks if available
  - [x] Run `openspec validate add-doc-spec-writer-agent --strict`
  - [x] Address any validation findings before handoff
