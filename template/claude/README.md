# Claude-Driven Development Workflow

Welcome to the Claude-driven development template! This directory contains a structured workflow for building software features with Claude Code through intentional, phased development.

## What Is This?

This template provides a systematic approach to software development that leverages AI assistance while maintaining strong human control at every decision point. Instead of ad-hoc prompting, you can choose between two structured workflows based on your task:

**Two Workflows Available:**

1. **Development Activity** - A comprehensive 5-phase workflow for building new features from scratch
2. **Refinement Activity** - A streamlined workflow for maintenance tasks like documentation, refactoring, or cleanup

Both workflows maintain the same deliberate approach: Claude asks questions, creates a plan, and waits for your approval before executing. The difference is scope and complexity, not control.

**The Development Workflow (Five Phases):**
1. **Requirements Discovery** (`/requirements`) - Clarify what you're building
2. **Design Decisions** (`/decisions`) - Make architectural choices
3. **Architecture Design** (`/architecture`) - Create detailed design
4. **Implementation Planning** (`/plan`) - Plan the implementation
5. **Execute Implementation** (`/implement`) - Build the solution

**The Refinement Workflow (Single Skill):**
- **Refinement** (`/refinement`) - Structured approach for refactoring, documentation, cleanup, or renaming tasks

## Choosing Your Workflow

**Use the Development Workflow when:**
- Building a new feature from scratch
- You need to make architectural decisions
- Requirements are unclear and need discovery
- The solution will span multiple components
- You want comprehensive design documentation

**Use the Refinement Workflow when:**
- Creating or updating documentation
- Refactoring existing code
- Performing global renaming (functions, classes, variables)
- Cleaning up code or removing unused features
- Making improvements to existing functionality

**Both workflows maintain the same level of human control:**
- Claude asks clarifying questions about your goals
- Claude creates a detailed plan for your review
- You approve the plan before execution begins
- Claude executes step by step with review gates

The key difference: **Development** is comprehensive (requirements → decisions → architecture → plan → implement), while **Refinement** is streamlined (goals → questions → plan → execute). Choose based on the complexity and scope of your task, not on how much control you want.

---

## Development Activity

This section describes the 5-phase development workflow for building new features from scratch.

### Why This Approach?

**Benefits:**
- **Reduced rework**: Catch issues in requirements/design before coding
- **Better architecture**: Intentional decisions vs. reactive coding
- **Clear documentation**: Every phase produces artifacts you can reference
- **Human control**: You review and approve at each phase transition
- **Consistent quality**: Systematic approach reduces ad-hoc mistakes

**Key Principle: Human-in-the-Loop**

This workflow maintains review gates between phases. Claude proposes and creates artifacts, but YOU review, provide feedback, and approve before moving forward. This prevents runaway AI decisions and ensures the solution meets your actual needs.

### Quick Start

### 1. Start Phase 1
Run the requirements discovery skill:
```
execute .claude/skills/requirements
```

Claude will:
- Ask you to name a task folder (format: YYYY-MM-DD-description, e.g., `2026-01-22-add-feature`)
- Create the folder under `claude/[task-name]/`
- Create a MISSION.md template for you to fill out
- Ask clarifying questions in GATHER_REQUIREMENTS.md
- Wait for you to answer
- Generate REQUIREMENTS.md based on your answers

### 2. Continue Through the Phases
After completing each phase, run the next skill:
```
execute .claude/skills/requirements  → decisions → architecture → plan → implement
```

Claude will remember your task folder throughout the session. At each phase, you'll review artifacts and provide feedback before proceeding.

### 3. Working with Multiple Tasks
To work on a different task or start a new one:
- Simply run any skill (e.g., `execute .claude/skills/requirements`)
- Claude will list existing task folders or prompt you to create a new one
- Select the task you want to work on

### The Workflow in Detail

### Phase 1: Requirements Discovery (`/requirements`)

**Input:** Your MISSION.md
**Output:** GATHER_REQUIREMENTS.md, REQUIREMENTS.md

