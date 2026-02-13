# Workflow Patterns

This document defines the core patterns used across all workflows in this repository.

## Interview Pattern

The Interview Pattern is a complete structured conversation cycle used to gather context, requirements, and decisions through bidirectional Q&A between Claude and the user. This pattern encompasses the entire interview flow from initial questions through iteration to final document generation.

### Core Concept

An interview is a complete conversation cycle where:
1. Claude asks questions to understand context, requirements, or decisions
2. User provides answers and can ask their own questions
3. Claude responds to user questions (researching if needed)
4. Claude asks follow-up questions based on the conversation
5. Repeat iteration until sufficient clarity is achieved
6. Generate output document from gathered information
7. Iterate on output document if needed
8. Finalize and proceed to next phase

**Key Principle:** An interview is ONE complete pattern that includes prompting, waiting, iteration, and document generation. It is not multiple separate patterns.

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

### Step 1: Initial Interview Round

When starting an interview:

1. Create interview document (`*_INTERVIEW.md`)
2. Add "## Interview Round 1" section
3. Provide **up to 15 questions** relevant to the phase (see Phase-Specific Behaviors below)
4. Each question includes:
   - **Your Answer:** [Space for user]
   - **Your Questions for Claude:** [Space for user to ask questions back]
   - Separator `---` between questions
5. **Prompt user** with standardized format:
   ```
   I've created [FILE] with initial questions about [context]. Please:
   1. Answer the questions in the 'Your Answer' sections
   2. Ask any questions you have in the 'Your Questions for Claude' sections
   3. Type 'iterate' when ready for me to respond

   What would you like to do?
   - Type 'iterate' to continue the interview (I'll answer your questions and ask follow-ups)
   - Type 'continue to next phase' to [context-specific next step]
   ```
6. **Wait for user response** (do not proceed until user responds)

### Step 2: Interview Iteration Cycle

When user types **'iterate'** during an interview:

1. **Read the interview file** - Read entire `*_INTERVIEW.md` file
2. **Extract information:**
   - User's answers to Claude's questions
   - User's questions for Claude
3. **If user asked questions:**
   - Research as needed using appropriate tools (read codebase, check docs, explore patterns, etc.)
   - Add section "## Claude's Responses (Round N)"
   - Provide detailed answers to each user question
   - Include examples, code snippets, diagrams as helpful
4. **Generate follow-up questions:**
   - Add new section "## Interview Round N+1"
   - Provide **up to 5 new questions** based on user's answers
   - Focus on: clarifying ambiguities, exploring edge cases, digging deeper, covering gaps
   - Each follow-up includes same structure (Your Answer / Your Questions / separator)
5. **Prompt again** with standardized format:
   ```
   I've updated [FILE] with:
   - Responses to your questions
   - [N] follow-up questions based on your answers

   What would you like to do?
   - Type 'iterate' to continue the interview
   - Type 'continue to next phase' to [context-specific next step]
   ```
6. **Wait for user response**
7. **Repeat** if user types 'iterate' again

### Step 3: Document Generation

When user types **'continue to next phase'** during an interview:

1. **Read all answers** from completed `*_INTERVIEW.md`
2. **Read context documents** as needed (REQUIREMENTS.md, DESIGN.md, etc.)
3. **Create output document** following appropriate template (see Document Templates section)
4. **Ensure completeness** - Output addresses all questions asked in interview
5. **Prompt for review:**
   ```
   I've generated [FILE] based on our interview.

   What would you like to do?
   - Type 'iterate' to review and refine the document
   - Type 'continue to next phase' to [move to next workflow]
   ```
6. **Wait for user response**
7. **If 'iterate':** Read feedback, update document, prompt again (repeat as needed)
8. **If 'continue':** Announce completion and suggest next workflow

**Note:** Document iteration is different from interview iteration. During document iteration, you're refining a completed document, not continuing an interview with new questions.

### Phase-Specific Interview Behaviors

Each phase customizes the interview pattern with specific focuses:

