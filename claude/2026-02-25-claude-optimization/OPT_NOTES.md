# Optimization Study Notes

> Append-only log of findings, observations, and insights.

---

## [2026-02-25] Session 1: Initial Research

### Scope Assessed
- Reviewed all workflows in `/home/psgivens/utils/gen-ai-dev-kit/workflows/`
- Reviewed ~100 markdown files across:
  - `_c/photo-manager/claude/` (12 task folders + project_management + archive)
  - `projects/weblog/claude/` (2 task folders)
  - `rev_eng/amzn_photos_rev_eng/`, `rev_eng/lrd_rev_eng/`, `rev_eng/nxstud/`

### Key Patterns Observed in Practice

**Workflow Adherence:**
- Large feature epics follow the full requirements → design → architecture → plan → implement sequence
- Bug-bash work bypasses formal workflows entirely: user creates BUG_LIST.md + MANUAL_TESTING.md ad hoc
- Small touchups use MISSION.md + REFINEMENT.md — skip requirements/design/architecture
- Research spikes (NX Studio, NEF gap analysis) are embedded within task folders but have no formal structure

**Non-Standard Documents Users Create:**
- MISSION.md (always — even when not in workflow spec, user creates this every time)
- EXISTING_PATTERNS.md (for new technology areas)
- BUG_REPORT.md / BUG_LIST.md (comprehensive bug tracking)
- MANUAL_TESTING.md (explicit test procedures)
- SUMMARY.md (post-refactor overview)
- GAP_ANALYSIS.md (implementation vs. spec drift — weblog project)
- DOCUMENTATION_ASSESSMENT.md (what docs need updating post-feature)
- SEED.md (high-level context before workflow — weblog project)
- AGENTS.md (work distribution in rev_eng projects)
- NEXT.md (incremental progress in rev_eng)

**Project Management:**
- Two-tier system: project_management/ (ROADMAP, BACKLOG, WINDSHIELD, REARVIEW, BUGS) + per-task claude/ folders
- WINDSHIELD.md = immediate focus, REARVIEW.md = completed work — very effective navigation tool
- Bug tracking separate from features (PRODUCT_BUGS.md) — bugs can be open across epics

### Pain Points Observed

1. **Stale Implementation Plans** — Plans go out of sync with code; GAP_ANALYSIS.md becomes source of truth
2. **No Bug-Bash Workflow** — Users create BUG_LIST.md manually with no structure guidance
3. **No Quick Task Workflow** — For small tasks that don't warrant full requirements/design/architecture pipeline
4. **Research Spikes Informal** — NX Studio analysis, NEF gap analysis have no workflow home
5. **Session Start Friction** — Each session, Claude must re-read all context to get oriented
6. **Interview Commands Non-Obvious** — "iterate" / "continue to next phase" require memorization
7. **MISSION.md Is Always First** — But not formally part of any workflow spec
8. **Research Findings Embedded** — Research docs live in task folders with no cross-task discoverability
9. **Rev Eng Has Unique Structure** — AGENTS.md, NEXT.md, step-plan.md not covered by existing workflows
10. **Implementation Plans Don't Self-Update** — Status tables require manual maintenance; often get abandoned

### Proposed New Workflows / Patterns
- **quick-task workflow** — MISSION.md + direct implementation; skip interview phases
- **bug-bash workflow** — BUG_LIST.md creation, triage, fix loop, MANUAL_TESTING.md
- **rev-eng workflow** — AGENTS.md, step plan, findings docs, NEXT.md progression
- **session-start pattern** — Read WINDSHIELD.md, read relevant task context, echo status
- **gap-analysis pattern** — Post-implementation: compare implementation vs. plan, document drift

---

## [2026-02-25] Session 1: Steps 6–7 Findings

---

### Step 6 Findings: New Workflow Specs

Eight new workflows/patterns specified. Summary:

