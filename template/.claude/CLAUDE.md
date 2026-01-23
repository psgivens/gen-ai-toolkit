# Project Instructions

## Project Context

This is a new project being built using a structured planning workflow.

## Skills Available

This project includes five workflow skills for phased development:

- `execute .claude/skills/requirements` - Requirements discovery (Phase 1)
- `execute .claude/skills/decisions` - Design decisions (Phase 2)
- `execute .claude/skills/architecture` - Architecture design (Phase 3)
- `execute .claude/skills/plan` - Implementation planning (Phase 4)
- `execute .claude/skills/implement` - Execute implementation (Phase 5)

When the user invokes one of these skills with the `execute` command, follow the instructions in the corresponding `.claude/skills/[name]/skill.md` file.

All workflow artifacts are organized in task-specific folders under `claude/[task-name]/`.

## Task Folder Management

All workflow artifacts are organized in task-specific folders under `claude/[task-name]/`.

### Naming Convention
Task folders use date-prefixed naming: `YYYY-MM-DD-description`
- Example: `claude/2026-01-22-add-authentication/`
- Example: `claude/2026-01-23-refactor-api/`

### Current Task Tracking
- At the start of any skill, determine the current task folder (Step 0)
- Remember the task folder for the entire session
- If unknown, prompt the user to select or create a task folder
- When working, echo the current task: "Working on task: 2026-01-22-add-authentication"

### Task Folder Discovery
When user invokes a skill and no task folder is known:
1. List existing task folders under `claude/`
2. If one folder exists, suggest using it
3. If multiple exist, ask which one to use
4. If none exist, prompt for a new task name

### Path References
All skill instructions use `${TASK_FOLDER}` placeholder:
- `claude/${TASK_FOLDER}/MISSION.md`
- `claude/${TASK_FOLDER}/REQUIREMENTS.md`
- etc.

When executing skills, replace `${TASK_FOLDER}` with the actual task folder name.

## Workflow Patterns

When building features for this project:

1. **Task Folder**: Always determine the current task folder at the start of any skill (Step 0)
2. **Requirements Phase**: Always start by reading `claude/${TASK_FOLDER}/MISSION.md`, then ask clarifying questions in `claude/${TASK_FOLDER}/GATHER_REQUIREMENTS.md`
3. **Design Phase**: Capture architectural decisions in `claude/${TASK_FOLDER}/DECISIONS.md` before implementation
4. **Implementation Phase**: Create detailed plans in `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md` with status tracking
5. **All phases**: Use descriptive section headers and maintain existing document structure

## Review Gate Pattern

After creating or updating any artifact, ALWAYS:

1. **Explicitly announce** the artifact is ready for review
2. **Prompt the user** with clear next-step options
3. **Wait** for their response before proceeding
4. **If they provide changes**, make the updates and prompt for review again
5. **Acknowledge their edits** when they modify files directly

### Example Review Gate with Options

```
"I've created claude/${TASK_FOLDER}/GATHER_REQUIREMENTS.md with initial clarifying questions about your mission.

What would you like to do?
- Type "iterate" to review and refine further
- Type "continue to next phase" to proceed with the workflow"
```

### Example After User Provides Feedback

```
"I've updated claude/${TASK_FOLDER}/GATHER_REQUIREMENTS.md based on your feedback.

What would you like to do?
- Type "iterate" to review and refine further
- Type "continue to next phase" to move forward"
```

### Example Acknowledging User Edits

```
"Thanks! I see you've answered:
- Input source: GitLab API
- Output format: Local git repositories
- Error handling: Log and continue

What would you like to do?
- Type "iterate" for follow-up questions
- Type "continue to next phase" to proceed with design decisions"
```

## Iteration Pattern

When prompting the user for next steps, ALWAYS provide these two options:

### "iterate"
When the user chooses to iterate:
1. Read the document they were asked to review or edit
2. Identify changes, additions, or answers they've provided
3. Update the document based on their input
4. Ask clarifying or follow-up questions if needed
5. Prompt again with iterate/continue options

### "continue to next phase"
When the user chooses to continue:
1. Proceed to the next workflow phase
2. If at end of a phase, move to the next skill (requirements → decisions → architecture → plan → implement)
3. Do not make further changes to the current document unless explicitly asked

### Standard Prompt Format

Always use this format at review gates:

```
What would you like to do?
- Type "iterate" to review and refine further
- Type "continue to next phase" to move forward
```

Keep the language consistent and concise to reduce cognitive load.

## Document Templates

### GATHER_REQUIREMENTS.md Structure
- What (requirements, not implementation)
- Inputs and outputs
- Edge cases and error handling
- User scenarios and workflows
- Constraints and limitations
- Leave space for user answers after each question

### DECISIONS.md Structure
- Lead with recommended option
- Brief trade-off analysis (2-3 sentences max)
- List 2-4 alternatives with pros/cons
- Space for user decision and follow-up questions
- Mark decisions as DECIDED, PENDING, or INVALIDATED

### REQUIREMENTS.md Structure
- Overview
- Functional requirements (numbered)
- Non-functional requirements (performance, security, etc.)
- Constraints
- Out of scope (explicitly state what we're NOT doing)

### DESIGN.md Structure
- Architecture overview
- Key components and their responsibilities
- Data flows
- Error handling strategy
- Technology choices
- Trade-offs made

### IMPLEMENTATION_PLAN.md Structure
- Overview (what we're building)
- Prerequisites (dependencies, setup)
- Numbered implementation steps
- Each step includes:
  - What needs to be done
  - Files involved
  - Prompt to execute the step
- Status tracking table
- Testing approach
- Rollout/deployment plan

## Status Tracking Convention

Use this format in all implementation plans:

| Step | Status | Notes |
|------|--------|-------|
| 1. [Task name] | Not Started / In Progress / Complete | [Details] |

## Communication Style

- Be explicit about what you're doing and why
- Ask for clarification when requirements are ambiguous
- Suggest best practices but defer to user preferences
- Keep trade-off analysis brief but meaningful
- Focus questions on WHAT, not HOW (during requirements phase)

## Code Standards

When implementation begins:

- Use type hints for all functions (Python)
- Include docstrings for public functions
- Explicit error handling, no silent failures
- Follow patterns from similar code in the project
- Write testable code
- Consider security implications (input validation, no hardcoded secrets)
