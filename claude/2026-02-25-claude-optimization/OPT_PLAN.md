# Optimization Plan: Claude Workflow Study

## Overview

This plan drives the Claude Optimization Study, producing `CLAUDE_OPTIMIZATION.md` — a report with findings and recommendations for improving workflow ease-of-use, Claude efficiency, and on-task focus.

Research is complete (Session 1 — 2026-02-25). Findings are captured in `OPT_NOTES.md`.
This plan now drives the analysis and report generation phases.

## Prerequisites

- [x] Workflows reviewed: `gen-ai-dev-kit/workflows/`
- [x] Photo-manager project reviewed: `_c/photo-manager/claude/` (all 12 task folders + project_management)
- [x] Weblog project reviewed: `projects/weblog/claude/` (both task folders)
- [x] Rev-eng projects reviewed: `rev_eng/amzn_photos_rev_eng/`, `rev_eng/lrd_rev_eng/`, `rev_eng/nxstud/`
- [x] Initial findings appended to `OPT_NOTES.md`

---

## Implementation Steps

### Step 1: Deep-Read Key Task Artifacts

**What:** Read representative MISSION.md, REQUIREMENTS_INTERVIEW.md, DESIGN_INTERVIEW.md, and IMPLEMENTATION_PLAN.md files from different epics to assess interview experience quality.
**Files to examine:**
- `_c/photo-manager/claude/2026-02-07-outer-shell-work/MISSION.md`
- `_c/photo-manager/claude/2026-02-08-file-indexing-photo-identity/MISSION.md`
- `_c/photo-manager/claude/2026-02-15-navigation-history/MISSION.md`
- Representative REQUIREMENTS_INTERVIEW.md and DESIGN_INTERVIEW.md from any task
- `_c/photo-manager/claude/2026-02-21-raw-rendering/IMPLEMENTATION_INTERVIEW.md`
**Dependencies:** None
**Expected outcome:** Clear picture of interview verbosity, question quality, user experience friction
**Verification:**
- [ ] OPT_NOTES.md updated with interview experience findings

---

### Step 2: Analyze Workflow Gaps vs. Actual Usage

**What:** Compare the 7 existing workflows (requirements, design, architecture, plan, implement, documentation, refinement) against the actual documents users created. Map which workflows covered which use cases and which gaps exist.
**Analysis approach:**
- List all non-standard document types found in research
- For each: identify which workflow (if any) covers it
- Flag gaps where users improvised without workflow support
**Dependencies:** Step 1
**Expected outcome:** Gap matrix showing covered vs. uncovered use cases
**Verification:**
- [ ] OPT_NOTES.md updated with gap matrix

---

### Step 3: Assess Session Start / Context Management

**What:** Evaluate how Claude gets oriented at the start of each session and how well the current patterns support that. Look at MISSION.md structure, PRODUCT_WINDSHIELD.md, and Task Folder Management Pattern.
**Analysis approach:**
- What context does Claude need at session start?
- How many files must be read before Claude is productive?
- Is there a standard "session primer" step?
- Does WINDSHIELD.md serve this purpose for the user?
**Dependencies:** None
**Expected outcome:** Findings on session start friction and orientation overhead
**Verification:**
- [ ] OPT_NOTES.md updated with session-start findings

---

### Step 4: Assess On-Task Focus Mechanisms

**What:** Evaluate how well current workflows keep Claude on task when diversions arise — user questions, research discoveries, scope creep during implementation.
**Analysis approach:**
- Review IMPLEMENTATION_INTERVIEW.md (raw-rendering) — how were blockers handled?
- Look at bug-bash MISSION.md — was scope maintained?
- Review NEFVIEW-GAPS.md — how was research discovery absorbed without derailing?
- Evaluate PRODUCT_WINDSHIELD.md as a focus anchor
**Dependencies:** Step 1
**Expected outcome:** Findings on diversion handling and parking-lot mechanisms
**Verification:**
- [ ] OPT_NOTES.md updated with on-task focus findings

---

### Step 5: Evaluate Interview Pattern Usability

**What:** Assess the Interview Pattern (in PATTERNS.md) from a user experience perspective. How natural is "iterate"/"continue to next phase"? How well do 15-question rounds work? Is the bidirectional Q&A structure effective?
**Analysis approach:**
- Review REQUIREMENTS_INTERVIEW.md and DESIGN_INTERVIEW.md from multiple epics
- Count questions per round, assess answer depth
- Look for signs of user fatigue (short answers, skipped questions)
- Assess whether 1 round vs. 2+ rounds was typical
**Dependencies:** Step 1
**Expected outcome:** Specific usability improvements to the Interview Pattern
**Verification:**
- [ ] OPT_NOTES.md updated with interview usability findings

---

### Step 6: Identify New Workflows Needed

