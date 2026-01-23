# Execute Implementation

## Description
Execute the implementation plan step by step, updating status tracking as progress is made.

## Trigger
When user invokes `execute .claude/skills/implement` or says "execute the plan" or "start implementation"

## Instructions

You are guiding the user through Phase 5: Execute Implementation of a structured development workflow.

### Step 0: Determine Task Folder
- If you already know the current task folder from this session, use it and skip to reading the plan
- If not, check if any task folders exist under `claude/`
  - If exactly one exists, ask: "I found task folder: claude/[folder-name]. Should I use this one?"
  - If multiple exist, ask: "Which task should I work on?" and list the folders with their names
  - If none exist, prompt: "What should I name this task folder? (Suggested format: YYYY-MM-DD-description, e.g., '2026-01-22-add-feature')"
- Create the folder if it doesn't exist: `claude/${TASK_FOLDER}/`
- Remember this task folder for the rest of the session
- Echo to user: "Working on task: ${TASK_FOLDER}"
- All subsequent paths in this skill should use `claude/${TASK_FOLDER}/` instead of `claude/`

### Step 1: Read the Plan
- Read `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md` to understand all steps
- Read `claude/${TASK_FOLDER}/DESIGN.md` for architectural guidance
- Verify you understand the full scope before starting

### Step 2: Begin Execution
- Start with the first step marked "Not Started"
- Before implementing, explain what you're about to do
- Execute the step (write code, create files, etc.)
- Follow the architecture and patterns defined in DESIGN.md

### Step 3: Update Status Tracking
- After completing each step, immediately update the status tracking table in `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md`
- Change status from "Not Started" → "In Progress" → "Complete"
- Add notes about what was done, any issues encountered, or deviations from plan

### Step 4: Review Gate After Each Step
- After completing a step, prompt: "Step [N] complete: [brief summary].

What would you like to do?
- Type 'iterate' to review and refine this step
- Type 'continue to next phase' to proceed to step [N+1]"
- Wait for user response
- If user chooses iterate, make changes and update status notes

### Step 5: Handle Issues
- If you encounter problems during implementation:
  - Mark the step as "In Progress" with notes about the issue
  - Explain the problem to the user
  - Propose solutions
  - Wait for user guidance
- Don't skip steps or mark them complete if they have issues

### Step 6: Test as You Go
- After major steps, verify functionality
- Run any tests specified in the plan
- Report test results to the user
- Fix any failing tests before proceeding

### Step 7: Continue Through All Steps
- Work through each step sequentially
- Maintain the review gate pattern (complete → prompt → wait → continue)
- Keep status tracking updated
- Stay focused on the plan (don't add features not in requirements)

### Step 8: Final Verification
- When all steps are complete, perform final testing
- Verify all requirements from `claude/${TASK_FOLDER}/REQUIREMENTS.md` are met
- Check code follows architecture from `claude/${TASK_FOLDER}/DESIGN.md`
- Prompt: "Implementation complete! All steps in claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md are done.

What would you like to do?
- Type 'iterate' to refine or fix any issues
- Type 'continue to next phase' if satisfied with the implementation"

## Best Practices
- Update status tracking immediately after each step (don't batch updates)
- Be honest about issues or blockers (don't mark things complete if they're not)
- Follow the architecture and patterns defined in earlier phases
- Write clean, maintainable code that follows project standards
- Test thoroughly as you go
- If you discover requirements issues during implementation, note them
- Keep the user informed of progress
- Don't add scope or features beyond what's in `claude/${TASK_FOLDER}/REQUIREMENTS.md`
- If you need to deviate from the plan, explain why and get approval
