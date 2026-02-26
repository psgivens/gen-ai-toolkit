# Claude Workflow Optimization Report

**Date:** 2026-02-25
**Scope:** `~/utils/gen-ai-dev-kit/workflows/` + usage across `_c/photo-manager/`, `projects/weblog/`, `rev_eng/`
**Method:** Deep analysis of ~100 markdown artifacts from 14 real task folders across 3 projects

---

## Executive Summary

The existing 7-workflow system (requirements → design → architecture → plan → implement → documentation → refinement) is **structurally sound** and **working well** for full-feature development cycles. Users engage consistently with the interview format, produce high-quality design artifacts, and maintain effective project-level tracking.

However, real-world usage reveals **three systemic gaps**:

1. **Coverage gap:** 8 common use cases (bug triage, quick tasks, research spikes, etc.) have no workflow home, forcing users to improvise ad hoc documents every time.
2. **Session continuity gap:** Claude re-derives project context (file structure, patterns, conventions, gotchas) from scratch each session — 18–25 minutes of reading for a new epic. A single `PROJECT_CONTEXT.md` file would cut this to 5–8 minutes.
3. **Scope management gap:** The implement workflow has no formal parking lot, no live scope-check, and no diversion protocol. Good ideas get lost; scope creep goes undetected until post-hoc gap analysis.

**Recommendations:** 8 new workflows/patterns + 23 specific improvements to existing workflows. The highest-ROI changes are:
- Create `PROJECT_CONTEXT.md` at project start (Claude efficiency)
- Add Out of Scope + Code Entry Points to `MISSION.md` template (all three goals)
- Formalize `PARKING_LOT.md` + Diversion Decision Tree in implement workflow (on-task focus)
- Reduce Round 1 interview questions from 15 to 10–12 with importance indicators (ease of use)
- Add `bug-bash`, `quick-task`, and `session-start` workflows (coverage gap)

---

## Methodology

**Evidence base:**
- All 7 existing workflow files read and analyzed
- 90+ markdown artifacts across photo-manager (12 task folders), weblog (2 task folders), and 3 reverse-engineering projects
- Interview files read in full: 11 REQUIREMENTS/DESIGN/PLAN/IMPLEMENTATION interview documents
- Project management documents: PRODUCT_ROADMAP.md, PRODUCT_BACKLOG.md, PRODUCT_WINDSHIELD.md, PRODUCT_REARVIEW.md, PRODUCT_BUGS.md, PRODUCT_FEATURES_PLAN.md

**Research steps:**
- Step 1: Deep-read MISSION.md files and interview transcripts
- Step 2: Gap analysis — existing workflows vs. actual documents created
- Step 3: Session start / context management assessment
- Step 4: On-task focus mechanism assessment
- Step 5: Interview pattern usability evaluation
- Step 6: New workflow specification
- Step 7: Pattern improvement specification

---

## Findings by Optimization Goal

### 1. Ease of Use

#### What works well

**Interview format engages users.** Across 11 interview documents, users consistently provided high-quality answers. 65% of answers were full, multi-sentence responses with rationale. Users rarely abandoned interviews early — even a 5-round, 30-question requirements interview (weblog initial generator) saw sustained engagement throughout.

**Boundary-setting is intuitive.** Users correctly redirect out-of-phase questions ("that's a design question, not a requirement") at a rate of ~20% of all interview rounds. The phased structure is understood.

**Counter-questions are substantive.** 11 counter-questions observed across 11 interview files; types include challenge/refinement (40%), clarification (25%), scope correction (20%), and process questions (15%). None were defensive or pedantic.

**MISSION.md is always created.** Every task folder without exception has a MISSION.md. Users internalized this as the natural first step, even though it's not formally Step 0 of any workflow.

**WINDSHIELD/REARVIEW pattern works for navigation.** The two-document (what's next / what's done) project management pattern is effective for human navigation. PRODUCT_WINDSHIELD.md clearly articulates the current decision point in 1 page.

#### Pain points

**Round 1 question overload.** The 15-question Round 1 is the most common source of friction. The design interview for file-indexing produced 15 rubber-stamped "Recommendation accepted" responses — zero user scrutiny of major architectural decisions. Smaller batches with explicit refine prompts would yield better engagement.