| # | Name | Type | Priority | Output Artifacts |
|---|------|------|----------|-----------------|
| 1 | **bug-bash** | Workflow | HIGH | BUG_LIST.md, MANUAL_TESTING.md |
| 2 | **quick-task** | Workflow | HIGH | MISSION.md, IMPLEMENTATION_PLAN.md |
| 3 | **research-spike** | Workflow | MEDIUM | RESEARCH_FINDINGS.md, RESEARCH_DECISION.md |
| 4 | **test-plan** | Workflow | MEDIUM | TEST_PLAN.md |
| 5 | **project-management** | Workflow | MEDIUM | PRODUCT_ROADMAP.md, PRODUCT_BACKLOG.md, WINDSHIELD.md, REARVIEW.md |
| 6 | **post-impl-review** | Workflow | MEDIUM | GAP_ANALYSIS.md, DOCUMENTATION_ASSESSMENT.md |
| 7 | **rev-eng** | Workflow | MEDIUM | AGENTS.md, ARCHITECTURE.md, FINDINGS.md, PORT_READINESS_CHECKLIST.md |
| 8 | **session-start** | Pattern | HIGH | (console output only — no artifacts) |

**Implementation order recommendation:**
- Wave 1 (HIGH): bug-bash, quick-task, session-start pattern
- Wave 2 (MEDIUM): project-management, test-plan, post-impl-review
- Wave 3 (Situational): research-spike, rev-eng

**Key design decisions per workflow:**
- **bug-bash**: BUG_LIST.md as source of truth; explicit Open/Fixed/Deferred/Closed status; "Deferred → Epic X" with rationale; MANUAL_TESTING.md verification before marking Fixed; no interview phase (bugs are self-explanatory); continuous discovery loop after each fix
- **quick-task**: Scope guard is critical — explicit check that feature fits existing ARCHITECTURE.md before proceeding (escalate to full workflow if not); no REQUIREMENTS/DESIGN/ARCHITECTURE interviews; IMPLEMENTATION_PLAN inferred directly from MISSION + ARCHITECTURE; minimal documentation
- **research-spike**: Time-boxed (not open-ended); Options + recommendation, not just findings; decision gate required before implementation; separate from Interview Pattern; mark inferences clearly as [inferred]
- **test-plan**: Interview only for testing philosophy (tools, coverage goals, critical paths); test cases mapped to each implementation step; executable test cases (arrange/act/assert); explicit coverage goals (%, not "test everything")
- **project-management**: Interview-driven prioritization; WINDSHIELD vs REARVIEW separate docs; roadmap is effort units not calendar dates; feature dependencies explicit; living documents (WINDSHIELD updated after each session)
- **post-impl-review**: Requirement-driven comparison (each requirement verified); fix prioritization (must-fix / should-fix / nice-to-have); DOCUMENTATION_ASSESSMENT equal to GAP_ANALYSIS; no automatic remediation — present to user
- **rev-eng**: Decompilation first; components before details; PORT_READINESS explicit; mark all inferences with [inferred]; working names for obfuscated code
- **session-start**: Read order matters — WINDSHIELD → MISSION → IMPLEMENTATION_PLAN; read-only, no artifacts; echo is brief (5 lines max); supports multiple task folders

---

### Step 7 Findings: Pattern and Workflow Improvement Specs

23 specific improvements specified across all existing workflows and PATTERNS.md. Summary by priority:

#### HIGH Priority Improvements

