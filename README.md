# Gen AI Development Kit

A collection of structured methodologies for building software with AI assistance, documenting my journey from straightforward prompts to sophisticated, skill-based workflows.

## What This Repository Contains

This repository chronicles the evolution of my approach to AI-assisted development, from initial experiments to refined methodologies that balance human control with AI capabilities:

- **[Naive Approach](./naive/)** - Where it all began: a document-driven, 10-step workflow using pre-written prompts
- **[Template Approach](./template/)** - An evolved system with Claude Code skills, task folders, and phased development
- **Refinement Workflows** - Streamlined processes for maintenance tasks and documentation

Each approach represents a stage in learning how to work effectively with AI coding assistants, capturing lessons learned and practical patterns that actually work in real-world development.

---

## The Journey

### Phase 1: The Naive Approach

When I first started exploring AI-assisted development with Claude Code, I needed structure. Rather than figuring out what to ask Claude on the fly, I created a straightforward, document-driven workflow with pre-written prompts that guide you through the entire development process.

The **naive approach** breaks down software creation into 10 sequential steps, each producing specific documents that build on each other. You tell Claude which step to execute, and it generates the corresponding artifacts:

```bash
# Execute a specific step from the workflow
"Execute step 3 from PROCESSING.md"
```

**Key characteristics:**
- **10-step workflow**: From requirements gathering through implementation
- **Document-driven**: Each step creates or refines documents (MISSION.md → QUESTIONS.md → REQUIREMENTS.md → DECISIONS.md → DESIGN.md → IMPLEMENTATION_PLAN.md)
- **Iterative review points**: Steps 2 and 5 are designed for repeated refinement
- **Pre-written prompts**: All step instructions are captured in [PROCESSING.md](./naive/PROCESSING.md)
- **Simple execution model**: Just tell Claude "execute step N"

**Why it works:**
- You focus on making product and architectural decisions
- Claude handles implementation details and plan execution
- Natural conversation flow with clearly defined decision points
- The process has proven effective for building real projects

**Example workflow:**
1. Create MISSION.md describing what you want to build
2. Execute step 1: Claude asks clarifying questions
3. Answer questions in QUESTIONS.md
4. Execute step 2: Claude asks follow-up questions (repeat as needed)
5. Execute step 3: Claude generates REQUIREMENTS.md
6. ... continue through all 10 steps
7. Execute step 10: Claude implements your solution

For complete details, see the [Naive Approach README](./naive/README.md) and the [Visual Workflow](./naive/WORKFLOW.md).

### Phase 2: Evolution to the Template Approach

After working with the naive approach, I wanted to leverage Claude Code's features more effectively. I asked Claude: *"How can I best leverage Claude features to improve my workflow?"*

Through that conversation, we evolved the naive approach into something more sophisticated: a **template-based system with Claude Code skills**. This wasn't a complete redesign—it was a thoughtful evolution that kept what worked while adding powerful new capabilities.

**What changed from naive → template:**

| Naive Approach | Template Approach |
|----------------|-------------------|
| 10 sequential steps | 5 distinct phases |
| Manual step tracking | Claude Code skills (semantic slash commands) |
| Single document set | Task-specific folders with dates |
| "Execute step 3" | `execute .claude/skills/requirements` |

**Key improvements:**

1. **Skills as Semantic Commands** - Instead of numbered steps, phases have descriptive names:
   ```bash
   execute .claude/skills/requirements  # Phase 1: Requirements discovery
   execute .claude/skills/decisions     # Phase 2: Design decisions
   execute .claude/skills/architecture  # Phase 3: Architecture design
   execute .claude/skills/plan          # Phase 4: Implementation planning
   execute .claude/skills/implement     # Phase 5: Execute implementation
   ```

2. **Task Folders** - Each feature/task gets its own dated folder:
   ```
   claude/
   ├── 2026-01-22-add-authentication/
   │   ├── MISSION.md
   │   ├── REQUIREMENTS.md
   │   ├── DECISIONS.md
   │   └── ...
   └── 2026-01-23-build-api/
       └── ...
   ```

