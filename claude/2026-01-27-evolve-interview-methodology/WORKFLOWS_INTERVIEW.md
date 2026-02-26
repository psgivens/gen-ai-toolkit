# Workflows Creation Interview

## Interview Round 1

### Question 1: Workflow Location and Structure

You mentioned putting workflows in `gen-ai-dev-kit/workflows/`. Should the structure be:

**Option A:**
```
gen-ai-dev-kit/
├── workflows/
│   ├── README.md
│   ├── PATTERNS.md
│   ├── requirements/
│   │   └── workflow.md
│   ├── design/
│   │   └── workflow.md
│   └── ...
```

**Option B:**
```
gen-ai-dev-kit/
├── workflows/
│   ├── README.md
│   ├── PATTERNS.md
│   ├── requirements.md
│   ├── design.md
│   └── ...
```

Option A keeps the folder structure (workflows have subdirectories), Option B flattens it (workflows are single files).

**Your Answer:**


**Your Questions for Claude:**


---

### Question 2: File Naming Convention

Currently skills use `skill.md` as the filename. For workflows, should we use:
- `workflow.md` (e.g., `requirements/workflow.md`)
- Keep `skill.md` for backwards compatibility
- Something else (e.g., `index.md`, `README.md`)

If using subdirectories (Option A from Q1), the user would invoke:
- `execute ~/.workflows/requirements` (Claude looks for `workflow.md` or `skill.md` by default)

**Your Answer:**


**Your Questions for Claude:**


---

### Question 3: PATTERNS.md Scope and Location

The PATTERNS.md file should define:
- Interview Pattern
- Review Gate Pattern
- Iteration Pattern
- Status Tracking Convention
- Document Templates

Should PATTERNS.md be:
1. **Standalone** in `workflows/PATTERNS.md` (workflows reference `~/.workflows/PATTERNS.md`)
2. **Embedded in each workflow** (copy pattern definitions into each workflow file for true self-containment)
3. **Both** (PATTERNS.md exists, but workflows also include a summary)

**Your Answer:**


**Your Questions for Claude:**


---

### Question 4: Relative Path Strategy

You said "all file references should be relative so they can live anywhere on the filesystem."

When a workflow needs to reference PATTERNS.md, should it use:
- `../PATTERNS.md` (relative to workflow location)
- `~/.workflows/PATTERNS.md` (assumes standard installation)
- `${WORKFLOWS_HOME}/PATTERNS.md` (environment variable)
- Something else?

Note: The challenge is that workflows don't know where they're stored unless we make assumptions.

**Your Answer:**


**Your Questions for Claude:**


---

### Question 5: Invocation Command

Users will invoke workflows with:
```bash
execute ~/.workflows/requirements
```

Should the README.md also mention alternatives like:
- `execute ~/path/to/gen-ai-dev-kit/workflows/requirements` (before symlinking)
- Environment variable: `export WORKFLOWS_HOME=~/.workflows`
- Shell aliases (e.g., `alias wreq='execute ~/.workflows/requirements'`)

**Your Answer:**


**Your Questions for Claude:**


---

### Question 6: Task Folder Creation

Currently workflows create task folders at `claude/${TASK_FOLDER}/`. This is relative to where the user invokes the workflow (their project directory).

Should this remain `claude/` or change to something else?
- Keep `claude/` (consistent with template approach)
- Change to `workflows/` (could be confusing with workflow files)
- Make it configurable somehow
- Use `.workflows/` or `.work/`

**Your Answer:**


**Your Questions for Claude:**


---

### Question 7: README.md Content Depth

The `workflows/README.md` should explain:
1. What these workflows do (overview)
2. How to symlink: `ln -s <repo_location>/workflows ~/.workflows`
3. How to invoke: `execute ~/.workflows/requirements`
4. Available workflows (list with descriptions)

Should it also include:
- Full interview pattern explanation?
- Examples of a complete workflow run?
- Troubleshooting section?
- Contribution guidelines (if this becomes shared)?

**Your Answer:**


**Your Questions for Claude:**


---

### Question 8: Terminology Consistency