| # | Target | Change |
|---|--------|--------|
| 1 | PATTERNS.md Interview Pattern | Round 1: 10–12 high-value questions (not 15); add question selection strategy |
| 2 | PATTERNS.md Interview Pattern | Add HIGH/MEDIUM/LOW importance indicators to each question |
| 3 | PATTERNS.md Interview Pattern | Add status check-in after Round 2+ with explicit "continue or generate doc?" choice |
| 7 | PATTERNS.md (new) | Parking Lot Pattern — PARKING_LOT.md structure, decision tree, integration with implement workflow |
| 8 | PATTERNS.md (new) | Diversion Decision Tree Pattern — blocking? → IMPLEMENTATION_INTERVIEW; good idea? → PARKING_LOT; irrelevant? → discard |
| 9 | PATTERNS.md (new) | MISSION.md Standard Pattern — formalize as required Step 0; add Out of Scope, Code Entry Points, Git Branch sections |
| 11 | requirements/workflow.md | Require "Out of Scope" section in REQUIREMENTS.md output |
| 14 | architecture/workflow.md | Require "Code Entry Points" section in ARCHITECTURE.md (CRITICAL for Claude orientation) |
| 15 | plan/workflow.md | Replace PLAN_INTERVIEW with template-based planning: draft plan from architecture, user reviews/approves |
| 23 | All workflows + PATTERNS.md | PROJECT_CONTEXT.md standard: project-wide reference (tech stack, directory structure, patterns, gotchas, commands); read at Step 1 of every workflow; reduces session startup 18–25 min → 5–8 min |

#### MEDIUM Priority Improvements

| # | Target | Change |
|---|--------|--------|
| 4 | PATTERNS.md Interview Pattern | Phase boundary guidance — what belongs in requirements vs. design vs. architecture vs. plan |
| 5 | PATTERNS.md Design Interview | Limit design recommendations to 5 per batch; explicit "refine any of these?" prompt after each batch |
| 6 | PATTERNS.md Task Folder Management | Smarter disambiguation — infer context first, then suggest best match folder |
| 10 | requirements/workflow.md | Reorder to make MISSION.md creation explicit Step 1 (not buried) |
| 12 | design/workflow.md | Limit design batches to 5 per round; add batch completion prompt |
| 13 | design/workflow.md | Make EXISTING_PATTERNS.md a standard Step 1 output (not optional) |
| 16 | implement/workflow.md | Create PARKING_LOT.md as standard Step 0 output (empty, ready for use) |
| 17 | implement/workflow.md | Add scope-check language to review gates: "Did this step stay within REQUIREMENTS.md?" |
| 18 | implement/workflow.md | Reference Diversion Decision Tree in workflow instructions |
| 19 | implement/workflow.md | Spike time-box protocol: 30-min max for research; escalate to IMPLEMENTATION_INTERVIEW if not resolved |
| 20 | implement/workflow.md | Add "Out of Scope" validation in Step 1 pre-implementation reading |
| 21 | documentation/workflow.md | Require at least one actual doc artifact (not just assessment) before closing |
| 22 | refinement/workflow.md | Add decision tree distinguishing refinement vs. quick-task; clarify trigger |

#### Key Cross-Cutting Insight
**PROJECT_CONTEXT.md** is the single highest-ROI change identified. Every workflow's Step 1 should check for and read it. Currently, this information is scattered across ARCHITECTURE.md, REARVIEW.md, code files, and must be re-derived every session. A single 100–150 line document covering tech stack, directory structure, entry points, patterns, gotchas, and commands would cut new-epic startup time by ~70%.

**MISSION.md Standard** is the second highest-ROI change: adding Out of Scope, Code Entry Points, and Git Branch sections to the existing template costs ~10 lines per MISSION.md but provides huge returns in scope management and Claude orientation.

---

## [2026-02-25] Session 1: Steps 1–5 Deep Research Findings

---

### Step 1 Findings: MISSION.md Quality and Interview Experience

#### MISSION.md Structure (Consistent Across All Epics)
All MISSION.md files contain: What I Want to Build / Problem I'm Solving / Success Criteria / Context / Next Step.
- **Strength**: Consistently high quality; orients Claude to scope, problem, and success criteria immediately
- **Strength**: Inter-epic dependencies clearly stated (e.g., "Epic 2a — the data layer that Epic 2b will wrap")
- **Weakness**: No "Non-Goals / Out of Scope" section — what we're NOT doing is undocumented
- **Weakness**: No code entry points — no file paths, no "start here" guidance for Claude
- **Weakness**: No links to related completed epics' MISSION.md for dependency chain
- **Weakness**: "Next Step" instruction (always "Execute the [phase] workflow") is redundant boilerplate
- **Weakness**: No timeline/priority context

