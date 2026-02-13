# Gen AI Development Kit

A collection of structured methodologies for building software with AI assistance, documenting my journey from straightforward prompts to reusable, interview-based workflows.

## What This Repository Contains

This repository chronicles the evolution of my approach to AI-assisted development, from initial experiments to refined methodologies that balance human control with AI capabilities:

- **[Naive Approach](./naive/)** - Where it all began: a document-driven, 10-step workflow using pre-written prompts
- **[Workflow Approach](./workflows/)** - Reusable, symlink-based workflows with interview-driven development phases
- **Specialized Workflows** - Documentation, refinement, and other focused processes

Each approach represents a stage in learning how to work effectively with AI coding assistants, capturing lessons learned and practical patterns that actually work in real-world development.

A good way to understand the process is to look at the [workflow diagram from the naive approach](./naive/Naive%20Approach%20Workflow.png).

---

## My AI Development Journey

I've been using AI for about a year now. In 2025, I learned a valuable lesson about building a workflow around development. After all, garbage in garbage out. In this new world of AI development, we are the deciders and AI is the implementor. This workflow aims to build a process where we focus on making decisions so that AI can implement. 

### The Naive Approach

When I first started exploring AI-assisted development with Claude Code, I needed structure. I found myself writing the same or similar prompts over and over, so I created a straightforward, document-driven workflow with pre-written prompts that guide you through the entire development process.

The **naive approach** breaks down software creation into 10 sequential steps, each producing specific documents that build on each other. You tell Claude which step to execute, and it generates the corresponding artifacts:

```bash
# Execute a specific step from the workflow
"Execute step 3 from PROCESSING.md"
```

**Key characteristics:**
- **10-step workflow**: From requirements gathering through implementation
- **Document-driven**: Each step creates or refines documents (MISSION.md → GATHER_REQUIREMENTS.md → REQUIREMENTS.md → DECISIONS.md → DESIGN.md → IMPLEMENTATION_PLAN.md)
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
3. Answer questions in GATHER_REQUIREMENTS.md
4. Execute step 2: Claude asks follow-up questions (repeat as needed)
5. Execute step 3: Claude generates REQUIREMENTS.md
6. ... continue through all 10 steps
7. Execute step 10: Claude implements your solution

For complete details, see the [Naive Approach README](./naive/README.md) and the [Visual Workflow](./naive/WORKFLOW.md).

### Evolution to the Workflow Approach

After working with the naive approach, I wanted something more flexible and reusable. Instead of copying template files into each project, I asked: *"How can I create reusable workflows that work across all my projects?"*

The answer: **symlink-based workflows with interview-driven development**. This approach keeps the human-in-the-loop philosophy while making workflows truly reusable and maintainable.

**What changed from naive → workflows:**

| Naive Approach | Workflow Approach |
|----------------|-------------------|
| 10 sequential steps | 7 reusable workflows |
| Copy PROCESSING.md per project | Symlink to global workflows directory |
| Manual step tracking | Interview-based Q&A pattern |
| "Execute step 3" | `execute ~/.workflows/requirements` |
| Single workflow file | Separate workflow files per phase |

**Key improvements:**

1. **Reusable via Symlinks** - Install once, use everywhere:
   ```bash
   ln -s ~/repos/gen-ai-dev-kit/workflows ~/.workflows
   cd any-project/
   execute ~/.workflows/requirements
   ```

2. **Interview-Based Pattern** - Bidirectional Q&A for each phase:
   - Claude asks up to 15 questions to understand your needs
   - You answer questions AND ask your own questions back
   - Claude researches and responds to your questions
   - Claude asks 5 follow-up questions based on your answers
   - Iterate until clarity is achieved

3. **Workflow Phases**:
   ```bash
   execute ~/.workflows/requirements   # Discover what to build
   execute ~/.workflows/design        # Make architectural decisions
   execute ~/.workflows/architecture  # Design system structure
   execute ~/.workflows/plan          # Create implementation plan
   execute ~/.workflows/implement     # Execute with status tracking
   execute ~/.workflows/documentation # Create docs
   execute ~/.workflows/refinement    # Refactor existing code
   ```

4. **Task Folders** - Each feature/task gets its own dated folder:
   ```
   claude/
   └── 2026-01-27-add-authentication/
       ├── REQUIREMENTS_INTERVIEW.md
       ├── REQUIREMENTS.md
       ├── DESIGN_INTERVIEW.md
       ├── DESIGN.md
       ├── ARCHITECTURE_INTERVIEW.md
       ├── ARCHITECTURE.md
       ├── PLAN_INTERVIEW.md
       └── IMPLEMENTATION_PLAN.md
   ```

