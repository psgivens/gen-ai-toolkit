# Development Workflows

Interview-based workflows for structured software development with Claude Code.

## Overview

This directory contains reusable workflows that guide you through software development phases using an interactive interview approach. Each workflow uses bidirectional Q&A to gather requirements, make decisions, design architecture, plan implementation, and execute tasks.

### What are Workflows?

Workflows are structured conversation guides that Claude follows to help you:
- **Discover requirements** through targeted questions
- **Make design decisions** with recommendations and trade-offs
- **Design architecture** with component and data flow analysis
- **Plan implementation** with step-by-step breakdowns
- **Execute implementation** with status tracking
- **Refactor code** with risk analysis and validation

## Available Workflows

| Workflow | Command | Purpose |
|----------|---------|---------|
| **Requirements** | `execute ~/.workflows/requirements` | Discover what to build through requirements interview |
| **Design** | `execute ~/.workflows/design` | Make architectural decisions with recommendations |
| **Architecture** | `execute ~/.workflows/architecture` | Design system structure, components, and data flows |
| **Plan** | `execute ~/.workflows/plan` | Create detailed implementation plan with dependencies |
| **Implement** | `execute ~/.workflows/implement` | Execute plan step-by-step with status tracking |
| **Refinement** | `execute ~/.workflows/refinement` | Refactor, reorganize, or clean up existing code |

## Installation

### Step 1: Clone or Update Repository

```bash
# If you haven't cloned yet
git clone https://github.com/your-repo/gen-ai-dev-kit.git
cd gen-ai-dev-kit

# If you already have it, pull latest changes
cd ~/repos/gen-ai-dev-kit
git pull origin main
```

### Step 2: Create Symbolic Link

```bash
# Create symlink to make workflows accessible globally
# (You can use any name you prefer - ~/.workflows is just a convention)
ln -s ~/repos/gen-ai-dev-kit/workflows ~/.workflows

# Verify it worked
ls -la ~/.workflows
```

The symlink allows you to invoke workflows from any project directory. You can name the symlink anything you like (e.g., `~/.workflows`, `~/.my-workflows`, `~/.dev-workflows`), and invoke workflows using that path.

### Step 3: Verify Installation

```bash
cd ~/your-project
execute ~/.workflows/requirements
# (or whatever name you chose for your symlink)
# Should start the requirements discovery workflow
```

## Usage

### Basic Workflow Execution

From any project directory (assuming you created the symlink as `~/.workflows`):

```bash
# Start requirements discovery
execute ~/.workflows/requirements

# Continue to design decisions
execute ~/.workflows/design

# Design the architecture
execute ~/.workflows/architecture

# Create implementation plan
execute ~/.workflows/plan

# Execute the plan
execute ~/.workflows/implement
```

**Note:** If you named your symlink something else (e.g., `~/.my-workflows`), simply replace `~/.workflows/` with your chosen path.

### Complete Workflow Example

Here's a typical development session:

```bash
cd ~/my-new-project

# Phase 1: Requirements
execute ~/.workflows/requirements
# Creates: claude/2026-01-27-feature-name/REQUIREMENTS_INTERVIEW.md
# Creates: claude/2026-01-27-feature-name/REQUIREMENTS.md

# Phase 2: Design
execute ~/.workflows/design
# Creates: claude/2026-01-27-feature-name/DESIGN_INTERVIEW.md
# Creates: claude/2026-01-27-feature-name/DESIGN.md

# Phase 3: Architecture
execute ~/.workflows/architecture
# Creates: claude/2026-01-27-feature-name/ARCHITECTURE_INTERVIEW.md
# Creates: claude/2026-01-27-feature-name/ARCHITECTURE.md

# Phase 4: Planning
execute ~/.workflows/plan
# Creates: claude/2026-01-27-feature-name/PLAN_INTERVIEW.md
# Creates: claude/2026-01-27-feature-name/IMPLEMENTATION_PLAN.md

# Phase 5: Implementation
execute ~/.workflows/implement
# Executes steps from IMPLEMENTATION_PLAN.md
# Updates status tracking table as you progress
```

### Task Folder Structure

Workflows create task folders under `claude/` in your project:

```
your-project/
├── claude/
│   └── 2026-01-27-add-authentication/
│       ├── MISSION.md
│       ├── REQUIREMENTS_INTERVIEW.md
│       ├── REQUIREMENTS.md
│       ├── DESIGN_INTERVIEW.md
│       ├── DESIGN.md
│       ├── ARCHITECTURE_INTERVIEW.md
│       ├── ARCHITECTURE.md
│       ├── PLAN_INTERVIEW.md
│       ├── IMPLEMENTATION_PLAN.md
│       └── (implementation artifacts)
└── (your source code)
```

## Interview Pattern

All workflows use an **interview-based approach** with bidirectional Q&A:

### How It Works

1. **Claude asks up to 15 questions** to understand your needs
2. **You answer questions** and **ask your own questions back**
3. **Claude researches** (reads code, checks docs) and **answers your questions**
4. **Claude asks 5 follow-up questions** based on your answers
5. **Repeat until clarity is achieved**

### Example Interview Structure

```markdown
## Interview Round 1

### Question 1: What are the primary inputs to this system?

**Your Answer:**
User uploads CSV files with customer data

**Your Questions for Claude:**
What's the best way to validate CSV structure?

---

### Question 2: What are the expected outputs?

**Your Answer:**
JSON API responses with transformed data

**Your Questions for Claude:**
Should we use REST or GraphQL?

---

## Claude's Responses (Round 1)

### Response to Your Question from Q1:
For CSV validation, I recommend using a schema validation library...
[detailed answer with code examples]

### Response to Your Question from Q2:
For this use case, I recommend REST because...
[comparison with trade-offs]

---

## Interview Round 2

### Question 1: Based on your CSV input, what error handling do you need?
...
```

