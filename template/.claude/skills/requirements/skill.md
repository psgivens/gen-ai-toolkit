# Requirements Discovery

## Description
Guide the user through requirements discovery using an interview-based approach with bidirectional Q&A to understand what they want to build.

## Trigger
When user invokes `execute .claude/skills/requirements` or says "start requirements discovery"

## Instructions

You are guiding the user through Phase 1: Requirements Discovery of a structured development workflow.

**Follow the Interview Pattern** defined in `.claude/CLAUDE.md` for conducting the requirements interview.

### Step 0: Determine Task Folder
- If you already know the current task folder from this session, use it and skip to creating MISSION.md
- If not, check if any task folders exist under `claude/`
  - If exactly one exists, ask: "I found task folder: claude/[folder-name]. Should I use this one?"
  - If multiple exist, ask: "Which task should I work on?" and list the folders with their names
  - If none exist, prompt: "What should I name this task folder? (Suggested format: YYYY-MM-DD-description, e.g., '2026-01-22-add-feature')"
- Create the folder if it doesn't exist: `claude/${TASK_FOLDER}/`
- Remember this task folder for the rest of the session
- Echo to user: "Working on task: ${TASK_FOLDER}"
- All subsequent paths in this skill should use `claude/${TASK_FOLDER}/` instead of `claude/`

### Step 1: Create MISSION.md document
- Create `claude/${TASK_FOLDER}/MISSION.md` with the following sections and helpful text for the user to fill out
- Prompt the user to tell you when the MISSION.md document has been answered
- Wait for a response

Template:

    # Mission

    <!--
    Replace this template with your mission statement.
    Describe what you want to build and why.
    -->

    ## What I Want to Build

    [Describe the script/app/tool you want to create]

    ## Problem I'm Solving

    [What problem does this solve? Who is this for?]

    ## Success Criteria

    [How will you know this is successful?]

    ## Context

    [Any additional context: existing systems, constraints, preferences]

    ---

    **Next Step**: Run `execute .claude/skills/requirements` to begin the requirements discovery phase.

### Step 2: Read Mission
- Read `claude/${TASK_FOLDER}/MISSION.md` to understand the project goal
- If MISSION.md doesn't exist or is empty, ask the user to describe their goal and offer to create it for them

### Step 3: Create Requirements Interview
- Create `claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md` following the Interview Pattern structure
- Start with "## Interview Round 1"
- Provide **up to 15 questions** focused on understanding requirements
- Focus on WHAT (requirements, outcomes), not HOW (implementation)
- Ask about:
  - Desired outcomes and success criteria
  - Inputs and outputs
  - Edge cases and error handling
  - User scenarios and workflows
  - Constraints and limitations
  - Data formats and structure
  - Integration points and dependencies
  - Non-functional requirements (performance, security)
- Each question should include:
  - **Your Answer:** [Space for user]
  - **Your Questions for Claude:** [Space for user to ask questions back]
  - Separator `---` between questions

### Step 4: Review Gate
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md with initial questions about your requirements. Please:
  1. Answer the questions in the 'Your Answer' sections
  2. Ask any questions you have in the 'Your Questions for Claude' sections
  3. Type 'iterate' when ready for me to respond

What would you like to do?
- Type 'iterate' to continue the interview (I'll answer your questions and ask follow-ups)
- Type 'continue to next phase' to finalize requirements and move to design"
- Wait for user response

### Step 5: Interview Iteration (When user types 'iterate')
- Read `claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md` to extract:
  - User's answers
  - User's questions for Claude
- If user asked questions:
  - Research as needed (read codebase, check documentation, investigate context)
  - Add section "## Claude's Responses (Round N)" with detailed answers to each question
- Based on user's answers, add "## Interview Round N+1" with **up to 5 follow-up questions**:
  - Dig deeper into unclear requirements
  - Clarify contradictions or ambiguities
  - Explore edge cases mentioned by user
  - Validate assumptions
  - Ask about areas not yet covered
- Each follow-up question includes the same structure (Your Answer / Your Questions for Claude / separator)
- Prompt: "I've updated claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md with:
  - Responses to your questions
  - [N] follow-up questions based on your answers

What would you like to do?
- Type 'iterate' to continue the interview
- Type 'continue to next phase' to finalize requirements"
- Wait for user response
- If user types 'iterate' again, repeat this step

### Step 6: Generate Requirements (When user types 'continue to next phase')
- Read all answers from `claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md`
- Create `claude/${TASK_FOLDER}/REQUIREMENTS.md` with:
  - Overview (summarize what we're building based on interview)
  - Functional requirements (numbered list of specific features/capabilities)
  - Non-functional requirements (performance, security, scalability, etc.)
  - Constraints (technical, business, or resource limitations)
  - Out of scope (explicitly state what we're NOT doing)
- Prompt: "I've generated claude/${TASK_FOLDER}/REQUIREMENTS.md based on our interview.

What would you like to do?
- Type 'iterate' to review and refine the requirements document
- Type 'continue to next phase' to move to design decisions"

### Step 7: Finalize Requirements
- If user types 'iterate', read their feedback and update REQUIREMENTS.md
- Continue iterating until user approves
- When user types 'continue to next phase', say: "Requirements phase complete! Use `execute .claude/skills/design` to begin design decisions."

## Best Practices
- Keep questions focused on requirements (WHAT), not implementation (HOW)
- Use clear, concise language
- Maintain the interview pattern (create interview → user answers + asks questions → Claude responds + follow-up questions → repeat)
- When user asks questions, research thoroughly before responding
- Acknowledge user answers and questions explicitly
- Generate follow-up questions that build on previous answers
- Stay in a continuous conversation throughout this phase
