# Reusable Workflows Proposal (UPDATED)

## Problem Statement

You've invested significant time developing interview-based workflows (requirements, design, architecture, plan, implement, refinement). You want to:

1. **Reuse these workflows across all your projects** without copying them
2. **Store them in source control** in the `gen-ai-dev-kit` repository
3. **Use symbolic links** to make them accessible as `~/.workflows`
4. **Make changes once** and have them apply everywhere
5. **Avoid forcing your configuration on others** who use this repository
6. **Keep workflows self-contained** with relative paths so they work anywhere

## How Workflows Work

Workflows are simply markdown files that contain instructions. When you invoke:
```bash
execute ~/.workflows/requirements
```

Claude reads the file at `~/.workflows/requirements/workflow.md` (or `skill.md`) and follows the instructions within it.

**Key insight:** Workflows can be referenced from **any path**:
```bash
execute ~/.workflows/requirements
execute /absolute/path/to/workflow
execute ../relative/path/to/workflow
```

There's **no special installation mechanism** - workflows are just markdown files that Claude reads and executes.

## Recommended Approach: Source-Controlled Workflows with Symlinks

### Architecture

**Repository Structure:**
```
gen-ai-dev-kit/
├── template/                    # Original template (unchanged)
│   └── .claude/
│       ├── CLAUDE.md
│       └── skills/
├── workflows/                   # NEW: Reusable workflows
│   ├── README.md               # Usage instructions
│   ├── PATTERNS.md             # Shared patterns (Interview, Review Gate, etc.)
│   ├── requirements/
│   │   └── workflow.md
│   ├── design/
│   │   └── workflow.md
│   ├── architecture/
│   │   └── workflow.md
│   ├── plan/
│   │   └── workflow.md
│   ├── implement/
│   │   └── workflow.md
│   └── refinement/
│       └── workflow.md
├── claude/                      # Task folders (like this refinement task)
└── naive/                       # Example implementations
```

**User Installation:**
```bash
# Clone or pull the repository
cd ~/repos/gen-ai-dev-kit

# Create symlink to workflows
ln -s ~/repos/gen-ai-dev-kit/workflows ~/.workflows

# Use from any project
cd ~/my-project
execute ~/.workflows/requirements
```

### Benefits

✅ **Version Controlled** - Workflows are in git, track changes, collaborate
✅ **Single Source of Truth** - Update once in repo, applies everywhere via symlink
✅ **Self-Contained** - All workflow files use relative paths within `workflows/`
✅ **No Forced Configuration** - Others clone repo and create their own symlink
✅ **Flexible Installation** - Symlink can point anywhere (e.g., `~/.workflows`, `~/.my-workflows`)
✅ **Template Unchanged** - `template/` remains intact for other use cases

### How It Works

1. **Workflows live in source control** at `gen-ai-dev-kit/workflows/`
2. **User creates symlink** to `~/.workflows` (or any name they choose)
3. **Workflows reference patterns** using relative references to `PATTERNS.md` in the workflows directory
4. **Projects invoke workflows** with `execute ~/.workflows/requirements` (or whatever path they used for the symlink)
5. **Updates propagate** via git pull (symlink automatically points to updated files)
6. **Path-agnostic design** - workflows work regardless of symlink name or location

## File Naming Convention

**Workflows use `workflow.md` instead of `skill.md`** to distinguish them from Claude Code's built-in skill system.

```
workflows/
├── requirements/
│   └── workflow.md          # Not skill.md
├── design/
│   └── workflow.md
└── ...
```

Invocation remains the same:
```bash
execute ~/.workflows/requirements
# Claude looks for workflow.md (or skill.md for backwards compatibility)
```

## Path-Agnostic Design

All references within workflows are path-agnostic so they work regardless of installation location.

### Pattern References

**Within workflow files:**
```markdown
Follow the **Interview Pattern** defined in `PATTERNS.md` (in the same directory as this workflow).
```

This works regardless of what the user names their symlink. Whether they use `~/.workflows`, `~/.my-workflows`, or `~/.dev-workflows`, the reference to `PATTERNS.md` remains valid.

### Next Workflow References

**Within workflow files:**
```markdown
Requirements phase complete! Continue to the design workflow to begin design decisions.
```

Rather than hardcoding `execute ~/.workflows/design`, we use generic language. The user knows what command they used to start the current workflow and can adapt accordingly.

### Task Folder References

Workflows create task folders relative to the user's current working directory:

```markdown
Create `claude/${TASK_FOLDER}/REQUIREMENTS_INTERVIEW.md`
```

