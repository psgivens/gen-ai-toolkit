# Requirements Discovery Workflow

## Description
Guide the user through requirements discovery using an interview-based approach with bidirectional Q&A to understand what they want to build.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/requirements`) or says "start requirements discovery"

## Instructions

You are guiding the user through Phase 1: Requirements Discovery of a structured development workflow.

**Follow the Interview Pattern** defined in `PATTERNS.md` (in the same directory as this workflow) for conducting the requirements interview.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Create MISSION.md Document
- Create `claude/${TASK_FOLDER}/MISSION.md` with the following template
- Prompt the user to fill out the template describing what they want to build
- Wait for user response before proceeding

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

    ## Design Tenets

    <!--
    Tenets guide design decisions and trade-offs. When multiple options are viable,
    tenets help choose the right one. List your priorities in order of importance.

    Examples:
    - "Robustness over performance" (correctness more important than speed)
    - "Simplicity over features" (prefer simple solutions, avoid complexity)
    - "User experience over developer convenience" (prioritize end-user needs)
    - "Security over convenience" (prefer secure-by-default even if harder to use)
    - "Explicit over implicit" (prefer clear, obvious code over clever abstractions)
    - "Consistency over novelty" (follow existing patterns rather than new approaches)
    - "Maintainability over cleverness" (code should be easy to understand and modify)
    -->

    **Tenet 1:** [Your most important design principle]

    **Tenet 2:** [Your second priority]

    **Tenet 3:** [Additional principles as needed]

    ## Context

    [Any additional context: existing systems, constraints, preferences]

    ---

    **Next Step**: Execute the requirements workflow to begin the requirements discovery phase.

### Step 2: Read Mission
- Read `claude/${TASK_FOLDER}/MISSION.md` to understand the project goal
- If MISSION.md doesn't exist or is empty, ask the user to describe their goal and offer to create it for them

### Step 3: Conduct Requirements Interview
**Follow Interview Pattern** to conduct requirements interview:

#### Phase-Specific Focus
- **Focus:** WHAT not HOW (requirements and outcomes, not implementation)
- **Initial questions (up to 15) should explore:**
  - Desired outcomes and success criteria
  - Inputs and outputs
  - Edge cases and error handling
  - User scenarios and workflows
  - Constraints and limitations
  - Data formats and structure
  - Integration points and dependencies
  - Non-functional requirements (performance, security)

#### Output Documents
- **Interview file:** `claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md`
- **Output document:** `claude/${TASK_FOLDER}/REQUIREMENTS.md`

#### Document Structure
When generating REQUIREMENTS.md, follow this structure:
- Overview (summarize what we're building)
- Functional requirements (numbered list)
- Non-functional requirements (performance, security, scalability)
- Constraints (technical, business, or resource limitations)
- Out of scope (explicitly state what we're NOT doing)

#### Next Workflow
When user types 'continue to next phase' after finalizing REQUIREMENTS.md, say:
"Requirements phase complete! Continue to the design workflow to begin design decisions."

## Best Practices
- Keep questions focused on requirements (WHAT), not implementation (HOW)
- Use clear, concise language
- Acknowledge user answers and questions explicitly
- Generate follow-up questions that build on previous answers
- When user asks questions, research thoroughly before responding
- Stay in a continuous conversation throughout this phase
