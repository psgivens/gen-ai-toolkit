# Project Refinement

## Description
Guide the user through making refinements to the current project using an interview-based approach to understand refactoring goals, risks, and constraints.

## Trigger
When user invokes `execute .claude/skills/refinement` or says "refine this project", "do some cleanup", "refactor the code", or "reorganize the project"

## Instructions

You are guiding the user through a structured refinement workflow to improve code quality, organization, or structure.

**Follow the Interview Pattern** defined in `.claude/CLAUDE.md` for conducting the refinement interview.

### Step 0: Determine Task Folder
- If you already know the current task folder from this session, use it and skip to creating refinement template
- If not, check if any task folders exist under `claude/`
  - If exactly one exists, ask: "I found task folder: claude/[folder-name]. Should I use this one?"
  - If multiple exist, ask: "Which task should I work on?" and list the folders with their names
  - If none exist, prompt: "What should I name this task folder? (Suggested format: YYYY-MM-DD-description, e.g., '2026-01-22-refactor-api')"
- Create the folder if it doesn't exist: `claude/${TASK_FOLDER}/`
- Remember this task folder for the rest of the session
- Echo to user: "Working on task: ${TASK_FOLDER}"
- All subsequent paths in this skill should use `claude/${TASK_FOLDER}/` instead of `claude/`

### Step 1: Create Refinement Template
- Create `claude/${TASK_FOLDER}/REFINEMENT.md` with the following template
- Prompt the user to fill out the template describing their desired refinement
- Wait for user response

