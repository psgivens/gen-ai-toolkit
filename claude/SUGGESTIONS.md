# Workflow Improvement Suggestions

Based on analysis of `vnext/process_notes.md`, here are recommendations for improving the workflow system.

## Priority 1: Critical UX Issues

### 1. Clarify 'iterate' Command Meaning

**Problem:** Users don't understand what "Type 'iterate' to review and refine the requirements document" means. Where do they put feedback? What happens next?

**Current Behavior (lines 4-5, 55-56 in process_notes.md):**
- Prompts say "Type 'iterate' to review and refine" but don't explain where/how
- User confusion about whether to edit the file or just type 'iterate'
- No clear instructions on what happens during iteration

**Recommended Changes:**

#### A. Update PATTERNS.md - Interview Pattern Section
Lines 95-104: Replace vague language with explicit instructions:

```markdown
6. **Prompt user** with standardized format:
   ```
   I've created [FILE] with initial questions about [context]. Please:
   1. Answer the questions in the 'Your Answer' sections
   2. Ask any questions you have in the 'Your Questions for Claude' sections
   3. Type 'iterate' when ready for me to respond

   What would you like to do?
   - Type 'iterate' - I'll answer your questions, provide research, and ask 5 follow-up questions
   - Type 'continue to next phase' - I'll create [OUTPUT_DOCUMENT] based on your answers so far
   ```
```

#### B. Update Document Iteration Language (PATTERNS.md lines 326-335)
```markdown
1. **Prompt for review:**
   ```
   I've generated [FILE] based on our interview.

   What would you like to do next?
   - Tell me specific edits to make (e.g., "Change section 3 to...", "Add details about...")
   - Type 'execute ~/.workflows/[next]' to continue to [next workflow]

   Note: You can directly request changes to the document. I'll make the edits and confirm.
   ```
```

**Rationale:**
- Removes the ambiguous 'iterate' command during document review
- Makes it clear users can just tell Claude what changes to make
- Provides explicit next step command

### 2. Research Spike Support

**Problem (line 31):** "I need the ability to stop the interview to produce a research spike. For instance, give me instructions to get you data you need. I don't expect to get another 5 questions, just the research instructions."

**Recommended Changes:**

#### A. Add Research Spike Pattern to PATTERNS.md

Insert new section after "Interview Pattern" (around line 263):

```markdown
## Research Spike Pattern

A research spike is a pause in the interview where Claude identifies information gaps and provides instructions for gathering missing data.

### When to Use

- User answers reveal gaps in Claude's understanding (missing codebase knowledge, unclear existing patterns)
- Questions depend on information Claude doesn't have access to
- User explicitly requests research before answering more questions

### Process

1. **Identify Research Needs:**
   - Review user's answers and questions
   - Identify what information would improve subsequent questions
   - Examples: existing architecture patterns, API contracts, performance benchmarks, user data formats

2. **Create Research Section in Interview:**
   Add section in interview document:
   ```markdown
   ## Research Spike (Round N)

   Before continuing with more questions, I need to gather information:

   ### Research Item 1: [Name]
   **What I need:** [Specific information needed]
   **Why:** [How this will improve the interview]
   **How to provide it:**
   - Option A: [e.g., "Run `cmd` and paste output"]
   - Option B: [e.g., "Share the file path to X"]
   - Option C: [e.g., "Describe how Y currently works"]

   ### Research Item 2: [Name]
   ...

   **When you've provided the research items above, type 'iterate' to continue the interview.**
   ```

3. **Wait for Research:**
   - User provides requested information
   - User types 'iterate'

4. **Process Research and Continue:**
   - Read and analyze provided information
   - Use research to inform follow-up questions
   - Continue interview with improved context

### Usage in Workflows

During interview iteration (Step 2 of Interview Pattern), before generating follow-up questions:
- Check if research is needed
- If yes, create Research Spike section instead of follow-up questions
- Resume normal interview after research is provided

### Tracking Research Spikes

At the top of each interview round that includes a research spike, add:
```markdown
**Pending Research:** [N items - see Research Spike section below]
```

This makes it clear to the user that research is blocking progress.
```

#### B. Update Interview Pattern (PATTERNS.md lines 108-137)

In "Step 2: Interview Iteration Cycle", add after step 3:

```markdown
3a. **Evaluate Research Needs:**
   - Based on user's answers, determine if additional information would significantly improve next questions
   - If research needed: Create Research Spike section (see Research Spike Pattern)
   - If no research needed: Proceed to generate follow-up questions (step 4)
```