You want to use "workflows" instead of "skills" to avoid confusion. Should we:

1. **Rename all references** in the markdown files?
   - "When user invokes `execute .claude/skills/requirements`" → "When user invokes `execute ~/.workflows/requirements`"
   - "skill.md" → "workflow.md"
   - "Phase 1: Requirements Discovery Skill" → "Phase 1: Requirements Discovery Workflow"

2. **Keep some "skill" references** where they refer to Claude's Skill tool?
   - The tool is still called "Skill" in Claude Code

**Your Answer:**


**Your Questions for Claude:**


---

### Question 9: Self-Contained vs. Dependent

You said "self-contained workflows." Does this mean:

1. **No external dependencies** - Each workflow file contains everything needed (patterns, examples, full instructions)
2. **Minimal dependencies** - Workflows can reference PATTERNS.md but nothing else
3. **Contained within workflows/** - Workflows can reference other files in `workflows/` but nothing outside

**Your Answer:**


**Your Questions for Claude:**


---

### Question 10: Template Directory

After creating `workflows/`, what should happen to `template/`?

1. **Leave it unchanged** - It remains as a project template with its own `.claude/` structure
2. **Update template/.claude/CLAUDE.md** to reference `~/.workflows/` instead of local skills
3. **Create two templates**: one for local skills, one for global workflows
4. **Archive template/** - Mark it as deprecated

**Your Answer:**


**Your Questions for Claude:**


---

### Question 11: Version Control and Updates

Since `workflows/` will be in source control, how should users handle updates?

1. **Git pull** - Users git pull the repo, symlink updates automatically
2. **No special handling** - Symlink means updates are automatic
3. **Document update process** in README.md
4. **Provide update script** (e.g., `workflows/update.sh`)

**Your Answer:**


**Your Questions for Claude:**


---

### Question 12: Multiple Installations

If a user wants different workflow versions for different purposes (e.g., `~/.workflows-stable` and `~/.workflows-experimental`), should we:

1. **Support multiple installations** - Document how to use different symlink names
2. **Single installation only** - Keep it simple
3. **Environment variable override** - `WORKFLOWS_HOME` can point anywhere

**Your Answer:**


**Your Questions for Claude:**


---

### Question 13: Project-Specific Overrides

Should a project be able to override a global workflow with a local version?

Example: User has `~/.workflows/requirements` but wants custom requirements workflow for a specific project.

1. **No overrides** - Global workflows only
2. **Local takes precedence** - If `.workflows/requirements` exists locally, use it
3. **Explicit override** - User must explicitly invoke the local version
4. **Don't support** - Keep it simple, global only

**Your Answer:**


**Your Questions for Claude:**


---

### Question 14: Error Handling for Missing Symlink

What should happen if a user tries `execute ~/.workflows/requirements` but hasn't created the symlink yet?

Should README.md include:
1. **Error message explanation** - "If you see 'file not found', create symlink with..."
2. **Detection script** - Small script that checks if symlink exists
3. **Fallback instructions** - "Or use absolute path: `execute ~/path/to/gen-ai-dev-kit/workflows/requirements`"

**Your Answer:**


**Your Questions for Claude:**


---

### Question 15: Workflow Metadata

Should each workflow file include metadata at the top like:

```markdown
---
name: Requirements Discovery
version: 1.0.0
author: Your Name
last_updated: 2026-01-27
compatible_with: claude-code v1.x
---
```

This could help with:
- Version tracking
- Compatibility notes
- Documentation

**Your Answer:**


**Your Questions for Claude:**


---

## Next Steps

Once you've answered these questions and I've addressed your questions, I'll:

1. Create the `workflows/` directory structure
2. Copy and adapt all skill files from `template/.claude/skills/`
3. Update all references from "skill" to "workflow" and from `.claude/` to `~/.workflows/`
4. Create `workflows/PATTERNS.md` with pattern definitions
5. Create comprehensive `workflows/README.md` with usage instructions
6. Ensure all paths are relative or use `~/.workflows/` convention

**What would you like to do?**
- Type "iterate" when you've answered the questions and want me to proceed
- Ask any clarifying questions you have