#### Interview Experience Summary

| Interview | Rounds | Total Qs | User Engagement | Quality |
|-----------|--------|----------|-----------------|---------|
| core-viewer REQUIREMENTS | 3 | 24 | HIGH | High |
| outer-shell REQUIREMENTS | 2 | 20 | Medium | High |
| file-indexing REQUIREMENTS | 1+ | 15+ | LOW (rubber-stamp) | Medium |
| navigation-history REQUIREMENTS | 2 | 17 | HIGH | High |
| slide-show REQUIREMENTS | 3 | 23 | Medium-High | Medium-Good |
| initial-weblog PLAN_INTERVIEW | 1 | 10 | FAILED (zero answers) | Failed |
| raw-rendering IMPLEMENTATION_INTERVIEW | 1 | 1 | Decisive | Excellent |

**Key user behaviors observed:**
- ~65% of answers: full, multi-sentence with rationale
- ~25% of answers: brief (1–5 words, accepting recommendations)
- ~10%: counter-questions or scope redirections ("that's a design question")
- <5%: blank/no answer
- 11 counter-questions across 11 files — ~1 per 20–30 questions asked
- No evidence of users abandoning interviews early or skipping to "continue"

#### PLAN_INTERVIEW Pattern: 0/1 Success Rate
The planning interview (initial-weblog-generator) failed completely — user answered zero of 10 questions. Possible causes: decision fatigue, mismatch between Q&A format and planning, scope already clear from MISSION.md. **Recommendation: Replace PLAN_INTERVIEW with template-based planning.**

#### IMPLEMENTATION_INTERVIEW as Best Practice
The raw-rendering blocker interview was the most effective document in the sample: structured as "Problem → 3 Options with pros/cons → Decision Question." User answered in 1 sentence. Format: recommendation + decision > open-ended discovery for technical blockers.

---

### Step 2 Findings: Workflow Gap Analysis

#### Coverage Summary

| Document / Use Case | Covered By | Status |
|---|---|---|
| REQUIREMENTS.md, DESIGN.md, ARCHITECTURE.md | requirements, design, architecture | Fully Covered |
| IMPLEMENTATION_PLAN.md | plan | Fully Covered |
| MISSION.md | requirements (optional) | Covered but not formalized as Step 0 |
| REFINEMENT_PLAN.md | refinement | Fully Covered |
| DOCUMENTATION_ASSESSMENT.md | documentation | Fully Covered |
| EXISTING_PATTERNS.md | design | Fully Covered |
| BUG_REPORT.md / BUG_LIST.md | **None** | **Not Covered** |
| MANUAL_TESTING.md | None | **Not Covered** |
| SUMMARY.md | None | **Not Covered** |
| GAP_ANALYSIS.md | None | **Not Covered** |
| TEST_IMPLEMENTATION_PLAN.md | None | **Not Covered** |
| IMPLEMENTATION_REVIEW_GUIDE.md | None | **Not Covered** |
| PRODUCT_ROADMAP/BACKLOG/WINDSHIELD/REARVIEW/BUGS | **None** | **Not Covered** |
| Research spike docs (NEF_RENDERING, RAW_RENDERING, NX-STUD) | None | **Not Covered** |
| AGENTS.md, NEXT.md, rev_eng_plan.md | **None** | **Not Covered** |

#### 8 Distinct Missing Use Cases (Ranked by Priority)