## Priority 2: Missing Documentation Workflow

### 3. Add User Documentation Creation

**Problem (line 33):** "It completed without creating user docs."

**Recommended Changes:**

#### A. Create New Workflow: `workflows/documentation/workflow.md`

```markdown
# User Documentation Workflow

## Description
Create end-user documentation after implementation is complete, including installation guides, usage instructions, and troubleshooting.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/documentation`) or implementation workflow explicitly suggests creating documentation.

## Instructions

You are creating user-facing documentation for a completed feature or project.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read Context
- Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` - understand user-facing functionality
- Read `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md` - understand what was built
- Read relevant code files to understand actual implementation
- Identify what documentation types are needed (README, user guide, API docs, etc.)

### Step 2: Conduct Documentation Interview
**Follow Interview Pattern** to conduct documentation interview:

#### Phase-Specific Focus
- **Focus:** What users need to know to USE the software, not HOW it works internally
- **Initial questions (up to 15) should explore:**
  - Target audience (developers, end-users, admins?)
  - Installation/setup instructions needed
  - Core use cases to document
  - Configuration options to explain
  - Common problems and troubleshooting
  - API/interface documentation needed
  - Examples and tutorials needed
  - Existing documentation to update vs. new docs to create

#### Output Documents
- **Interview file:** `claude/${TASK_FOLDER}/DOCUMENTATION_INTERVIEW.md`
- **Output document:** `claude/${TASK_FOLDER}/DOCUMENTATION_PLAN.md`

#### Document Structure
When generating DOCUMENTATION_PLAN.md:
- **Documentation Types:** List what will be created (README, API docs, user guide, etc.)
- **Target Audiences:** Who each doc type is for
- **Content Outline:** Sections and topics for each document
- **Examples to Include:** Specific use cases to demonstrate
- **Status Tracking:** Table with each doc item

### Step 3: Generate Documentation
Follow the plan to create actual documentation files:
- Update or create README.md
- Create user guides in appropriate locations
- Generate API documentation
- Add code examples
- Update status tracking as each item completes

#### Next Steps
When documentation is complete, announce:
"Documentation phase complete! All user-facing documentation has been created."
```

#### B. Update PATTERNS.md - Workflow Progression

Add to workflow progression section (line 359-381):

```markdown
1. **Requirements** → Design → Architecture → Plan → Implement → Documentation
2. **Design** → Architecture → Plan → Implement → Documentation
3. **Architecture** → Plan → Implement → Documentation
4. **Plan** → Implement → Documentation
5. **Implement** → Documentation → (completion)
6. **Documentation** → (completion)
7. **Refinement** → Can be invoked at any time independently
```

#### C. Update Implement Workflow

In `workflows/implement/workflow.md`, update Step 4 (lines 74-86):

```markdown
### Step 4: Final Verification
When all steps are complete:
1. Perform final testing
2. Verify all requirements from `claude/${TASK_FOLDER}/REQUIREMENTS.md` are met
3. Check code follows architecture from `claude/${TASK_FOLDER}/ARCHITECTURE.md`
4. Prompt:
   ```
   Implementation complete! All steps in claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md are done.

   What would you like to do?
   - Type 'iterate' to refine or fix any issues
   - Continue to the documentation workflow to create user-facing documentation
   ```
```

## Priority 3: Workflow Structural Improvements

### 4. Evaluate Removing Architecture and Plan Interviews

**Problem (line 35):** "Explore removing interviews for architecture and plan."

**Analysis:**
- Requirements interview: HIGH value (discovers unknowns)
- Design interview: HIGH value (makes decisions with trade-offs)
- Architecture interview: MEDIUM value (often straightforward given design decisions)
- Plan interview: LOW value (usually mechanical breakdown of steps)

**Recommended Changes:**

#### Option A: Make Architecture Interview Optional

Update `workflows/architecture/workflow.md` to add "Skip Pattern":

```markdown
### Step 1: Evaluate Architecture Complexity

Before starting interview, analyze the design:
- Read `claude/${TASK_FOLDER}/DESIGN.md`
- Assess architecture complexity:
  - **Simple:** Single component, clear structure → Skip interview, generate architecture directly
  - **Moderate:** Multiple components, some integration → Quick interview (5-7 questions)
  - **Complex:** Many components, complex data flows, novel patterns → Full interview (up to 15 questions)

Prompt user:
```
Based on the design, I assess this as [Simple/Moderate/Complex] architecture.