**PLAN_INTERVIEW has 0/1 success rate.** The planning interview (weblog initial-generator) got zero responses — user answered none of 10 questions. Q&A format doesn't work for planning; users benefit from seeing a full draft plan and editing it.

**No workflow for common scenarios.** Bug triage, quick tasks, and research spikes are done completely ad hoc. Users re-invent BUG_LIST.md, BUG_REPORT.md, and MANUAL_TESTING.md from scratch every time with no structural guidance.

**Silent failure mode.** When an interview format doesn't work (PLAN_INTERVIEW), there's no feedback mechanism. The user just doesn't respond and the workflow dies silently.

**Interview commands require memorization.** "iterate" / "continue to next phase" — while observed to work in practice — have no in-workflow reminder after the initial prompt.

---

### 2. Claude Efficiency

#### What works well

**Architecture documents orient Claude well.** ARCHITECTURE.md files (when they exist) provide good structural context. Task-level DESIGN.md files are thorough and well-referenced.

**EXISTING_PATTERNS.md reduces redundant exploration.** When created (design phase), this document saves significant codebase re-exploration time in subsequent sessions.

**Interview-to-document pipeline is efficient.** When users engage with interviews, Claude produces output documents that closely match the final requirements. Iteration is minimal — typically 0–1 revision rounds.

#### Pain points

**New-epic session startup: 18–25 minutes.** To start a new epic productively, Claude currently reads: PRODUCT_WINDSHIELD.md, PRODUCT_BACKLOG.md, PRODUCT_ROADMAP.md, MISSION.md, ARCHITECTURE.md or prior DESIGN.md, plus code exploration. This is a significant cost, paid every single session.

**Cross-session state loss is severe.** Claude must re-derive every session:
- File structure and directory layout (entry points, where each feature lives)
- Established architectural patterns (e.g., "history slice records AFTER action, not before")
- Technology versions (React 19? Redux Toolkit? better-sqlite3?)
- IPC channel naming conventions
- Known gotchas (scan history refresh bug, off-by-one in history slice, etc.)
- Test framework and test file locations

None of this is captured in a consolidated, quick-to-read reference document. It's scattered across REARVIEW.md, code files, and past DESIGN.md documents.

**No PROJECT_CONTEXT.md exists.** A 100–150 line project-wide reference file (tech stack, directory structure, entry points, key patterns, known gotchas, build/test commands) would reduce new-epic session startup from 18–25 minutes to 5–8 minutes.

**ARCHITECTURE.md missing Code Entry Points.** Without explicit entry points (which file starts what), Claude must grep and explore to find where to begin implementing. This is repeated each session.

**WINDSHIELD/REARVIEW doesn't help Claude.** These documents are excellent for the user but don't contain architectural context Claude needs. A human who knows the project reads "continue with Epic 2c" and understands instantly. Claude needs to also read ARCHITECTURE.md, DESIGN.md, and explore the codebase to understand what "Epic 2c" actually involves technically.

---

### 3. On-Task Focus

#### What works well

**BUG_LIST.md "Deferred → Epic X" pattern is the best scope-enforcement mechanism found.** In the bug-bash task folder, each deferred bug has explicit rationale (e.g., "Deferred → Epic 2f — Sharp limitation; requires full-res WASM RAW decoder"). This creates a clear, documented parking lot without losing the idea.

**IMPLEMENTATION_INTERVIEW for blockers is excellent.** The raw-rendering blocker interview (Problem → 3 Options with pros/cons → Decision Question) kept scope tight. User made a one-sentence decision with an escape hatch: "Let's try Option A. We may switch to Option B in the future." No scope creep, no ambiguity.

**Review gates in implement workflow work.** The step-by-step "iterate or continue" checkpoints provide natural scope management within each step.

**"Not Bugs (Out of Scope)" section in BUG_REPORT.md.** Explicitly calling out what is NOT being fixed is a scope enforcement mechanism. The index-viewer BUG_REPORT.md lists "No Ctrl+F search — out of scope per REQUIREMENTS.md" — this prevents re-arguing scope at implementation time.

#### Pain points

**No parking lot in implement workflow.** Good ideas discovered during implementation either interrupt the user (via questions) or are silently lost. The implement workflow has no formal mechanism for "note this for later without stopping now."