3. **Automatic Context Management** - Skills remember the current task folder throughout your session

4. **Review Gates** - Explicit prompts between phases: "Type 'iterate' to review or 'continue to next phase'"

5. **Portable Skills** - Skill definitions travel with your template and work across projects

**The collaborative process:**

This evolution required some back-and-forth with Claude and iterative refinement, but the result is a system that's in pretty good shape. It maintains the human-in-the-loop approach of the naive workflow while leveraging Claude Code's skill system for better organization and discoverability.

For complete details, see the [Template Approach README](./template/claude/README.md) and individual skill files in `.claude/skills/`.

### Phase 3: Adding the Refinement Workflow

The 5-phase development workflow works great for building new features from scratch, but what about maintenance tasks? Documentation updates, refactoring, code cleanup, and reorganization don't need the full requirements → decisions → architecture → plan → implement cycle.

That's where the **refinement workflow** comes in: a streamlined process that maintains the same human-in-the-loop approach but without the overhead of comprehensive architectural design.

**The refinement skill:**

```bash
execute .claude/skills/refinement
```

**What makes refinement different:**

| Development Workflow | Refinement Workflow |
|---------------------|---------------------|
| 5 phases (requirements, decisions, architecture, plan, implement) | Single skill (goals → questions → plan → execute) |
| Best for new features | Best for maintenance tasks |
| MISSION.md, REQUIREMENTS.md, DECISIONS.md, DESIGN.md, IMPLEMENTATION_PLAN.md | REFINEMENT.md, REFINEMENT_QUESTIONS.md, REFINEMENT_PLAN.md |
| Comprehensive architectural decisions | Focused clarifying questions |

**When to use refinement:**
- Creating or updating documentation
- Refactoring existing code
- Global renaming (functions, classes, variables)
- Code cleanup and consistency improvements
- Performance optimizations
- Reorganizing files or directories

**Example refinement workflow:**
1. Execute the refinement skill
2. Fill out REFINEMENT.md (what you want to refine and why)
3. Answer clarifying questions in REFINEMENT_QUESTIONS.md
4. Review REFINEMENT_PLAN.md with detailed steps
5. Type "execute" to implement the changes

**Key point:** Refinement isn't "quick and dirty"—it maintains the same level of human control and review gates as the development workflow. It's just optimized for focused improvements rather than greenfield development.