Options:
- Type 'skip' - I'll create ARCHITECTURE.md directly (recommended for simple architectures)
- Type 'interview' - I'll conduct an architecture interview to explore decisions together
- Type 'continue' - I'll use the recommended approach ([skip/interview])
```

### Step 2: If Interview Chosen
[existing interview process]

### Step 2 Alternative: If Skip Chosen
- Read REQUIREMENTS.md and DESIGN.md
- Create ARCHITECTURE.md directly following template
- Prompt for review and iteration as normal
```

#### Option B: Remove Plan Interview Entirely

Replace `workflows/plan/workflow.md` interview with direct plan generation:

```markdown
### Step 2: Generate Implementation Plan

Instead of interview, directly generate plan:

1. **Read context:**
   - REQUIREMENTS.md - what to build
   - DESIGN.md - architectural decisions
   - ARCHITECTURE.md - system structure
   - Existing codebase patterns (via codebase exploration)

2. **Create IMPLEMENTATION_PLAN.md:**
   - Break requirements into sequential steps
   - Identify dependencies
   - Include testing approach
   - Add status tracking table
   - Apply best practices (small steps, clear verification, etc.)

3. **Prompt for review:**
   ```
   I've created claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md with [N] implementation steps.

   What would you like to do?
   - Tell me specific changes to make (e.g., "Break step 5 into smaller steps", "Move testing earlier")
   - Type 'execute ~/.workflows/implement' to begin implementation
   ```

4. **Iterate on feedback:**
   - User provides feedback on plan
   - Update plan accordingly
   - Repeat until user starts implementation
```

**Rationale:**
- Plans are usually mechanical breakdowns, not discovery processes
- Users can still provide feedback and iterate
- Removes interview overhead for low-value phase
- Faster path to implementation

### 5. Explicit Testing Guidance

**Problem (line 37):** "Review the workflows to determine if there is explicit mention of how to test and when to test or if this should be a separate process."

**Recommended Changes:**

#### A. Add Testing Section to PATTERNS.md

Insert new section after "Status Tracking Convention" (after line 423):

```markdown
## Testing Convention

Testing should be integrated throughout workflows, not a separate phase.

### Requirements Phase
- Capture testability requirements
- Define success criteria that can be verified
- Identify test scenarios and edge cases

### Design Phase
- Decide testing approach (unit, integration, e2e)
- Choose testing frameworks and tools
- Plan test data and fixtures

### Architecture Phase
- Design for testability (dependency injection, interfaces, etc.)
- Define testing boundaries and integration points
- Plan test doubles (mocks, stubs, fakes)

### Planning Phase
- Include test creation as explicit steps in implementation plan
- For each implementation step, define verification approach
- Sequence: Implement → Test → Verify → Next step

### Implementation Phase
- **Write tests before or alongside feature code (TDD recommended but not required)**
- Run tests after each step
- Don't mark step "Complete" if tests are failing
- Include test results in status notes

### Testing Step Structure

Each test step in implementation plan should include:
```markdown
### Step N: Test [Feature]
**What:** Create tests for [specific functionality]
**Files:**
- `tests/test_[feature].py` (or appropriate test file)
**Test Cases:**
- [Test case 1]
- [Test case 2]
**Verification:** All tests pass with `[test command]`
```

### Continuous Testing Loop (Ralph Wiggum Loop)

After implementing each feature step:
1. **Implement** feature code
2. **Write/update** tests for feature
3. **Run** tests
4. **If tests pass:** Mark step complete, move to next
5. **If tests fail:** Debug, fix, re-run (loop at step 3)
6. **Never** mark step complete with failing tests

This ensures quality at each step rather than testing everything at the end.
```

#### B. Update Implementation Workflow

In `workflows/implement/workflow.md`, enhance "Test as You Go" section (lines 48-52):

```markdown
4. **Test as You Go (Ralph Wiggum Loop)**
   - After implementing feature code, write/update tests
   - Run tests: `[project-specific test command]`
   - **If tests pass:**
     - Add test results to status notes
     - Mark step complete
     - Proceed to next step
   - **If tests fail:**
     - Keep step marked "In Progress"
     - Debug and fix issue
     - Re-run tests
     - Loop until tests pass
   - NEVER mark a step "Complete" with failing tests
   - Report test results to user (e.g., "✓ 15 tests passed, 0 failed")
```

#### C. Update Plan Workflow

In `workflows/plan/workflow.md`, line 62 document structure, add:

```markdown
- **Testing Approach**: How to verify each step (from interview)
  - Testing framework and commands
  - When to write tests (before/during/after feature code)
  - Test coverage expectations
  - Continuous testing loop: implement → test → verify → next
```

