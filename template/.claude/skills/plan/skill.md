# Implementation Planning

## Description
Create a detailed, executable implementation plan using an interview-based approach to explore sequencing, dependencies, and testing strategy.

## Trigger
When user invokes `execute .claude/skills/plan` or says "create implementation plan" or "plan the implementation"

## Instructions

You are guiding the user through Phase 4: Implementation Planning of a structured development workflow.

**Follow the Interview Pattern** defined in `.claude/CLAUDE.md` for conducting the planning interview.

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
- Read `claude/${TASK_FOLDER}/DESIGN.md` to understand architectural choices
- Read `claude/${TASK_FOLDER}/ARCHITECTURE.md` to understand the system architecture
- Ensure architecture is complete before proceeding

### Step 2: Create Planning Interview
- Create `claude/${TASK_FOLDER}/PLAN_INTERVIEW.md` following the Interview Pattern structure
- Start with "## Interview Round 1"
- Provide **up to 15 questions** focused on implementation approach and sequencing
- Ask about:
  - Implementation order and sequencing (what to build first?)
  - Step granularity (how to break down the work?)
  - Dependencies between steps
  - Testing strategy (unit, integration, e2e - when and how?)
  - Data migration or setup needs
  - Configuration and environment setup
  - Rollout approach (phased, all-at-once, feature flags?)
  - Risk mitigation (what could go wrong, how to handle it?)
  - Verification approach (how to know each step is complete?)
  - Rollback plan (how to undo if needed?)
  - Documentation needs
  - Time-sensitive constraints
- Each question should include:
  - **Your Answer:** [Space for user]
  - **Your Questions for Claude:** [Space for user to ask questions back]
  - Separator `---` between questions

### Step 3: Review Gate
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/PLAN_INTERVIEW.md with questions about implementation approach. Please:
  1. Answer the questions in the 'Your Answer' sections
  2. Ask any questions you have in the 'Your Questions for Claude' sections
  3. Type 'iterate' when ready for me to respond

What would you like to do?
- Type 'iterate' to continue the interview (I'll answer your questions and ask follow-ups)
- Type 'continue to next phase' to finalize plan and begin implementation"
- Wait for user response

### Step 4: Interview Iteration (When user types 'iterate')
- Read `claude/${TASK_FOLDER}/PLAN_INTERVIEW.md` to extract:
  - User's planning decisions/answers
  - User's questions for Claude
- If user asked questions:
  - Research as needed (check architecture, review requirements, explore implementation patterns)
  - Add section "## Claude's Responses (Round N)" with detailed answers to each question
  - Provide implementation examples, sequence diagrams, or step breakdowns if helpful
- Based on user's answers, add "## Interview Round N+1" with **up to 5 follow-up questions**:
  - Dig deeper into step dependencies
  - Clarify testing strategy for specific components
  - Explore risk mitigation approaches
  - Address rollback or error handling
  - Ask about areas not yet covered
- Prompt: "I've updated claude/${TASK_FOLDER}/PLAN_INTERVIEW.md with:
  - Responses to your questions
  - [N] follow-up questions based on your planning approach

What would you like to do?
- Type 'iterate' to continue the interview
- Type 'continue to next phase' to finalize plan"
- Wait for user response
- If user types 'iterate' again, repeat this step

### Step 5: Generate Implementation Plan (When user types 'continue to next phase')
- Read all answers from `claude/${TASK_FOLDER}/PLAN_INTERVIEW.md`
- Create `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md` with:
  - **Overview**: What we're building (1-2 paragraphs)
  - **Prerequisites**: Dependencies, setup, environment requirements
  - **Implementation Steps**: Numbered, sequential steps based on interview answers
    - For each step:
      - Clear description of what needs to be done
      - Files that will be created or modified
      - Dependencies on other steps
      - Expected outcome or deliverable
      - Testing/verification approach
  - **Status Tracking**: Table showing progress
    ```
    | Step | Status | Notes |
    |------|--------|-------|
    | 1. [Task name] | Not Started | [Details] |
    ```
  - **Testing Approach**: How to verify each step (from interview)
  - **Rollout/Deployment**: How to deploy or release (from interview)
  - **Rollback Plan**: How to undo changes if needed (from interview)
- Validate plan against REQUIREMENTS.md and ARCHITECTURE.md
- Prompt: "I've generated claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md based on our interview.

What would you like to do?
- Type 'iterate' to review and refine the plan
- Type 'continue to next phase' to begin implementation"

### Step 6: Finalize Plan
- If user types 'iterate', read their feedback and update IMPLEMENTATION_PLAN.md
- Continue iterating until user approves
- When user types 'continue to next phase', say: "Implementation plan is finalized! Use `execute .claude/skills/implement` to begin execution."

## Best Practices
- Break work into small, manageable steps (ideally each step is 1-2 hours)
- Make steps sequential with clear dependencies
- Each step should have a clear definition of "done"
- Include testing/verification for each major step
- Consider what can fail and how to handle it
- Make the plan executable (someone should be able to follow it step-by-step)
- Include time for refactoring and cleanup
- Don't forget documentation and testing steps
- Maintain the interview pattern (create interview → user answers + asks questions → Claude responds + follow-up questions → repeat)
- When user asks questions, provide concrete implementation examples or step breakdowns
- Generate follow-up questions that explore dependencies and risk mitigation