1. **Bug triage & fix tracking** — BUG_LIST.md, BUG_REPORT.md, PRODUCT_BUGS.md, fix cycle
2. **Quick task (small feature, reuse existing architecture)** — INDEX_CLI_IMPL_PLAN.md, TEST_IMPLEMENTATION_PLAN.md evidence
3. **Research spikes / proof of concept** — NEF_RENDERING_RESEARCH.md, NX-STUD-METHOD.md, NEFVIEW-GAPS.md evidence
4. **Test planning & strategy** — TEST_IMPLEMENTATION_PLAN.md as a separate 7-section epic
5. **Project-level management** — PRODUCT_ROADMAP, BACKLOG, WINDSHIELD, REARVIEW, BUGS_CLOSED; user creates features plan, Claude converts to roadmap
6. **Post-implementation assessment** — GAP_ANALYSIS.md, DOCUMENTATION_ASSESSMENT.md
7. **Reverse engineering / codebase study** — 13-phase plan in rev_eng_plan_update.md; AGENTS.md; PORT_READINESS_CHECKLIST.md
8. **Session re-entry / context alignment** — next.md, IMPLEMENTATION_REVIEW_GUIDE.md evidence

#### Workflow Frequency in Practice
- **Most used**: requirements, plan, implement (every major feature)
- **Moderately used**: design, architecture (sometimes skipped for smaller features)
- **Under-used**: documentation (assessment created, follow-through sporadic), refinement (no formal REFINEMENT_PLAN.md found in sample)
- **Testing phase**: Always an afterthought — TEST_IMPLEMENTATION_PLAN.md created separately post-implementation

---

### Step 3 Findings: Session Start / Context Management

#### WINDSHIELD/REARVIEW Effectiveness: 6/10
- **Works well**: Orients to immediate decision point; shows what's been completed
- **Critical gap**: Assumes architectural understanding — no tech stack, no code locations, no established patterns
- **Critical gap**: No "decision rationale" — ROADMAP captures decisions but not reasoning behind them
- **Critical gap**: No consolidated "known gotchas" (off-by-one bug in history, scan history refresh issue, etc.)
- **Reading load**: ~3–4 minutes to absorb both documents

#### MISSION.md as Session Anchor: 7/10
- **Works well**: Problem, scope, and success criteria immediately clear; inter-epic dependencies visible
- **Critical gap**: No code entry points (WHERE in codebase does this live?)
- **Critical gap**: No "patterns to follow" — Claude must discover from code
- **Critical gap**: No reference to previously completed work or git branches
- **Reading load**: ~2–3 minutes per MISSION.md

#### Session Start Reading Load (Current State)
| Scenario | Time Estimate |
|----------|--------------|
| Starting a new epic | 18–25 min |
| Resuming mid-epic | 6–9 min |
| Bug fix | 8–14 min |
| Quick question | 5–6 min |

#### Cross-Session State Loss (Critical)
Information Claude must re-derive every session (NOT captured in any document):
1. File structure / directory layout / entry points
2. Redux slice names and relationships
3. IPC channel naming conventions
4. Established patterns (e.g., "history records AFTER action completes, not before")
5. Technology version specifics
6. Known gotchas (scattered across REARVIEW, not consolidated)
7. Test location and framework

#### Recommended Fix: PROJECT_CONTEXT.md
A 100–150 line project-level reference file: tech stack with versions, directory structure, entry points, Redux slice inventory, key architectural patterns, known gotchas, build/test commands, IPC channel conventions, test framework and locations. If read first at session start, reduces new-epic startup from 18–25 min → 5–8 min.

---

### Step 4 Findings: On-Task Focus Mechanisms

#### What Currently Works Well
- **Interview pattern for blockers**: Structured IMPLEMENTATION_INTERVIEW (Problem → Options → Decision) keeps Claude from silently pivoting. User decides direction with full context.
- **BUG_LIST.md as scope anchor**: "Deferred → Epic X" pattern with rationale is the most effective scope-enforcement mechanism observed. Prevents bugs from becoming scope creep.
- **Review gates in implement workflow**: Step-by-step checkpoints with explicit continue/iterate work well.
- **"Not Bugs (Out of Scope)" section in BUG_REPORT.md**: Explicitly naming what is NOT being fixed is a scope enforcement mechanism.

#### What Is Missing

1. **No parking lot mechanism** — Good ideas found during implementation have no home. Either lost or interrupt user with questions. Bug-bash's "Deferred → Epic X" pattern should be formalized as PARKING_LOT.md in implement workflow.