#### Requirements Interview
- **File:** `REQUIREMENTS_INTERVIEW.md`
- **Focus:** WHAT not HOW
- **Initial questions (up to 15) about:**
  - Desired outcomes and success criteria
  - Inputs and outputs
  - Edge cases and error handling
  - User scenarios and workflows
  - Constraints and limitations
  - Data formats and structure
  - Integration points and dependencies
  - Non-functional requirements (performance, security)
- **Output Document:** REQUIREMENTS.md

#### Design Interview
- **File:** `DESIGN_INTERVIEW.md`
- **Focus:** Architectural decisions and trade-offs
- **Initial questions (up to 15) about:**
  - Technology stack and frameworks
  - Architecture patterns and structure
  - Data storage and management
  - API design and interfaces
  - Error handling strategy
  - Testing approach
  - Deployment and infrastructure
  - Security considerations
- **Question format:** Lead with recommendation (e.g., "What X should we use? I recommend Y because [reason]. Alternatives: A (pros/cons), B (pros/cons)")
- **Output Document:** DESIGN.md with decided options

#### Architecture Interview
- **File:** `ARCHITECTURE_INTERVIEW.md`
- **Focus:** System structure and components
- **Initial questions (up to 15) about:**
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
- **May include:** Architecture options with trade-offs
- **Output Document:** ARCHITECTURE.md

#### Planning Interview
- **File:** `PLAN_INTERVIEW.md`
- **Focus:** Implementation approach and sequencing
- **Initial questions (up to 15) about:**
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
- **Output Document:** IMPLEMENTATION_PLAN.md

#### Implementation Interview
- **File:** `IMPLEMENTATION_INTERVIEW.md`
- **Focus:** Execution details and blockers
- **Used for:** Continuous communication during implementation when blockers arise
- **Questions about:** Current step status, blockers, test results, proposed solutions
- **Different from other interviews:** Created on-demand when issues arise, not at phase start

#### Refinement Interview
- **File:** `REFINEMENT_INTERVIEW.md`
- **Focus:** Understanding refactoring goals and risks
- **Initial questions (up to 15) about:**
  - Scope and boundaries of the refactoring
  - Current pain points and desired improvements
  - Risks and dependencies
  - Testing strategy (existing tests, new tests needed)
  - Success criteria (what defines "done"?)
  - Breaking changes tolerance
  - Backwards compatibility requirements
  - Migration path if needed
  - Rollback strategy
  - Timeline and urgency
  - Files and modules affected
- **Output Document:** REFINEMENT_PLAN.md

### Standard Prompt Format

**Always use this format when prompting:**

```
What would you like to do?
- Type 'iterate' to [context-specific action]
- Type 'continue to next phase' to [context-specific next step]
```

Keep language consistent and concise to reduce cognitive load.

## Task Folder Management Pattern

Every workflow must establish which task folder to use for storing artifacts. This pattern defines how to determine or create the task folder.

### Process

1. **Check if already known:**
   - If task folder is already known from this session, use it and skip to next step
   - Echo reminder: "Working on task: ${TASK_FOLDER}"

2. **Check for existing folders:**
   - List all task folders under `claude/`
   - **If exactly one exists:** Ask "I found task folder: claude/[folder-name]. Should I use this one?"
   - **If multiple exist:** Ask "Which task should I work on?" and list folders with their names
   - **If none exist:** Prompt "What should I name this task folder? (Suggested format: YYYY-MM-DD-description, e.g., '2026-01-22-add-feature')"

3. **Create folder if needed:**
   - Create `claude/${TASK_FOLDER}/` if it doesn't exist

4. **Remember for session:**
   - Store task folder name in memory for rest of session

5. **Echo to user:**
   - Display: "Working on task: ${TASK_FOLDER}"

6. **Use consistently:**
   - All subsequent paths use `claude/${TASK_FOLDER}/` instead of `claude/`

### Usage in Workflows

