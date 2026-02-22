# Development Workflows

Interview-based workflows for structured software development with Claude Code.

## For Claude: Executing Workflows from a URL

When a user says `execute [workflow] from $WORKFLOWS` where `$WORKFLOWS` is a URL:

1. **Fetch the workflow file:** `$WORKFLOWS/[workflow-name]/workflow.md`
2. **Fetch PATTERNS.md when referenced:** `$WORKFLOWS/PATTERNS.md`
3. **Fetch templates when referenced:** `$WORKFLOWS/templates/[filename]`
4. **All artifact creation is local:** Task folders, interview files, and output documents are created in the current working directory — not at the URL

### Available Workflows

| Workflow Name | File Path | Purpose |
|--------------|-----------|---------|
| `requirements` | `requirements/workflow.md` | Requirements discovery through interview |
| `design` | `design/workflow.md` | Design decisions with recommendations |
| `architecture` | `architecture/workflow.md` | System structure and components |
| `plan` | `plan/workflow.md` | Detailed implementation planning |
| `implement` | `implement/workflow.md` | Step-by-step execution with status tracking |
| `documentation` | `documentation/workflow.md` | User and codebase documentation |
| `refinement` | `refinement/workflow.md` | Refactoring, cleanup, and reorganization |

### All Files in This Directory

```
index.md                             — This file (manifest and landing page)
PATTERNS.md                          — Core patterns used by all workflows

requirements/workflow.md             — Requirements workflow
design/workflow.md                   — Design workflow
architecture/workflow.md             — Architecture workflow
plan/workflow.md                     — Plan workflow
implement/workflow.md                — Implement workflow
documentation/workflow.md            — Documentation workflow
refinement/workflow.md               — Refinement workflow

templates/ADR_TEMPLATE.md            — Architecture Decision Record template
templates/ARCHITECTURE_TEMPLATE.md   — Architecture document template
templates/CLAUDE_PROJECT_TEMPLATE.md — Claude project guidelines template
```

## Workflow Sequence

```
requirements → design → architecture → plan → implement → documentation
                                                    ↑
                                   refinement (invoke at any time independently)
```

## Overview

Each workflow conducts a structured interview to gather context, then generates output documents. Each phase reads documents from prior phases, building progressively richer context.

| Phase | Reads | Produces |
|-------|-------|---------|
| requirements | — | REQUIREMENTS.md |
| design | REQUIREMENTS.md | DESIGN.md |
| architecture | REQUIREMENTS.md, DESIGN.md | ARCHITECTURE.md |
| plan | REQUIREMENTS.md, DESIGN.md, ARCHITECTURE.md | IMPLEMENTATION_PLAN.md |
| implement | IMPLEMENTATION_PLAN.md, ARCHITECTURE.md | Updated status tracking |
| documentation | All prior docs + codebase | docs/, ARCHITECTURE.md |
| refinement | (independent) | REFINEMENT_PLAN.md |

See `PATTERNS.md` for complete pattern definitions used across all workflows.