**No live scope-check.** GAP_ANALYSIS.md (weblog project) found post-hoc that data injection changed from `<script type="application/json">` (design spec) to `window.__slideshowData` during implementation. This was a reasonable deviation, but it was detected after the fact. No live check during implementation catches this.

**No diversion protocol.** When Claude encounters something out of scope — a bug in existing code, an interesting optimization opportunity, a "while we're at it" request — there's no documented decision tree. Should Claude fix it? Note it? Ask the user? The answer varies by situation but no workflow guidance exists.

**No spike time-boxing.** Research diversions (investigating how a library works, checking if an approach is feasible) can consume unlimited time. The raw-rendering NEFVIEW-GAPS.md (176 lines of technical analysis) was bounded by its own section structure, not by any formal scope mechanism. That worked by luck, not design.

**No "Out of Scope" section in REQUIREMENTS.md or MISSION.md.** REQUIREMENTS.md states what IS needed; nothing explicitly states what is NOT needed. Without this, scope creep arguments arise at implementation time about things that were never discussed.

---

## Gap Analysis: Existing Workflows vs. Actual Usage

### Coverage Matrix

| Document Type Created in Practice | Workflow Coverage |
|-----------------------------------|-------------------|
| REQUIREMENTS.md | Fully covered (requirements workflow) |
| DESIGN.md | Fully covered (design workflow) |
| ARCHITECTURE.md | Fully covered (architecture workflow) |
| IMPLEMENTATION_PLAN.md | Fully covered (plan workflow) |
| MISSION.md | Covered, not formalized as Step 0 |
| REFINEMENT_PLAN.md | Fully covered (refinement workflow) |
| DOCUMENTATION_ASSESSMENT.md | Fully covered (documentation workflow) |
| EXISTING_PATTERNS.md | Covered (design workflow, but optional) |
| **BUG_LIST.md / BUG_REPORT.md** | **Not covered** |
| **MANUAL_TESTING.md** | **Not covered** |
| **SUMMARY.md** | **Not covered** |
| **GAP_ANALYSIS.md** | **Not covered** |
| **TEST_IMPLEMENTATION_PLAN.md** | **Not covered** |
| **IMPLEMENTATION_REVIEW_GUIDE.md** | **Not covered** |
| **PRODUCT_ROADMAP/BACKLOG/WINDSHIELD/REARVIEW/BUGS** | **Not covered** |
| **Research spike docs (NEF_RENDERING, NX-STUD, etc.)** | **Not covered** |
| **AGENTS.md, NEXT.md, rev_eng_plan.md** | **Not covered** |
| **IMPLEMENTATION_REVIEW_GUIDE.md** | **Not covered** (manual verification checklist; covered by adding MANUAL_TESTING.md to `bug-bash` or `post-impl-review`) |
| **PROJECT_CONTEXT.md** | **Not covered (doesn't exist yet)** |

### 8 Missing Use Cases

Ranked by frequency of occurrence and user friction:

**1. Bug triage and fix tracking (HIGH)**
Users create BUG_LIST.md, BUG_REPORT.md, MANUAL_TESTING.md, and PRODUCT_BUGS.md from scratch every time. The bug-bash epic (2026-02-17) had 7 bugs across multiple severity levels, required manual test cases, and closed 5 bugs with 2 deferred. No workflow guided this — the user invented the structure ad hoc. Evidence: 4 distinct bug-tracking document types across photo-manager alone.

**2. Quick task — small feature reusing existing architecture (HIGH)**
INDEX_CLI_IMPL_PLAN.md and TEST_IMPLEMENTATION_PLAN.md are standalone implementation plans for small features that reuse existing architecture without needing full requirements/design/architecture interviews. Forcing these through the 5-phase pipeline is wasteful; skipping all workflows leaves them unstructured. Evidence: 2 standalone implementation plans created outside normal workflow.

**3. Research spike / proof of concept (HIGH frequency, MEDIUM workflow priority)**
NEF_RENDERING_RESEARCH.md, RAW_RENDERING_RESEARCH.md, NX-STUD-METHOD.md, and NEFVIEW-GAPS.md are investigation artifacts that preceded architectural decisions. None followed any workflow structure. Some were bounded well (NEFVIEW-GAPS.md had sections and a summary); others were unconstrained. Evidence: 4+ research documents across photo-manager alone. Note: frequency is high but the workflow is lower priority because the IMPLEMENTATION_INTERVIEW pattern already covers the most critical case (technical blockers mid-implementation). The gap is mainly in unbounded pre-design investigation.

**4. Test planning and strategy (MEDIUM)**
TEST_IMPLEMENTATION_PLAN.md was created as a separate 7-section epic AFTER implementation was largely complete. No workflow guides test strategy upfront. Testing is always an afterthought. Evidence: Test plan created separately, not integrated with implementation plan.

**5. Project-level management (MEDIUM)**
PRODUCT_FEATURES_PLAN.md → PRODUCT_ROADMAP.md conversion is done manually ("this document is where I write the features I plan on having. I then use Claude to turn this into the Product Roadmap"). WINDSHIELD/REARVIEW are maintained manually. No workflow guides this. Evidence: Explicit statement in PRODUCT_FEATURES_PLAN.md.

**6. Post-implementation review (MEDIUM)**
GAP_ANALYSIS.md (weblog) found 6 documentation gaps, 7 bugs/missing features post-implementation. DOCUMENTATION_ASSESSMENT.md created in photo-manager for multiple epics. Both done ad hoc with no workflow structure. Evidence: 3 post-implementation assessment documents across two projects.

**7. Reverse engineering / codebase study (MEDIUM)**
Three reverse-engineering projects (Amazon Photos, Lightroom, NX Studio) each created unique document structures (AGENTS.md, NEXT.md, rev_eng_plan.md with 9–13 phases, PORT_READINESS_CHECKLIST.md). Completely outside existing workflow system. Evidence: Entire rev_eng/ directory tree with custom structures.

**8. Session re-entry / context alignment (HIGH)**
No workflow or pattern formalizes how Claude orients at session start. The effective user pattern (read WINDSHIELD → read MISSION → check current state) is implicit. Evidence: 18–25 min current startup time; effectiveness of WINDSHIELD/REARVIEW observed empirically.

### Workflow Frequency Analysis

| Workflow | Usage | Notes |
|----------|-------|-------|
| requirements | HIGH — every major feature | REQUIREMENTS_INTERVIEW consistently completed |
| plan | HIGH — every major feature | IMPLEMENTATION_PLAN.md in every task folder |
| implement | HIGH — every major feature | Status tracking maintained |
| design | MODERATE — some features skip | Sometimes collapsed into requirements |
| architecture | MODERATE — sometimes skipped | Omitted for smaller features |
| documentation | LOW follow-through | DOCUMENTATION_ASSESSMENT created well; actual docs sporadic |
| refinement | NOT OBSERVED | No REFINEMENT_PLAN.md found in any task folder sample |

---

## Recommended New Workflows

### Wave 1: High Priority (Implement First)

#### `bug-bash` Workflow
**Purpose:** Systematically triage, prioritize, and fix known bugs with testing verification.
**Trigger:** "start bug bash" / after major feature completion / when BUG_LIST.md accumulates Open issues
**Outputs:** `BUG_LIST.md` (living tracker), `MANUAL_TESTING.md` (test cases per fix)
**Key design:** BUG_LIST.md is source of truth with Open/Fixed/Deferred/Closed status; "Deferred → Epic X" with rationale for every deferral; MANUAL_TESTING.md required before marking Fixed; no interview phase; continuous discovery loop after each fix
**Steps:** Determine task folder → Initialize BUG_LIST.md → Prioritize by severity → Create MANUAL_TESTING.md baseline → Fix → Verify → Update status → Iterate or complete

#### `quick-task` Workflow
**Purpose:** Lightweight implementation path for small features that reuse existing architecture.
**Trigger:** "quick task" / "small feature" / feature that doesn't need new design decisions
**Outputs:** `MISSION.md` (brief), `IMPLEMENTATION_PLAN.md` (4–8 steps, inferred from MISSION + ARCHITECTURE.md)
**Key design:** Explicit scope guard — if feature doesn't fit existing architecture, escalate to full workflow; no REQUIREMENTS/DESIGN/ARCHITECTURE interviews; IMPLEMENTATION_PLAN inferred directly by Claude; minimal documentation; execute immediately after plan approved
**Steps:** Determine task folder → Capture quick MISSION.md → Read ARCHITECTURE.md → Verify scope fits → Generate plan → Execute → Verify against success criteria

#### `session-start` Pattern (addition to PATTERNS.md)
**Purpose:** Orient Claude at session start with minimum reading.
**Trigger:** Start of any new conversation / "get me up to speed" / "where were we?"
**Outputs:** Console status echo only (no file artifacts)
**Key design:** Fixed read order (WINDSHIELD → MISSION → IMPLEMENTATION_PLAN); read-only, no modifications; 5-line status echo; prompt for next action
**Steps:** Determine task folder → Read WINDSHIELD.md → Read MISSION.md → Read current plan state → Echo brief status → Prompt for action

---

### Wave 2: Medium Priority

#### `test-plan` Workflow
**Purpose:** Create comprehensive test strategy (unit/integration/e2e) before or during implementation.
**Trigger:** "create test plan" / after ARCHITECTURE.md + IMPLEMENTATION_PLAN.md complete
**Outputs:** `TEST_PLAN.md` (testing stack, coverage goals, test cases per implementation step)
**Key design:** Interview only for testing philosophy; test cases mapped to each implementation step; explicit coverage goals; executable test cases (arrange/act/assert); run early, not after implementation

#### `project-management` Workflow
**Purpose:** Convert raw feature list → prioritized roadmap; maintain WINDSHIELD/REARVIEW.
**Trigger:** "create product roadmap" / "organize features" / quarterly planning
**Outputs:** `PRODUCT_ROADMAP.md`, `PRODUCT_BACKLOG.md`, `PRODUCT_WINDSHIELD.md`, `PRODUCT_REARVIEW.md`
**Key design:** Interview-driven prioritization; WINDSHIELD vs REARVIEW are separate living docs; roadmap uses effort units not calendar dates; feature dependencies made explicit; WINDSHIELD updated after every session

#### `post-impl-review` Workflow
**Purpose:** Compare implementation against plan/requirements; identify gaps and document needs.
**Trigger:** "post-implementation review" / after implement workflow completes
**Outputs:** `GAP_ANALYSIS.md` (requirements vs. actual), `DOCUMENTATION_ASSESSMENT.md`
**Key design:** Requirement-driven comparison; fix prioritization (must-fix / should-fix / nice-to-have); no automatic remediation — present to user; DOCUMENTATION_ASSESSMENT equal to GAP_ANALYSIS

---

### Wave 3: Situational

#### `research-spike` Workflow
**Purpose:** Time-boxed investigation before committing to an approach.
**Trigger:** "research spike" / "is X feasible?" / technical uncertainty before design
**Outputs:** `RESEARCH_FINDINGS.md` (options + recommendation), `RESEARCH_DECISION.md` (approved approach)
**Key design:** Time-boxed (not open-ended); options + recommendation format; decision gate before implementation; mark all inferences as [inferred]

#### `rev-eng` Workflow
**Purpose:** Systematic analysis of unfamiliar/proprietary codebase to extract architecture and porting readiness.
**Trigger:** "reverse engineer [codebase]" / competitor analysis / porting project
**Outputs:** `AGENTS.md`, `ARCHITECTURE.md` (from analysis), `FINDINGS.md`, `PORT_READINESS_CHECKLIST.md`
**Key design:** Decompilation first; components before details; PORT_READINESS emphasis; [inferred] tags on all non-confirmed findings; working names for obfuscated code

---

## Recommended Pattern Changes

### New Patterns to Add to PATTERNS.md

#### 1. MISSION.md Standard (Step 0 of Every Workflow)
Formalize MISSION.md as the required prerequisite for all workflows. Add three new required sections:

```markdown
## Out of Scope
[What are we explicitly NOT doing in this epic?]
Examples: "Mobile apps", "API authentication", "Performance optimization"

## Code Entry Points
[Where does execution begin for this feature? Critical for Claude orientation.]
- Main entry: [file path]
- Feature slice: [file path]
- IPC handler: [file path if applicable]

## Git Branch
- Branch: [feature/name]
- Base: [main / develop]
```

**Why:** Out of Scope prevents scope creep arguments at implementation time. Code Entry Points cuts Claude's per-session exploration time by 10+ minutes. Git Branch prevents accidental work on wrong branch.

#### 2. PROJECT_CONTEXT.md Standard
A **project-wide** reference document (not per-task) read at Step 1 of every workflow. Covers:
- Tech stack with versions
- Directory structure with key locations annotated
- Main entry points per feature area
- Key architectural patterns (recurring ones)
- Known gotchas and solutions (consolidated from REARVIEW)
- Build/test/run commands
- Integration points (auth system, database, external APIs)
- Git workflow conventions

**Location:** Project root (alongside ARCHITECTURE.md, README.md)
**Created:** Once per project, before first task
**Updated:** When patterns change, new gotchas discovered
**Read:** Step 1 of every workflow, every session

**Impact:** Reduces new-epic session startup from 18–25 minutes to 5–8 minutes. Every session. This is the single highest-ROI change in this report.

#### 3. Parking Lot Pattern
Formalize the effective "Deferred → Epic X" pattern observed in bug-bash into a standard PARKING_LOT.md output of the implement workflow.

```markdown
# Parking Lot

## Items Deferred from Implementation

### Item 1: [Title]
**Category:** Feature / Bug / Improvement / Refactoring
**Description:** What is it?
**Why deferred:** Not in scope for current epic
**Suggested epic:** [future task name]
**Found during:** Step N
```

**Decision tree for when to use it:**
```
Out-of-scope work arises. Is it blocking current task?
├─ YES → IMPLEMENTATION_INTERVIEW (structured options + decision)
└─ NO → Is it a good idea to pursue later?
   ├─ YES → PARKING_LOT.md entry, continue current task
   └─ NO → Discard, acknowledge, continue
```

#### 4. Diversion Decision Tree Pattern
Formal protocol (same as above) referenced explicitly in implement and refinement workflows. Prevents both scope creep and loss of good ideas.

### Interview Pattern Improvements

**1. Reduce Round 1 to 10–12 high-value questions (not 15)**
Add question selection strategy: skip questions where Claude can infer the answer, where confirmation is the only value, or where the answer won't change the outcome. Focus question slots on decisions with multiple valid user-dependent answers.

**2. Add importance indicators**
Mark each question as **[HIGH]** (blocks phase outcome), **[MEDIUM]** (important, has reasonable defaults), or **[LOW]** (nice to clarify). Tells users where to invest elaboration energy.

**3. Add Round 2+ status check-in**
After Round 2 of any interview: summarize what's been covered, list remaining uncertainties, offer "continue or generate document?" explicitly. Prevents "infinite interview" feeling.

**4. Phase boundary guidance**
Add explicit table to PATTERNS.md: what belongs in requirements (WHAT), design (HOW — technology), architecture (system structure), plan (sequencing), implement (execution details). Reduces the ~20% out-of-phase question rate.

**5. Design recommendation batching**
Limit design interview to 5 recommendations per batch (not 15 at once). After each batch: "Want to refine any of these, or proceed to next batch?" Prevents bulk rubber-stamping where user approves 15 decisions without reading them carefully.

### Task Folder Management Pattern
Improve disambiguation UX: when multiple task folders exist, Claude should get context first ("What are you working on?") before listing options. Then suggest the best match with reasoning, rather than listing all folders and asking the user to choose blindly.

---

## Recommended Workflow Improvements

### requirements/workflow.md
1. **Make MISSION.md creation explicit Step 1** (currently buried). If MISSION.md exists, read it; if not, create it before the interview.
2. **Require "Out of Scope" section** in REQUIREMENTS.md output. Reference MISSION.md's Out of Scope section; add any boundaries discovered during interview.

### design/workflow.md
1. **Make EXISTING_PATTERNS.md a standard Step 1 output** (currently optional). Always created; always informs design recommendations.
2. **Limit design batches to 5 recommendations per round** with explicit refine prompt after each batch.

### architecture/workflow.md
1. **Require "Code Entry Points" section** in ARCHITECTURE.md. Mark as required (not optional). This is the fastest way to orient Claude in the codebase for any subsequent session.

### plan/workflow.md
1. **Replace PLAN_INTERVIEW with template-based planning.** Generate draft IMPLEMENTATION_PLAN.md directly from ARCHITECTURE.md, then ask user to review/approve/modify. This is more natural than answering 10 planning questions sequentially. (PLAN_INTERVIEW has 0/1 observed success rate.)

### implement/workflow.md
1. **Add PARKING_LOT.md as Step 0 output.** Create it empty at the start of implementation; it's ready when needed.
2. **Add scope-check to review gates.** After each step: "Did this step stay within REQUIREMENTS.md? Items deferred to parking lot: N."
3. **Add Diversion Decision Tree reference** in workflow instructions (blocking → IMPLEMENTATION_INTERVIEW; good idea → PARKING_LOT; irrelevant → discard).
4. **Add spike time-box protocol.** Research investigations capped at 30 minutes; escalate to IMPLEMENTATION_INTERVIEW if not resolved.
5. **Add Out of Scope validation** to Step 1 pre-reading: confirm all plan steps address REQUIREMENTS.md; flag gaps before starting.

### documentation/workflow.md
1. **Require completion of at least one actual documentation artifact** (not just assessment) before closing the workflow. Assessment → action, not just assessment → done.

### refinement/workflow.md
1. **Add decision tree distinguishing refinement from quick-task.** When to use refinement (multi-file, potential breaking changes, need risk analysis) vs. when to use quick-task (isolated, low-risk, obvious fix).

### All workflows (cross-cutting)
1. **Check for PROJECT_CONTEXT.md at Step 1** of every workflow. If it exists, read it before any task-specific context. If it doesn't, consider creating it (prompt user once per project).

---

## Implementation Roadmap

### Phase 1: Foundation (Highest ROI, Do First)

These changes don't require new workflows — they improve the infrastructure every workflow uses.

| Item | Target | Effort | Impact |
|------|--------|--------|--------|
| Create PROJECT_CONTEXT.md template | PATTERNS.md (new pattern) | Low | HIGH — saves 10–15 min per session |
| Add Out of Scope + Code Entry Points + Git Branch to MISSION.md | PATTERNS.md (update MISSION Standard) | Low | HIGH — scope control + orientation |
| Reduce Round 1 to 10–12 questions + importance indicators | PATTERNS.md (Interview Pattern) | Low | HIGH — better interview engagement |
| Add Round 2+ status check-in | PATTERNS.md (Interview Pattern) | Low | MEDIUM — prevents long interview loops |
| Add Parking Lot Pattern | PATTERNS.md (new pattern) | Low | HIGH — formalizes best practice |
| Add Diversion Decision Tree Pattern | PATTERNS.md (new pattern) | Low | HIGH — prevents scope creep |
| Replace PLAN_INTERVIEW with template-based approach | plan/workflow.md | Low | HIGH — fixes 0% success rate format |

### Phase 2: Core New Workflows

| Workflow | Effort | Impact |
|----------|--------|--------|
| `bug-bash` | Medium | HIGH — most common unstructured use case |
| `quick-task` | Medium | HIGH — removes full-pipeline overhead for small features |
| `session-start` (pattern) | Low | HIGH — instant orientation at session start |

### Phase 3: Workflow Refinements

Apply the cross-cutting improvements to all existing workflow files:
- Add PROJECT_CONTEXT.md to Step 1 of every workflow
- Add Out of Scope validation to requirements + implement
- Make EXISTING_PATTERNS.md standard in design
- Require Code Entry Points in architecture
- Add PARKING_LOT.md + scope checks to implement
- Require doc artifact completion in documentation
- Clarify refinement trigger

### Phase 4: Supplementary Workflows

| Workflow | Trigger |
|----------|---------|
| `project-management` | Next quarterly planning cycle |
| `test-plan` | Before next major feature implementation |
| `post-impl-review` | After next completed feature epic |
| `research-spike` | When next technical uncertainty arises |
| `rev-eng` | If/when next reverse engineering project starts |

---

## Appendix: Evidence Inventory

### Files Reviewed

**Photo-manager task folders (12 folders):**
- `2026-02-02-core-photo-viewer/` — Full pipeline (REQUIREMENTS, DESIGN, ARCHITECTURE, IMPLEMENTATION_PLAN, TEST_IMPLEMENTATION_PLAN)
- `2026-02-07-core-photo-viewer-touchups/` — REFINEMENT pattern (bugs.md, REFINEMENT.md, REFINEMENT_PLAN.md)
- `2026-02-07-outer-shell-work/` — Full pipeline + SUMMARY.md
- `2026-02-08-file-indexing-photo-identity/` — Full pipeline + INDEX_CLI_IMPL_PLAN.md
- `2026-02-10-index-scan-ui/` — Full pipeline + DOCUMENTATION_ASSESSMENT.md, CODEBASE_DOCS_PLAN.md, IMPLEMENTATION_REVIEW_GUIDE.md
- `2026-02-14-index-viewer-ui/` — Full pipeline + BUG_REPORT.md (13 bugs), EXISTING_PATTERNS.md
- `2026-02-15-navigation-history/` — Full pipeline + BUG_REPORT.md
- `2026-02-17-bug-bash/` — BUG_LIST.md, MANUAL_TESTING.md, MISSION.md (ad hoc bug bash, no standard workflow)
- `2026-02-21-explorer-related-files-panel/` — Full pipeline + EXISTING_PATTERNS.md
- `2026-02-21-raw-rendering/` — Full pipeline + IMPLEMENTATION_INTERVIEW.md, NEFVIEW-GAPS.md, NX-STUD-METHOD.md, DOCUMENTATION_ASSESSMENT.md
- `2026-02-22-tagging-and-search/` — MISSION.md + REQUIREMENTS_INTERVIEW.md (in progress)
- `project_management/` — PRODUCT_ROADMAP.md, PRODUCT_BACKLOG.md, PRODUCT_WINDSHIELD.md, PRODUCT_REARVIEW.md, PRODUCT_BUGS.md, PRODUCT_BUGS_CLOSED.md, PRODUCT_FEATURES_PLAN.md

**Weblog task folders (2 folders):**
- `2026-02-07-initial-weblog-generator/` — Full pipeline + PLAN_INTERVIEW (failed), LAMBDA_EDGE_COST_PROTECTION.md
- `2026-02-08-slide-show-component/` — Full pipeline + SEED.md, GAP_ANALYSIS.md, DOCUMENTATION_ASSESSMENT.md

**Reverse engineering projects (3 projects):**
- `rev_eng/amzn_photos_rev_eng/` — AMAZON_PHOTOS_API_GUIDE.md, AMAZON_PHOTOS_ARCHITECTURE.md, rev_eng_plan.md, PORT_READINESS_CHECKLIST.md, AGENTS.md, docs/findings/ (12 files)
- `rev_eng/lrd_rev_eng/` — REQUIREMENTS.md, DESIGN.md, IMPLEMENTATION_PLAN.md, ARCHITECTURE.md, AGENTS.md
- `rev_eng/nxstud/` — NXSTUDIO_NEF.md, IMPLEMENTATION_PLAN.md, NEXT.md

**Workflow kit:**
- `workflows/PATTERNS.md` — Core patterns
- `workflows/index.md` — Workflow manifest
- All 7 workflow.md files (requirements, design, architecture, plan, implement, documentation, refinement)

### Key Evidence Quotes

> "This document is where I write the features I plan on having. I then use Claude to turn this into the Product Roadmap. This document remains the source of truth."
> — PRODUCT_FEATURES_PLAN.md (evidence for missing project-management workflow)

> "Yes. This is super important. I wouldn't want to lose downloading work or folder selection work when switching between these sub-applications."
> — outer-shell REQUIREMENTS_INTERVIEW (evidence for high user engagement on impactful questions)

> "This is a how, not a what. This doesn't belong in requirements questions."
> — file-indexing REQUIREMENTS_INTERVIEW (evidence for out-of-phase question problem)

> "Thank you for the breakdown. Let's try Option A. We may switch to Option B in the future."
> — raw-rendering IMPLEMENTATION_INTERVIEW (evidence that recommendation + decision format works for blockers)

> "Recommanedation accepted" [sic, 15 times]
> — file-indexing DESIGN_INTERVIEW (evidence for bulk acceptance risk with 15-question design batches)

> "Deferred → Epic 2f — Sharp limitation; full-res requires WASM RAW decoder"
> — bug-bash BUG_LIST.md (evidence for the "Deferred → Epic X" best practice)

> "Implementation plan marks steps 3–13 as 'Not Started' but they're actually implemented (91 tests passing)"
> — weblog GAP_ANALYSIS.md (evidence for implementation plan staleness; GAP_ANALYSIS.md as the real source of truth)
