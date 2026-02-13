# Execute Implementation Workflow

## Description
Execute the implementation plan step by step, using an interview-based approach for addressing blockers and questions during execution.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/implement`) or says "execute the plan" or "start implementation"

## Instructions

You are guiding the user through Phase 5: Execute Implementation of a structured development workflow.

**Follow the Interview Pattern** defined in `PATTERNS.md` (in the same directory as this workflow) when addressing blockers or questions during implementation.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read the Plan
- Read `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md` to understand all steps
- Read `claude/${TASK_FOLDER}/ARCHITECTURE.md` for architectural guidance
- Verify you understand the full scope before starting

### Step 2: Execute Implementation Steps

#### Execution Process
1. **Start with first "Not Started" step**
   - Before implementing, explain what you're about to do
   - Execute the step (write code, create files, etc.)
   - Follow the architecture and patterns defined in ARCHITECTURE.md

2. **Update Status Tracking**
   - After completing each step, immediately update the status tracking table in `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md`
   - Change status from "Not Started" → "In Progress" → "Complete"
   - Add notes about what was done, any issues encountered, or deviations from plan

3. **Review Gate After Each Step**
   - After completing a step, prompt:
     ```
     Step [N] complete: [brief summary].

     What would you like to do?
     - Type 'iterate' to review and refine this step
     - Type 'continue to next phase' to proceed to step [N+1]
     ```
   - Wait for user response
   - If user chooses iterate, make changes and update status notes

4. **Test as You Go**
   - After major steps, verify functionality
   - Run any tests specified in the plan
   - Report test results to the user
   - Fix any failing tests before proceeding

#### Handling Issues and Blockers

If you encounter problems during implementation:
1. Mark the step as "In Progress" with notes about the issue
2. **Use Interview Pattern** to address the blocker:
   - Create or update `claude/${TASK_FOLDER}/IMPLEMENTATION_INTERVIEW.md`
   - Ask questions about the blocker (e.g., "How should we handle [specific issue]?")
   - Propose 2-3 solutions with trade-offs
   - Leave space for user's answer and their questions
   - Wait for user guidance
   - When user responds with "iterate", answer their questions and ask follow-ups if needed
3. Don't skip steps or mark them complete if they have issues

### Step 3: Continue Through All Steps
- Work through each step sequentially
- Maintain the review gate pattern (complete → prompt → wait → continue)
- Keep status tracking updated
- Stay focused on the plan (don't add features not in requirements)

### Step 4: Final Verification
When all steps are complete:
1. Perform final testing
2. Verify all requirements from `claude/${TASK_FOLDER}/REQUIREMENTS.md` are met
3. Check code follows architecture from `claude/${TASK_FOLDER}/ARCHITECTURE.md`
4. Prompt:
   ```
   Implementation complete! All steps in claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md are done.

   What would you like to do?
   - Type 'iterate' to refine or fix any issues
   - Type 'continue to next phase' if satisfied with the implementation
   ```

## Best Practices
- Update status tracking immediately after each step (don't batch updates)
- Be honest about issues or blockers (don't mark things complete if they're not)
- Follow the architecture and patterns defined in ARCHITECTURE.md
- Write clean, maintainable code that follows project standards
- Test thoroughly as you go
- If you discover requirements issues during implementation, note them
- Keep the user informed of progress
- Don't add scope or features beyond what's in REQUIREMENTS.md
- If you need to deviate from the plan, explain why and get approval
- Use the interview pattern (IMPLEMENTATION_INTERVIEW.md) to address blockers collaboratively
- When creating interview questions for blockers, provide recommendations and alternatives
