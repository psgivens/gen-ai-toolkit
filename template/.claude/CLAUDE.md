# Project Instructions

## Project Context

This is a new project being built using a structured planning workflow.

## Skills Available

This project includes five workflow skills for phased development:

- `execute .claude/skills/requirements` - Requirements discovery (Phase 1)
- `execute .claude/skills/design` - Design decisions (Phase 2)
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
2. **Requirements Phase**: Always start by reading `claude/${TASK_FOLDER}/MISSION.md`, then conduct interview in `claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md`
3. **Design Phase**: Capture architectural decisions through `claude/${TASK_FOLDER}/DESIGN_INTERVIEW.md` before implementation
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
"I've created claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md with initial questions about your mission.

What would you like to do?
- Type "iterate" to answer questions and continue the interview
- Type "continue to next phase" to proceed with the workflow"
```

### Example After User Provides Feedback

```
"I've updated claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md with responses to your questions and 5 new follow-up questions.

What would you like to do?
- Type "iterate" to continue the interview
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
2. If at end of a phase, move to the next skill (requirements → design → architecture → plan → implement)
3. Do not make further changes to the current document unless explicitly asked

**Note:** During interviews, "iterate" has special behavior defined in the **Interview Pattern** section (answer user questions + generate 5 new questions).

### Standard Prompt Format

Always use this format at review gates:

```
What would you like to do?
- Type "iterate" to review and refine further
- Type "continue to next phase" to move forward
```

Keep the language consistent and concise to reduce cognitive load.

## Interview Pattern

The Interview Pattern is a structured conversation methodology used across all workflow phases to gather context, requirements, and decisions through bidirectional Q&A between Claude and the user.

### Core Concept

An interview is a structured conversation where:
1. Claude asks questions to understand context, requirements, or decisions
2. User provides answers and can ask their own questions
3. Claude responds to user questions (researching if needed)
4. Claude asks follow-up questions based on the conversation
5. Repeat until sufficient clarity is achieved

### Interview Document Structure

Each interview phase creates a `*_INTERVIEW.md` file with this structure:

```markdown
# [Phase Name] Interview

## Interview Round 1

### Question 1: [Question text]

**Your Answer:**
[Space for user to answer]

**Your Questions for Claude:**
[Space for user to ask questions back]

---

### Question 2: [Question text]

**Your Answer:**
[Space for user to answer]

**Your Questions for Claude:**
[Space for user to ask questions back]

---

[... continues for all questions in this round]

---

## Claude's Responses (Round 1)

> This section appears after you type "iterate"

### Response to Your Question from Q1:
[Claude's answer, may include code examples, research, references]

### Response to Your Question from Q3:
[Claude's answer]

---

## Interview Round 2

### Question 1: [Follow-up question based on previous answers]

**Your Answer:**
[Space for user to answer]

**Your Questions for Claude:**
[Space for user to ask questions back]

---

[... continues for all follow-up questions]
```

### Initial Interview Round

When creating an interview document:
1. Claude provides **up to 15 questions** in Round 1
2. Questions are numbered and separated by `---`
3. Each question has space for:
   - User's answer
   - User's questions for Claude
4. Claude prompts user to fill out the interview and type "iterate" when ready

### Interview Iteration Cycle

When user types "iterate" during an interview:

1. **Read the interview** - Claude reads the entire `*_INTERVIEW.md` file
2. **Extract answers and questions** - Parse what the user provided
3. **Research if needed** - If user asked questions requiring codebase exploration, API docs, or other research, Claude investigates using appropriate tools
4. **Write responses** - Add a new "Claude's Responses (Round N)" section with answers to all user questions
5. **Generate follow-up questions** - Add a new "Interview Round N+1" section with **up to 5 new questions** based on the conversation so far
6. **Prompt for next iteration** - Ask if user wants to iterate again or continue to next phase

### Interview Continuation

When user types "continue to next phase" during an interview:
1. Claude creates the output artifact for that phase (e.g., REQUIREMENTS.md, DESIGN.md)
2. Follows the review gate pattern for that artifact
3. Proceeds to next workflow step

### How Skills Use the Interview Pattern

Each skill references the interview pattern and adds phase-specific guidance:

```markdown
## Instructions

Follow the **Interview Pattern** defined in `.claude/CLAUDE.md`.

### Phase-Specific Interview Guidance

**Artifact Name:** `claude/${TASK_FOLDER}/[PHASE]_INTERVIEW.md`

**Initial Questions (up to 15):**
- [Phase-specific guidance on what to ask]

**Follow-Up Questions (up to 5 per iteration):**
- [Phase-specific guidance on follow-up areas]

**Output Artifact:** After interview concludes, create `claude/${TASK_FOLDER}/[OUTPUT].md`
```

### Phase-Specific Interview Behaviors

Each phase customizes the interview pattern:

#### Requirements Interview
- **File:** `REQUIREMENTS_INTERVIEW.md`
- **Focus:** WHAT not HOW
- **Questions about:** Inputs, outputs, edge cases, user scenarios, constraints
- **Output:** REQUIREMENTS.md

#### Design Interview
- **File:** `DESIGN_INTERVIEW.md`
- **Focus:** Architectural decisions and trade-offs
- **Questions include:** Recommendations with brief justification (2-3 sentences)
- **Format:** "What X should we use? I recommend Y because [reason]. Alternatives: A (pros/cons), B (pros/cons)"
- **Output:** DESIGN.md with decided options

#### Architecture Interview
- **File:** `ARCHITECTURE_INTERVIEW.md`
- **Focus:** System structure and components
- **Questions about:** Components, data flows, technology choices, integration points
- **May include:** Architecture options with trade-offs
- **Output:** ARCHITECTURE.md

#### Planning Interview
- **File:** `PLAN_INTERVIEW.md`
- **Focus:** Implementation approach and sequencing
- **Questions about:** Implementation order, dependencies, testing strategy, rollout approach
- **Output:** IMPLEMENTATION_PLAN.md

#### Implementation Interview
- **File:** `IMPLEMENTATION_INTERVIEW.md`
- **Focus:** Execution details and blockers
- **Questions about:** Current step status, blockers, test results, next steps
- **Used for:** Continuous communication during implementation

#### Refinement Interview
- **File:** `REFINEMENT_INTERVIEW.md`
- **Focus:** Understanding refactoring goals and risks
- **Questions about:** Scope, constraints, testing strategy, rollback plan
- **Output:** REFINEMENT_PLAN.md

### Integration with Other Patterns

The Interview Pattern enhances the existing workflow patterns:

- **Review Gate Pattern:** Applies at interview completion - announce the interview is ready, provide iterate/continue options, wait for response
- **Iteration Pattern:** "iterate" during an interview means: answer user questions + generate 5 new questions (interview-specific iteration)
- **Document Templates:** Interview files are conversation artifacts that lead to the structured output documents

## Document Templates

### Interview Documents

Interview documents (`*_INTERVIEW.md`) are conversation artifacts created during each phase. See the **Interview Pattern** section for complete structure and behavior.

- `REQUIREMENTS_INTERVIEW.md` - Questions and answers about requirements
- `DESIGN_INTERVIEW.md` - Questions and decisions about architecture and design
- `ARCHITECTURE_INTERVIEW.md` - Questions about system structure
- `PLAN_INTERVIEW.md` - Questions about implementation approach
- `IMPLEMENTATION_INTERVIEW.md` - Ongoing communication during implementation
- `REFINEMENT_INTERVIEW.md` - Questions about refactoring goals

### Output Documents

Output documents are created after interviews conclude and contain structured artifacts:

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
