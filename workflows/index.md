# Development Workflows

Interview-based workflows for structured software development with Claude Code.

## For Claude: Executing Workflows

The invocation syntax is:

```
execute [workflow] in [location]
```

Examples:
- `execute plan in ~/.workflows`
- `execute plan in $WORKFLOWS`
- `execute refinement in https://example.com/workflows/index.md`

### Step 1: Resolve the Location

If `[location]` looks like a shell variable (e.g., `$WORKFLOWS`), resolve it first:

```bash
echo $WORKFLOWS
```

Use the expanded value as `[location]`. Two forms are accepted:

| Form | Example | Notes |
|------|---------|-------|
| Local directory path | `~/.workflows` | Works — filesystem directories are listable |
| URL to `index.md` | `https://example.com/workflows/index.md` | Required — bare directory URLs return 404 on static sites |

If the URL ends with `/index.md`, strip that suffix to get the base: `https://example.com/workflows`

### Step 2: Determine Access Method

| Location type | Access method |
|--------------|---------------|
| Starts with `http://` or `https://` | WebFetch tool |
| Starts with `~/`, `/`, or `./` | Read tool |

### Step 3: Fetch the Workflow File

Construct the path: `[location]/[workflow-name]/workflow.md`

Examples:
- `~/.workflows/plan/workflow.md` → Read tool
- `https://example.com/workflows/plan/workflow.md` → WebFetch tool

### Step 4: Resolve Supporting Files

When a workflow references `PATTERNS.md`, `WRITING_GUIDE.md`, or a template, use the same base location:

- PATTERNS.md → `[location]/PATTERNS.md`
- WRITING_GUIDE.md → `[location]/WRITING_GUIDE.md`
- Templates → `[location]/templates/[filename]`

### Step 5: Create Artifacts Locally

All task folders, interview files, and output documents are created in the **current working directory** — not at the remote location.

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
| `bug-bash` | `bug-bash/workflow.md` | Systematic bug triage, fix, and verification |
| `bug` | `bug/workflow.md` | Single-bug lifecycle: record → investigate → plan → fix → verify |
| `quick-task` | `quick-task/workflow.md` | Lightweight implementation for small features |

### All Files in This Directory

```
index.md                             — This file (manifest and landing page)
PATTERNS.md                          — Core patterns used by all workflows
WRITING_GUIDE.md                     — Document writing and review standards

requirements/workflow.md             — Requirements workflow
design/workflow.md                   — Design workflow
architecture/workflow.md             — Architecture workflow
plan/workflow.md                     — Plan workflow
implement/workflow.md                — Implement workflow
documentation/workflow.md            — Documentation workflow
refinement/workflow.md               — Refinement workflow
bug-bash/workflow.md                 — Bug bash workflow
bug/workflow.md                      — Single-bug lifecycle workflow
quick-task/workflow.md               — Quick task workflow

templates/ADR_TEMPLATE.md            — Architecture Decision Record template
templates/ARCHITECTURE_TEMPLATE.md   — Architecture document template
templates/CLAUDE_PROJECT_TEMPLATE.md — Claude project guidelines template
```

## Work Breakdown Structure

Features are organized in three levels:

```
Epic  (high-level feature area — e.g., "Amazon Photos Integration")
 └── User Story  (implementable chunk — e.g., "Authenticate with Amazon Photos")
       └── Task  (tracked in claude/ task folder, implemented via a workflow below)
```

**When starting a new Epic:** run `requirements → design → architecture` at the epic level first, then break the epic into user stories. Each user story is then implemented via the `plan → implement` or `quick-task` workflow.

**When the scope is already clear** (small feature, clear requirements, fits existing architecture): go straight to `quick-task`.

---

## Workflow Sequence

```
[Epic level]
requirements → design → architecture → (story breakdown)
                                              │
                                    [User Story level]
                                    plan → implement → documentation
                                               ↑
                          refinement  (invoke at any time independently)
                          bug-bash    (invoke at any time independently — multi-bug triage)
                          bug         (invoke at any time independently — single bug lifecycle)
                          quick-task  (lightweight alternative to plan → implement for small stories)
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

See `PATTERNS.md` for complete pattern definitions used across all workflows. See `WRITING_GUIDE.md` for document writing and review standards.