2. **No live scope-creep detection** — GAP_ANALYSIS.md is post-hoc. No live check during implementation: "Am I implementing something not in REQUIREMENTS.md?"

3. **No research/spike boundaries** — No formal guidance on time-boxing research, when to surface as blocker vs. continue, or how deep to investigate before returning to task.

4. **No diversion handling protocol** — When Claude discovers something out of scope, no decision tree: Is it blocking? → IMPLEMENTATION_INTERVIEW. Is it a good idea? → PARKING_LOT.md. Is it irrelevant? → Discard.

5. **No explicit out-of-scope section** — REQUIREMENTS.md states what IS needed; no "explicitly not doing" list. MISSION.md also lacks this.

#### Evidence of Uncontrolled Drift
- Weblog GAP_ANALYSIS.md: data injection changed from `<script type="application/json">` (design spec) to `window.__slideshowData` during implementation — detected retroactively, not prevented live.
- NEFVIEW-GAPS.md (176 lines of technical analysis): bounded by its own section structure, not by any formal scope mechanism.

#### Recommended Mechanisms (Ranked)
1. **PARKING_LOT.md** as standard implement workflow output — captures deferred items with description, step-found, reason, priority, planned-epic
2. **Scope check in review gates** — After each step: "Scope check: stayed within REQUIREMENTS? Items to parking lot: N"
3. **Formal diversion decision tree** in implement workflow instructions
4. **Spike time-box protocol** — Define question upfront, set boundary, surface as blocker after boundary, never implement without decision gate
5. **"Out of Scope" section** required in MISSION.md and REQUIREMENTS.md

---

### Step 5 Findings: Interview Pattern Usability

#### Question Count Statistics
- **Initial round**: 7–15 questions (15 most common; later epics used 7–10 after patterns established)
- **Follow-up rounds**: 1–5 questions (typically 4–5)
- **Total per interview**: 14–30 questions across 1–5 rounds
- **Convergence**: Most interviews converged in 2–3 rounds; longest was 5-round requirements (weblog, greenfield complexity, justified)
- **No evidence of iteration fatigue** in any file across 11 interview documents

#### Question Quality Assessment
- **~65% high-value questions**: required user domain knowledge, produced new information
- **~15% redundant/confirmatory**: Claude had already proposed answer, just needed "yes" — wasted question slots
- **~20% out-of-phase**: design questions in requirements, or vice versa — users correctly redirected
- Best questions: operationalized vague terms ("how many photos? what's too slow?"), revealed implicit priorities ("state preservation is super important"), connected requirements to architecture impacts ("this affects build times")
- Worst questions: "Does this list of states look right?" style — confirmations with no discovery value

#### Design Interview Risk: Bulk Acceptance
File-indexing DESIGN_INTERVIEW: user rubber-stamped 15 design decisions with "Recommendation accepted" (including typo). No scrutiny of 15 major decisions. Risk: poor choices accepted without awareness. **Recommendation: smaller batches (5 per round) with explicit "do you want to refine any of these?" prompt.**

#### Interview Command UX: Low Friction
- No evidence of confusion about "iterate" / "continue to next phase"
- No early bailouts
- Users engaged through 5-round interviews without complaint
- Silent failure mode: PLAN_INTERVIEW (10 Qs, 0 answers) fails with no feedback to user about what went wrong

#### Top 3 Interview Pattern Improvements

1. **Smart question bundling in Round 1** — Target 10–12 high-value questions (not 15). Replace confirmation questions ("Does this look right?") with substantive discovery questions or fold them into related questions.

2. **Confidence/importance indicators** — Mark each question HIGH / MEDIUM / LOW importance. Tells user where to invest elaboration energy vs. quick approval. Reduces "what do they really need from me?" uncertainty.

3. **Status check-in after Round 2** — For interviews reaching Round 3: summarize what's been covered, list remaining uncertainties, offer explicit "continue or proceed to document generation?" choice. Prevents indefinite iteration and gives user visible progress.

---