This path is relative to where the user invokes the workflow (their project directory), so it works correctly regardless of where workflows are installed.

## Terminology: Workflows vs Skills

To avoid confusion with Claude Code's "Skill" tool, we use "workflow" terminology:

- ✅ "Execute the requirements workflow"
- ✅ "Follow the workflow pattern"
- ✅ "workflow.md files"
- ❌ "Execute the requirements skill" (too confusing)

However, we keep references to the "Skill tool" when discussing Claude Code internals, since that's the official tool name.

## README.md Content

`workflows/README.md` will include:

1. **Overview** - What these workflows do, who they're for
2. **Installation** - How to create symlink: `ln -s <repo_location>/workflows ~/.workflows`
3. **Available Workflows** - List with descriptions:
   - `requirements` - Requirements discovery interview
   - `design` - Design decisions with recommendations
   - `architecture` - System architecture design
   - `plan` - Implementation planning
   - `implement` - Step-by-step execution
   - `refinement` - Refactoring and cleanup
4. **Usage Examples** - How to invoke: `execute ~/.workflows/requirements`
5. **Patterns** - Reference to PATTERNS.md
6. **Updates** - How to get updates via git pull
7. **Customization** - How to fork/customize workflows
8. **Troubleshooting** - Common issues (missing symlink, path errors)

## PATTERNS.md Structure

`workflows/PATTERNS.md` contains shared pattern definitions:

```markdown
# Workflow Patterns

## Interview Pattern
[Complete definition with structure, iteration cycle, 15→5 questions]

## Review Gate Pattern
[Complete definition]

## Iteration Pattern
[Complete definition]

## Status Tracking Convention
[Table format and usage]

## Document Templates
[Structures for REQUIREMENTS.md, DESIGN.md, etc.]
```

Each workflow references this file:
```markdown
**Follow the Interview Pattern** defined in `~/.workflows/PATTERNS.md`.
```

## Template Directory Strategy

The `template/` directory **remains unchanged**. It serves a different purpose:

