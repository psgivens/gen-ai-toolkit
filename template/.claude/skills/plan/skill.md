# Implementation Planning

## Description
Create a detailed, executable implementation plan with status tracking and validation.

## Trigger
When user invokes `execute .claude/skills/plan` or says "create implementation plan" or "plan the implementation"

## Instructions

You are guiding the user through Phase 4: Implementation Planning of a structured development workflow.

### Step 0: Determine Task Folder
- If you already know the current task folder from this session, use it and skip to reading context
- If not, check if any task folders exist under `claude/`
  - If exactly one exists, ask: "I found task folder: claude/[folder-name]. Should I use this one?"
  - If multiple exist, ask: "Which task should I work on?" and list the folders with their names
  - If none exist, prompt: "What should I name this task folder? (Suggested format: YYYY-MM-DD-description, e.g., '2026-01-22-add-feature')"
- Create the folder if it doesn't exist: `claude/${TASK_FOLDER}/`
- Remember this task folder for the rest of the session
- Echo to user: "Working on task: ${TASK_FOLDER}"
- All subsequent paths in this skill should use `claude/${TASK_FOLDER}/` instead of `claude/`

### Step 1: Read Context
- Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` to understand what needs to be built
- Read `claude/${TASK_FOLDER}/DECISIONS.md` to understand architectural choices
- Read `claude/${TASK_FOLDER}/DESIGN.md` to understand the system architecture
- Ensure design is complete before proceeding

### Step 2: Create Implementation Plan
- Create `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md` with the following sections:
  - **Overview**: What we're building (1-2 paragraphs)
  - **Prerequisites**: Dependencies, setup, environment requirements
  - **Implementation Steps**: Numbered, sequential steps
  - **Status Tracking**: Table showing progress
  - **Testing Approach**: How to verify each step
  - **Rollout/Deployment**: How to deploy or release

- For each implementation step, include:
  - Clear description of what needs to be done
  - Files that will be created or modified
  - Dependencies on other steps
  - Expected outcome or deliverable

- Status tracking table format:
  ```
  | Step | Status | Notes |
  |------|--------|-------|
  | 1. [Task name] | Not Started | [Details] |
  ```

### Step 3: Review Gate
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md.

What would you like to do?
- Type 'iterate' to review and refine the steps
- Type 'continue to next phase' to validate the plan"
- Wait for user response

### Step 4: Validate the Plan
- After user reviews, create `claude/${TASK_FOLDER}/PLAN_ANALYSIS.md` that:
  - Checks plan against REQUIREMENTS.md (does it build everything needed?)
  - Checks plan against DESIGN.md (does it follow the architecture?)
  - Identifies any risks, gaps, or potential issues
  - Suggests improvements if needed
- Prompt: "I've analyzed the plan in claude/${TASK_FOLDER}/PLAN_ANALYSIS.md.

What would you like to do?
- Type 'iterate' to refine based on the analysis
- Type 'continue to next phase' to finalize the plan"

### Step 5: Update Plan Based on Analysis
- If PLAN_ANALYSIS.md identified issues, update IMPLEMENTATION_PLAN.md
- Address any feedback from user
- Continue iterating until plan is solid

### Step 6: Final Review
- Prompt: "Updated implementation plan is ready.

What would you like to do?
- Type 'iterate' for any final refinements
- Type 'continue to next phase' to begin implementation"
- Wait for final approval

### Step 7: Finalize Plan
- When approved, prompt: "Implementation plan is finalized! Use `execute .claude/skills/implement` to begin execution, or start executing individual steps."

## Best Practices
- Break work into small, manageable steps (ideally each step is 1-2 hours)
- Make steps sequential with clear dependencies
- Each step should have a clear definition of "done"
- Include testing/verification for each major step
- Consider what can fail and how to handle it
- Make the plan executable (someone should be able to follow it step-by-step)
- Include time for refactoring and cleanup
- Don't forget documentation and testing steps
