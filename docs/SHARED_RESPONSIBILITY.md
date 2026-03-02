# Shared Responsibility Model

This document defines what the **user** is responsible for and what **Claude** is responsible for when using these workflows. Inspired by AWS's Shared Responsibility Model: the boundary between what the platform manages and what the customer owns.

---

## The Core Principle

**You own the problem. Claude owns the execution.**

You bring domain knowledge, decisions, and judgment about what's worth building. Claude brings research, structure, code, and autonomous follow-through. Neither side can do the other's job well.

---

## Responsibility Overview

| Area | User Responsibility | Claude Responsibility |
|------|--------------------|-----------------------|
| **Goals** | Define what to build and why | Ask clarifying questions, capture intent |
| **Scope** | Declare what's out of scope | Enforce the scope boundary during execution |
| **Decisions** | Make final calls on trade-offs | Present options with recommendations and trade-offs |
| **Domain knowledge** | Provide context about your business/system | Research codebase and technical options |
| **Approval** | Review and approve artifacts before proceeding | Generate accurate, validated artifacts |
| **Verification** | Confirm the result works in the real world | Run tests, validate code, report results |
| **Priorities** | Set design tenets and rank trade-offs | Apply tenets consistently throughout the workflow |

---

## By Workflow Phase

### Requirements

| User | Claude |
|------|--------|
| Fill out MISSION.md (goal, success criteria, out of scope) | Create the MISSION.md template, wait for user to complete it |
| Answer discovery questions honestly and completely | Conduct structured interview with up to 15 questions |
| Identify what's explicitly out of scope | Persist the Out of Scope section and reference it in later phases |
| Define success criteria | Capture them in REQUIREMENTS.md for validation later |
| Ask questions when recommendations are unclear | Research and answer user questions before proceeding |

### Design

| User | Claude |
|------|--------|
| Make the final call on each technology/architecture decision | Present recommendations with confidence levels (✓, ✓✓, ✓✓✓) |
| Override Claude's recommendations when you disagree | Explain trade-offs, not just conclusions |
| Provide context about team preferences and constraints | Discover existing codebase patterns before asking questions |
| Approve batches of design decisions (5 per round) | Batch recommendations to prevent rubber-stamping |
| Decide whether to create ADRs for significant decisions | Identify which decisions qualify as architecturally significant |

### Architecture

| User | Claude |
|------|--------|
| Review the generated ARCHITECTURE.md | Generate architecture directly from requirements + design |
| Request specific changes or additions | Validate internal consistency (no circular deps, all requirements covered) |
| Approve before moving to planning | Produce implementation-ready structure with real file paths |

### Planning

| User | Claude |
|------|--------|
| Review the generated IMPLEMENTATION_PLAN.md | Generate the full plan directly from architecture documents |
| Request step breakdowns or reordering | Validate that every requirement has a corresponding step |
| Confirm the plan before implementation starts | Ensure unit tests are planned inline, not deferred to the end |

### Implementation

| User | Claude |
|------|--------|
| Choose execution mode (autonomous or interactive) | Default to autonomous; only stop for genuine blockers |
| Make scope boundary decisions when escalated | Detect when work would cross into Out of Scope territory |
| Interrupt if something looks wrong | Pause and handle user input at any point |
| Confirm the feature works end-to-end | Run tests after each step, track status in IMPLEMENTATION_PLAN.md |
| Decide what to do with parking lot items | Capture out-of-scope discoveries in PARKING_LOT.md without stopping |

### Bug Tracking

| User | Claude |
|------|--------|
| Report symptoms: what you observed, steps to reproduce | Collect bug report, create BUG-NNN.md, update BUG_LIST.md |
| Confirm when a fix is verified (type 'verified') | Investigate root cause, write fix plan, implement fix |
| Decide whether to defer or close a bug | Update status through Reported → Investigating → Fixed → Verified |

### Quick Task

| User | Claude |
|------|--------|
| Confirm the task fits existing architecture | Verify scope against ARCHITECTURE.md before generating a plan |
| Approve the abbreviated IMPLEMENTATION_PLAN.md | Generate a 4–8 step plan (not the full 15–20 step pipeline) |
| Escalate if unexpected complexity is discovered | Flag complexity to the user and offer to escalate to the full pipeline |

---

## What Claude Never Decides Alone

These decisions always require explicit user input:

- **What to build** — goals and success criteria come from the user
- **What's out of scope** — Claude enforces the boundary but does not draw it
- **Technology trade-offs** — Claude recommends, user decides
- **Whether to proceed after a blocker** — Claude stops and presents options, user chooses
- **Whether a bug is worth fixing** — Claude investigates, user decides to fix, defer, or close
- **Approval to move between phases** — each phase requires the user to explicitly continue

---

## What the User Never Has to Do

These are Claude's job:

- Read and synthesize prior phase documents before starting each phase
- Explore the codebase to discover existing patterns
- Generate structured documents (REQUIREMENTS.md, DESIGN.md, ARCHITECTURE.md, etc.)
- Write code, run tests, and track step-by-step status
- Detect when scope creep is happening and surface it
- Enforce the Out of Scope section during implementation
- Produce recommendations with rationale rather than making silent choices

---

## The Interview Contract

Every interview-based phase follows a bidirectional Q&A:

- Claude asks → User answers (and can ask their own questions)
- Claude responds to user questions, then asks follow-ups
- Claude does not generate output documents until sufficient clarity is achieved

**Claude's obligation:** Ask questions that matter. Include a recommendation for each one. Research before answering user questions.

**User's obligation:** Engage honestly. Answers drive the output — vague answers produce vague documents.

---

## Scope Enforcement

Scope is defined in `MISSION.md` (Out of Scope section) and enforced throughout:

| Phase | How scope is enforced |
|-------|-----------------------|
| Requirements | Interview questions stay within the stated goal |
| Design | Decisions that require out-of-scope functionality are flagged |
| Implementation | Steps that would cross scope boundaries trigger the Diversion Protocol |
| Bug tracking | Bugs outside scope are Deferred with a suggested future epic |

**User responsibility:** Write an honest Out of Scope section. A blank or vague Out of Scope produces scope creep.

**Claude's responsibility:** Reference it at every phase. Never silently implement something listed as out of scope.

---

## Summary

The workflows function as a division of labor: the user provides direction and judgment, Claude provides structure and execution. The shared boundary is the interview — a space where both sides contribute to produce artifacts that neither could generate as well alone.
