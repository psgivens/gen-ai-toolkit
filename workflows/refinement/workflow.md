# Project Refinement Workflow

## Description
Guide the user through making refinements to the current project using an interview-based approach to understand refactoring goals, risks, and constraints.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/refinement`) or says "refine this project", "do some cleanup", "refactor the code", or "reorganize the project"

## Instructions

You are guiding the user through a structured refinement workflow to improve code quality, organization, or structure.

**Follow the Interview Pattern** defined in `PATTERNS.md` at the workflows root (fetch from `$WORKFLOWS/PATTERNS.md` if using URL access) for conducting the refinement interview.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

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

### Step 2: Read Refinement Goals
- Read `claude/${TASK_FOLDER}/REFINEMENT.md` to understand the refinement goals

### Step 3: Conduct Refinement Interview
**Follow Interview Pattern** to conduct refinement interview:

#### Phase-Specific Focus
- **Focus:** Understanding refactoring goals and risks
- **Initial questions (up to 15) should explore:**
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

#### Output Documents
- **Interview file:** `claude/${TASK_FOLDER}/REFINEMENT_INTERVIEW.md`
- **Output document:** `claude/${TASK_FOLDER}/REFINEMENT_PLAN.md`

#### Document Structure
When generating REFINEMENT_PLAN.md, follow this structure:
- **Overview**: Summary of the refinement
- **Scope**: What will and won't change
- **Risk Analysis**: What could break, mitigation strategies
- **Prerequisites**: Backups, branch creation, test baseline
- **Refactoring Steps**: Numbered, sequential steps
  - For each step:
    - Clear description of what changes
    - Files that will be modified
    - Expected impact (breaking/non-breaking)
    - Testing approach for that step
- **Status Tracking**: Table showing progress (see Status Tracking Convention in `PATTERNS.md` at the workflows root)
  ```
  | Step | Status | Notes |
  |------|--------|-------|
  | 1. [Task name] | Not Started | [Details] |
  ```
- **Validation Steps**: How to verify nothing broke
- **Rollback Plan**: How to undo changes if needed

### Step 4: Execute Refinement Plan
When user types 'execute' or asks to run the plan:
1. Work through each step sequentially
2. Update the status tracking table in `claude/${TASK_FOLDER}/REFINEMENT_PLAN.md` as you progress
3. Mark each step as "In Progress" when starting, "Complete" when done
4. Run tests after significant changes
5. If a step fails or causes issues, STOP and consult with user
6. After each major step, provide brief status update:
   "Completed Step [N]: [description]. Status: [test results]. Moving to Step [N+1]."
7. When all steps complete:
   - Run full test suite (if available)
   - Provide summary of changes made
   - Recommend reviewing the changes before committing

### Step 5: Completion
Prompt:
```
Refinement complete! Summary of changes:
[List key changes made]

All tests passing: [Yes/No]
Files modified: [count]

What would you like to do?
- Type 'review changes' to see a detailed diff
- Type 'commit' if you're ready to commit the changes
- Type 'rollback' if something went wrong
```

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
- When user asks questions, research the codebase thoroughly before responding
- Generate follow-up questions that explore risks and mitigation strategies
