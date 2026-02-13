# Design Decisions Workflow

## Description
Guide the user through making architectural and design decisions using an interview-based approach with recommendations and trade-offs.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/design`) or says "start design decisions" or "make architectural decisions"

## Instructions

You are guiding the user through Phase 2: Design Decisions of a structured development workflow.

**Follow the Interview Pattern** defined in `PATTERNS.md` (in the same directory as this workflow) for conducting the design interview.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read Context
- Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` to understand what needs to be built
- Identify key architectural decisions that need to be made

### Step 2: Conduct Design Interview
**Follow Interview Pattern** to conduct design interview:

#### Phase-Specific Focus
- **Focus:** HOW (implementation approach), not WHAT (already decided in requirements)
- **Initial questions (up to 15) should explore:**
  - Technology stack and frameworks
  - Architecture patterns and structure
  - Data storage and management
  - API design and interfaces
  - Error handling strategy
  - Testing approach
  - Deployment and infrastructure
  - Security considerations

#### Question Format
For each question, lead with your recommendation:
- "What X should we use? I recommend Y because [brief reason]. Alternatives: A (pros/cons), B (pros/cons)"
- Provide 2-4 alternatives with brief trade-offs (2-3 sentences total)
- Follow-up questions should also include recommendations + alternatives

#### Output Documents
- **Interview file:** `claude/${TASK_FOLDER}/DESIGN_INTERVIEW.md`
- **Output document:** `claude/${TASK_FOLDER}/DESIGN.md`

#### Document Structure
When generating DESIGN.md, follow this structure:
- Architecture overview (high-level approach)
- Key components and their responsibilities
- Data flows
- Technology choices (based on user's decisions in interview)
- Error handling strategy
- Trade-offs made (briefly explain why certain choices were made)

#### Next Workflow
When user types 'continue to next phase' after finalizing DESIGN.md, say:
"Design phase complete! Continue to the architecture workflow to create the detailed architecture."

## Best Practices
- Always lead with a recommended option in each question (don't just list choices without guidance)
- Keep trade-off analysis brief but meaningful (2-3 sentences)
- Focus on decisions that impact implementation, not trivial choices
- If a decision depends on another, note that dependency in the question
- Highlight decisions that are harder to reverse later
- When user asks questions, research thoroughly before responding
- Provide code examples or architectural diagrams when helpful
- Generate follow-up questions that build on previous design choices
