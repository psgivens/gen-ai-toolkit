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
   I've created [FILE] with initial questions about [context].

   Please fill out the interview document:
   1. Answer the questions in the 'Your Answer' sections
   2. Ask any questions you have in the 'Your Questions for Claude' sections
   3. Type 'iterate' when you're ready for me to respond

   What 'iterate' does:
   - I'll read your answers and questions
   - I'll research and answer your questions (may include code examples, codebase exploration)
   - I'll ask 5 follow-up questions based on your answers
   - We'll repeat this cycle until you have enough clarity

   What would you like to do?
   - Type 'iterate' - Continue the interview (I answer your questions + ask follow-ups)
   - Type 'continue to next phase' - Skip to generating [OUTPUT_DOCUMENT] with answers so far
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
   - My responses to your questions (see "Claude's Responses" section)
   - [N] follow-up questions based on your answers (see "Interview Round [N]" section)

   What would you like to do?
   - Type 'iterate' - Continue the interview (answer the new questions, I'll respond again)
   - Type 'continue to next phase' - Generate [OUTPUT_DOCUMENT] based on our conversation so far
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

   What would you like to do next?
   - Tell me specific changes to make (e.g., "Change section 3 to emphasize X", "Add details about Y")
   - Type 'execute ~/.workflows/[next-workflow]' to continue to [next workflow name]

   I'll make any edits you request and confirm the changes.
   ```
6. **Wait for user response**
7. **If user requests changes:** Make the edits, confirm what changed, prompt again with same format (repeat as needed)
8. **If user continues to next workflow:** Announce completion and confirm they can proceed

**Note:** Document review is conversational - users tell you what changes they want, you make them. No special commands needed.

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

**During Interview Phase** (gathering information):

```
What would you like to do?
- Type 'iterate' - [Explain what iterate does: answer questions + ask follow-ups]
- Type 'continue to next phase' - [Explain what continues: generate output document]
```

**During Document Review Phase** (refining generated output):

```
What would you like to do next?
- Tell me specific changes to make (e.g., "Change X to Y", "Add details about Z")
- Type 'execute ~/.workflows/[next]' to continue to [next workflow name]
```

Keep language consistent and explicit to reduce cognitive load. Always explain what actions will happen, don't assume users know what commands mean.

## Research Spike Pattern

A research spike is a pause in the interview where Claude identifies information gaps and provides instructions for gathering missing data before continuing with more questions.

### When to Use

Use research spikes when:
- User answers reveal gaps in Claude's understanding (missing codebase knowledge, unclear existing patterns)
- Questions depend on information Claude doesn't have access to
- User explicitly requests research before answering more questions
- Design/architecture questions require understanding existing code patterns

### Process

1. **Identify Research Needs** (during interview iteration)

   While processing user answers, determine if additional information would significantly improve follow-up questions.

   Examples of research needs:
   - Existing architecture patterns (how is X currently implemented?)
   - API contracts or interfaces (what does the external API look like?)
   - Performance benchmarks (what are current response times?)
   - User data formats (what does the actual input look like?)
   - Technology stack details (what version of Y are we using?)

2. **Create Research Section in Interview**

   Instead of generating follow-up questions, add research spike section:

   ```markdown
   ## Research Spike (Round N)

   Before continuing with more questions, I need to gather information to make better recommendations.

   ### Research Item 1: [Name]
   **What I need:** [Specific information needed]
   **Why:** [How this will improve the interview]
   **How to provide it:**
   - Option A: [e.g., "Run `find . -name 'api*.ts'` and share the file list"]
   - Option B: [e.g., "Share the file path to your API documentation"]
   - Option C: [e.g., "Describe how user authentication currently works"]

   ### Research Item 2: [Name]
   **What I need:** [Specific information]
   **Why:** [Benefit]
   **How to provide it:**
   - [Concrete instructions]

   ---

   **When you've provided the research items above, type 'iterate' to continue the interview.**

   **Pending Research:** 2 items (see above)
   ```

3. **Wait for Research**

   User provides requested information in conversation or by pointing to files/data.
   User types 'iterate' when ready to continue.

4. **Process Research and Continue**

   - Read and analyze provided information
   - Use research to inform follow-up questions
   - Continue normal interview cycle with improved context
   - Resume standard "Interview Round N+1" format

### Integration with Interview Pattern

In **Interview Pattern → Step 2: Interview Iteration Cycle**, add after step 3:

**3a. Evaluate Research Needs:**
   - Based on user's answers, determine if additional information would significantly improve next questions
   - If research needed: Create Research Spike section (see Research Spike Pattern)
   - If no research needed: Proceed to generate follow-up questions (step 4)

### Example Research Spike

```markdown
## Research Spike (Round 2)

Before continuing with architecture questions, I need to understand your current codebase better.

### Research Item 1: Existing UI Component Patterns
**What I need:** Examples of how you currently build UI components
**Why:** So I can recommend patterns consistent with your existing code
**How to provide it:**
- Share path to 2-3 existing component files, OR
- Describe your component structure (class-based? functional? hooks?)

### Research Item 2: Current Database Schema
**What I need:** Your user and authentication table structures
**Why:** To recommend auth approach that fits your existing schema
**How to provide it:**
- Share the schema file path, OR
- Run `psql -d mydb -c '\d users'` and paste output

---

**When you've provided these items, type 'iterate' to continue.**

**Pending Research:** 2 items
```

### Tracking Research Spikes

At the top of each interview round that includes a research spike, add status indicator:

```markdown
## Interview Round 3
**Pending Research:** 2 items - see Research Spike section below
```

This makes it immediately visible that the interview is blocked on research.

### Best Practices

- Request only essential research (2-4 items max)
- Provide multiple options for providing data (file path, command output, description)
- Explain the "why" so users understand the value
- Group related research items together
- Resume quickly after research is provided

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

1. **Requirements** → Design → Architecture → Plan → Implement → Documentation
2. **Design** → Architecture → Plan → Implement → Documentation
3. **Architecture** → Plan → Implement → Documentation
4. **Plan** → Implement → Documentation
5. **Implement** → Documentation
6. **Documentation** → (completion)
7. **Refinement** → Can be invoked at any time independently

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
- "Implementation complete! Continue to the documentation workflow to create user-facing documentation."

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

## Documentation Standards

Based on principles from `claude/CLAUDE_PREP.md`, workflows create focused, high-value documentation that makes codebases easy to navigate without over-documenting.

### Documentation Philosophy

**Goal:** Create just enough documentation to make navigation efficient, without creating maintenance burden through over-documentation.

**Key Principle:** Focus on "why" not "what" - code shows what, documentation explains why.

### Documentation Types

#### Navigation Documentation (Makes codebase easy to navigate)

**ARCHITECTURE.md** (Project root)
- **Purpose:** Single source of truth for system design
- **Created by:** Architecture workflow (can be created/updated by documentation workflow)
- **Key sections:** Directory structure, entry points, architectural patterns, common operations, technology stack
- **Audience:** All developers (human and AI)
- **Most valuable document per CLAUDE_PREP.md**

**docs/CLAUDE.md** (Project-specific guidelines)
- **Purpose:** Development guidelines, patterns, gotchas specific to this codebase
- **Created by:** Documentation workflow
- **Key sections:** Build/test commands, key patterns, common gotchas, integration points
- **Audience:** Developers working on this project
- **Complements global ~/.claude/CLAUDE.md**

**docs/code/** (Component guides)
- **Purpose:** Deep dives on complex subsystems
- **Created by:** Documentation workflow
- **Examples:** Plugin system guide, state management guide, API layer guide
- **Audience:** Developers working on or integrating with these subsystems
- **Only for complex areas - not every directory**

**Directory READMEs**
- **Purpose:** Quick orientation to directory contents
- **Created by:** Documentation workflow
- **Format:** Brief (1-2 paragraphs + file list)
- **Location:** In each major directory
- **Keep minimal - just enough for quick understanding**

#### Decision Documentation (Explains "why")

**docs/adrs/** (Architecture Decision Records)
- **Purpose:** Record significant architectural decisions with context and rationale
- **Created by:** Design workflow for significant decisions
- **Format:** Use ADR_TEMPLATE.md
- **Audience:** Future developers understanding why choices were made
- **Examples:** Database selection, framework choice, architectural pattern

#### User Documentation (Explains how to use)

**README.md** (Project root)
- **Purpose:** Project overview and quick start
- **Created by:** Documentation workflow
- **Audience:** First-time users, potential adopters
- **Standard location**

**docs/** (User guides, API docs)
- **Purpose:** Detailed usage instructions
- **Created by:** Documentation workflow
- **Examples:** USER_GUIDE.md, API.md, DEPLOYMENT.md
- **Audience:** End users, API consumers, administrators

### Documentation Quality Standards

#### ✅ Good Documentation

- **Explains "why" not just "what"**
  - Good: "Use transactions here to prevent race conditions in concurrent updates"
  - Bad: "This function updates the database"

- **Focuses on high-value information**
  - Document: Entry points, complex patterns, integration points, gotchas
  - Don't document: Obvious code, every function, generated code

- **Provides concrete examples**
  - Include actual code from the codebase
  - Show complete, runnable examples
  - Include expected output

- **Identifies entry points and common operations**
  - Where does execution start?
  - How do I add a new [feature]?
  - Where do components wire together?

- **Stays up-to-date with code changes**
  - Update ARCHITECTURE.md when patterns change
  - Add to CLAUDE.md when gotchas discovered
  - Remove outdated information immediately

#### ❌ Avoid

- **Auto-generated function docs** - Creates noise, low signal-to-noise ratio
- **File/class indices** - Claude can search efficiently with Glob/Grep
- **Documenting obvious code** - If code is clear, don't duplicate in docs
- **Over-verbose API documentation** - Focus on concepts and examples, not every parameter
- **Documentation that duplicates code comments** - Comments explain inline "why", docs explain architecture

### When to Create Documentation

| Phase | Documentation | Location | Trigger |
|-------|--------------|----------|---------|
| **Architecture** | ARCHITECTURE.md | Root | Always create during architecture phase |
| **Design** | ADR | docs/adrs/ | Only for significant decisions (prompted) |
| **Implementation** | Code comments | Inline | For non-obvious logic only |
| **Documentation** | All docs | docs/, docs/code/ | After implementation complete |

### Document Locations

Standard locations per `claude/CLAUDE_PREP.md`:

```
project-root/
├── ARCHITECTURE.md          # System architecture (root for visibility)
├── README.md               # Project overview (standard location)
├── docs/
│   ├── CLAUDE.md          # Project development guidelines
│   ├── [user docs]        # USER_GUIDE.md, API.md, etc.
│   ├── code/              # Developer navigation docs
│   │   ├── [SUBSYSTEM]_GUIDE.md
│   │   └── ...
│   └── adrs/              # Architecture Decision Records
│       ├── ADR-001-[title].md
│       └── ...
├── [major-dir]/
│   └── README.md          # Directory orientation
└── ...
```

### Maintaining Documentation

#### Update Documentation When:

- ✅ **Architectural patterns change** → Update ARCHITECTURE.md
  - Example: Switch from REST to GraphQL, change state management approach
  - Who: Developer making the change
  - How: Update relevant sections, commit with "docs: update architecture"

- ✅ **Significant decisions are made** → Create ADR via design workflow
  - Example: Choose database, select framework, pick architectural pattern
  - Who: Design workflow (automated prompt)
  - How: Use ADR_TEMPLATE.md

- ✅ **New patterns emerge** → Add to docs/CLAUDE.md
  - Example: New error handling pattern, new testing approach
  - Who: Developer establishing the pattern (after using it 2+ times)
  - How: Add to Key Patterns section with example

- ✅ **Documentation becomes outdated** → Fix immediately
  - **Outdated docs are worse than no docs** - they mislead
  - Who: Anyone who notices
  - How: Update immediately, don't defer

- ✅ **Common gotchas discovered** → Add to docs/CLAUDE.md
  - Example: Database connection leak, race condition, configuration issue
  - Who: Developer who discovered and fixed it
  - How: Add to Common Gotchas section with problem/solution

#### Don't Over-Maintain:

- ❌ Don't document every code change
- ❌ Don't create changelogs in architecture docs (use git)
- ❌ Don't duplicate what's in code comments
- ❌ Don't maintain indices that get stale

### Documentation Quality Checklist

When creating or updating documentation, verify:

**ARCHITECTURE.md:**
- [ ] Directory structure is complete with purposes
- [ ] Entry points are identified with file paths
- [ ] Architectural patterns are explained with examples
- [ ] Common operations are documented (how to add X)
- [ ] Technology stack lists specific versions
- [ ] Design principles are concrete with examples

**docs/CLAUDE.md:**
- [ ] Build/test commands work (tested them)
- [ ] Key patterns have code examples from actual codebase
- [ ] Common gotchas have solutions
- [ ] Integration points list actual external systems
- [ ] File locations are specific paths

**Component Guides (docs/code/):**
- [ ] Only created for genuinely complex subsystems
- [ ] Explains "how it works" not just "what files exist"
- [ ] Includes concrete examples from codebase
- [ ] Documents common operations (how to add/modify)
- [ ] Lists common issues with solutions

**ADRs (docs/adrs/):**
- [ ] Context explains why decision was needed
- [ ] Decision is specific and concrete
- [ ] Rationale explains why this option chosen
- [ ] Alternatives are listed with pros/cons and why rejected
- [ ] Consequences (positive/negative) are documented

**Directory READMEs:**
- [ ] Brief (1-2 paragraphs max)
- [ ] Lists key files with purposes
- [ ] Links to detailed guides if they exist
- [ ] Doesn't duplicate what's obvious from filenames

### Examples

#### Good Documentation Example

**ARCHITECTURE.md Entry Points section:**
```markdown
## Entry Points

- **Main entry point:** `src/main.ts` - Application starts here, initializes all services
- **API server:** `src/api/server.ts` - Express server setup, middleware registration
- **Plugin orchestration:** `src/plugins/index.ts` - Where all plugins are registered and initialized
- **Database connection:** `src/db/connection.ts` - Database pool setup, migration runner
```

**Why good:** Specific file paths, explains what happens there, immediately actionable.

#### Bad Documentation Example

**Directory README that's too verbose:**
```markdown
# src/utils Directory

This directory contains utility functions that are used throughout the application.

## Files

### arrayUtils.ts
Contains utility functions for array manipulation including:
- map() - Maps over an array
- filter() - Filters array elements
- reduce() - Reduces array to single value
[... continues for 20 more functions]

### stringUtils.ts
[... equally verbose]
```

**Why bad:** Too much detail on obvious functionality, creates maintenance burden, low value.

**Better version:**
```markdown
# src/utils

Shared utility functions used across the application.

## Key Files
- `arrayUtils.ts` - Array manipulation helpers
- `stringUtils.ts` - String formatting and validation
- `dateUtils.ts` - Date parsing and formatting

See individual files for function-level documentation.
```

### Measuring Documentation Effectiveness

You'll know documentation is working when:

✅ **Claude can start work without extensive exploration** - ARCHITECTURE.md provides quick orientation

✅ **Claude references docs when implementing** - "Following the pattern in docs/CLAUDE.md..."

✅ **You don't explain same patterns repeatedly** - Patterns are documented once, referenced many times

✅ **New contributors onboard faster** - Clear entry points and common operations

✅ **Architectural decisions are clear** - ADRs explain the "why" behind choices

✅ **Documentation stays current** - Team updates docs as code changes

❌ **Documentation is failing if:**
- Claude still needs extensive exploration after reading docs
- You're constantly explaining things that should be documented
- Documentation is out of sync with code
- Documentation is so verbose no one reads it