**What happens:**
1. Claude asks 8-10 clarifying questions about WHAT you want (not HOW)
2. You answer in GATHER_REQUIREMENTS.md
3. Claude asks 5 follow-up questions
4. You answer again
5. Claude generates REQUIREMENTS.md with:
   - Functional requirements
   - Non-functional requirements (performance, security, etc.)
   - Constraints
   - Explicit scope (what's OUT of scope)

**Review gate:** You review and approve REQUIREMENTS.md before moving to Phase 2

### Phase 2: Design Decisions (`/decisions`)

**Input:** REQUIREMENTS.md
**Output:** DECISIONS.md

**What happens:**
1. Claude identifies 5-8 key architectural decisions
2. For each decision, Claude:
   - Recommends an option
   - Presents alternatives
   - Explains trade-offs
3. You make decisions and ask follow-up questions
4. Claude updates DECISIONS.md based on your choices
5. Iterate until all decisions are made

**Review gate:** You review and approve all decisions before moving to Phase 3

### Phase 3: Architecture Design (`/architecture`)

**Input:** REQUIREMENTS.md, DECISIONS.md
**Output:** DESIGN.md

**What happens:**
1. Claude creates comprehensive design document:
   - Architecture overview
   - Key components and responsibilities
   - Data flows
   - Technology stack
   - Directory structure
   - Error handling strategy
   - Security considerations
   - Testing strategy
2. You review and provide feedback
3. Claude validates design addresses all requirements

**Review gate:** You approve the architecture before moving to Phase 4

### Phase 4: Implementation Planning (`/plan`)

**Input:** REQUIREMENTS.md, DECISIONS.md, DESIGN.md
**Output:** IMPLEMENTATION_PLAN.md, PLAN_ANALYSIS.md

**What happens:**
1. Claude creates detailed implementation plan:
   - Numbered, sequential steps
   - Files to create/modify for each step
   - Status tracking table
   - Testing approach
2. You review the plan
3. Claude analyzes the plan for gaps or risks (PLAN_ANALYSIS.md)
4. Claude updates plan based on analysis
5. You approve the final plan

**Review gate:** You approve the implementation plan before execution

### Phase 5: Execute Implementation (`/implement`)

**Input:** IMPLEMENTATION_PLAN.md, DESIGN.md
**Output:** Working code, updated status tracking

**What happens:**
1. Claude executes each step in the plan sequentially
2. After each step:
   - Updates status tracking in IMPLEMENTATION_PLAN.md
   - Prompts you to review before continuing
3. Tests as it goes
4. Handles issues by pausing and consulting you
5. Final verification when all steps complete

**Review gates:** You review after each major step during implementation

### Skills Reference

This template includes six skills (slash commands) across two workflows:

| Skill | Activity | Phase | What It Does |
|-------|----------|-------|--------------|
| `/requirements` | Development | 1 | Requirements discovery through Q&A |
| `/decisions` | Development | 2 | Architectural decision-making |
| `/architecture` | Development | 3 | Create detailed design document |
| `/plan` | Development | 4 | Create implementation plan |
| `/implement` | Development | 5 | Execute the implementation |
| `/refinement` | Refinement | - | Streamlined workflow for maintenance tasks |

**Skills are:**
- **Descriptive**: Semantic names make them easy to remember
- **Self-documenting**: See `.claude/skills/[name]/skill.md` for details
- **Portable**: Travel with this template when copied to new projects
- **Sequential**: Each skill suggests running the next one

---

## Refinement Activity

This section describes the streamlined refinement workflow for maintenance tasks like documentation, refactoring, cleanup, and renaming.

### What Is Refinement?

Refinement is a structured workflow for making improvements to existing code or documentation without the full complexity of the 5-phase development process. It's designed for tasks where:

- You know what needs to be done (but want Claude to help plan and execute it)
- The scope is focused (specific files, components, or documentation)
- You still want the human-in-the-loop approach (questions, planning, approval)
- You don't need extensive architectural decision-making

**Common refinement tasks:**
- Creating or updating documentation
- Refactoring existing code for better structure
- Global renaming of functions, classes, or variables
- Code cleanup (removing unused code, improving consistency)
- Performance optimizations
- Reorganizing files or directories

### Why Use Refinement?

**You should use refinement when you want:**
- Claude to ask clarifying questions about your goals
- A detailed plan to review before execution
- Step-by-step execution with review gates
- The same human control as the development workflow
- But without the overhead of requirements discovery and architectural design

**Refinement is NOT:**
- A "quick and dirty" approach
- An uncontrolled or ad-hoc workflow
- Less thorough than development workflow
- For skipping human review

### Quick Start

#### 1. Start the Refinement Skill
Run the refinement skill:
```
execute .claude/skills/refinement
```

Claude will:
- Ask you to name a task folder (format: YYYY-MM-DD-description, e.g., `2026-01-23-refactor-api`)
- Create the folder under `claude/[task-name]/`
- Create a REFINEMENT.md template for you to fill out
- Wait for you to describe your refinement goals

#### 2. Describe Your Refinement
Fill out the REFINEMENT.md template with:
- Type of refinement (refactoring, documentation, cleanup, etc.)
- What you want to refine and why
- Current issues you're addressing
- Desired outcome
- Scope (which files/components are affected)
- Constraints (backwards compatibility, etc.)

#### 3. Answer Questions
Claude will:
- Read your REFINEMENT.md
- Create REFINEMENT_QUESTIONS.md with 5 clarifying questions
- Ask follow-up questions based on your answers
- Iterate until the goals and approach are clear

#### 4. Review the Plan
Claude will:
- Create REFINEMENT_PLAN.md with detailed steps
- Include risk analysis and validation approach
- Show a status tracking table
- Wait for your approval before executing

#### 5. Execute the Plan
Once you approve:
- Claude executes each step sequentially
- Updates status tracking in REFINEMENT_PLAN.md
- Runs tests after significant changes
- Provides status updates after each major step
- Stops and consults you if issues arise

### The Refinement Workflow in Detail

**Input:** Your REFINEMENT.md describing refinement goals
**Output:** REFINEMENT_QUESTIONS.md, REFINEMENT_PLAN.md, updated code/documentation

**Workflow steps:**

1. **Define Goals (REFINEMENT.md)**
   - You describe what needs refinement
   - Include type, current issues, desired outcome, scope, constraints

2. **Clarifying Questions (REFINEMENT_QUESTIONS.md)**
   - Claude asks 5 initial questions
   - You answer in the spaces provided
   - Claude asks 5 follow-up questions based on your answers
   - Iterate until goals are clear

3. **Create Plan (REFINEMENT_PLAN.md)**
   - Claude reads the codebase to understand current state
   - Creates detailed, numbered refactoring steps
   - Includes risk analysis and mitigation strategies
   - Provides status tracking table
   - Outlines validation and rollback approach

4. **Review Gate**
   - You review REFINEMENT_PLAN.md
   - Provide feedback or request changes
   - Claude iterates on the plan until you approve
   - Type "execute" when ready to proceed

5. **Execute Plan**
   - Claude works through each step sequentially
   - Updates status table as steps complete
   - Runs tests after significant changes
   - Pauses if issues occur for your input
   - Provides summary when complete

**Review gates:** You review and approve the plan before execution, and Claude checks in after major steps during execution

### Refinement vs. Development

| Aspect | Development Workflow | Refinement Workflow |
|--------|---------------------|---------------------|
| **Best for** | New features, complex systems | Maintenance tasks, focused improvements |
| **Phases** | 5 (requirements → decisions → architecture → plan → implement) | 1 skill (goals → questions → plan → execute) |
| **Artifacts** | MISSION.md, REQUIREMENTS.md, DECISIONS.md, DESIGN.md, IMPLEMENTATION_PLAN.md | REFINEMENT.md, REFINEMENT_QUESTIONS.md, REFINEMENT_PLAN.md |
| **Duration** | Multi-day for complex features | Hours to 1-2 days typically |
| **Human Control** | Questions, planning, approval gates | Questions, planning, approval gates |
| **When Unclear** | Extensive requirements discovery | Focused clarifying questions |

**Both workflows maintain:**
- Human-in-the-loop approach
- Question-driven clarification
- Detailed planning before execution
- Review gates and approval steps
- Step-by-step progress tracking

### Example Refinement Session

```
# Refactoring Example
You: execute .claude/skills/refinement
Claude: "What should I name this task folder?"
You: "2026-01-23-refactor-error-handling"
Claude: [Creates REFINEMENT.md template]
You: [Fills out: "Refactor error handling to use consistent patterns across API"]
You: "Done"
Claude: [Asks 5 questions about scope, patterns, breaking changes]
You: [Answers in REFINEMENT_QUESTIONS.md]
Claude: [Follow-up questions about specific files]
You: [Answers]
Claude: [Creates REFINEMENT_PLAN.md with 8 numbered steps]
You: [Reviews plan] "Looks good"
You: "execute"
Claude: [Executes step 1] "Step 1 complete: Updated error handler base class. Tests passing."
Claude: [Executes step 2] "Step 2 complete: Refactored API routes. Review?"
You: "Continue"
[... continues through all steps ...]
Claude: "Refinement complete! All tests passing. 12 files modified."
```

## Directory Structure

```
./claude/                                  # Claude workflow documents
├── README.md                              # This file
├── CLAUDE_RECOMMENDATIONS.md              # Optimization tips
├── CLAUDE_BACKLOG.md                     # Future enhancements
├── task-template/                         # Example task structure
│   └── MISSION.md                        # Template MISSION file
├── 2026-01-22-add-authentication/        # Example development task folder
│   ├── MISSION.md                        # Your project goal
│   ├── GATHER_REQUIREMENTS.md            # Generated during Phase 1
│   ├── REQUIREMENTS.md                   # Generated during Phase 1
│   ├── DECISIONS.md                      # Generated during Phase 2
│   ├── DESIGN.md                         # Generated during Phase 3
│   ├── IMPLEMENTATION_PLAN.md            # Generated during Phase 4
│   └── PLAN_ANALYSIS.md                  # Generated during Phase 4
├── 2026-01-23-refactor-api/              # Example refinement task folder
│   ├── REFINEMENT.md                     # Your refinement goals
│   ├── REFINEMENT_QUESTIONS.md           # Questions and answers
│   └── REFINEMENT_PLAN.md                # Execution plan with status tracking
└── 2026-01-24-update-docs/               # Another refinement task folder
    ├── REFINEMENT.md
    ├── REFINEMENT_QUESTIONS.md
    └── REFINEMENT_PLAN.md
```

**Task Folder Naming:**
- Format: `YYYY-MM-DD-description`
- Example: `2026-01-22-add-authentication`
- Example: `2026-01-23-refactor-api`

This structure allows you to work on multiple features/tasks simultaneously without conflicts.

## Best Practices

### Do:
- ✅ **Choose the right workflow**: Use Development for new features, Refinement for maintenance tasks
- ✅ Use descriptive task folder names that clearly indicate what you're building
- ✅ Write clear, detailed initial documents (MISSION.md or REFINEMENT.md)
- ✅ Answer all questions thoughtfully during the clarification phase
- ✅ Review artifacts carefully at each phase
- ✅ Provide specific feedback when something isn't right
- ✅ Trust the process - each phase builds on the previous one
- ✅ Stay focused on your stated goals (don't expand scope during execution)
- ✅ Keep related work in the same task folder

### Don't:
- ❌ Skip phases or rush through reviews (both workflows require thoughtful review)
- ❌ Add requirements during implementation (update your planning documents first)
- ❌ Approve artifacts you haven't actually read
- ❌ Let Claude make decisions without your input
- ❌ Ignore warnings or issues raised during planning
- ❌ Use refinement for complex new features (use the development workflow instead)

## Continuous Conversations

Within each phase, stay in a single conversation with Claude. This maintains context and enables quick iterations:

**Good:**
```
You: /requirements
Claude: [Creates GATHER_REQUIREMENTS.md] "Please review and answer"
You: [Edits file] "Done"
Claude: [Reads your answers] "Based on your answers, I have 5 follow-ups..."
You: [Answers] "Done"
Claude: [Creates REQUIREMENTS.md] "Please review"
You: "Add error handling for network failures"
Claude: [Updates] "Added. Anything else?"
You: "Looks good"
```

**Not ideal:**
```
You: /requirements
Claude: [Creates GATHER_REQUIREMENTS.md]
[You close conversation]
You: [New conversation] "Read GATHER_REQUIREMENTS.md and continue"
Claude: [Has to re-read everything, loses context]
```

## When Things Don't Go as Planned

**If requirements change during implementation:**
- Pause implementation
- Go back to Phase 1 and update REQUIREMENTS.md
- Update DECISIONS.md and DESIGN.md if needed
- Update IMPLEMENTATION_PLAN.md
- Resume implementation

**If you discover design issues during implementation:**
- Pause implementation
- Go back to Phase 3 and update DESIGN.md
- Update IMPLEMENTATION_PLAN.md
- Resume implementation

**If a step in the plan doesn't work:**
- Update IMPLEMENTATION_PLAN.md with the issue in status notes
- Discuss with Claude how to adjust
- Update the plan and continue

The workflow is iterative - it's OK to go back and update earlier artifacts based on what you learn.

## Tips for Success

1. **Invest time in MISSION.md**: A clear mission leads to better questions and requirements
2. **Be thorough in Phase 1**: Good requirements prevent rework later
3. **Make thoughtful decisions in Phase 2**: These affect the entire implementation
4. **Validate the plan in Phase 4**: Catch issues before coding
5. **Stay in conversation**: Don't start new conversations unnecessarily
6. **Review regularly**: Small, frequent reviews are better than big, late reviews
7. **Document changes**: If requirements or design change, update the artifacts

## Getting Help

- **For workflow questions**: See `CLAUDE_RECOMMENDATIONS.md`
- **For future enhancements**: See `CLAUDE_BACKLOG.md`
- **For skill details**: See `.claude/skills/[name]/skill.md`
- **For project-specific questions**: Ask Claude directly in context

## Example Sessions

### Development Workflow Example

Here's what a typical development workflow session looks like:

```
# Day 1: Requirements
You: execute .claude/skills/requirements
Claude: "What should I name this task folder? (format: YYYY-MM-DD-description)"
You: "2026-01-22-build-cli-tool"
Claude: "Working on task: 2026-01-22-build-cli-tool"
Claude: [Creates MISSION.md template]
You: [Fills out MISSION.md describing a CLI tool]
You: "Done"
Claude: [Asks questions about CLI tool]
You: [Answers questions in GATHER_REQUIREMENTS.md]
Claude: [Follow-up questions]
You: [Answers]
Claude: [Creates REQUIREMENTS.md]
You: [Reviews and approves]

# Day 2: Design
You: execute .claude/skills/decisions
Claude: "Working on task: 2026-01-22-build-cli-tool" [remembers from session]
Claude: [Proposes architectural decisions]
You: [Makes decisions in DECISIONS.md]
Claude: [Updates based on decisions]
You: [Approves]
You: execute .claude/skills/architecture
Claude: [Creates DESIGN.md]
You: [Reviews and approves]

# Day 3: Planning
You: execute .claude/skills/plan
Claude: [Creates IMPLEMENTATION_PLAN.md]
You: [Reviews]
Claude: [Creates PLAN_ANALYSIS.md]
Claude: [Updates plan based on analysis]
You: [Approves final plan]

# Day 4-5: Implementation
You: execute .claude/skills/implement
Claude: [Executes step 1] "Step 1 complete. Review?"
You: "Looks good"
Claude: [Executes step 2] "Step 2 complete. Review?"
[... continues through all steps ...]
Claude: "Implementation complete!"
You: [Tests the final product]
```

## What Makes This Different

**Traditional approach:**
- Write code immediately
- Fix issues as they arise
- Refactor when design problems appear
- Documentation is an afterthought

**This approach:**
- Clarify requirements first
- Make design decisions intentionally
- Plan before coding
- Documentation is built-in

The result: Better architecture, less rework, clearer thinking, and a system that actually solves the problem you intended to solve.

## Next Steps

**For building a new feature:**
1. Run `execute .claude/skills/requirements`
2. Name your task folder (e.g., `2026-01-22-my-feature`)
3. Fill out the MISSION.md template Claude creates
4. Follow the workflow through all five phases
5. Build something great!

**For maintenance tasks (documentation, refactoring, cleanup):**
1. Run `execute .claude/skills/refinement`
2. Name your task folder (e.g., `2026-01-23-refactor-api`)
3. Fill out the REFINEMENT.md template Claude creates
4. Answer questions and review the plan
5. Execute and improve your codebase!

For optimization tips, see `CLAUDE_RECOMMENDATIONS.md`.
For future enhancements to this workflow, see `CLAUDE_BACKLOG.md`.