Template:

    # Project Refinement

    <!--
    Replace this template with your refinement goals.
    Describe what you want to improve, refactor, or reorganize.
    -->

    ## Type of Refinement

    - [ ] Code refactoring (improve internal structure)
    - [ ] Reorganization (move files, restructure directories)
    - [ ] Global renaming (rename functions, classes, variables)
    - [ ] Code cleanup (remove unused code, improve consistency)
    - [ ] Performance optimization
    - [ ] Other: [Describe]

    ## What I Want to Refine

    [Describe what needs refinement and why]

    ## Current Issues

    [What problems exist with the current code/structure?]

    ## Desired Outcome

    [What should the code look like after refinement?]

    ## Scope

    [Which files, modules, or components are affected?]

    ## Constraints

    [Any limitations: must maintain backwards compatibility, can't break existing tests, etc.]

    ---

    **Next Step**: Once you've filled this out, tell Claude you're ready to proceed.

### Step 2: Create Refinement Interview
- Read `claude/${TASK_FOLDER}/REFINEMENT.md` to understand the refinement goals
- Create `claude/${TASK_FOLDER}/REFINEMENT_INTERVIEW.md` following the Interview Pattern structure
- Start with "## Interview Round 1"
- Provide **up to 15 questions** focused on understanding the refactoring
- Focus on understanding:
  - Scope and boundaries of the refactoring
  - Current pain points and desired improvements
  - Risks and dependencies
  - Testing strategy (existing tests, new tests needed)
  - Success criteria (what defines "done"?)
  - Breaking changes tolerance
  - Backwards compatibility requirements
  - Migration path if needed
  - Rollback strategy
  - Timeline and urgency
  - Files and modules affected
- Each question should include:
  - **Your Answer:** [Space for user]
  - **Your Questions for Claude:** [Space for user to ask questions back]
  - Separator `---` between questions

### Step 3: Review Gate
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/REFINEMENT_INTERVIEW.md with questions about your refactoring goals. Please:
  1. Answer the questions in the 'Your Answer' sections
  2. Ask any questions you have in the 'Your Questions for Claude' sections
  3. Type 'iterate' when ready for me to respond

What would you like to do?
- Type 'iterate' to continue the interview (I'll answer your questions and ask follow-ups)
- Type 'continue to next phase' to create the refinement plan"
- Wait for user response

### Step 4: Interview Iteration (When user types 'iterate')
- Read `claude/${TASK_FOLDER}/REFINEMENT_INTERVIEW.md` to extract:
  - User's answers about refactoring goals
  - User's questions for Claude
- If user asked questions:
  - Research as needed (explore codebase, check dependencies, review existing patterns)
  - Add section "## Claude's Responses (Round N)" with detailed answers to each question
  - Provide code examples, refactoring patterns, or risk analysis if helpful
- Based on user's answers, add "## Interview Round N+1" with **up to 5 follow-up questions**:
  - Dig deeper into scope and boundaries
  - Clarify testing and validation approach
  - Explore risk mitigation strategies
  - Address rollback or migration concerns
  - Ask about areas not yet covered
- Prompt: "I've updated claude/${TASK_FOLDER}/REFINEMENT_INTERVIEW.md with:
  - Responses to your questions
  - [N] follow-up questions based on your refactoring goals

What would you like to do?
- Type 'iterate' to continue the interview
- Type 'continue to next phase' to create the refinement plan"
- Wait for user response
- If user types 'iterate' again, repeat this step

### Step 5: Create Refinement Plan (When user types 'continue to next phase')
- Read all answers from `claude/${TASK_FOLDER}/REFINEMENT_INTERVIEW.md`
- Read the current codebase to understand what needs to change
- Create `claude/${TASK_FOLDER}/REFINEMENT_PLAN.md` with:
  - **Overview**: Summary of the refinement
  - **Scope**: What will and won't change
  - **Risk Analysis**: What could break, how to mitigate
  - **Prerequisites**: Backups, branch creation, test baseline
  - **Refactoring Steps**: Numbered, sequential steps
  - **Status Tracking**: Table showing progress
  - **Validation Steps**: How to verify nothing broke
  - **Rollback Plan**: How to undo changes if needed

- For each refactoring step, include:
  - Clear description of what changes
  - Files that will be modified
  - Expected impact (breaking/non-breaking)
  - Testing approach for that step

- Status tracking table format:
  ```
  | Step | Status | Notes |
  |------|--------|-------|
  | 1. [Task name] | Not Started | [Details] |
  ```

### Step 6: Review Gate for Plan
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/REFINEMENT_PLAN.md with the detailed refactoring steps.

What would you like to do?
- Type 'iterate' to review and make changes to the plan
- Type 'execute' to begin executing the refactoring plan"
- Wait for user response

### Step 7: Iterate on Plan (If Requested)
- If user provides feedback, update REFINEMENT_PLAN.md accordingly
- After each update, prompt: "I've updated claude/${TASK_FOLDER}/REFINEMENT_PLAN.md.

What would you like to do?
- Type 'iterate' for more changes
- Type 'execute' to begin execution"
- Continue iterating until user is ready to execute

### Step 8: Execute Refinement Plan
- When user types 'execute' or asks to run the plan:
  - Work through each step sequentially
  - Update the status tracking table in `claude/${TASK_FOLDER}/REFINEMENT_PLAN.md` as you progress
  - Mark each step as "In Progress" when starting, "Complete" when done
  - Run tests after significant changes
  - If a step fails or causes issues, STOP and consult with user

- After each major step, provide a brief status update:
  "Completed Step [N]: [description]. Status: [test results]. Moving to Step [N+1]."

- When all steps are complete:
  - Run full test suite (if available)
  - Provide summary of changes made
  - Recommend reviewing the changes before committing

### Step 9: Completion
- Prompt: "Refinement complete! Summary of changes:
  [List key changes made]

All tests passing: [Yes/No]
Files modified: [count]

What would you like to do?
- Type 'review changes' to see a detailed diff
- Type 'commit' if you're ready to commit the changes
- Type 'rollback' if something went wrong"

## Best Practices
- Always create a backup or work in a branch before major refactoring
- Make small, incremental changes rather than large rewrites
- Run tests frequently during refactoring
- If tests don't exist, consider writing them first
- Document why changes were made, not just what changed
- Keep the refactoring scope manageable (don't try to fix everything at once)
- If a step breaks something, stop and fix it before proceeding
- Maintain the review gate pattern throughout
- Be explicit about breaking vs. non-breaking changes
- Consider backwards compatibility and migration paths
- Use the interview pattern (create interview → user answers + asks questions → Claude responds + follow-up questions → repeat)
- When user asks questions, research the codebase thoroughly before responding
- Generate follow-up questions that explore risks and mitigation strategies 
