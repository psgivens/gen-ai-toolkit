# Architecture Design

## Description
Create a comprehensive architecture document using an interview-based approach to explore system structure, components, and interactions.

## Trigger
When user invokes `execute .claude/skills/architecture` or says "create architecture design" or "design the system"

## Instructions

You are guiding the user through Phase 3: Architecture Design of a structured development workflow.

**Follow the Interview Pattern** defined in `.claude/CLAUDE.md` for conducting the architecture interview.

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
- Read `claude/${TASK_FOLDER}/DESIGN.md` to understand architectural choices made
- Ensure design decisions are finalized before proceeding
- If design is incomplete, prompt user to complete design phase first

### Step 2: Create Architecture Interview
- Create `claude/${TASK_FOLDER}/ARCHITECTURE_INTERVIEW.md` following the Interview Pattern structure
- Start with "## Interview Round 1"
- Provide **up to 15 questions** focused on system architecture and structure
- Ask about:
  - System components and their responsibilities
  - Data flows and transformations
  - Integration points and interfaces
  - Directory structure and code organization
  - Module boundaries and dependencies
  - State management approach
  - Concurrency and scaling considerations
  - Error propagation and handling
  - Security boundaries and validation points
  - Testing architecture (unit, integration, e2e)
  - Deployment architecture
  - Configuration management
- Each question should include:
  - **Your Answer:** [Space for user]
  - **Your Questions for Claude:** [Space for user to ask questions back]
  - Separator `---` between questions

### Step 3: Review Gate
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/ARCHITECTURE_INTERVIEW.md with questions about system architecture. Please:
  1. Answer the questions in the 'Your Answer' sections
  2. Ask any questions you have in the 'Your Questions for Claude' sections
  3. Type 'iterate' when ready for me to respond

What would you like to do?
- Type 'iterate' to continue the interview (I'll answer your questions and ask follow-ups)
- Type 'continue to next phase' to finalize architecture and move to planning"
- Wait for user response

### Step 4: Interview Iteration (When user types 'iterate')
- Read `claude/${TASK_FOLDER}/ARCHITECTURE_INTERVIEW.md` to extract:
  - User's architecture decisions/answers
  - User's questions for Claude
- If user asked questions:
  - Research as needed (read existing codebase, check patterns, explore best practices)
  - Add section "## Claude's Responses (Round N)" with detailed answers to each question
  - Provide architecture diagrams, code examples, or directory structures if helpful
- Based on user's answers, add "## Interview Round N+1" with **up to 5 follow-up questions**:
  - Dig deeper into component interactions
  - Clarify module boundaries and dependencies
  - Explore scaling or performance implications
  - Address testing or deployment considerations
  - Ask about areas not yet covered
- Prompt: "I've updated claude/${TASK_FOLDER}/ARCHITECTURE_INTERVIEW.md with:
  - Responses to your questions
  - [N] follow-up questions based on your architecture

What would you like to do?
- Type 'iterate' to continue the interview
- Type 'continue to next phase' to finalize architecture"
- Wait for user response
- If user types 'iterate' again, repeat this step

### Step 5: Generate Architecture Document (When user types 'continue to next phase')
- Read all answers from `claude/${TASK_FOLDER}/ARCHITECTURE_INTERVIEW.md`
- Create `claude/${TASK_FOLDER}/ARCHITECTURE.md` with:
  - **Overview**: High-level description of the system architecture
  - **Key Components**: List major components and their responsibilities
  - **Data Flow**: How data moves through the system
  - **Technology Stack**: Specific technologies (from DESIGN.md)
  - **Directory Structure**: Proposed file/folder organization with rationale
  - **Module Dependencies**: Component interaction diagram or description
  - **Error Handling Strategy**: How errors propagate through the system
  - **Security Considerations**: Authentication, authorization, data protection boundaries
  - **Testing Strategy**: Unit, integration, e2e test approach
  - **Trade-offs**: Key architectural trade-offs made and why
- Validate that architecture addresses all requirements from REQUIREMENTS.md
- Prompt: "I've generated claude/${TASK_FOLDER}/ARCHITECTURE.md based on our interview.

What would you like to do?
- Type 'iterate' to review and refine the architecture document
- Type 'continue to next phase' to move to implementation planning"

### Step 6: Finalize Architecture
- If user types 'iterate', read their feedback and update ARCHITECTURE.md
- Continue iterating until user approves
- When user types 'continue to next phase', say: "Architecture phase complete! Use `execute .claude/skills/plan` to create the implementation plan."

## Best Practices
- Be specific with technology choices (versions, libraries, etc.)
- Show how components interact (data flow is critical)
- Explain WHY architectural choices were made (reference DESIGN.md)
- Keep it practical and implementation-focused
- Identify potential risks or challenges
- Make sure architecture is consistent with design decisions
- Use diagrams or ASCII art if helpful for clarity
- Maintain the interview pattern (create interview → user answers + asks questions → Claude responds + follow-up questions → repeat)
- When user asks questions, provide concrete examples (directory structures, component diagrams, code patterns)
- Generate follow-up questions that explore component boundaries and interactions