For complete details, see the [Refinement Skill](./template/.claude/skills/refinement/skill.md) and the refinement section in the [Template README](./template/claude/README.md#refinement-activity).

---

## Choosing Your Approach

With three methodologies available, which one should you use? Here's a decision guide:

### Use the Naive Approach When:
- ✅ You prefer explicit, numbered steps
- ✅ You want pre-written prompts you can follow verbatim
- ✅ You like seeing the entire workflow in a single document ([PROCESSING.md](./naive/PROCESSING.md))
- ✅ You're new to structured AI-assisted development
- ✅ You want the simplest possible execution model ("execute step N")

**Best for:** Straightforward projects, learning the fundamentals, teams that prefer prescriptive guidance

### Use the Template Development Workflow When:
- ✅ You're building a new feature or system from scratch
- ✅ Requirements are unclear and need discovery
- ✅ You need to make significant architectural decisions
- ✅ You want comprehensive design documentation
- ✅ You prefer semantic commands over numbered steps
- ✅ You're working on multiple features simultaneously (task folders)

**Best for:** Complex new features, greenfield projects, teams that value comprehensive planning

### Use the Template Refinement Workflow When:
- ✅ You're improving existing code or documentation
- ✅ The scope is focused (specific files or components)
- ✅ You don't need extensive architectural design
- ✅ You still want human-in-the-loop control and review gates
- ✅ You're doing maintenance tasks (refactoring, cleanup, documentation)

**Best for:** Documentation updates, code refactoring, cleanup tasks, focused improvements

### Key Factors to Consider

| Factor | Naive Approach | Template Development | Template Refinement |
|--------|---------------|---------------------|---------------------|
| **Complexity** | Low to Medium | Medium to High | Low to Medium |
| **Learning Curve** | Gentle | Moderate | Gentle (if familiar with template) |
| **Setup** | Copy PROCESSING.md | Copy entire template | Use template's refinement skill |
| **Structure** | 10 numbered steps | 5 phased skills | Single skill |
| **Best For** | New users, simple projects | Complex features | Maintenance tasks |
| **Control Level** | High (review each step) | High (review each phase) | High (review plan) |

### Can I Mix Approaches?

Absolutely! Many developers:
- Start with the **naive approach** to learn the fundamentals
- Adopt the **template development workflow** for complex features
- Use **template refinement** for ongoing maintenance
- Keep the naive approach around for simple one-off scripts

The approaches share the same core philosophy: human-in-the-loop development with clear decision points. Choose based on project needs, not dogma.

---

## Quick Start

### Getting Started with the Naive Approach

1. Copy the [naive/](./naive/) folder to your project
2. Create a `MISSION.md` describing what you want to build
3. Tell Claude: `"Execute step 1 from PROCESSING.md"`
4. Follow the prompts through all 10 steps

**→ [Read the Naive Approach README](./naive/README.md)**

### Getting Started with the Template Approach

1. Copy the [template/](./template/) folder to your project
2. For a new feature: `execute .claude/skills/requirements`
3. For maintenance tasks: `execute .claude/skills/refinement`
4. Follow the workflow prompts

**→ [Read the Template Approach README](./template/claude/README.md)**

---

## Repository Structure

```
gen-ai-dev-kit/
├── naive/                          # Naive approach methodology
│   ├── README.md                   # Comprehensive guide to the naive approach
│   ├── PROCESSING.md               # The 10-step workflow with prompts
│   └── WORKFLOW.md                 # Visual workflow diagram
│
├── template/                       # Template approach methodology
│   ├── .claude/                    # Claude Code configuration
│   │   ├── CLAUDE.md               # Project-specific instructions
│   │   └── skills/                 # Workflow skills
│   │       ├── requirements/       # Phase 1: Requirements discovery
│   │       ├── decisions/          # Phase 2: Design decisions
│   │       ├── architecture/       # Phase 3: Architecture design
│   │       ├── plan/               # Phase 4: Implementation planning
│   │       ├── implement/          # Phase 5: Execute implementation
│   │       └── refinement/         # Streamlined refinement workflow
│   │
│   ├── claude/                     # Task-specific workflow artifacts
│   │   ├── README.md               # Guide to template approach
│   │   ├── CLAUDE_RECOMMENDATIONS.md  # Optimization tips
│   │   └── CLAUDE_BACKLOG.md       # Future enhancements
│   │
│   ├── docs/                       # Additional documentation
│   │   └── GETTING_STARTED.md      # Setup without Claude Code
│   │
│   └── examples/                   # Example task structures
│       └── EXAMPLE_MISSION.md      # Template for MISSION.md
│
└── README.md                       # This file
```

---

## Where to Go Next

### If You're New to AI-Assisted Development
Start with the **naive approach**. It provides clear, numbered steps and pre-written prompts that teach the fundamentals of structured AI collaboration.

**→ [Naive Approach README](./naive/README.md)**

### If You're Building a Complex Feature
Use the **template development workflow**. It provides comprehensive requirements discovery, architectural decision-making, and implementation planning.

**→ [Template Development Workflow](./template/claude/README.md#development-activity)**

### If You're Doing Maintenance or Documentation
Use the **template refinement workflow**. It provides the same human-in-the-loop control with a streamlined process optimized for focused improvements.

**→ [Template Refinement Workflow](./template/claude/README.md#refinement-activity)**

### If You Want to Understand the Philosophy
Read about the journey above, explore the documentation in each folder, and see how the methodologies evolved to balance human control with AI capabilities.

---

## Contributing

This repository documents my personal journey and methodologies. Feel free to fork, adapt, and evolve these approaches for your own needs. If you develop interesting variations or improvements, I'd love to hear about them!

## License

[Specify your license here]

---

**Happy building!** 🚀