- **template/** - Project template with local `.claude/` structure (for users who want embedded skills)
- **workflows/** - Global reusable workflows (for users who want central management)

Users can choose:
1. **Use workflows globally** - Symlink `~/.workflows`, reference globally
2. **Use template locally** - Copy `template/.claude/` into project
3. **Hybrid** - Use global workflows but have project-specific `.claude/CLAUDE.md`

Most users will prefer **option 1** (global workflows).

## Update Process

Since workflows are in source control:

```bash
# Get latest workflow updates
cd ~/repos/gen-ai-dev-kit
git pull origin main

# Symlink automatically points to updated files
execute ~/.workflows/requirements  # Uses latest version
```

No manual copying or syncing required.

## Multiple Installations (Advanced)

Users can maintain multiple workflow versions:

```bash
# Stable version
ln -s ~/repos/gen-ai-dev-kit/workflows ~/.workflows

# Experimental version
git clone https://github.com/you/gen-ai-dev-kit.git ~/experimental-workflows
ln -s ~/experimental-workflows/workflows ~/.workflows-experimental

# Use stable by default
execute ~/.workflows/requirements

# Use experimental when testing
execute ~/.workflows-experimental/requirements
```

## Migration Plan

### Step 1: Create Workflows Directory Structure

```bash
cd /home/phillipgivens/repos/gen-ai-dev-kit
mkdir -p workflows
mkdir -p workflows/requirements
mkdir -p workflows/design
mkdir -p workflows/architecture
mkdir -p workflows/plan
mkdir -p workflows/implement
mkdir -p workflows/refinement
```

### Step 2: Copy and Adapt Workflow Files

For each workflow in `template/.claude/skills/*`:
1. **Copy** to `workflows/[name]/workflow.md`
2. **Rename** "skill" → "workflow" in content
3. **Update** trigger: `execute .claude/skills/[name]` → `execute ~/.workflows/[name]`
4. **Update** pattern references: `.claude/CLAUDE.md` → `~/.workflows/PATTERNS.md`
5. **Verify** all paths are correct

Example:
```bash
# Copy requirements skill to workflows
cp template/.claude/skills/requirements/skill.md workflows/requirements/workflow.md

# Edit workflows/requirements/workflow.md:
# - Change "skill" to "workflow"
# - Update references to use ~/.workflows/
```

### Step 3: Extract PATTERNS.md

Create `workflows/PATTERNS.md` by copying these sections from `template/.claude/CLAUDE.md`:
- Interview Pattern
- Review Gate Pattern
- Iteration Pattern
- Status Tracking Convention
- Document Templates (interview files)

### Step 4: Create README.md

Create comprehensive `workflows/README.md` with:
- Overview of workflow system
- Installation instructions (symlinking)
- Available workflows with descriptions
- Usage examples
- Pattern references
- Update process
- Troubleshooting

### Step 5: Verify Self-Containment

Check that all workflows:
- Reference `~/.workflows/PATTERNS.md` (not `.claude/CLAUDE.md`)
- Use relative task folder paths (`claude/${TASK_FOLDER}/`)
- Have updated terminology (workflow not skill)
- Include correct trigger commands

### Step 6: Test Installation

```bash
# Create symlink
ln -s /home/phillipgivens/repos/gen-ai-dev-kit/workflows ~/.workflows

# Test invocation
execute ~/.workflows/requirements

# Verify it works
```

## Comparison: Template vs Workflows

### Template Approach (template/.claude/)
```
your-project/
├── .claude/
│   ├── CLAUDE.md               # Patterns + project instructions
│   └── skills/                  # Copied into each project
│       ├── requirements/
│       ├── design/
│       └── ...
└── claude/                      # Task folders
```

**Use case:** Users who want everything embedded in their project

### Workflows Approach (workflows/)
```
~/.workflows/ -> ~/repos/gen-ai-dev-kit/workflows/
├── PATTERNS.md                  # Shared patterns
├── README.md
├── requirements/workflow.md
├── design/workflow.md
└── ...

your-project/
├── .claude/                     # Optional: project-specific config
│   └── CLAUDE.md
└── claude/                      # Task folders
```

**Use case:** Users who want centralized, version-controlled workflows (recommended)

## Source Control Considerations

### .gitignore

No changes needed. The symlink `~/.workflows` is outside the repo and won't be committed.

Projects using workflows might add:
```gitignore
# User's workflow symlink (if they create it in project)
.workflows
```

### Collaboration

When others clone the repository:

```bash
# Clone the repo
git clone https://github.com/you/gen-ai-dev-kit.git
cd gen-ai-dev-kit

# Create their own symlink
ln -s $(pwd)/workflows ~/.workflows

# Start using workflows
execute ~/.workflows/requirements
```

Each person creates their own symlink. No conflicts.

### Customization

Users who want to customize workflows:

**Option 1: Fork the repo**
```bash
git clone https://github.com/you/gen-ai-dev-kit.git my-custom-workflows
cd my-custom-workflows
# Edit workflows/
git commit -m "Customize requirements workflow"
ln -s $(pwd)/workflows ~/.workflows
```

**Option 2: Create local overrides**
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

## Implementation Checklist

- [ ] Create `workflows/` directory structure
- [ ] Copy requirements workflow from template
- [ ] Copy design workflow from template
- [ ] Copy architecture workflow from template
- [ ] Copy plan workflow from template
- [ ] Copy implement workflow from template
- [ ] Copy refinement workflow from template
- [ ] Update all "skill" → "workflow" terminology
- [ ] Update all trigger references to `execute ~/.workflows/[name]`
- [ ] Update all pattern references to `~/.workflows/PATTERNS.md`
- [ ] Extract PATTERNS.md from template/.claude/CLAUDE.md
- [ ] Create comprehensive workflows/README.md
- [ ] Test symlink creation: `ln -s $(pwd)/workflows ~/.workflows`
- [ ] Test workflow invocation: `execute ~/.workflows/requirements`
- [ ] Verify all paths work correctly
- [ ] Verify task folders create in correct location
- [ ] Document in main repo README.md

## Success Criteria

✅ Workflows exist in `gen-ai-dev-kit/workflows/`
✅ All workflow files use `workflow.md` naming
✅ All references use "workflow" not "skill" terminology
✅ Pattern references are path-agnostic (reference `PATTERNS.md` in same directory)
✅ Next workflow references are generic (no hardcoded paths)
✅ PATTERNS.md contains all shared pattern definitions
✅ README.md has complete usage instructions
✅ Symlink installation works: `ln -s <repo>/workflows ~/.workflows`
✅ Invocation works: `execute ~/.workflows/requirements` (or any symlink name user chooses)
✅ Template directory unchanged
✅ All workflows work regardless of symlink name or location

## Next Steps

Ready to implement? I'll:

1. **Create** `workflows/` directory structure
2. **Copy and adapt** all 6 workflows from `template/.claude/skills/`
3. **Extract** PATTERNS.md from template/.claude/CLAUDE.md
4. **Create** comprehensive workflows/README.md
5. **Update** all terminology and references
6. **Verify** everything works with symlink

The `template/` directory will remain completely unchanged.

**Shall I proceed with implementation?**
