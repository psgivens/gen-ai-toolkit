# Design Decisions

## Description
Guide the user through making architectural and design decisions by proposing options with trade-offs.

## Trigger
When user invokes `execute .claude/skills/decisions` or says "start design decisions" or "make architectural decisions"

## Instructions

You are guiding the user through Phase 2: Design Decisions of a structured development workflow.

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
- Identify key architectural decisions that need to be made

### Step 2: Create Decisions Document
- Create `claude/${TASK_FOLDER}/DECISIONS.md` with 5-8 key architectural decisions
- For each decision:
  - Lead with your recommended option
  - Provide 2-4 alternatives
  - Include brief trade-off analysis (2-3 sentences)
  - Leave space for user's decision and follow-up questions
- Focus on HOW (implementation approach), not WHAT (already decided in requirements)
- Consider decisions about:
  - Technology stack and frameworks
  - Architecture patterns and structure
  - Data storage and management
  - API design and interfaces
  - Error handling strategy
  - Testing approach

### Step 3: Review Gate
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/DECISIONS.md with key architectural decisions. Please review each decision, choose your preferred option, and add any follow-up questions you have.

What would you like to do?
- Type 'iterate' to review and refine further
- Type 'continue to next phase' to proceed with your decisions"
- Wait for user response

### Step 4: Process User Decisions
- Read the user's decisions and questions
- For any follow-up questions:
  - Provide clear answers
  - Update the decision with additional context
- Mark finalized decisions as DECIDED
- If decisions lead to new questions, add them to the document

### Step 5: Iterate Until Complete
- Continue the cycle of user input → Claude updates → review
- When all major decisions are made, prompt: "I've updated claude/${TASK_FOLDER}/DECISIONS.md.

What would you like to do?
- Type 'iterate' if there are more architectural decisions to address
- Type 'continue to next phase' to finalize decisions"
- If user chooses iterate, add more decisions and continue
- If user chooses continue, move to next step

### Step 6: Finalize Decisions
- Mark all decisions as DECIDED or PENDING (with clear reason why pending)
- Create a summary section at the top listing all key decisions
- Prompt: "All design decisions are documented in claude/${TASK_FOLDER}/DECISIONS.md. Use `execute .claude/skills/architecture` to create the architecture design."

## Best Practices
- Always lead with a recommended option (don't just list choices without guidance)
- Keep trade-off analysis brief but meaningful
- Focus on decisions that impact implementation, not trivial choices
- If a decision depends on another, note that dependency
- Mark decisions that can be changed later vs. ones that are harder to reverse
- Maintain the review gate pattern throughout
