# Bug Workflow

## Description
Single-bug lifecycle: record → investigate → root cause → fix plan → implement → verify.
One invocation tracks one bug from first report to verified resolution.

Distinct from `bug-bash` (which triages many bugs in a session).
Use this workflow when you have one specific bug to chase down completely.

## Trigger
When user says "log a bug", "record a bug", "I found a bug", "file a bug", or "track this bug".

## Instructions

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder.

### Step 1: Initialize Bug Registry

Check if `claude/${TASK_FOLDER}/BUG_LIST.md` exists.

**If it does NOT exist**, create it:

```markdown
# Bug List

## Status Key
- **Reported** — Bug recorded, not yet investigated
- **Investigating** — Root cause analysis in progress
- **Root Cause Found** — Cause identified, fix not yet planned
- **Fix Planned** — Approach documented, not yet implemented
- **Fixed** — Implementation complete, awaiting verification
- **Verified** — Fix confirmed working
- **Deferred** — Out of scope; reason and suggested epic documented
- **Won't Fix** — Acknowledged but intentionally not fixed

## Open Bugs

| # | Severity | Title | Status | Bug File |
|---|----------|-------|--------|----------|

## Closed Bugs

| # | Title | Resolution | Bug File |
|---|-------|------------|----------|
```

**If it exists**, read it and determine the next bug number (highest existing # + 1, or 1 if empty).

### Step 2: Collect the Bug Report

Ask the user for the following information (all at once, not one question at a time):

```
To record this bug I need a few details:

1. **Title** — a short name for the bug (e.g. "File type filter resets on Back")
2. **Severity** — CRITICAL (crash/data loss), HIGH (broken feature), MEDIUM (degraded UX), or LOW (cosmetic)
3. **Symptoms** — what you saw (copy/paste your observation)
4. **Steps to reproduce** — numbered steps to trigger the bug
5. **Expected behavior** — what should have happened
6. **Actual behavior** — what actually happened

You can skip any you're unsure about — I'll fill in what I can.
```

Wait for user response.

### Step 3: Create BUG-NNN.md

Determine the bug number (`NNN` = zero-padded 3 digits, e.g. `001`).

Create `claude/${TASK_FOLDER}/bugs/BUG-NNN.md`:

```markdown
# Bug NNN: [Title]

**Severity:** [CRITICAL/HIGH/MEDIUM/LOW]
**Status:** Reported
**Reported:** [YYYY-MM-DD]
**Task:** [task folder name]

---

## Report

### Symptoms
[User's observation]

### Steps to Reproduce
1. [step]
2. [step]

### Expected Behavior
[What should happen]

### Actual Behavior
[What actually happens]

---

## Investigation

*(Populated during investigation phase)*

### Hypotheses
- **H1:**

### Code Examined
| File | Lines | Observation |
|------|-------|-------------|

### Findings
[What the investigation revealed]

### Root Cause
[The specific defect — file, line(s), and why it causes the symptom]

---

## Fix Plan

*(Populated after root cause is confirmed)*

### Approach
[How to fix it]

### Files to Change
| File | Change |
|------|--------|

### Risks
[Regression risks and how to mitigate]

---

## Fix

*(Populated during implementation)*

### Changes Made
[What was actually changed — diffs or descriptions]

### Verification Steps
1. [step]
2. [step]

---

## Resolution

**Status:** [Fixed / Deferred / Won't Fix]
**Fix Summary:** [One sentence describing what was changed]
**Verified by:** [manual test / automated test]
```

### Step 4: Update BUG_LIST.md

Add the bug to the Open section of BUG_LIST.md:

```
| NNN | [SEVERITY] | [Title] | Reported | bugs/BUG-NNN.md |
```

Confirm to the user:

```
Bug NNN recorded: "[Title]"
Severity: [SEVERITY]
File: claude/${TASK_FOLDER}/bugs/BUG-NNN.md

What would you like to do?
- Type 'investigate' to start root cause analysis now
- Type 'done' to stop here (bug is logged for later)
```

Wait for user response.

### Step 5: Investigate

If user says 'investigate' (or equivalent):

1. Update BUG-NNN.md status → **Investigating**
2. Update BUG_LIST.md status → Investigating

Read relevant code. Populate the **Investigation** section of BUG-NNN.md as you go:
- List hypotheses before reading code
- Document each file examined and what was found
- Cross off or confirm hypotheses

When root cause is found:
- Write the **Root Cause** section clearly: which file(s), which line(s), why it causes the symptom
- Update status → **Root Cause Found**

Present findings:

```
Root cause identified.

[Summary of root cause in 2-3 sentences]

Key code: [file:line]

Investigation notes saved to bugs/BUG-NNN.md.

Type 'plan' to design the fix, or 'done' to stop here.
```

Wait for user response.

### Step 6: Fix Plan

If user says 'plan' (or equivalent):

1. Update status → **Fix Planned**

Write the **Fix Plan** section of BUG-NNN.md:
- Describe the approach in plain language
- List every file that will change and what change
- Identify regression risks

Present the plan:

```
Fix plan:

[Approach summary]

Files to change:
- [file] — [what changes]

Risks: [any concerns]

Type 'fix' to implement, or 'done' to stop here.
```

Wait for user response.

### Step 7: Implement

If user says 'fix' (or equivalent):

1. Update status → **Fixed**
2. Implement the changes described in the fix plan
3. Populate the **Fix** section of BUG-NNN.md with what was actually changed
4. Run TypeScript check (or whatever the project's compile check is)

Present result:

```
Fix implemented.

[Brief summary of changes]

TypeScript: [clean / N errors]

Please verify with these steps:
[Verification Steps from BUG-NNN.md]

Type 'verified' when confirmed, or report what you see.
```

Wait for user response.

### Step 8: Close

When user confirms the fix works:

1. Update BUG-NNN.md status → **Verified**
2. Move bug from Open to Closed section in BUG_LIST.md:
   ```
   | NNN | [Title] | [Fix Summary] | bugs/BUG-NNN.md |
   ```

```
Bug NNN closed. BUG_LIST.md and BUG-NNN.md updated.
```

If user says fix didn't work: re-open investigation (go back to Step 5).

If deferring: update status → **Deferred**, move to a Deferred section in BUG_LIST.md with reason and suggested epic.

---

## Output Documents

| Document | Purpose |
|----------|---------|
| `BUG_LIST.md` | Shared bug registry for the task — all bugs across all sessions |
| `bugs/BUG-NNN.md` | Per-bug lifecycle document — grows from report through resolution |
