# Proposal: Doc & Spec Writer Agent

**Change ID:** `add-doc-spec-writer-agent`
**Status:** Draft
**Date:** 2025-11-18
**Author:** AI Assistant

## Executive Summary
Introduce a doc-and-spec-writer subagent that reliably produces OpenSpec-aligned proposals, tasks, and spec deltas while also drafting design docs, ADRs, READMEs, and changelogs. The agent will use dedicated documentation skills so documentation stays consistent, testable, and generic for any Python project using this plugin.

## Background
- OpenSpec manages change proposals in this repo, but we lack an agent purpose-built for spec/document authoring.
- Documentation responsibilities currently fall across general agents (technical-writer, requirements-analyst) without OpenSpec-specific rigor.
- We need a repeatable way to enforce metadata, section ordering, and scenario quality when generating specs and docs.

## Goals
- Add a `spec-writer` subagent that follows the hybrid agent pattern and OpenSpec authoring conventions.
- Provide reusable skills for doc style, templates, and OpenSpec rules to keep outputs consistent.
- Ensure the agent negotiates missing details instead of hallucinating, and runs lightweight checks where available.

## Scope / Non-Goals
- **In scope:** New agent definition, doc-focused skills, OpenSpec-ready workflows, and validation guidance.
- **Out of scope:** Changing existing command behavior, adding automation hooks, or altering plugin installation instructions.

## Approach
- Create a hybrid-pattern agent with workflows for OpenSpec packages, design docs/ADRs, README updates, and changelog drafting.
- Add supporting skills: documentation style, spec/document templates, and OpenSpec authoring conventions.
- Align workflows with allowed tools (read/glob/grep, markdown lint/format checks) and explicit skill invocation.
- Document tasks for implementing and validating the new capability.

## Risks & Mitigations
- **Risk:** Agent or skills become project-specific.  
  **Mitigation:** Keep examples generic and reference repo-wide guidance only.
- **Risk:** Missing OpenSpec details lead to incorrect proposals.  
  **Mitigation:** Require context gathering (`openspec/AGENTS.md`, `openspec/project.md`, active specs/changes) before drafting.
- **Risk:** Validation gaps.  
  **Mitigation:** Include `openspec validate <id> --strict` in tasks and encourage markdown linting where available.

## Validation & Metrics
- Agent file passes hybrid-agent-pattern requirements (frontmatter, required sections, skill references).
- Skills include trigger keywords and agent integration notes.
- Run `openspec validate add-doc-spec-writer-agent --strict` once delta files are in place.
- Manual spot-check: generate a proposal and ensure sections follow required ordering.

## Open Questions
- Should we add a lightweight markdownlint/prettier hook to support this agent by default?
- Do we need a dedicated docs/examples update in README to advertise the new agent and skills?