5. **Automatic Updates** - Pull latest workflow improvements for all projects:
   ```bash
   cd ~/repos/gen-ai-dev-kit
   git pull origin main
   # All projects using ~/.workflows get updates automatically
   ```

**The collaborative process:**

This evolution maintains the structured, human-in-the-loop approach while adding true reusability. Workflows are version-controlled, shareable, and continuously improved without per-project maintenance.

For complete details, see the [Workflows README](./workflows/README.md) and [Patterns Documentation](./workflows/PATTERNS.md).

### Specialized Workflows

While the main development workflows (requirements → design → architecture → plan → implement) work great for building new features, specialized workflows handle focused tasks more efficiently.

**Available Specialized Workflows:**

1. **Refinement** - For maintenance and improvement tasks:
   ```bash
   execute ~/.workflows/refinement
   ```

2. **Documentation** - For creating comprehensive project documentation:
   ```bash
   execute ~/.workflows/documentation
   ```

**What makes refinement different:**

| Development Workflows | Refinement Workflow |
|----------------------|---------------------|
| 5 phases (requirements, design, architecture, plan, implement) | Single streamlined workflow |
| Best for new features | Best for maintenance tasks |
| Multiple interview rounds | Focused clarifying questions |
| Comprehensive architectural decisions | Quick iteration on existing code |

**When to use refinement:**
- Refactoring existing code
- Global renaming (functions, classes, variables)
- Code cleanup and consistency improvements
- Performance optimizations
- Reorganizing files or directories

**When to use documentation:**
- Creating ARCHITECTURE.md
- Writing user guides and API documentation
- Creating developer navigation docs (docs/code/)
- Adding directory READMEs
- Generating Architecture Decision Records (ADRs)

**Key point:** All workflows maintain the same level of human control and review gates. They're just optimized for different types of work—refinement for code improvements, documentation for comprehensive docs, and development workflows for greenfield features.

For complete details, see the [Workflows README](./workflows/README.md) with detailed descriptions of each workflow.

---

## Choosing Your Approach

With multiple methodologies available, which one should you use? Here's a decision guide:

### Use the Naive Approach When:
- ✅ You prefer explicit, numbered steps
- ✅ You want pre-written prompts you can follow verbatim
- ✅ You like seeing the entire workflow in a single document ([PROCESSING.md](./naive/PROCESSING.md))
- ✅ You're new to structured AI-assisted development
- ✅ You want the simplest possible execution model ("execute step N")
- ✅ You're working on a single, straightforward project

**Best for:** Learning the fundamentals, simple projects, understanding the core philosophy

### Use the Workflow Development Phases When:
- ✅ You're building a new feature or system from scratch
- ✅ Requirements are unclear and need discovery through interviews
- ✅ You need to make significant architectural decisions
- ✅ You want comprehensive design documentation
- ✅ You're working on multiple projects or features
- ✅ You want workflows that update automatically via git pull

**Best for:** Complex new features, greenfield projects, professional development work

### Use the Workflow Refinement When:
- ✅ You're improving existing code
- ✅ The scope is focused (specific files or components)
- ✅ You don't need extensive architectural design
- ✅ You still want human-in-the-loop control and review gates
- ✅ You're doing maintenance tasks (refactoring, cleanup)

**Best for:** Code refactoring, cleanup tasks, performance optimizations

### Use the Workflow Documentation When:
- ✅ You need to create or update project documentation
- ✅ You want to generate ARCHITECTURE.md or user guides
- ✅ You're creating developer navigation docs
- ✅ You need Architecture Decision Records (ADRs)

**Best for:** Documentation creation, onboarding materials, architectural docs

### Key Factors to Consider

| Factor | Naive Approach | Workflow Development | Workflow Refinement | Workflow Documentation |
|--------|---------------|---------------------|---------------------|----------------------|
| **Complexity** | Low to Medium | Medium to High | Low to Medium | Medium |
| **Learning Curve** | Gentle | Moderate | Gentle | Gentle |
| **Setup** | Copy PROCESSING.md | Create symlink once | Use symlink | Use symlink |
| **Structure** | 10 numbered steps | 5 interview phases | Single interview | Single interview |
| **Reusability** | Per-project copy | Symlink (global) | Symlink (global) | Symlink (global) |
| **Best For** | Learning, simple projects | Complex features | Code improvements | Documentation |
| **Control Level** | High (review each step) | High (review each phase) | High (review plan) | High (review plan) |

### Can I Mix Approaches?