### Iteration Commands

During any interview:
- Type **"iterate"** → Claude answers your questions and asks 5 follow-ups
- Type **"continue to next phase"** → Claude creates output document and moves to next workflow

## Workflow Patterns

All workflows follow shared patterns defined in [`PATTERNS.md`](./PATTERNS.md):

- **Interview Pattern** - Bidirectional Q&A structure (15 initial, 5 follow-up questions)
- **Review Gate Pattern** - Explicit prompts before proceeding
- **Iteration Pattern** - "iterate" vs "continue to next phase" behavior
- **Status Tracking** - Progress tables in implementation/refinement plans
- **Document Templates** - Standard structures for output artifacts

## Updating Workflows

Since workflows are in version control, updates are automatic:

```bash
cd ~/repos/gen-ai-dev-kit
git pull origin main

# Symlink automatically points to updated workflows
execute ~/.workflows/requirements  # Uses latest version
```

## Customization

### Option 1: Fork the Repository

```bash
git clone https://github.com/you/gen-ai-dev-kit.git ~/my-workflows
cd ~/my-workflows
# Edit workflows/ to customize
git commit -m "Customize for my needs"

# Create symlink to your fork
ln -s ~/my-workflows/workflows ~/.workflows
```

### Option 2: Create Local Overrides

```bash
# Keep global workflows
ln -s ~/repos/gen-ai-dev-kit/workflows ~/.workflows

# Create project-specific override
mkdir -p my-project/.workflows/requirements
cp ~/.workflows/requirements/workflow.md my-project/.workflows/requirements/

# Edit my-project/.workflows/requirements/workflow.md

# In project, use local version
cd my-project
execute .workflows/requirements  # Uses local override
```

### Option 3: Multiple Installations

```bash
# Stable version
ln -s ~/repos/gen-ai-dev-kit/workflows ~/.workflows

# Experimental version
git clone https://github.com/you/gen-ai-dev-kit.git ~/experimental-workflows
ln -s ~/experimental-workflows/workflows ~/.workflows-experimental

# Use experimental when testing
execute ~/.workflows-experimental/requirements
```

## Troubleshooting

### "File not found" when executing workflow

**Problem:** Symlink doesn't exist or points to wrong location

**Solution:**
```bash
# Check if symlink exists
ls -la ~/.workflows

# If not, create it
ln -s ~/repos/gen-ai-dev-kit/workflows ~/.workflows

# If it points to wrong place, remove and recreate
rm ~/.workflows
ln -s ~/repos/gen-ai-dev-kit/workflows ~/.workflows
```

### Workflows reference wrong patterns file

**Problem:** Workflow references `.claude/CLAUDE.md` or can't find `PATTERNS.md`

**Solution:** You may be using an old version. Update:
```bash
cd ~/repos/gen-ai-dev-kit
git pull origin main
```

The workflows reference `PATTERNS.md` in the same directory, so as long as your symlink points to the workflows directory, the references will work correctly.

### Task folders created in wrong location

**Problem:** Workflows create `claude/` folders relative to where you invoke them

**Solution:** This is intentional. Always invoke workflows from your project root:
```bash
cd ~/my-project  # Your project root
execute ~/.workflows/requirements
# Creates: ~/my-project/claude/task-name/
```

### Want to use different symlink name

**Problem:** `~/.workflows` conflicts with something else, or you prefer a different name

**Solution:** Use any name you want - the workflows are flexible:
```bash
ln -s ~/repos/gen-ai-dev-kit/workflows ~/.my-workflows
execute ~/.my-workflows/requirements
```

The workflows will work correctly regardless of what you name the symlink. References to `PATTERNS.md` and next workflow steps are path-agnostic.

## Advanced Usage

### Using with Different Projects

Workflows are project-agnostic and create task folders in the current directory:

```bash
# Project A
cd ~/project-a
execute ~/.workflows/requirements
# Creates: ~/project-a/claude/task-name/

# Project B
cd ~/project-b
execute ~/.workflows/requirements
# Creates: ~/project-b/claude/task-name/
```

### Skipping Phases

You don't have to follow the full workflow sequence. You can:

```bash
# Skip straight to planning if you already know requirements
execute ~/.workflows/plan

# Or just use refinement to clean up existing code
execute ~/.workflows/refinement
```

### Reusing Interviews

Interview files are reusable. If you need to revisit a decision:

```bash
# Re-read the design interview
cat claude/2026-01-27-feature/DESIGN_INTERVIEW.md

# Make changes
# Then regenerate the design document manually or re-run workflow
```

## Integration with Claude Code

These workflows use standard Claude Code features:
- `execute` command (via the Skill tool)
- File reading/writing
- Interview pattern for bidirectional Q&A

No special plugins or extensions required.

## Contributing

To contribute improvements:

1. Fork the repository
2. Create a feature branch
3. Make your changes to `workflows/`
4. Test with `ln -s $(pwd)/workflows ~/.workflows-test`
5. Submit a pull request

## Resources

- [PATTERNS.md](./PATTERNS.md) - Complete pattern definitions
- [Workflow Files](.) - Individual workflow markdown files
- [Gen AI Dev Kit](../) - Parent repository

## License

[Your license here]

## Support

For issues or questions:
- Open an issue on GitHub
- Check [PATTERNS.md](./PATTERNS.md) for pattern documentation
- Review individual workflow files for specific guidance
