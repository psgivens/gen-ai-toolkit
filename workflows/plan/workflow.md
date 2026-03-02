# Implementation Planning Workflow

## Description
Create a detailed, executable implementation plan by analyzing requirements, design, and architecture, then breaking down work into sequential steps.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/plan`) or says "create implementation plan" or "plan the implementation"

## Instructions

You are guiding the user through Phase 4: Implementation Planning of a structured development workflow.

This workflow generates IMPLEMENTATION_PLAN.md directly by breaking down the architecture into concrete implementation steps.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read Context

Read all necessary context documents:
- Check if `PROJECT_CONTEXT.md` exists at project root. If yes, read it first.
- Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` to understand what needs to be built
- Read `claude/${TASK_FOLDER}/DESIGN.md` to understand architectural choices
- Read `claude/${TASK_FOLDER}/ARCHITECTURE.md` to understand the system architecture
- Read `claude/${TASK_FOLDER}/MISSION.md` for context about project goals
- Explore codebase if needed to understand existing patterns and integration points

If architecture is incomplete or missing, prompt:
```
Architecture is needed before creating an implementation plan. Please complete the architecture workflow first.
```

### Step 2: Generate Implementation Plan

Based on the context read in Step 1, create `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md` directly.

**Note on planning approach:** This workflow generates the plan directly from the architecture documents rather than conducting a planning interview. This is intentional — users engage better reviewing a complete draft plan than answering sequential planning questions (the Q&A format has low completion rates for planning tasks). Present the complete draft, then iterate based on user feedback.

#### Document Structure

Follow this structure when generating IMPLEMENTATION_PLAN.md:

```markdown
# Implementation Plan

## Overview
[1-2 paragraphs summarizing what we're building based on requirements]

## Prerequisites

Before starting implementation:
- [ ] [e.g., Node.js 18+ installed]
- [ ] [e.g., PostgreSQL 15 running locally]
- [ ] [e.g., Environment variables configured]
- [ ] [e.g., Dependencies installed via npm install]

## Implementation Steps

### Step 1: [Foundation/Setup Task]
**What:** [Clear description of what needs to be done]
**Files to create/modify:**
- `[file path]` - [purpose]
- `[file path]` - [purpose]
**Dependencies:** None (or list step numbers this depends on)
**Expected outcome:** [What should work after this step]
**Verification:**
- [ ] [Unit tests written for any new functions/classes/services — name the file, e.g., `tests/unit/services/foo.test.ts`]
- [ ] [`npm test` passes with all new tests green]
- [ ] [Manual/integration check if applicable, e.g., "API returns 200"]

### Step 2: [Next Logical Task]
**What:** [Description]
**Files to create/modify:**
- `[file path]` - [purpose]
**Dependencies:** Step 1
**Expected outcome:** [Deliverable]
**Verification:**
- [ ] [Test approach]

[Continue for all steps - typically 8-20 steps for a feature]

## Status Tracking

| Step | Status | Notes |
|------|--------|-------|
| 1. [Task name] | Not Started | [Initial details] |
| 2. [Task name] | Not Started | [Initial details] |
| ... | | |

## Parking Lot

Items discovered during implementation that are out of scope for this epic but worth tracking.
See `claude/${TASK_FOLDER}/PARKING_LOT.md` for the full parking lot.
(This section is populated during implementation, not planning.)

## Testing Approach

**Unit Tests:**
- [What to test, when to write them]
- [Location: e.g., tests/unit/]

**Integration Tests:**
- [What to test, when to write them]
- [Location: e.g., tests/integration/]

**E2E Tests:**
- [Critical flows to test]
- [Location: e.g., tests/e2e/]

**Test Command:** `[e.g., npm test]`

## Rollout/Deployment

[How to deploy or release this feature]
1. [Step 1, e.g., "Merge PR to main"]
2. [Step 2, e.g., "Run database migrations"]
3. [Step 3, e.g., "Deploy to staging"]
4. [Step 4, e.g., "Verify in staging"]
5. [Step 5, e.g., "Deploy to production"]

## Rollback Plan

If something goes wrong:
1. [How to revert, e.g., "Roll back deployment to previous version"]
2. [How to undo data changes, e.g., "Run migration down script"]
3. [How to notify users if needed]
```

#### Planning Guidelines

When creating the implementation plan:

1. **Start with foundation:**
   - Database schema/models (if needed)
   - Core data structures
   - Configuration setup
   - Project structure/scaffolding

2. **Build incrementally:**
   - Each step should add visible progress
   - Steps should be small (1-2 hours each ideally)
   - Steps should be independently verifiable

3. **Follow dependency order:**
   - Database layer before service layer
   - Service layer before API layer
   - Backend before frontend (usually)
   - Core functionality before edge cases

4. **Include unit tests at each step (not at the end):**
   - Any step that introduces a new function, class, or service MUST include writing unit tests as part of that step — not as a separate later step
   - Name the test file explicitly in the Verification section (e.g., `tests/unit/services/tags/database.test.ts`)
   - Verification should include: "Write unit tests for [class/function], run `npm test`, all new tests pass"
   - Pattern: Implement → Write Unit Tests → Run `npm test` → Verify Green → Next
   - Leaving testing to the end produces gaps and is harder to enforce autonomously

5. **Be specific:**
   - Name actual files that will be created
   - Reference actual technology (from DESIGN.md)
   - Provide concrete verification steps

6. **Consider risks:**
   - What could break existing functionality?
   - Where are integration points with existing code?
   - What's the most uncertain/risky part? (Consider doing it early)

7. **Apply architecture:**
   - Follow directory structure from ARCHITECTURE.md
   - Use component names from ARCHITECTURE.md
   - Respect boundaries defined in architecture

### Step 3: Validation

After generating IMPLEMENTATION_PLAN.md, validate it:
- All functional requirements from REQUIREMENTS.md have implementation steps
- Steps follow architecture structure from ARCHITECTURE.md
- Dependencies are correct (no circular dependencies)
- Testing is integrated throughout: each step that introduces new code names a specific test file and includes a `npm test` verification — not just "add tests later"
- Each step has clear verification criteria

### Step 4: Prompt for Review

```
I've created claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md with [N] implementation steps.

Key milestones:
- Steps 1-3: [Summary, e.g., "Database and models"]
- Steps 4-7: [Summary, e.g., "API endpoints"]
- Steps 8-10: [Summary, e.g., "Frontend components"]

What would you like to do next?
- Tell me specific changes to make (e.g., "Break step 5 into smaller steps", "Add testing earlier")
- Continue to the implement workflow to begin execution
```

Wait for user response. If changes requested, update IMPLEMENTATION_PLAN.md and repeat this prompt.

### Step 5: Completion

When user continues to next phase:
```
Implementation plan is finalized! Continue to the implement workflow to begin execution.
```

## Best Practices
- Break work into small, manageable steps (ideally each step is 1-2 hours)
- Make steps sequential with clear dependencies
- Each step should have a clear definition of "done"
- Include testing/verification for each major step
- Consider what can fail and how to handle it
- Make the plan executable (someone should be able to follow it step-by-step)
- Include time for refactoring and cleanup
- Don't forget documentation and testing steps
- When user asks questions, provide concrete implementation examples or step breakdowns
- Generate follow-up questions that explore dependencies and risk mitigation
