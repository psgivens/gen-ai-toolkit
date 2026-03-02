# Quick Task Workflow

## Description
Lightweight implementation path for small features that reuse existing architecture. Skips the full requirements/design/architecture interview cycle when not needed.

## Trigger
When user says "quick task", "small feature", "just implement", or when a feature:
- Clearly fits within existing architecture
- Requires no new design decisions
- Can be planned in under 15 minutes
- Is estimated to take 1–4 hours of implementation

## Scope Guard

**This workflow is NOT appropriate when:**
- The feature requires new architectural patterns
- Multiple components need to be designed from scratch
- There are significant trade-offs to evaluate
- The feature affects data storage schemas
- Security or authentication decisions are needed

If the task is unclear or complex, say: "This sounds like it needs the full requirements → design → architecture pipeline. Let me suggest starting with the requirements workflow instead."

## Instructions

You are guiding the user through a focused, lightweight implementation task.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Check for PROJECT_CONTEXT.md

Check if `PROJECT_CONTEXT.md` exists at project root. If yes, read it.

### Step 2: Create MISSION.md

**Follow MISSION.md Standard** to create `claude/${TASK_FOLDER}/MISSION.md`.

Keep it brief:
- Goal: 1-2 sentences
- Out of Scope: at least 2-3 explicit exclusions (required)
- Code Entry Points: where implementation will happen
- Success Criteria: how we'll know it's done

### Step 3: Verify Scope Fits Existing Architecture

Read `ARCHITECTURE.md` (project root or task folder).

Confirm:
- [ ] The feature uses existing components/patterns
- [ ] No new directory structure needed
- [ ] No new external dependencies required
- [ ] No schema changes required

If scope does NOT fit, say: "This feature needs [new component / new dependency / schema change]. I recommend using the full design + architecture workflow instead. Want me to start there?"

Wait for user confirmation. If they confirm escalation, stop this workflow and suggest: "execute the design workflow."

### Step 4: Generate IMPLEMENTATION_PLAN.md

Based on MISSION.md, ARCHITECTURE.md, and PROJECT_CONTEXT.md, directly generate `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md`.

Use the same template as the plan workflow, but keep it focused:
- 4–8 steps (not 15–20)
- Each step should be 30–60 minutes of work
- Focus on the specific change, not scaffolding that already exists

Present it:

```
I've created IMPLEMENTATION_PLAN.md with [N] steps.

Steps overview:
[bullet list of steps]

Success criteria: [from MISSION.md]

What would you like to do?
- Tell me changes to make
- Type 'continue' to start implementation
```

Wait for user response. If changes requested, update and re-present.

### Step 5: Implement

Execute the implementation plan step by step.

For each step:
1. Update status to In Progress
2. Implement the change
3. If the change introduces any new function, class, or service: write unit tests for it now (not later)
4. Run `npm test` (or project test command) and confirm green
5. Verify against the step's verification criteria
6. Update status to Complete
7. Echo brief summary of what was done

After each step:

```
Step [N] complete: [1-sentence summary]

What would you like to do?
- Type 'continue' to proceed to Step [N+1]
- Tell me any issues or changes needed
```

Wait for user response.

### Step 6: Verify Success Criteria

After all steps complete, verify each success criterion from MISSION.md:

```
All steps complete. Verifying success criteria:

- [criterion 1]: [PASS / FAIL — description]
- [criterion 2]: [PASS / FAIL — description]
- [criterion 3]: [PASS / FAIL — description]

[If all pass:] Task complete! All success criteria met.
[If any fail:] [N] criteria not yet met. Want me to address them?
```

### Step 7: Completion

When all criteria are met:

```
Quick task complete!

What was built: [1-2 sentences]
Files changed: [list]
Test to verify: [quick manual test the user can run]
```

## Best Practices

- Keep MISSION.md short — this is a quick task, not a full epic
- If implementation reveals unexpected complexity, escalate: "This is more complex than expected. Want to pause and do a proper design phase?"
- Document all deviations from MISSION.md in the status tracking notes
- Out of Scope in MISSION.md is your scope guard — enforce it
