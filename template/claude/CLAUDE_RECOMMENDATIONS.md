# Recommendations for Optimizing Your Workflow

This document provides short, actionable recommendations for getting the most out of this Claude-driven development template.

## Making Skills Global

**When to promote skills from local to global:**
- After using successfully on 3+ projects
- When you find yourself copying the template just for the skills
- When the skills haven't changed across projects

**How to promote local skills to global:**

1. Copy skill directories from template to global location:
   ```bash
   cp -r .claude/skills/requirements ~/.claude/skills/
   cp -r .claude/skills/decisions ~/.claude/skills/
   # ... repeat for other skills
   ```

2. Update skill paths in each `skill.md` to be project-agnostic:
   - Keep `claude/MISSION.md` paths (assumes project has `claude/` directory)
   - Or make them flexible: "Read MISSION.md from project root or claude/ directory"

3. Consider creating a "project-init" global skill that:
   - Creates the `claude/` directory structure
   - Creates a template MISSION.md
   - Explains the workflow

**Trade-off:**
- Local skills: Travel with template, can be customized per project
- Global skills: Available everywhere, but changes affect all projects

**Recommendation:** Keep skills local in template for now. If you adopt this workflow across many projects, promote to global at that point.

## Git and Version Control

**What to commit:**
- ✅ `claude/MISSION.md` - Documents project intent
- ✅ `claude/REQUIREMENTS.md` - Requirements are valuable history
- ✅ `claude/DECISIONS.md` - Architectural decisions should be preserved
- ✅ `claude/DESIGN.md` - Design documentation is valuable
- ✅ `.claude/CLAUDE.md` - Project-specific Claude instructions
- ✅ `.claude/skills/` - Local skills travel with the project

**What to .gitignore:**
- ⚠️ `claude/GATHER_REQUIREMENTS.md` - Q&A is typically ephemeral
- ⚠️ `claude/IMPLEMENTATION_PLAN.md` - Plan may change often during work
- ⚠️ `claude/PLAN_ANALYSIS.md` - Analysis is ephemeral
- ✅ `.claude/activity.log` - Don't commit logs

**Sample .gitignore:**
```
# Claude workflow - ephemeral artifacts
claude/GATHER_REQUIREMENTS.md
claude/IMPLEMENTATION_PLAN.md
claude/PLAN_ANALYSIS.md
.claude/activity.log

# Keep these:
# claude/MISSION.md
# claude/REQUIREMENTS.md
# claude/DECISIONS.md
# claude/DESIGN.md
```

**Rationale:** Requirements, decisions, and design are documentation that future contributors (including future you) will value. Q&A and planning artifacts are useful during development but less valuable long-term.

## Writing a Good MISSION.md

**Be specific:**
- ❌ "Build a web app"
- ✅ "Build a REST API for managing GitLab project metadata, syncing it to local git repositories"

**Include context Claude needs:**
- Why you're building this
- Who will use it
- What problem it solves
- Any constraints (time, technology, etc.)

**Template:**
```markdown
# Mission: [Short Project Name]

## Goal
[1-2 sentences: what you're building]

## Context
- **Problem**: [What problem does this solve?]
- **Users**: [Who will use this?]
- **Constraints**: [Any technical, time, or resource constraints]

## Success Criteria
- [ ] [Specific, measurable outcome 1]
- [ ] [Specific, measurable outcome 2]
- [ ] [Specific, measurable outcome 3]

## Background
[Any additional context Claude should know]
```

**Example:**
```markdown
# Mission: GitLab Sync Tool

## Goal
Build a Python CLI tool that syncs GitLab projects to local git repositories with metadata management.

## Context
- **Problem**: Need to mirror multiple GitLab projects locally for backup and offline access
- **Users**: DevOps engineers managing multiple GitLab instances
- **Constraints**: Must work offline after initial sync, Python 3.8+

## Success Criteria
- [ ] Can sync all projects from a GitLab group to local directories
- [ ] Stores and updates metadata (issues, MRs, comments)
- [ ] Handles incremental updates efficiently
- [ ] Works offline after initial sync

## Background
Currently using manual git clone commands. Need automation with proper error handling and resume capability.
```

## Team Usage

**For solo developers:**
- Follow the workflow as documented
- Keep conversations with Claude ongoing within each phase

**For team collaboration:**
1. **One person drives each phase** with Claude, others review artifacts
2. **Review gates become team reviews** (share REQUIREMENTS.md for feedback)
3. **Decisions.md becomes team decision log** (document who decided what and why)
4. **Design.md is the team's shared understanding** of architecture

**Team tips:**
- Use PR comments to discuss artifacts (REQUIREMENTS.md, DESIGN.md, etc.)
- Link to specific decisions in DECISIONS.md when explaining code
- Update artifacts when requirements or design change (keep them current)
- Consider separate MISSION.md for each feature branch

## Workflow Variations

**For small features/bug fixes:**
- Skip to `/plan` if requirements and design are obvious
- Create minimal REQUIREMENTS.md manually
- Run `/plan` and `/implement`

**For exploratory work:**
- Start with a rough MISSION.md
- After `/requirements`, you may discover the real problem
- OK to go back and revise MISSION.md and restart

**For maintenance/refactoring:**
- Create MISSION.md describing what you're refactoring and why
- `/requirements` focuses on what the refactored code should do
- `/decisions` focuses on new patterns/approaches
- Use `/architecture` to document target architecture

## Measuring Success

Track these metrics after using this workflow on 2-3 projects:

1. **Rework rate**: How often do you have to redo work due to requirements changes?
2. **Design issues**: How many design problems appear during implementation?
3. **Documentation quality**: Do you have clear docs for what was built?
4. **Time to completion**: Does planning upfront save time overall?

If the workflow isn't helping, adjust:
- Spending too long in planning? Make phases shorter/lighter
- Too many design issues in implementation? Spend more time in Phase 3
- Requirements keep changing? Invest more in Phase 1 Q&A

## Common Mistakes

**Mistake 1: Skipping requirements**
- Symptom: Discover mid-implementation that you're building the wrong thing
- Fix: Invest time in Phase 1, even for "obvious" features

**Mistake 2: Not reviewing artifacts**
- Symptom: Errors compound, implementation goes wrong direction
- Fix: Actually read what Claude produces. Give feedback.

**Mistake 3: Adding scope during implementation**
- Symptom: Implementation takes 3x longer than planned
- Fix: Note new ideas in a separate file. Stay focused on current requirements.

**Mistake 4: Starting new conversations unnecessarily**
- Symptom: Claude keeps asking to re-read files, loses context
- Fix: Stay in one conversation per phase

**Mistake 5: Not updating artifacts when things change**
- Symptom: Documentation doesn't match reality
- Fix: When requirements or design change, update the artifacts

## Questions?

This template is designed to evolve. As you use it:
- Note what works and what doesn't
- Adjust the skills to fit your style
- Update this file with your own recommendations

The goal is a workflow that helps YOU think clearly and build better software.
