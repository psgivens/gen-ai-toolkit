# Requirements Discovery

## Description
Guide the user through requirements discovery by asking clarifying questions about what they want to build.

## Trigger
When user invokes `execute .claude/skills/requirements` or says "start requirements discovery"

## Instructions

You are guiding the user through Phase 1: Requirements Discovery of a structured development workflow.

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

### Step 3: Initial Questions
- Create `claude/${TASK_FOLDER}/GATHER_REQUIREMENTS.md` with 8-10 clarifying questions
- Focus on WHAT (requirements, outcomes), not HOW (implementation)
- Ask about:
  - Desired outcomes and success criteria
  - Inputs and outputs
  - Edge cases and error handling
  - User scenarios and workflows
  - Constraints and limitations
- Leave space after each question for user answers

### Step 4: Review Gate
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/GATHER_REQUIREMENTS.md with initial questions. Please review and add your answers in the spaces provided between each question.

What would you like to do?
- Type 'iterate' to review and refine further
- Type 'continue' to proceed with follow-up questions"
- Wait for user response

### Step 5: Follow-Up Questions
- Read the user's answers
- Add a new section to GATHER_REQUIREMENTS.md with up to 5 follow-up questions
- Prompt: "Based on your answers, I have [N] follow-up questions. I've added them to claude/${TASK_FOLDER}/GATHER_REQUIREMENTS.md.

What would you like to do?
- Type 'iterate' to review and refine the questions
- Type 'continue' to answer and proceed"
- Wait for user response

### Step 6: Generate Requirements
- Read all answers from GATHER_REQUIREMENTS.md
- Create `claude/${TASK_FOLDER}/REQUIREMENTS.md` with:
  - Overview
  - Functional requirements (numbered list)
  - Non-functional requirements (performance, security, etc.)
  - Constraints
  - Out of scope (explicitly state what we're NOT doing)
- Prompt: "I've generated claude/${TASK_FOLDER}/REQUIREMENTS.md based on our discussion.

What would you like to do?
- Type 'iterate' to review and refine further
- Type 'continue' to finalize requirements"

### Step 7: Iterate on Feedback
- If user provides feedback, update REQUIREMENTS.md
- Continue iterating until user approves
- When approved, say: "Requirements phase complete! Use `execute .claude/skills/decisions` to begin design decisions."

## Best Practices
- Keep questions focused on requirements, not implementation
- Use clear, concise language
- Maintain the review gate pattern (create → prompt → wait → iterate)
- Acknowledge user edits explicitly
- Stay in a continuous conversation throughout this phase
