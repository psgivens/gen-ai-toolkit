# Workflow Enhancements Backlog

This document tracks potential enhancements to the Claude-driven development workflow. Items here are candidates for future versions based on actual usage patterns and pain points.

## Version 1.0 (Current)

**Included:**
- ✅ Five phase skills: `/requirements`, `/decisions`, `/architecture`, `/plan`, `/implement`
- ✅ Review gate pattern at each phase
- ✅ Self-contained template documentation
- ✅ Template-local skills

## Version 1.1 (Utility Skills)

Consider adding these utility skills after using v1.0 on 2-3 projects:

### `/iterate`
**Purpose:** Continue refining current artifact without re-running entire phase

**Value proposition:** Avoids re-running `/requirements` or `/decisions` just to tweak one section. Maintains context and makes quick updates.

**How it works:**
- Detects most recently modified artifact in `claude/`
- Prompts: "What would you like to change in [artifact]?"
- Makes updates iteratively
- Continues until you say "done"

**When to add:** If you frequently need to make small tweaks to artifacts after phases complete.

### `/status`
**Purpose:** Show current phase and progress

**Value proposition:** Quick orientation when returning to a project after time away. Shows what's been completed and what's next.

**How it works:**
- Scans `claude/` directory for existing artifacts
- Determines current phase based on what exists
- Shows completed artifacts
- Suggests next skill to run
- Shows last modification times

**When to add:** If you work on multiple projects or take breaks between phases.

### `/validate`
**Purpose:** Check consistency across all artifacts

**Value proposition:** Catches gaps and conflicts before they become implementation problems. Safety net for complex projects.

**How it works:**
- Reads all artifacts (REQUIREMENTS, DECISIONS, DESIGN, PLAN)
- Cross-references for consistency
- Identifies gaps, conflicts, ambiguities
- Suggests specific fixes
- Does NOT automatically fix (waits for approval)

**When to add:** If you find yourself manually checking consistency or discovering conflicts during implementation.

### `/reset [phase]`
**Purpose:** Start a specific phase over from scratch

**Value proposition:** Clean slate when you need to change direction significantly without manually deleting files.

**How it works:**
- Archives existing artifacts to `claude/.backups/[timestamp]/`
- Deletes artifacts for specified phase and all downstream phases
- Prompts to confirm before deleting
- Restarts from that phase

**When to add:** If requirements frequently change mid-project requiring restarts.

## Version 1.5 (Process Enhancements)

Workflow improvements based on real usage feedback:

### Roadmap/Backlog Workflow
**Purpose:** Break down product roadmap or backlog into manageable tasks before starting requirements

**Value proposition:** Prevents scope creep and overcommitment. Helps prioritize multiple features and plan execution sequence.

**How it works:**
- Create `claude/roadmap/` folder for tracking
- Conduct interview about all features in backlog
- Generate ROADMAP.md with feature breakdown, priorities, dependencies
- Recommend implementation sequence (Phase 1, 2, 3...)
- Suggest which feature to start with
- Track feature completion status

**When to add:** If you work on projects with multiple features or maintain a product backlog.

**Reference:** See SUGGESTIONS.md suggestion #6

### Scope Breakdown Recommendations
**Purpose:** Detect large scope early and recommend breaking down work into smaller features

**Value proposition:** Prevents "biting off more than you can chew". Ships working software faster through incremental delivery.

**How it works:**
- After reading MISSION.md in requirements workflow, assess scope
- If Large/Very Large (15+ requirements, 20+ implementation steps), prompt for breakdown
- Suggest 2-5 smaller features with priorities and sizes
- Update MISSION.md to focus on Phase 1 only
- Create FUTURE_PHASES.md documenting later phases
- Guide user through Phase 1 before starting Phase 2

**When to add:** If you frequently start projects that feel overwhelming or never get completed.

**Reference:** See SUGGESTIONS.md suggestion #7

### Explicit Testing Guidance ("Ralph Wiggum Loop")
**Purpose:** Integrate continuous testing throughout workflows instead of treating testing as separate phase

**Value proposition:** Catches issues early when they're easier to fix. Never mark steps complete with failing tests.

**How it works:**
- Add Testing Convention section to PATTERNS.md
- Requirements phase: Capture test scenarios and edge cases
- Design phase: Choose testing frameworks and approach
- Architecture phase: Design for testability
- Planning phase: Include test creation as explicit steps with "implement → test → verify → next" sequence
- Implementation phase: Enforce "never mark complete with failing tests" rule

**Testing step structure in implementation plans:**
```
### Step N: Test [Feature]
**What:** Create tests for [functionality]
**Files:** test files to create
**Test Cases:** specific scenarios
**Verification:** All tests pass with [command]
```

**When to add:** If you ship bugs or discover test gaps during implementation.

**Reference:** See SUGGESTIONS.md suggestion #5

