# Implementation Planning Workflow

## Description
Create a detailed, executable implementation plan using an interview-based approach to explore sequencing, dependencies, and testing strategy.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/plan`) or says "create implementation plan" or "plan the implementation"

## Instructions

You are guiding the user through Phase 4: Implementation Planning of a structured development workflow.

**Follow the Interview Pattern** defined in `PATTERNS.md` (in the same directory as this workflow) for conducting the planning interview.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read Context
- Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` to understand what needs to be built
- Read `claude/${TASK_FOLDER}/DESIGN.md` to understand architectural choices
- Read `claude/${TASK_FOLDER}/ARCHITECTURE.md` to understand the system architecture
- Ensure architecture is complete before proceeding

### Step 2: Conduct Planning Interview
**Follow Interview Pattern** to conduct planning interview:

#### Phase-Specific Focus
- **Focus:** Implementation approach and sequencing
- **Initial questions (up to 15) should explore:**
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

#### Output Documents
- **Interview file:** `claude/${TASK_FOLDER}/PLAN_INTERVIEW.md`
- **Output document:** `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md`

#### Document Structure
When generating IMPLEMENTATION_PLAN.md, follow this structure:
- **Overview**: What we're building (1-2 paragraphs)
- **Prerequisites**: Dependencies, setup, environment requirements
- **Implementation Steps**: Numbered, sequential steps based on interview answers
  - For each step:
    - Clear description of what needs to be done
    - Files that will be created or modified
    - Dependencies on other steps
    - Expected outcome or deliverable
    - Testing/verification approach
- **Status Tracking**: Table showing progress (see Status Tracking Convention in PATTERNS.md)
  ```
  | Step | Status | Notes |
  |------|--------|-------|
  | 1. [Task name] | Not Started | [Details] |
  ```
- **Testing Approach**: How to verify each step (from interview)
- **Rollout/Deployment**: How to deploy or release (from interview)
- **Rollback Plan**: How to undo changes if needed (from interview)

#### Validation
- Validate plan against REQUIREMENTS.md and ARCHITECTURE.md

#### Next Workflow
When user types 'continue to next phase' after finalizing IMPLEMENTATION_PLAN.md, say:
"Implementation plan is finalized! Continue to the implement workflow to begin execution."

## Best Practices
- Break work into small, manageable steps (ideally each step is 1-2 hours)
- Make steps sequential with clear dependencies
- Each step should have a clear definition of "done"
- Include testing/verification for each major step
- Consider what can fail and how to handle it
- Make the plan executable (someone should be able to follow it step-by-step)
- Include time for refactoring and cleanup
- Don't forget documentation and testing steps
- When user asks questions, provide concrete implementation examples or step breakdowns
- Generate follow-up questions that explore dependencies and risk mitigation
