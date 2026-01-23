# Architecture Design

## Description
Create a comprehensive architecture and design document based on requirements and decisions.

## Trigger
When user invokes `execute .claude/skills/architecture` or says "create architecture design" or "design the system"

## Instructions

You are guiding the user through Phase 3: Architecture Design of a structured development workflow.

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
- Read `claude/${TASK_FOLDER}/DECISIONS.md` to understand architectural choices made
- Ensure all decisions are marked as DECIDED before proceeding
- If any decisions are still PENDING, prompt user to finalize them first

### Step 2: Create Design Document
- Create `claude/${TASK_FOLDER}/DESIGN.md` with the following sections:
  - **Overview**: High-level description of the system architecture
  - **Key Components**: List major components and their responsibilities
  - **Data Flow**: How data moves through the system
  - **Technology Stack**: Specific technologies chosen (from DECISIONS.md)
  - **Directory Structure**: Proposed file/folder organization
  - **Error Handling Strategy**: How errors will be handled throughout
  - **Security Considerations**: Authentication, authorization, data protection
  - **Testing Strategy**: Unit tests, integration tests, etc.
  - **Trade-offs**: Key architectural trade-offs made and why

### Step 3: Review Gate
- Explicitly prompt: "I've created claude/${TASK_FOLDER}/DESIGN.md with the architecture design.

What would you like to do?
- Type 'iterate' to review and refine further
- Type 'continue to next phase' to validate against requirements"
- Wait for user response

### Step 4: Iterate on Feedback
- If user provides feedback, update DESIGN.md
- If feedback reveals gaps in REQUIREMENTS or DECISIONS, note them
- Continue iterating until user is satisfied
- Address any architectural concerns or questions

### Step 5: Validate Against Requirements
- Explicitly check that the design satisfies all requirements from REQUIREMENTS.md
- If any requirements are not addressed, add them to the design
- Prompt: "I've verified the design addresses all requirements.

What would you like to do?
- Type 'iterate' to add or refine anything
- Type 'continue to next phase' to finalize the design"

### Step 6: Finalize Design
- When approved, prompt: "Architecture design complete! Use `execute .claude/skills/plan` to create the implementation plan."

## Best Practices
- Be specific with technology choices (versions, libraries, etc.)
- Show how components interact (data flow is critical)
- Explain WHY architectural choices were made (reference DECISIONS.md)
- Keep it practical and implementation-focused
- Identify potential risks or challenges
- Make sure design is consistent with all decisions made
- Use diagrams or ASCII art if helpful for clarity