## Version 2.0 (Composite Skills)

Combine related operations for specific workflows:

### `/quickplan`
**Purpose:** Fast-track from requirements to plan for simple features

**Value proposition:** Skips separate decision and architecture phases when the approach is obvious.

**How it works:**
- Reads REQUIREMENTS.md
- Creates minimal DECISIONS.md with obvious choices
- Creates lightweight DESIGN.md
- Goes straight to implementation plan
- Best for small features with clear implementation path

### `/review [phase]`
**Purpose:** Review and validate a specific phase without re-running it

**Value proposition:** Spot-check a phase's artifacts for quality or consistency without full re-execution.

**How it works:**
- Reads specified phase's artifacts
- Checks against prior phases for consistency
- Identifies improvements or gaps
- Suggests updates but doesn't make them

### `/plan-validate`
**Purpose:** Combine planning and validation into one step

**Value proposition:** Automatically validates plan as part of `/plan` instead of separate step.

**How it works:**
- Creates implementation plan
- Immediately analyzes it
- Updates plan based on analysis
- Presents final plan for review

## Version 3.0 (Advanced Features)

More sophisticated enhancements for teams or complex projects:

### Branching Workflows
**Purpose:** Support feature branches with separate workflows

**Value proposition:** Each feature branch maintains its own requirements/design/plan.

**Implementation:**
- Store artifacts in `claude/branches/[branch-name]/`
- Switch context based on git branch
- Merge artifacts when merging branches

### Progress Dashboard
**Purpose:** Visual overview of all workflow phases

**Value proposition:** At-a-glance understanding of project status.

**Implementation:**
- Generate HTML dashboard showing:
  - Phase completion status
  - Last modified times
  - Validation results
  - Outstanding issues
- Update automatically via hooks

### Version Control Integration
**Purpose:** Automatic git commits at phase boundaries

**Value proposition:** Natural checkpoint creation with meaningful commit messages.

**Implementation:**
- Hook that runs after each phase completion
- Commits artifacts with descriptive message
- Tags major milestones (e.g., "requirements-approved")

### Team Collaboration Features
**Purpose:** Multi-user coordination on same workflow

**Value proposition:** Clear ownership and review assignments.

**Implementation:**
- Ownership tracking in artifacts (who created, who reviewed)
- Review request system (mark for team review)
- Approval tracking (which team members approved)

### Metrics and Analytics
**Purpose:** Track workflow effectiveness over time

**Value proposition:** Data-driven improvements to your process.

**Metrics to track:**
- Time spent in each phase
- Number of iterations per phase
- Requirements volatility (changes after approval)
- Issues discovered per phase
- Rework rate (going back to earlier phases)

## Other Ideas

### Documentation Generation
Auto-generate traditional docs from workflow artifacts:
- Convert REQUIREMENTS.md → User Stories
- Convert DESIGN.md → Architecture Doc
- Convert DECISIONS.md → ADR (Architecture Decision Records)

### Template Variants
Specialized templates for different project types:
- Web API projects
- CLI tools
- Data processing pipelines
- Frontend applications
- Library/SDK development

### AI-Assisted Estimation
Skill that estimates implementation time based on requirements and plan:
- Analyzes complexity
- Considers dependencies
- Suggests realistic timeline
- Tracks actual vs. estimated time

### Interactive Tutorials
Built-in tutorials for learning the workflow:
- Sample MISSION.md files
- Example projects to walk through
- Common patterns and anti-patterns

### Integration with Project Management
Sync with external tools:
- Create Jira issues from requirements
- Update Confluence pages from design
- Link GitHub issues to workflow phases

## How to Propose New Features

If you have ideas for workflow enhancements:

1. **Use the workflow first** - Understand current pain points
2. **Document the problem** - What specific issue does this solve?
3. **Estimate value** - How much time/effort would this save?
4. **Consider alternatives** - Could existing skills be adjusted instead?
5. **Prototype locally** - Test the idea in your own projects
6. **Share feedback** - Document what worked and what didn't

## Prioritization Criteria

When deciding what to build next:

1. **Frequency of pain** - How often does this problem occur?
2. **Severity of pain** - How much does it disrupt the workflow?
3. **Generality** - Does this help most users or just specific cases?
4. **Complexity** - How hard is it to implement?
5. **Maintenance** - How much ongoing maintenance will this require?

**Priority: High value + Low complexity**

Start with utility skills that solve frequent, simple problems before tackling complex integrations.

## Anti-Features

Things we intentionally won't build:

❌ **Full automation without review gates** - Human oversight is a core principle
❌ **AI-makes-all-decisions mode** - Defeats the purpose of intentional design
❌ **Skip phase options** - Phases exist for good reasons
❌ **Auto-accept artifacts** - Review is essential for quality

The goal is to enhance the workflow while preserving its core value: thoughtful, human-guided development with AI assistance.