Absolutely! A typical evolution:
- Start with the **naive approach** to learn the fundamentals
- Install **workflows via symlink** for all projects
- Use **workflow development phases** for complex features
- Use **workflow refinement** for ongoing maintenance
- Use **workflow documentation** when you need comprehensive docs
- Keep the naive approach available for teaching others

The approaches share the same core philosophy: human-in-the-loop development with clear decision points. Choose based on project needs, not dogma.

---

## Quick Start

### Getting Started with the Naive Approach

1. Copy the [naive/](./naive/) folder to your project
2. Create a `MISSION.md` describing what you want to build
3. Tell Claude: `"Execute step 1 from PROCESSING.md"`
4. Follow the prompts through all 10 steps

**→ [Read the Naive Approach README](./naive/README.md)**

### Getting Started with Workflows

1. **Install workflows globally:**
   ```bash
   # Clone the repository
   git clone https://github.com/your-repo/gen-ai-dev-kit.git ~/repos/gen-ai-dev-kit

   # Create symlink
   ln -s ~/repos/gen-ai-dev-kit/workflows ~/.workflows
   ```

2. **Use in any project:**
   ```bash
   cd your-project/

   # For new features
   execute ~/.workflows/requirements

   # For maintenance
   execute ~/.workflows/refinement

   # For documentation
   execute ~/.workflows/documentation
   ```

3. **Follow the interview prompts** - Answer questions, ask your own, iterate until complete

**→ [Read the Workflows README](./workflows/README.md)**

---

## Repository Structure

```
gen-ai-dev-kit/
├── naive/                          # Naive approach methodology
│   ├── README.md                   # Comprehensive guide to the naive approach
│   ├── PROCESSING.md               # The 10-step workflow with prompts
│   └── WORKFLOW.md                 # Visual workflow diagram
│
├── workflows/                      # Reusable workflow definitions (symlink to ~/.workflows)
│   ├── README.md                   # Comprehensive workflow guide
│   ├── PATTERNS.md                 # Core pattern definitions
│   │
│   ├── requirements/               # Requirements discovery workflow
│   │   └── workflow.md
│   ├── design/                     # Design decisions workflow
│   │   └── workflow.md
│   ├── architecture/               # Architecture design workflow
│   │   └── workflow.md
│   ├── plan/                       # Implementation planning workflow
│   │   └── workflow.md
│   ├── implement/                  # Implementation execution workflow
│   │   └── workflow.md
│   ├── documentation/              # Documentation creation workflow
│   │   └── workflow.md
│   ├── refinement/                 # Refinement workflow
│   │   └── workflow.md
│   │
│   └── templates/                  # Document templates
│       ├── ARCHITECTURE_TEMPLATE.md
│       ├── ADR_TEMPLATE.md
│       └── CLAUDE_PROJECT_TEMPLATE.md
│
├── claude/                         # Example usage and documentation
│   ├── CLAUDE_PREP.md              # Documentation philosophy
│   ├── FEATURE_BREAKDOWN_GUIDE.md  # Feature planning guide
│   └── SUGGESTIONS.md              # Workflow improvement ideas
│
└── README.md                       # This file
```

---

## Where to Go Next

### If You're New to AI-Assisted Development
Start with the **naive approach**. It provides clear, numbered steps and pre-written prompts that teach the fundamentals of structured AI collaboration.

**→ [Naive Approach README](./naive/README.md)**

### If You're Ready for Production Workflows
Install the **workflow system** via symlink and use interview-based development for all your projects.

**→ [Workflows README](./workflows/README.md)**

### If You're Building a Complex Feature
Use the **workflow development phases** (requirements → design → architecture → plan → implement) for comprehensive feature development.

**→ [Development Workflows](./workflows/README.md#available-workflows)**

### If You're Doing Maintenance or Refactoring
Use the **refinement workflow** for focused code improvements with human-in-the-loop control.

**→ [Refinement Workflow](./workflows/README.md#available-workflows)**

### If You Need Documentation
Use the **documentation workflow** to create ARCHITECTURE.md, user guides, developer navigation docs, and ADRs.

**→ [Documentation Workflow](./workflows/README.md#documentation-philosophy)**

### If You Want to Understand the Philosophy
Read about the journey above, explore the [Patterns Documentation](./workflows/PATTERNS.md), and see how the methodologies evolved to balance human control with AI capabilities.

---

## Contributing

This repository documents my personal journey and methodologies. Feel free to fork, adapt, and evolve these approaches for your own needs. If you develop interesting variations or improvements, I'd love to hear about them!

## License

[Specify your license here]

---

**Happy building!** 🚀