Workflows should reference this pattern rather than duplicate the logic:

```markdown
### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder
```

## Document Generation Pattern

After completing an interview, transform the gathered information into a structured output document. This pattern defines the document creation and iteration process.

### Document Creation

1. **Read interview answers:**
   - Read all answers from completed `*_INTERVIEW.md` file
   - Extract key decisions, requirements, and context

2. **Read context documents:**
   - Read relevant prior documents (REQUIREMENTS.md, DESIGN.md, ARCHITECTURE.md as appropriate)
   - Ensure consistency with earlier decisions

3. **Create output document:**
   - Follow appropriate Document Template (see Document Templates section)
   - Ensure all interview questions are addressed
   - Use specific, actionable language

4. **Validate completeness:**
   - Check that document addresses all questions asked in interview
   - Verify no critical gaps or ambiguities

### Document Iteration

1. **Prompt for review:**
   ```
   I've generated [FILE] based on our interview.

   What would you like to do?
   - Type 'iterate' to review and refine the document
   - Type 'continue to next phase' to [move to next workflow]
   ```

2. **Wait for user response**

3. **If user types 'iterate':**
   - Read their feedback or edits
   - Update document accordingly
   - Prompt again with same format
   - Repeat as needed

4. **If user types 'continue to next phase':**
   - Announce completion
   - Suggest next workflow (see Workflow Progression Pattern)

### Key Difference

**Document iteration** is about refining a completed document. It uses the same commands ('iterate', 'continue to next phase') as interview iteration but serves a different purpose:
- **Interview iteration:** Continue conversation, generate follow-up questions
- **Document iteration:** Refine completed artifact based on feedback

## Workflow Progression Pattern

Workflows follow a standard sequence. This pattern defines how to move between workflows and maintain consistent navigation.

### Standard Sequence

1. **Requirements** → Design → Architecture → Plan → Implement
2. **Design** → Architecture → Plan → Implement
3. **Architecture** → Plan → Implement
4. **Plan** → Implement
5. **Implement** → (completion)
6. **Refinement** → Can be invoked at any time independently

### Progression Language

When completing a phase, use this format:

```
[Phase] complete! Continue to the [next workflow] to [next action].
```

**Examples:**
- "Requirements phase complete! Continue to the design workflow to begin design decisions."
- "Design phase complete! Continue to the architecture workflow to create the detailed architecture."
- "Architecture phase complete! Continue to the plan workflow to create the implementation plan."
- "Implementation plan is finalized! Continue to the implement workflow to begin execution."

### Path-Agnostic Guidance

- Use generic language (not hardcoded paths like `execute ~/.workflows/design`)
- Users know how they invoked the current workflow and can adapt for next
- Example invocation shown in trigger: "e.g., `execute ~/.workflows/requirements`"
- User understands this is their installation-specific path

## Status Tracking Convention

Use this format in all implementation and refinement plans to track progress.

### Table Format

```markdown
| Step | Status | Notes |
|------|--------|-------|
| 1. [Task name] | Not Started | [Details] |
| 2. [Task name] | In Progress | [Current work] |
| 3. [Task name] | Complete | [What was done] |
```

### Status Values

- **Not Started** - Step has not been attempted yet
- **In Progress** - Currently working on this step
- **Complete** - Step is finished and verified

### Notes Column

Use notes to capture:
- What was done for completed steps
- Current blockers for in-progress steps
- Deviations from plan
- Test results
- Issues encountered

### Update Timing

- Update status **immediately** after each step
- Don't batch updates
- Keep status table current so user can see progress

## Document Templates

### Interview Documents

Interview documents (`*_INTERVIEW.md`) are conversation artifacts created during each phase. See the **Interview Pattern** section above for complete structure and behavior.

