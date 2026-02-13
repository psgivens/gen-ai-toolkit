# Design Decisions

## Description
Guide the user through making architectural and design decisions using an interview-based approach with recommendations and trade-offs.

## Trigger
When user invokes `execute .claude/skills/design` or says "start design decisions" or "make architectural decisions"

## Instructions

You are guiding the user through Phase 2: Design Decisions of a structured development workflow.

**Follow the Interview Pattern** defined in `.claude/CLAUDE.md` for conducting the design interview.

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

### Step 2: Create Design Interview
- Create `claude/${TASK_FOLDER}/DESIGN_INTERVIEW.md` following the Interview Pattern structure
- Start with "## Interview Round 1"
- Provide **up to 15 questions** focused on architectural and design decisions
- For each question:
  - Lead with your recommended option (e.g., "What X should we use? I recommend Y because [brief reason]")
  - Mention 2-4 alternatives with brief pros/cons (2-3 sentences total)
  - Include space for:
    - **Your Answer:** [Space for user to choose or provide their preference]
    - **Your Questions for Claude:** [Space for user to ask follow-up questions]
  - Separator `---` between questions
- Focus on HOW (implementation approach), not WHAT (already decided in requirements)
- Consider decisions about:
  - Technology stack and frameworks
  - Architecture patterns and structure
  - Data storage and management
  - API design and interfaces
  - Error handling strategy
  - Testing approach
  - Deployment and infrastructure
  - Security considerations

### Step 3: Review Gate
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/DESIGN_INTERVIEW.md with architectural and design questions (each includes my recommendation). Please:
  1. Choose your preferred option in the 'Your Answer' sections
  2. Ask any questions you have in the 'Your Questions for Claude' sections
  3. Type 'iterate' when ready for me to respond

What would you like to do?
- Type 'iterate' to continue the interview (I'll answer your questions and ask follow-ups)
- Type 'continue to next phase' to finalize design and move to architecture"
- Wait for user response

### Step 4: Interview Iteration (When user types 'iterate')
- Read `claude/${TASK_FOLDER}/DESIGN_INTERVIEW.md` to extract:
  - User's design choices/answers
  - User's questions for Claude
- If user asked questions:
  - Research as needed (read codebase, check documentation, compare technologies)
  - Add section "## Claude's Responses (Round N)" with detailed answers to each question
  - For technical questions, provide code examples or architectural diagrams if helpful
- Based on user's answers, add "## Interview Round N+1" with **up to 5 follow-up questions**:
  - Dig deeper into chosen technologies or patterns
  - Address dependencies between decisions
  - Explore edge cases or scaling considerations
  - Ask about areas not yet covered
  - Each follow-up question should still include recommendation + alternatives
- Prompt: "I've updated claude/${TASK_FOLDER}/DESIGN_INTERVIEW.md with:
  - Responses to your questions
  - [N] follow-up questions based on your design choices

What would you like to do?
- Type 'iterate' to continue the interview
- Type 'continue to next phase' to finalize design"
- Wait for user response
- If user types 'iterate' again, repeat this step

### Step 5: Generate Design Document (When user types 'continue to next phase')
- Read all answers from `claude/${TASK_FOLDER}/DESIGN_INTERVIEW.md`
- Create `claude/${TASK_FOLDER}/DESIGN.md` with:
  - Architecture overview (high-level approach)
  - Key components and their responsibilities
  - Data flows
  - Technology choices (based on user's decisions in interview)
  - Error handling strategy
  - Trade-offs made (briefly explain why certain choices were made)
- Prompt: "I've generated claude/${TASK_FOLDER}/DESIGN.md based on our interview.

What would you like to do?
- Type 'iterate' to review and refine the design document
- Type 'continue to next phase' to move to architecture design"

### Step 6: Finalize Design
- If user types 'iterate', read their feedback and update DESIGN.md
- Continue iterating until user approves
- When user types 'continue to next phase', say: "Design phase complete! Use `execute .claude/skills/architecture` to create the detailed architecture."

## Best Practices
- Always lead with a recommended option in each question (don't just list choices without guidance)
- Keep trade-off analysis brief but meaningful (2-3 sentences)
- Focus on decisions that impact implementation, not trivial choices
- If a decision depends on another, note that dependency in the question
- Highlight decisions that are harder to reverse later
- Maintain the interview pattern (create interview → user answers + asks questions → Claude responds + follow-up questions → repeat)
- When user asks questions, research thoroughly before responding
- Provide code examples or architectural diagrams when helpful
- Generate follow-up questions that build on previous design choices