## Priority 4: Enhanced Workflow Features

### 6. Roadmap/Backlog Workflow

**Problem (line 39):** "I need to build out a workflow for working through a product roadmap and/or backlog."

**Recommended Changes:**

#### Create New Workflow: `workflows/roadmap/workflow.md`

```markdown
# Product Roadmap Workflow

## Description
Break down a product roadmap or backlog into manageable tasks, prioritize work, and plan execution across multiple features.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/roadmap`) or says "plan my roadmap" or "organize my backlog"

## Instructions

You are helping the user organize and prioritize a product roadmap or feature backlog.

### Step 1: Create Roadmap Folder
- Create `claude/roadmap/` folder (not dated - this is ongoing)
- This folder will contain multiple task breakdowns

### Step 2: Conduct Roadmap Interview

Create `claude/roadmap/ROADMAP_INTERVIEW.md` with questions:

1. **What features or tasks are in your backlog?** (List them all, even if rough)
2. **What are your goals for this roadmap?** (Release date, MVP scope, specific outcomes)
3. **What constraints do you have?** (Time, resources, dependencies)
4. **What's your risk tolerance?** (Can you ship incomplete features? Need high stability?)
5. **What features depend on each other?** (Must X be built before Y?)
6. **What's your current system state?** (Starting from scratch? Modifying existing system?)
7. **How do you want to sequence work?** (User-facing first? Foundation first? Highest risk first?)
8. **What's your definition of "done" for each feature?** (Tested? Documented? Deployed?)

[Standard interview pattern: user answers, asks questions, types 'iterate' for follow-ups]

### Step 3: Generate Roadmap Document

Create `claude/roadmap/ROADMAP.md`:

```markdown
# Product Roadmap

## Overview
[Summary of goals and scope]

## Features Breakdown

### Feature: [Feature Name]
**Priority:** [High/Medium/Low]
**Estimated Size:** [Small/Medium/Large/XL]
**Dependencies:** [List features this depends on]
**Value:** [Why this matters]
**Risks:** [What could go wrong]
**Task Folder:** `claude/YYYY-MM-DD-feature-name/` (to be created)

[Repeat for each feature]

## Recommended Sequence

1. **Phase 1: Foundation** (Weeks 1-2)
   - Feature A
   - Feature B
   - Rationale: [Why these first]

2. **Phase 2: Core Features** (Weeks 3-5)
   - Feature C
   - Feature D
   - Rationale: [Why these second]

3. **Phase 3: Enhancement** (Weeks 6-7)
   - Feature E
   - Feature F
   - Rationale: [Why these last]

## Risk Analysis
[Identify risky items and mitigation strategies]

## Scope Reduction Options
If time is tight, these features can be cut or deferred:
- [Feature X] - [Impact of cutting it]
- [Feature Y] - [Impact of cutting it]
```

### Step 4: Break Down Next Feature

After roadmap is created:
```
I've created your roadmap in claude/roadmap/ROADMAP.md.

What would you like to do next?
- Pick a feature to start - I'll create a task folder and run the requirements workflow
- Adjust the roadmap - Tell me what changes to make
- Type 'execute ~/.workflows/requirements' after creating a task folder for the first feature
```

### Step 5: Track Roadmap Progress

As features are completed, update `claude/roadmap/ROADMAP.md` with status:

```markdown
### Feature: User Authentication
**Status:** ✓ Complete (claude/2026-02-01-auth/)
**Actual Size:** Medium
**Notes:** Implemented OAuth2, took 3 days instead of estimated 2
```

