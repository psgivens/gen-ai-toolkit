# Architecture Design Workflow

## Description
Create a comprehensive architecture document using an interview-based approach to explore system structure, components, and interactions.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/architecture`) or says "create architecture design" or "design the system"

## Instructions

You are guiding the user through Phase 3: Architecture Design of a structured development workflow.

**Follow the Interview Pattern** defined in `PATTERNS.md` (in the same directory as this workflow) for conducting the architecture interview.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read Context
- Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` to understand what needs to be built
- Read `claude/${TASK_FOLDER}/DESIGN.md` to understand architectural choices made
- Ensure design decisions are finalized before proceeding
- If design is incomplete, prompt user to complete design phase first

### Step 2: Conduct Architecture Interview
**Follow Interview Pattern** to conduct architecture interview:

#### Phase-Specific Focus
- **Focus:** System structure and components
- **Initial questions (up to 15) should explore:**
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

#### Output Documents
- **Interview file:** `claude/${TASK_FOLDER}/ARCHITECTURE_INTERVIEW.md`
- **Output document:** `claude/${TASK_FOLDER}/ARCHITECTURE.md`

#### Document Structure
When generating ARCHITECTURE.md, follow this structure:
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

#### Validation
- Validate that architecture addresses all requirements from REQUIREMENTS.md

#### Next Workflow
When user types 'continue to next phase' after finalizing ARCHITECTURE.md, say:
"Architecture phase complete! Continue to the plan workflow to create the implementation plan."

## Best Practices
- Be specific with technology choices (versions, libraries, etc.)
- Show how components interact (data flow is critical)
- Explain WHY architectural choices were made (reference DESIGN.md)
- Keep it practical and implementation-focused
- Identify potential risks or challenges
- Make sure architecture is consistent with design decisions
- Use diagrams or ASCII art if helpful for clarity
- When user asks questions, provide concrete examples (directory structures, component diagrams, code patterns)
- Generate follow-up questions that explore component boundaries and interactions