- `REQUIREMENTS_INTERVIEW.md` - Questions and answers about requirements
- `DESIGN_INTERVIEW.md` - Questions and decisions about architecture and design
- `ARCHITECTURE_INTERVIEW.md` - Questions about system structure
- `PLAN_INTERVIEW.md` - Questions about implementation approach
- `IMPLEMENTATION_INTERVIEW.md` - Ongoing communication during implementation
- `REFINEMENT_INTERVIEW.md` - Questions about refactoring goals

### Output Documents

Output documents are created after interviews conclude and contain structured artifacts:

#### REQUIREMENTS.md Structure
- **Overview** - Summarize what we're building based on interview
- **Functional Requirements** - Numbered list of specific features/capabilities
- **Non-functional Requirements** - Performance, security, scalability, etc.
- **Constraints** - Technical, business, or resource limitations
- **Out of Scope** - Explicitly state what we're NOT doing

#### DESIGN.md Structure
- **Architecture Overview** - High-level approach
- **Key Components** - Components and their responsibilities
- **Data Flows** - How data moves through system
- **Technology Choices** - Based on user's decisions in interview
- **Error Handling Strategy** - Approach to handling errors
- **Trade-offs Made** - Briefly explain why certain choices were made

#### ARCHITECTURE.md Structure
- **Overview** - High-level description of system architecture
- **Key Components** - Major components and responsibilities
- **Data Flow** - How data moves through system
- **Technology Stack** - Specific technologies (from DESIGN.md)
- **Directory Structure** - File/folder organization with rationale
- **Module Dependencies** - Component interaction diagram or description
- **Error Handling Strategy** - How errors propagate through system
- **Security Considerations** - Authentication, authorization, data protection boundaries
- **Testing Strategy** - Unit, integration, e2e test approach
- **Trade-offs** - Key architectural trade-offs made and why

#### IMPLEMENTATION_PLAN.md Structure
- **Overview** - What we're building (1-2 paragraphs)
- **Prerequisites** - Dependencies, setup, environment requirements
- **Implementation Steps** - Numbered, sequential steps based on interview answers
  - For each step:
    - Clear description of what needs to be done
    - Files that will be created or modified
    - Dependencies on other steps
    - Expected outcome or deliverable
    - Testing/verification approach
- **Status Tracking** - Table showing progress (see Status Tracking Convention)
- **Testing Approach** - How to verify each step (from interview)
- **Rollout/Deployment** - How to deploy or release (from interview)
- **Rollback Plan** - How to undo changes if needed (from interview)

#### REFINEMENT_PLAN.md Structure
- **Overview** - Summary of the refinement
- **Scope** - What will and won't change
- **Risk Analysis** - What could break, mitigation strategies
- **Prerequisites** - Backups, branch creation, test baseline
- **Refactoring Steps** - Numbered, sequential steps
  - For each step:
    - Clear description of what changes
    - Files that will be modified
    - Expected impact (breaking/non-breaking)
    - Testing approach for that step
- **Status Tracking** - Table showing progress (see Status Tracking Convention)
- **Validation Steps** - How to verify nothing broke
- **Rollback Plan** - How to undo changes if needed

## Pattern Integration

The patterns work together to create a complete workflow system:

1. **Task Folder Management Pattern** establishes where artifacts are stored
2. **Interview Pattern** conducts the bidirectional Q&A conversation (includes prompting, waiting, iteration)
3. **Document Generation Pattern** transforms interview insights into structured artifacts
4. **Workflow Progression Pattern** guides navigation between phases
5. **Status Tracking Convention** provides visibility during execution phases
6. **Document Templates** define the structure of outputs

### Typical Workflow Flow

1. Invoke workflow
2. **Task Folder Management**: Establish task folder
3. Read context documents if applicable
4. **Interview Pattern**: Conduct interview
   - Create interview document with initial questions
   - Prompt and wait for user
   - Iterate (answer questions + generate follow-ups) as needed
   - Generate output document when user says "continue"
5. **Document Generation Pattern**: Create and refine output document
   - Prompt and wait for user
   - Iterate on document if needed
6. **Workflow Progression**: Announce completion and suggest next workflow
7. User invokes next workflow in sequence