## Best Practices
- Start with feature breakdown before diving into requirements
- Be realistic about scope - prefer small, shippable increments
- Build dependencies first (don't paint yourself into a corner)
- Leave buffer time for unexpected issues
- Re-evaluate roadmap after each feature (priorities may shift)
```

### 7. Work Breakdown Recommendations

**Problem (line 41):** "I often bite off more than I can chew. When we are working through requirements, I need to build out prompt-instructions for 1) making recommendations to break down the work and 2) making the changes if I agree."

**Recommended Changes:**

#### A. Add Scope Assessment to Requirements Workflow

In `workflows/requirements/workflow.md`, add new step after Step 2 (after line 52):

```markdown
### Step 3: Assess Scope and Recommend Breakdown

After reading MISSION.md and before starting interview:

1. **Analyze scope indicators:**
   - Multiple distinct features mentioned
   - Complex integration points
   - Large system described
   - Ambiguous or very broad goals

2. **If scope appears large, prompt user:**
   ```
   Based on your mission statement, this appears to be a [Medium/Large/Very Large] project
   that may benefit from being broken down into smaller chunks.

   Recommendation: Instead of one large feature, consider breaking this into [N] smaller,
   deliverable pieces:

   **Suggested Breakdown:**
   1. [Feature/Phase 1 Name]
      - [Key capabilities]
      - Estimated size: [Small/Medium]
      - Value: [Why this first]

   2. [Feature/Phase 2 Name]
      - [Key capabilities]
      - Estimated size: [Small/Medium]
      - Value: [Why this second]

   3. [Feature/Phase 3 Name]
      - [Key capabilities]
      - Estimated size: [Medium]
      - Value: [Why this third]

   **Benefits of breaking this down:**
   - Ship working software faster
   - Learn from early phases before building later ones
   - Reduce risk of scope creep
   - Easier to estimate and plan

   What would you like to do?
   - Type 'accept' - I'll update MISSION.md to focus on Phase 1 only and note future phases
   - Type 'revise' - Tell me how you'd like to adjust the breakdown
   - Type 'continue' - Proceed with full scope as written (not recommended for large projects)
   ```

3. **If user accepts breakdown:**
   - Update MISSION.md to focus on Phase 1
   - Create FUTURE_PHASES.md listing phases 2, 3, etc.
   - Continue with requirements interview for Phase 1 only

4. **If scope is reasonable:**
   - Proceed directly to requirements interview (current Step 3)
```

#### B. Add to PATTERNS.md

Insert new pattern after "Workflow Progression Pattern" (after line 388):

```markdown
## Scope Management Pattern

Help users avoid overcommitting by assessing scope and recommending breakdowns.

### Scope Assessment Triggers

Assess scope when:
- MISSION.md describes multiple distinct features
- Requirements interview reveals 15+ functional requirements
- User says "I want to build [very large thing]"
- Implementation plan exceeds 20 steps

### Scope Indicators

**Small:**
- Single focused feature
- < 5 functional requirements
- Implementation in < 10 steps
- 1-2 days of work

**Medium:**
- 2-3 related features
- 5-10 functional requirements
- Implementation in 10-15 steps
- 3-5 days of work

**Large:**
- Multiple features or system components
- 10-20 functional requirements
- Implementation in 15-25 steps
- 1-2 weeks of work

**Very Large:**
- Complete system or major subsystem
- 20+ functional requirements
- Implementation in 25+ steps
- 2+ weeks of work

### Breakdown Recommendations

**For Large/Very Large scope:**

1. **Identify phases:**
   - Phase 1: Minimum viable feature (MVP)
   - Phase 2: Core enhancements
   - Phase 3: Advanced features

2. **Prioritize by value:**
   - What delivers value soonest?
   - What reduces risk earliest?
   - What dependencies exist?

3. **Propose breakdown:**
   - Show phases with size estimates
   - Explain benefits of phased approach
   - Recommend starting with Phase 1

4. **Get user buy-in:**
   - User can accept, revise, or continue with full scope
   - Document future phases for reference
   - Focus current workflow on Phase 1

### When to Break Down

- **Requirements phase:** After reading MISSION, before interview
- **Planning phase:** If implementation plan exceeds 20 steps
- **Implementation phase:** If step is too large (> 4 hours work)

### Communication

Frame breakdowns positively:
- "Let's start with something we can ship in 3 days"
- "This gives us a working feature we can build on"
- "You'll have something usable much sooner"

NOT:
- "This is too big" ❌
- "You're biting off more than you can chew" ❌
- "This will take too long" ❌
```

## Priority 5: Design Workflow Enhancements

### 8. Reference Existing Architecture in Design

**Problem (lines 43-45):** "When designing a new feature, the design asked me which context menu library to use. Other features already had a context menu, so it should have referenced that. Design recommendations are not based on existing architecture/design."

**Recommended Changes:**

#### A. Update Design Workflow - Add Architecture Discovery

In `workflows/design/workflow.md`, update Step 1 (currently lines 17-20):

```markdown
### Step 1: Read Context and Discover Existing Patterns

1. **Read requirements:**
   - Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` to understand what needs to be built

2. **Discover existing architecture and patterns:**
   - Read `ARCHITECTURE.md` or `DESIGN.md` in project root if it exists (living architecture doc)
   - Search codebase for similar features (use Grep, Glob, Read tools)
   - Identify existing technology choices relevant to this feature:
     * UI libraries/frameworks already in use
     * Database/ORM patterns established
     * API patterns (REST, GraphQL, etc.)
     * Testing frameworks in place
     * Build/deployment tools configured
     * Error handling patterns used
   - Document findings in `claude/${TASK_FOLDER}/EXISTING_PATTERNS.md`:
     ```markdown
     # Existing Patterns Discovered

     ## UI Framework
     - Using: [Framework name and version]
     - Location: [File paths where used]
     - Pattern: [How it's currently used]

     ## Database
     - Using: [DB and ORM]
     - Location: [Schema files, model files]
     - Pattern: [How queries/models are structured]

     [etc. for each relevant category]

     ## Recommendations
     - For [requirement X], we should use [existing pattern Y] for consistency
     - New decisions needed: [Only things not already decided by existing code]
     ```

3. **Identify key architectural decisions needed:**
   - Focus on decisions NOT already made by existing codebase
   - Prioritize questions about integration with existing patterns
```

#### B. Update Design Interview Questions

In `workflows/design/workflow.md`, update "Phase-Specific Focus" section (lines 26-38):

```markdown
#### Phase-Specific Focus
- **Focus:** HOW (implementation approach), not WHAT (already decided in requirements)
- **First:** Reference existing patterns discovered in Step 1
- **Then:** Focus questions on decisions not yet made by existing architecture
- **Initial questions (up to 15) should explore:**
  - **Integration with existing patterns** (How does this fit with current architecture?)
  - Technology stack **additions** or **variations** from existing (only if needed)
  - New architecture patterns (only if current patterns don't fit)
  - Data storage (reference existing DB/ORM unless new storage needed)
  - API design (reference existing API patterns unless new needed)
  - Error handling (reference existing strategy, extend if needed)
  - Testing approach (use existing frameworks, extend if needed)
  - Security considerations (follow existing patterns)

#### Question Format
For each question, reference existing patterns when relevant:
- "I found we're using [Library X] for [purpose] in [location]. Should we use the same for this feature?
   Alternatives only if there's a reason to differ: A (pros/cons), B (pros/cons)"
- "The existing [feature] uses [pattern]. Should we follow the same pattern here?"
- For truly new decisions: "What X should we use? I recommend Y because [reason].
   Alternatives: A (pros/cons), B (pros/cons)"
```

### 9. Living Architecture Document

**Problem (line 45):** "Have a living design/architecture document which describes how we do things and ask design workflow to reference it when making decisions."

**Recommended Changes:**

#### A. Create Architecture Document Template

Create reference file in workflows: `workflows/templates/ARCHITECTURE_TEMPLATE.md`

```markdown
# Project Architecture (Living Document)

> **Purpose:** This document captures architectural decisions and patterns for this project.
> It should be updated as new patterns are established. Reference this when making design
> decisions for new features.
>
> **Location:** Keep this at project root as `ARCHITECTURE.md` or `docs/ARCHITECTURE.md`

## Technology Stack

### Frontend
- **Framework:** [e.g., React 18.2]
- **UI Library:** [e.g., Material-UI v5]
- **State Management:** [e.g., Redux Toolkit]
- **Routing:** [e.g., React Router v6]
- **Build Tool:** [e.g., Vite]

### Backend
- **Runtime:** [e.g., Node.js 18]
- **Framework:** [e.g., Express 4.18]
- **Database:** [e.g., PostgreSQL 15]
- **ORM:** [e.g., Prisma 5]
- **API Style:** [e.g., REST]

### Testing
- **Unit Tests:** [e.g., Jest]
- **Integration Tests:** [e.g., Supertest]
- **E2E Tests:** [e.g., Playwright]

### Infrastructure
- **Hosting:** [e.g., AWS]
- **CI/CD:** [e.g., GitHub Actions]
- **Monitoring:** [e.g., Datadog]

## Architectural Patterns

### Code Organization
```
project/
├── src/
│   ├── components/   # UI components
│   ├── services/     # Business logic
│   ├── models/       # Data models
│   ├── utils/        # Shared utilities
│   └── tests/        # Test files
```

### API Design Pattern
[Describe REST/GraphQL conventions, endpoint naming, error responses, etc.]

### Database Pattern
[Describe migration approach, schema organization, query patterns]

### Error Handling Pattern
[Describe how errors are handled, logged, and surfaced to users]

### Testing Pattern
[Describe test organization, naming, fixtures, mocking approach]

### State Management Pattern
[Describe how application state is managed]

## Design Principles

### Principle 1: [e.g., "Consistency over novelty"]
**What:** [Explain principle]
**Why:** [Rationale]
**How:** [Concrete guidance]
**Example:** [Code or pattern example]

### Principle 2: [e.g., "Explicit over implicit"]
[etc.]

## Integration Patterns

### How to Add a New API Endpoint
1. [Step by step with example]

### How to Add a New UI Component
1. [Step by step with example]

### How to Add a New Database Table
1. [Step by step with example]

## Decision Log

### [Decision]: Use React instead of Vue
**Date:** 2026-01-15
**Context:** [Why this decision was needed]
**Decision:** [What was decided]
**Rationale:** [Why this choice]
**Consequences:** [Implications]

[Add new decisions over time]

## When to Update This Document

- After making a significant architectural decision
- After establishing a new pattern (and using it in 2+ places)
- After changing technology choices
- When onboarding new team members reveals missing information
```

#### B. Add Living Architecture Check to Design Workflow

In `workflows/design/workflow.md`, update Step 1 (now enhanced with pattern discovery):

```markdown
2. **Discover existing architecture and patterns:**
   - **First, check for living architecture doc:**
     - Look for `ARCHITECTURE.md` or `docs/ARCHITECTURE.md` at project root
     - If exists: Read it thoroughly, this is the source of truth for patterns
     - If doesn't exist: Offer to create one after design phase
   - Then search codebase for concrete implementations
   - Reconcile living doc with actual code (doc may be outdated)
```

And add to end of design workflow (after step 2):

```markdown
### Step 3: Update Living Architecture Document

After generating DESIGN.md:

1. **Check if project has living architecture doc:**
   - Look for `ARCHITECTURE.md` or `docs/ARCHITECTURE.md`

2. **If it exists:**
   ```
   I notice this project has a living architecture document. Should I update it with
   decisions from this design phase?

   Proposed updates:
   - [List new patterns or technology choices that should be documented]

   Type 'yes' to update the architecture doc, or 'no' to skip.
   ```

3. **If it doesn't exist:**
   ```
   This project doesn't have a living architecture document yet. I recommend creating one
   to capture patterns for future features.

   Would you like me to create ARCHITECTURE.md based on:
   - Existing codebase patterns I've discovered
   - Design decisions from this feature

   Type 'yes' to create it, or 'no' to skip.
   ```

4. **If user agrees:**
   - Update or create ARCHITECTURE.md
   - Follow template structure
   - Include decision log entry for this design
```

### 10. Design Recommendation Confidence Levels

**Problem (line 47):** "For design: we should also ask for confidence level of recommendation."

**Recommended Changes:**

#### Update Design Workflow - Add Confidence Levels

In `workflows/design/workflow.md`, update "Question Format" section (lines 38-41):

```markdown
#### Question Format
For each question, lead with your recommendation including confidence level:

**High Confidence (✓✓✓):** Clear best choice based on requirements and constraints
```
[Question format with confidence level]
What X should we use?

**Recommendation:** Y [✓✓✓ High Confidence]
**Why:** [Strong, specific reasons with evidence]
**Alternatives:**
- A: [Pros/cons]
- B: [Pros/cons]
```

**Medium Confidence (✓✓):** Solid choice but alternatives are reasonable
```
[Question format]
What X should we use?

**Recommendation:** Y [✓✓ Medium Confidence]
**Why:** [Good reasons but some trade-offs]
**Alternatives:**
- A: [Pros/cons - may be equally valid]
- B: [Pros/cons]
```

**Low Confidence (✓):** Multiple options are viable, user preference matters most
```
[Question format]
What X should we use?

**Recommendation:** Y [✓ Low Confidence]
**Why:** [Mild reasons, many valid approaches]
**Alternatives:**
- A: [Pros/cons - could be just as good]
- B: [Pros/cons - could be just as good]
```

**Confidence Level Guidance:**

- **High (✓✓✓):** Use when:
  - Requirement clearly favors one option
  - One option has significant advantages with minimal downsides
  - Industry best practice applies directly
  - Example: "Use PostgreSQL ✓✓✓ for relational data with complex queries"

- **Medium (✓✓):** Use when:
  - Multiple options are viable but one has slight edge
  - Trade-offs exist but one option fits requirements better
  - Example: "Use REST ✓✓ for simple CRUD API (GraphQL is also reasonable for complex queries)"

- **Low (✓):** Use when:
  - Multiple options are equally valid
  - Decision is largely preference-based
  - More information needed to make confident recommendation
  - Example: "Use ESLint ✓ for linting (Prettier is equally good, depends on team preference)"
```

### 11. Design Tenets

**Problem (line 49):** "For design: We should ask for tenets up front so that Claude can make better design decisions. e.g., I value robustness over smaller size because this is a desktop app so I don't have to worry about network latency."

**Recommended Changes:**

#### A. Add Tenets to MISSION.md Template

In `workflows/requirements/workflow.md`, update MISSION.md template (lines 19-50):

```markdown
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
    Tenets guide design decisions. Examples:
    - "Robustness over performance" (correctness is more important than speed)
    - "Simplicity over features" (prefer simple solutions, avoid complexity)
    - "User experience over developer convenience" (prioritize end-user needs)
    - "Security over convenience" (prefer secure-by-default even if harder to use)
    - "Explicit over implicit" (prefer clear, obvious code over clever abstractions)
    -->

    **Tenet 1:** [Your most important design principle]

    **Tenet 2:** [Your second priority]

    **Tenet 3:** [etc.]

    ## Context

    [Any additional context: existing systems, constraints, preferences]

    ---

    **Next Step**: Execute the requirements workflow to begin the requirements discovery phase.
```

#### B. Reference Tenets in Design Workflow

In `workflows/design/workflow.md`, update Step 1 (currently lines 17-20):

```markdown
### Step 1: Read Context

- Read `claude/${TASK_FOLDER}/MISSION.md` to understand project tenets and goals
  - **Pay special attention to Design Tenets section**
  - Tenets guide trade-off decisions when multiple options are viable
  - Examples:
    - "Robustness over performance" → Choose PostgreSQL over SQLite
    - "Simplicity over features" → Choose REST over GraphQL
    - "Developer experience over bundle size" → Include helpful error messages even if verbose
- Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` to understand what needs to be built
- Identify key architectural decisions that need to be made
```

And update question format (lines 38-41):

```markdown
#### Question Format
For each question, lead with your recommendation and apply tenets:

```
[Question format with tenets]
What X should we use?

**Recommendation:** Y [✓✓ Medium Confidence]
**Why:** [Reasons, **explicitly reference relevant tenet if applicable**]
  - Aligns with Tenet "[tenet name]" because [specific explanation]
**Alternatives:**
- A: [Pros/cons, note if conflicts with tenets]
- B: [Pros/cons]

**Example:**
What database should we use?

**Recommendation:** PostgreSQL [✓✓✓ High Confidence]
**Why:**
  - Aligns with Tenet "Robustness over performance" - ACID guarantees and data integrity
    are more important than raw speed for this application
  - Supports complex queries needed for reporting requirements
  - Mature ecosystem with strong tooling
**Alternatives:**
- MongoDB: Faster for simple operations but sacrifices robustness (conflicts with Tenet #1)
- SQLite: Simple but not robust enough for multi-user scenarios
```
```

## Implementation Priority Summary

| Priority | Suggestion | Impact | Effort |
|----------|-----------|--------|--------|
| **P1** | #1: Clarify 'iterate' command | Critical UX improvement | Small |
| **P1** | #2: Research spike support | Critical for complex projects | Medium |
| **P2** | #3: Documentation workflow | Fills important gap | Medium |
| **P3** | #4: Optional architecture/plan interviews | Faster workflows | Small |
| **P3** | #5: Explicit testing guidance | Quality improvement | Medium |
| **P4** | #6: Roadmap workflow | New capability | Large |
| **P4** | #7: Scope breakdown recommendations | Prevents overcommitment | Medium |
| **P5** | #8: Reference existing architecture | Design quality | Small |
| **P5** | #9: Living architecture document | Long-term consistency | Medium |
| **P5** | #10: Design confidence levels | Decision clarity | Small |
| **P5** | #11: Design tenets | Better recommendations | Small |

## Recommended Implementation Order

1. **Week 1:** P1 issues (#1, #2) - Critical UX fixes
2. **Week 2:** P3 testing (#5) and P3 workflow simplification (#4)
3. **Week 3:** P2 documentation (#3)
4. **Week 4:** P5 design enhancements (#8, #10, #11)
5. **Week 5:** P5 living architecture (#9)
6. **Week 6:** P4 scope management (#7)
7. **Week 7+:** P4 roadmap workflow (#6) - Most complex addition

## Questions for Review

1. **Interview removal:** Do you want to make architecture/plan interviews optional, or remove them entirely?
2. **Testing approach:** Should we mandate TDD, or keep it recommended but not required?
3. **Confidence levels:** Should these apply only to design, or also to architecture questions?
4. **Roadmap workflow:** Is this a high priority, or can it be deferred?
5. **Living architecture doc:** Should this be created proactively for all projects, or only when requested?