**What:** Based on gaps identified in Step 2, define new workflows that would cover unaddressed use cases.
**Candidates to evaluate:**
- `quick-task` — For small tasks: MISSION.md → direct implementation (no interview phases)
- `bug-bash` — BUG_LIST.md triage, fix loop, MANUAL_TESTING.md structure
- `rev-eng` — AGENTS.md, step plan, findings documents, NEXT.md progression
- `session-start` — Orient Claude quickly at start of session using existing context
- `gap-analysis` — Post-implementation: compare implementation vs. plan, document drift
**Dependencies:** Step 2
**Expected outcome:** Short spec for each proposed new workflow (purpose, trigger, output)
**Verification:**
- [ ] OPT_NOTES.md updated with new workflow specs

---

### Step 7: Identify Pattern Improvements

**What:** For each existing workflow and pattern, identify specific improvements based on the research findings.
**Key areas:**
- Task Folder Management: is suggested naming format followed? Any friction?
- Interview Pattern: question count, round length, command names
- Research Spike Pattern: when triggered, how integrated
- Status Tracking Convention: are status tables maintained? Alternative approaches?
- MISSION.md: formalize as Step 0 of all workflows (it's always done but not in spec)
- EXISTING_PATTERNS.md: make a standard design phase output instead of ad hoc
**Dependencies:** Steps 2, 3, 4, 5
**Expected outcome:** Ranked list of pattern changes with rationale
**Verification:**
- [ ] OPT_NOTES.md updated with pattern improvement recommendations

---

### Step 8: Draft CLAUDE_OPTIMIZATION.md

**What:** Synthesize all findings into the final report covering the three optimization goals:
1. Ease of use (user experience)
2. Claude efficiency (token/context management, orientation speed)
3. On-task focus (diversion handling, scope management)

**Document Structure:**
```
# Claude Workflow Optimization Report

## Executive Summary
## Methodology
## Findings by Optimization Goal
  ### 1. Ease of Use
  ### 2. Claude Efficiency
  ### 3. On-Task Focus
## Gap Analysis: Existing Workflows vs. Actual Usage
## Recommended New Workflows
## Recommended Pattern Changes
## Recommended Workflow Improvements
## Implementation Roadmap
## Appendix: Evidence Inventory
```
**Dependencies:** Steps 1–7
**Expected outcome:** Complete CLAUDE_OPTIMIZATION.md report ready for review
**Verification:**
- [ ] All three optimization goals addressed
- [ ] Specific, actionable recommendations (not just observations)
- [ ] Evidence cited from actual project files

---

### Step 9: Review and Iterate

**What:** Present CLAUDE_OPTIMIZATION.md for user review. Incorporate feedback. Finalize.
**Dependencies:** Step 8
**Expected outcome:** Final approved report
**Verification:**
- [ ] User confirms report is complete and accurate
- [ ] Any requested changes incorporated

---

## Status Tracking

| Step | Status | Notes |
|------|--------|-------|
| 1. Deep-read task artifacts | Complete | MISSION.md quality high; PLAN_INTERVIEW 0/1; IMPLEMENTATION_INTERVIEW best format for blockers |
| 2. Analyze workflow gaps | Complete | 8 missing use cases; bug-bash, quick-task, research-spike, test-plan, project-mgmt, post-impl, rev-eng, session-start |
| 3. Assess session start / context | Complete | 18–25 min new epic startup; PROJECT_CONTEXT.md would reduce to 5–8 min |
| 4. Assess on-task focus mechanisms | Complete | No parking lot; no live scope check; diversion protocol missing; bug-bash "Deferred → Epic X" is best practice |
| 5. Evaluate interview usability | Complete | 10–12 Qs better than 15; bulk design acceptance risky; add importance indicators; Round 2 status check-in |
| 6. Identify new workflows needed | Complete | 8 new workflows/patterns specified: bug-bash (HIGH), quick-task (HIGH), session-start (HIGH), project-mgmt, test-plan, post-impl-review, research-spike, rev-eng |
| 7. Identify pattern improvements | Complete | 23 improvements across all workflows; highest ROI: PROJECT_CONTEXT.md, MISSION.md Standard, Parking Lot Pattern, Diversion Decision Tree, Round 1 question reduction |
| 8. Draft CLAUDE_OPTIMIZATION.md | Complete | Full report written: exec summary, methodology, findings by goal, gap analysis, new workflows, pattern changes, workflow improvements, implementation roadmap, evidence appendix |
| 9. Review and iterate | Complete | Self-review done; fixed research-spike priority inconsistency and added IMPLEMENTATION_REVIEW_GUIDE.md to coverage matrix; presented to user |

---

## Notes on Approach

- **OPT_NOTES.md is append-only** — all observations go there as we work through steps
- **Evidence-based** — every recommendation cites specific files/patterns observed
- **Actionable output** — report must produce concrete workflow changes, not just meta-analysis
- Steps 1–5 are research steps that can be parallelized where independent
- Steps 6–7 depend on completing Steps 2–5 respectively
- Step 8 depends on all prior steps
