# Bug Bash Workflow

## Description
Systematically triage, prioritize, and fix known bugs with test verification and explicit scope tracking.

## Trigger
When user says "start bug bash", "let's do a bug bash", "fix bugs", or when BUG_LIST.md accumulates Open issues.

## Instructions

You are guiding the user through a structured bug triage and fix session.

This workflow produces BUG_LIST.md (living tracker) and MANUAL_TESTING.md (verification steps per fix).

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Check for PROJECT_CONTEXT.md

Check if `PROJECT_CONTEXT.md` exists at project root.
- If yes: read it for project conventions, test commands, and entry points
- If no: proceed without it

### Step 2: Initialize or Load BUG_LIST.md

Check if `claude/${TASK_FOLDER}/BUG_LIST.md` exists.

**If it does NOT exist**, create it:

```markdown
# Bug List

## Status Key
- **Open** — Not yet fixed
- **In Progress** — Currently being worked on
- **Fixed** — Fix implemented, awaiting test verification
- **Verified** — Fix confirmed via manual test
- **Deferred** — Out of scope; reason documented
- **Closed** — Verified and closed

## Open Bugs

| # | Severity | Description | Status | Notes |
|---|----------|-------------|--------|-------|
| | | | | |

## Deferred Bugs

| # | Description | Reason Deferred | Suggested Epic |
|---|-------------|-----------------|----------------|
| | | | |

## Closed Bugs

| # | Description | Fix Summary |
|---|-------------|-------------|
| | | |
```

**If it already exists**, read it and echo current Open bug count.

Then ask the user: "Please list the bugs you want to address in this session. For each bug, give a brief description. I'll prioritize them by severity."

Wait for user response.

### Step 3: Populate and Prioritize

For each bug the user provides:

1. Add to BUG_LIST.md Open section with:
   - Sequential number
   - Severity: **CRITICAL** (data loss/crash), **HIGH** (broken feature), **MEDIUM** (degraded experience), **LOW** (cosmetic/minor)
   - Description
   - Status: Open

2. Sort open bugs by severity (CRITICAL first, then HIGH, MEDIUM, LOW)

3. Present prioritized list:

```
I've added [N] bugs to BUG_LIST.md, prioritized by severity:

CRITICAL: [count]
HIGH: [count]
MEDIUM: [count]
LOW: [count]

Recommended fix order: [list first 3-5 bugs]

What would you like to do?
- Type 'continue' to start fixing in priority order
- Tell me which bug to tackle first
- Say 'defer [bug #]' to defer a bug before we start
```

Wait for user response.

### Step 4: Create MANUAL_TESTING.md

Before starting fixes, create `claude/${TASK_FOLDER}/MANUAL_TESTING.md`:

```markdown
# Manual Testing

Test cases for verifying each bug fix. Update status as bugs are fixed and verified.

## Test Cases

| Bug # | Description | Steps to Reproduce | Expected Result | Actual Result | Status |
|-------|-------------|-------------------|-----------------|---------------|--------|
| | | | | | |
```

For each Open bug, add a test case row with "Steps to Reproduce" and "Expected Result" filled in. Leave "Actual Result" and "Status" for after fixing.

### Step 5: Fix Loop

For each bug (in priority order):

1. **Update status** in BUG_LIST.md: Open → In Progress
2. **Implement the fix** in the codebase
3. **Update MANUAL_TESTING.md**: Fill in "Actual Result" after fix
4. **Verify the fix** using the test case
5. **Update status** in BUG_LIST.md: In Progress → Fixed
6. **If fix introduces new bugs or reveals scope issues:**
   - New bug discovered → add to BUG_LIST.md as new Open item
   - Fix is out of scope → mark as Deferred (see Deferral Protocol below)

After each fix, prompt:

```
Bug #[N] fixed and verified.

BUG_LIST.md status:
- Fixed: [count]
- Open: [count]
- Deferred: [count]

What would you like to do?
- Type 'continue' to fix the next bug
- Say 'defer [bug #]' to defer the next bug
- Type 'done' to close the session
```

Wait for user response.

### Deferral Protocol

When a bug is deferred, **require explicit reason and suggested epic**:

```markdown
| # | Description | Reason Deferred | Suggested Epic |
|---|-------------|-----------------|----------------|
| 3 | [description] | Sharp limitation; requires WASM decoder | Epic 4b - Performance |
```

Use "Deferred → [Epic Name]" format in the Notes column of the main table.

This makes the parking lot explicit and reviewable.

### Step 6: Session Close

When user says 'done' or all bugs are addressed:

1. Move Verified bugs from Open to Closed section in BUG_LIST.md
2. Update MANUAL_TESTING.md with final status for all test cases
3. Present session summary:

```
Bug bash session complete!

Summary:
- Fixed and verified: [count]
- Deferred (with rationale): [count]
- New bugs discovered: [count]
- Open (remaining): [count]

BUG_LIST.md and MANUAL_TESTING.md are updated.

[If deferred bugs exist:]
Deferred bugs are documented with suggested epics — consider adding them to your product backlog.
```

## Best Practices

- Never mark a bug Fixed without a test case verification
- Always document deferral reason — "Deferred → Epic X" with specific rationale
- Add newly-discovered bugs to BUG_LIST.md immediately (don't lose them)
- Scope: fix bugs only. New features discovered during fixes go to PARKING_LOT.md, not BUG_LIST.md
- If a fix requires more than 30 minutes of research, create an IMPLEMENTATION_INTERVIEW.md for that bug (Problem → Options → Decision format)
