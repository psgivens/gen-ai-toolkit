# Proposed Changes to Implement CLAUDE_PREP.md

This document proposes specific changes to the workflows to incorporate the codebase optimization principles from `claude/CLAUDE_PREP.md`.

## Overview

CLAUDE_PREP.md emphasizes creating focused, high-value documentation that helps Claude navigate codebases efficiently:
- ARCHITECTURE.md as single source of truth
- Project-specific CLAUDE.md for development guidelines
- ADRs for significant decisions
- Component guides for complex subsystems
- Directory READMEs for quick orientation
- **Avoid** over-documentation and auto-generated noise

## Proposed Changes

### 1. Enhance ARCHITECTURE_TEMPLATE.md ⭐ HIGH PRIORITY

**File:** `workflows/templates/ARCHITECTURE_TEMPLATE.md`

**Changes:**
- Align template structure with CLAUDE_PREP.md recommendations
- Add "Entry Points" section (currently missing)
- Add "Common Operations" section for frequent tasks
- Simplify some overly verbose sections
- Add more practical examples

**Rationale:** ARCHITECTURE.md is "the single most valuable document" per CLAUDE_PREP.md. Our template should reflect best practices.

**Specific additions:**
```markdown
## Entry Points
- `[main.go/index.ts/etc]` - Application entry point
- `[key orchestration file]` - Where components are wired together
- `[plugin/extension system]` - Extensibility entry point

## Common Operations

### [Operation 1: e.g., "Adding a new API endpoint"]
1. Create route in `[location]`
2. Implement handler in `[location]`
3. Add validation in `[location]`
4. Write tests in `[location]`

### [Operation 2: e.g., "Adding a new database table"]
1. Create migration in `[location]`
2. Update models in `[location]`
3. Add repository methods in `[location]`
```

**Impact:** Makes architecture documents immediately actionable for common tasks.

---

### 2. Create Project-Specific CLAUDE.md Template ⭐ HIGH PRIORITY

**New File:** `workflows/templates/CLAUDE_PROJECT_TEMPLATE.md`

**Purpose:** Template for project-specific development guidelines (separate from global ~/.claude/CLAUDE.md)

**Content:**
```markdown
# Project Development Guide

> This document contains project-specific guidelines for AI-assisted development.
> It complements the global ~/.claude/CLAUDE.md with repository-specific context.

## Quick Start

### Build & Test Commands
```bash
# Install dependencies
[command]

# Run tests
[command]

# Build
[command]

# Run locally
[command]
```

## Development Workflow

### Before Starting Work
1. [Project-specific setup steps]
2. [Environment requirements]

### Making Changes
1. [Branching strategy]
2. [Commit message format]
3. [Testing requirements]

## Key Patterns

### Pattern 1: [Name]
**When to use:** [Context]
**Implementation:** [How to implement]
**Example:** [Code example or file reference]

### Pattern 2: [Name]
[Same structure]

## Common Gotchas

### Gotcha 1: [Description]
**Problem:** [What goes wrong]
**Solution:** [How to fix it]
**Prevention:** [How to avoid it]

### Gotcha 2: [Description]
[Same structure]

## Integration Points

### [External System 1]
**Purpose:** [Why we integrate with this]
**Location:** [Where integration code lives]
**Authentication:** [How auth works]
**Common Issues:** [Known problems and solutions]

## Testing Guidelines

### What to Test
- [Requirement 1]
- [Requirement 2]

### What NOT to Test
- [Anti-pattern 1]
- [Anti-pattern 2]

### Test Organization
- Unit tests: [Location and pattern]
- Integration tests: [Location and pattern]
- E2E tests: [Location and pattern]

## Code Review Checklist

- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] [Project-specific check 1]
- [ ] [Project-specific check 2]

## Learnings & Evolution

### [Date]: [Learning Title]
[What we learned and how it changes our approach]

### [Date]: [Pattern Change]
[What changed and why]

## Related Documentation

- [Link to ARCHITECTURE.md]
- [Link to component guides]
- [Link to ADRs]
- [External documentation]
```

**Usage:** Created by documentation workflow or codebase-prep workflow

**Impact:** Reduces repetitive explanations of project-specific patterns

---

### 3. Create ADR Template and Integrate into Design Workflow ⭐ HIGH PRIORITY

**New File:** `workflows/templates/ADR_TEMPLATE.md`

**Content:**
```markdown
# ADR [NUMBER]: [TITLE]

**Status:** [Proposed | Accepted | Deprecated | Superseded]
**Date:** [YYYY-MM-DD]
**Deciders:** [Who made this decision]

## Context

[What is the issue we're trying to solve? Include relevant technical, business, and project context.]

## Decision

[What is the change we're actually making? Be specific and concrete.]

## Rationale

[Why did we choose this option? What factors influenced the decision?]

## Consequences

### Positive
- [Good consequence 1]
- [Good consequence 2]

### Negative
- [Bad consequence 1]
- [Bad consequence 2]

### Neutral
- [Neutral consequence 1]

## Alternatives Considered

### Alternative 1: [Name]
**Pros:**
- [Pro 1]

**Cons:**
- [Con 1]

**Why rejected:** [Reason]

### Alternative 2: [Name]
[Same structure]

## Implementation Notes

[Any specific guidance for implementing this decision]

## References

- [Link to related discussions]
- [Link to documentation]
- [Link to prototypes or experiments]

---

## Update History

- [YYYY-MM-DD]: Status changed to [Status] - [Reason]
```

**Integration Point:** Update `workflows/design/workflow.md`

**Add to Step 3** (after updating living architecture):

```markdown
### Step 3b: Create ADR for Significant Decisions

If this design phase involved a significant architectural decision:

**What qualifies as "significant":**
- Changes that are hard to reverse later
- Choices between fundamentally different approaches
- Decisions that impact multiple components
- Trade-offs with long-term implications
- Technology selections (databases, frameworks, major libraries)

**Examples:**
- Choosing REST vs GraphQL
- Selecting state management approach
- Database selection
- Authentication strategy
- Microservices vs monolith
- Event-driven vs request-response

**Prompt:**
```
This design involved a significant decision about [topic].

Would you like me to create an ADR (Architecture Decision Record)?
- Type 'yes' to create docs/adrs/[number]-[title].md
- Type 'no' to skip
```

If yes:
1. Create `docs/adrs/` directory if it doesn't exist
2. Determine next ADR number (check existing ADRs)
3. Use ADR_TEMPLATE.md to create the record
4. Include decision context from DESIGN_INTERVIEW.md
5. Document alternatives considered and why they were rejected
6. Reference relevant design tenets from MISSION.md
```

**Impact:** Captures "why" behind significant decisions for future reference

---

### 4. Enhance Documentation Workflow ⭐ HIGH PRIORITY

**File:** `workflows/documentation/workflow.md`

**Add after Step 1** (Read Context):

```markdown
### Step 1b: Assess Documentation Scope

Determine what type of documentation is needed:

**For new features/projects:**
- User-facing documentation (README, user guides, API docs)
- Developer documentation (covered by architecture workflow)

**For existing codebases (codebase optimization):**
- ARCHITECTURE.md (if missing)
- Project-specific CLAUDE.md
- Component guides for complex subsystems
- Directory READMEs
- Entry points documentation

**Prompt:**
```
What type of documentation should I create?

For a **new feature/project**:
- Type 'user' - Create user-facing documentation (README, guides, API docs)

For an **existing codebase** (making it easier to navigate):
- Type 'codebase' - Create developer navigation documentation (ARCHITECTURE, guides, READMEs)

Your choice: [user/codebase]
```

If 'codebase' is chosen, follow the Codebase Prep pattern (see below).
```

**Add new section after Step 2:**

```markdown
### Step 2-Codebase: Generate Codebase Optimization Plan

When user chooses 'codebase' documentation type, create navigation/orientation documentation following CLAUDE_PREP.md principles.

**Priority order (from CLAUDE_PREP.md):**

**If 1 hour available:**
1. ARCHITECTURE.md (30 min)
2. Directory READMEs (30 min)

**If 4 hours available:**
1. ARCHITECTURE.md (45 min)
2. Document most complex subsystem (60 min)
3. Create ADRs for major past decisions (90 min)
4. Directory READMEs (45 min)

**Create codebase optimization plan:**

```markdown
# Codebase Documentation Plan

## Current State Assessment

### Existing Documentation
- [List what exists: README.md, docs/, etc.]
- [Note what's missing or outdated]

### Codebase Characteristics
- **Size:** [Lines of code, number of files]
- **Complexity:** [Simple/Moderate/Complex]
- **Age:** [New/Established/Legacy]
- **Most Complex Areas:** [Subsystems that need guides]

## Documentation Priority

### Phase 1: Essential (1 hour)
- [ ] Create/update ARCHITECTURE.md at project root
- [ ] Add README.md to [N] major directories

### Phase 2: High-Value (3 more hours)
- [ ] Create component guide for [complex subsystem 1]
- [ ] Create component guide for [complex subsystem 2]
- [ ] Create ADRs for [N] major architectural decisions
- [ ] Create project-specific CLAUDE.md

### Phase 3: Nice-to-Have (if time allows)
- [ ] Additional directory READMEs
- [ ] Update outdated documentation
- [ ] Create examples/tutorials

## Documentation Items

### 1. ARCHITECTURE.md
**Location:** Project root
**Purpose:** Single source of truth for system design
**Template:** workflows/templates/ARCHITECTURE_TEMPLATE.md
**Key sections to focus on:**
- Directory structure with descriptions
- Entry points
- Key patterns
- Common operations

### 2. [Complex Subsystem] Guide
**Location:** docs/[SUBSYSTEM]_GUIDE.md
**Purpose:** Deep dive on [subsystem name]
**Why this subsystem:** [Explain complexity - e.g., plugin system, state management, etc.]
**Template:** Component Guide Template (see CLAUDE_PREP.md)

### 3. Directory READMEs
**Locations:**
- [directory 1]/README.md
- [directory 2]/README.md
**Purpose:** Quick orientation to directory contents
**Template:** Directory README Template (see CLAUDE_PREP.md)

### 4. Project-Specific CLAUDE.md
**Location:** Project root or docs/
**Purpose:** Development guidelines and learnings
**Template:** workflows/templates/CLAUDE_PROJECT_TEMPLATE.md
**Focus on:**
- Build/test commands
- Common patterns
- Gotchas and solutions
- Integration points

## Status Tracking

| Item | Status | Notes |
|------|--------|-------|
| 1. ARCHITECTURE.md | Not Started | |
| 2. [Subsystem] guide | Not Started | |
| 3. Directory READMEs | Not Started | |
| 4. CLAUDE.md | Not Started | |
```

**Then proceed with Step 5 (Generate Documentation) but adapted for codebase docs.**
```

**Impact:** Documentation workflow can now handle both user-facing docs AND codebase optimization

---

### 5. Create New "Codebase Prep" Workflow (Optional) ⭐ MEDIUM PRIORITY

**New File:** `workflows/codebase-prep/workflow.md`

**Purpose:** Dedicated workflow for optimizing existing codebases for Claude Code navigation

**When to use:** When taking over an existing codebase that lacks navigation documentation

**Content:**

```markdown
# Codebase Preparation Workflow

## Description
Optimize an existing codebase for efficient Claude Code navigation by creating focused, high-value documentation.

Based on principles from claude/CLAUDE_PREP.md.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/codebase-prep`) or says "prepare codebase for Claude" or "optimize codebase documentation"

## Instructions

This workflow helps you create the right amount of documentation to make a codebase easy to navigate without over-documenting.

### Step 1: Analyze Codebase

**Scan the repository to understand:**
1. **Size and complexity:**
   - Use `find . -name "*.js" -o -name "*.py" -o -name "*.go" | wc -l` to count files
   - Use Glob to identify major directories
   - Look for complex subsystems (e.g., plugin systems, state management, API layers)

2. **Existing documentation:**
   - Check for README.md, docs/, ARCHITECTURE.md
   - Assess quality and completeness
   - Identify gaps

3. **Technology stack:**
   - Identify languages, frameworks, databases
   - Find build/test tools
   - Locate configuration files

**Create assessment document:** `docs/CODEBASE_ASSESSMENT.md`

```markdown
# Codebase Assessment

## Size & Complexity
- **Languages:** [List]
- **File count:** [Number]
- **Major directories:** [List with line counts]
- **Complexity rating:** [Simple/Moderate/Complex/Very Complex]

## Existing Documentation
- README.md: [Exists? Quality?]
- docs/: [What exists?]
- ARCHITECTURE.md: [Exists? Quality?]
- Code comments: [Quality assessment]
- **Gaps:** [What's missing?]

## Technology Stack
- **Frontend:** [Framework, libraries]
- **Backend:** [Framework, libraries]
- **Database:** [Type, ORM]
- **Testing:** [Framework, coverage]
- **Build:** [Tools]

## Complex Subsystems

### [Subsystem 1: e.g., "Plugin System"]
**Location:** [Directory]
**Complexity:** [High/Medium/Low]
**Current documentation:** [Exists/Missing]
**Needs guide:** [Yes/No - why?]

### [Subsystem 2: e.g., "State Management"]
[Same structure]

## Entry Points
- Main: [File path]
- CLI: [File path if applicable]
- API: [File path if applicable]
- Key orchestration: [File path]

## Recommendations

**Priority 1 (1 hour):**
- [ ] [Specific recommendation]

**Priority 2 (3 hours):**
- [ ] [Specific recommendation]

**Priority 3 (Optional):**
- [ ] [Specific recommendation]
```

### Step 2: Propose Documentation Plan

Based on assessment, propose a prioritized plan:

**Prompt:**
```
I've assessed the codebase and created docs/CODEBASE_ASSESSMENT.md.

How much time do you have for documentation?
- Type '1' for 1-hour quick prep (essential only)
- Type '4' for 4-hour thorough prep (recommended)
- Type 'custom' to discuss specific needs
```

**Based on time available, create plan following CLAUDE_PREP.md priority order.**

### Step 3: Execute Documentation Plan

For each documentation item in the plan:

#### 3a. Create/Update ARCHITECTURE.md

Use `workflows/templates/ARCHITECTURE_TEMPLATE.md` as template.

**Process:**
1. Read major directories and key files
2. Identify architectural patterns (hexagonal, MVC, microservices, etc.)
3. Map directory structure with purposes
4. Document entry points
5. Document common operations (how to add X, how to modify Y)
6. Create the document at project root

**Quality check:**
- [ ] Directory structure is complete with descriptions
- [ ] Entry points are identified
- [ ] Key patterns are explained
- [ ] Common operations are documented
- [ ] Testing strategy is clear

#### 3b. Create Complex Subsystem Guides

For each complex subsystem identified in assessment:

**Use Component Guide Template:**
```markdown
# [Subsystem Name] Guide

## Overview
[What this subsystem does - 2-3 sentences]

## Key Files
- `[file1]` - [Purpose]
- `[file2]` - [Purpose]
- `[file3]` - [Purpose]

## How It Works

[Step-by-step explanation of the subsystem's operation]

1. [Step 1]
2. [Step 2]
3. [Step 3]

[Include simple diagram if helpful]

## Common Operations

### Adding New [Feature]
1. [Step 1 with file references]
2. [Step 2 with file references]
3. [Step 3 with file references]

**Example:**
```code
[Show concrete example]
```

### Modifying Existing [Feature]
[Same pattern]

## Testing This Subsystem
[How to test, where test files live]

## Common Issues

### Issue 1: [Description]
**Symptom:** [What you see]
**Cause:** [Why it happens]
**Solution:** [How to fix]

## Related Documentation
- [Link to ARCHITECTURE.md section]
- [Link to related guides]
```

#### 3c. Create Directory READMEs

For major directories without READMEs:

**Use Directory README Template:**
```markdown
# [Directory Name]

[1-2 sentence description of what's in this directory]

## Contents

- `[file1.ext]` - [Brief purpose]
- `[file2.ext]` - [Brief purpose]
- `[subdirectory/]` - [What's in this subdirectory]

## Related Documentation
- See [link to detailed guide if exists]
- See ARCHITECTURE.md section [link]
```

**Keep it brief** - Just enough to orient someone quickly.

#### 3d. Create Project-Specific CLAUDE.md

Use `workflows/templates/CLAUDE_PROJECT_TEMPLATE.md`

**Focus on:**
- Build/test commands (exact commands that work)
- Common patterns specific to this codebase
- Gotchas and their solutions
- Integration points with external systems
- Project-specific conventions

#### 3e. Create ADRs for Major Past Decisions (If time allows)

For existing architectural decisions that aren't documented:

**Identify decisions to document:**
- Database choice
- Framework selection
- Architectural pattern choice
- Major technology selections

**Process:**
1. Research the codebase/git history to understand the decision
2. Use `workflows/templates/ADR_TEMPLATE.md`
3. Document what you can infer about context, rationale, alternatives
4. Mark as "Accepted" since decision was already made
5. Save to `docs/adrs/`

### Step 4: Validate Documentation

**Quality checks:**

- [ ] ARCHITECTURE.md exists and is comprehensive
- [ ] Complex subsystems have guides
- [ ] Major directories have READMEs
- [ ] CLAUDE.md has practical commands and patterns
- [ ] Entry points are clearly documented
- [ ] Common operations are documented
- [ ] Documentation is accurate (spot-check against code)
- [ ] No over-documentation (focused on high-value info)

### Step 5: Test Documentation Effectiveness

**Prompt:**
```
I've created the codebase documentation. Let's test its effectiveness.

Can you answer these questions using only the documentation created:
1. What is the main architectural pattern used?
2. Where would I add a new [feature type]?
3. How do I run tests?
4. What are the entry points?

[Claude attempts to answer from docs]
[If gaps found, update documentation]
```

### Step 6: Completion

**Prompt:**
```
Codebase preparation complete! Created:
- [List documents created]

Next steps:
- Keep ARCHITECTURE.md updated as patterns evolve
- Add ADRs when making new architectural decisions
- Update CLAUDE.md with new learnings
- Add directory READMEs as new areas are developed

The codebase is now optimized for efficient Claude Code navigation.
```

## Best Practices

### Do:
✅ Focus on high-value documentation (ARCHITECTURE.md, complex subsystem guides)
✅ Document "why" not "what" (code shows what)
✅ Keep directory READMEs brief
✅ Test that documentation actually helps navigation
✅ Update documentation when patterns change

### Don't:
❌ Generate docs for every function
❌ Create file indices (Claude can glob/grep efficiently)
❌ Over-document obvious code
❌ Create verbose API documentation
❌ Use tools that generate unreadable output
```

**Impact:** Provides dedicated workflow for the "prepare existing codebase" use case

---

### 6. Update Workflow README ⭐ MEDIUM PRIORITY

**File:** `workflows/README.md`

**Add new workflow to table** (around line 22):

```markdown
| **Codebase Prep** | `execute ~/.workflows/codebase-prep` | Optimize existing codebase for Claude Code navigation |
```

**Add new section after "Available Workflows":**

```markdown
## Documentation Philosophy

These workflows follow the principles in `claude/CLAUDE_PREP.md`:

### High-Value Documentation
- **ARCHITECTURE.md** - Single source of truth (created by architecture workflow)
- **Project CLAUDE.md** - Development guidelines (created by documentation workflow)
- **Component guides** - For complex subsystems (created by documentation workflow)
- **ADRs** - For significant decisions (created by design workflow)
- **Directory READMEs** - Quick orientation (created by documentation workflow)

### What We Avoid
- ❌ Auto-generated API docs (creates noise)
- ❌ File indices (Claude can glob/grep efficiently)
- ❌ Over-documented obvious code
- ❌ Massive UML diagrams for simple code

### When to Document
- **During development:** Architecture workflow creates ARCHITECTURE.md
- **After implementation:** Documentation workflow creates user docs
- **For existing codebases:** Codebase-prep workflow optimizes navigation
- **On significant decisions:** Design workflow prompts for ADRs
```

**Impact:** Makes documentation philosophy explicit to users

---

### 7. Update PATTERNS.md ⭐ LOW PRIORITY

**File:** `workflows/PATTERNS.md`

**Add new section after "Document Templates":**

```markdown
## Documentation Standards

Based on principles from `claude/CLAUDE_PREP.md`, workflows create focused, high-value documentation.

### Documentation Types

**Navigation Documentation** (makes codebase easy to navigate):
- ARCHITECTURE.md - System design, patterns, entry points
- Component guides - Deep dives on complex subsystems
- Directory READMEs - Quick orientation
- Project CLAUDE.md - Development guidelines and gotchas

**Decision Documentation** (explains "why"):
- ADRs (Architecture Decision Records) - Significant architectural decisions

**User Documentation** (explains how to use):
- README.md - Project overview and quick start
- User guides - Feature walkthroughs
- API documentation - Endpoint/function reference

### Documentation Quality Standards

**✅ Good documentation:**
- Explains "why" not just "what"
- Focuses on high-value information
- Provides concrete examples
- Identifies entry points and common operations
- Stays up-to-date with code changes

**❌ Avoid:**
- Auto-generated function docs (creates noise)
- File/class indices (Claude can search efficiently)
- Documenting obvious code
- Over-verbose API documentation
- Documentation that duplicates code comments

### When to Create Documentation

| Phase | Documentation Created | Purpose |
|-------|----------------------|---------|
| Architecture | ARCHITECTURE.md | System design and patterns |
| Design | ADR (if significant decision) | Record architectural choices |
| Implementation | Code comments | Explain non-obvious logic |
| Documentation | User-facing docs | Enable end-users |
| Codebase Prep | Navigation docs | Optimize existing codebase |

### Maintaining Documentation

**Update documentation when:**
- Architectural patterns change (update ARCHITECTURE.md)
- Significant decisions are made (create ADR)
- New patterns emerge (update CLAUDE.md)
- Documentation becomes outdated (fix it immediately)

**Don't let documentation rot** - Outdated docs are worse than no docs.
```

**Impact:** Centralizes documentation standards for all workflows

---

## Summary of Changes

| Priority | Change | Files Affected | Impact |
|----------|--------|----------------|--------|
| HIGH | Enhance ARCHITECTURE_TEMPLATE.md | 1 template | Better architecture docs |
| HIGH | Create CLAUDE project template | 1 new template | Project-specific guidelines |
| HIGH | Create ADR template + integrate | 1 template, 1 workflow | Decision documentation |
| HIGH | Enhance documentation workflow | 1 workflow | Handles codebase optimization |
| MEDIUM | Create codebase-prep workflow | 1 new workflow | Dedicated prep flow |
| MEDIUM | Update README.md | 1 doc | Explain philosophy |
| LOW | Update PATTERNS.md | 1 doc | Centralize standards |

## Implementation Order

1. **Phase 1: Templates** (30 minutes)
   - Enhance ARCHITECTURE_TEMPLATE.md
   - Create CLAUDE_PROJECT_TEMPLATE.md
   - Create ADR_TEMPLATE.md

2. **Phase 2: Integrate ADRs** (15 minutes)
   - Update design workflow to prompt for ADRs

3. **Phase 3: Enhance Documentation Workflow** (45 minutes)
   - Add codebase vs user documentation choice
   - Add codebase optimization plan generation
   - Add component guide and directory README creation

4. **Phase 4: Optional Dedicated Workflow** (1 hour)
   - Create codebase-prep workflow (if desired)

5. **Phase 5: Documentation Updates** (30 minutes)
   - Update README.md
   - Update PATTERNS.md

## Total Time: 3-4 hours

## Questions for You

1. **Codebase-prep workflow:** Do you want a dedicated workflow, or is enhancing the documentation workflow sufficient?

2. **ADR enforcement:** Should design workflow always create ADRs, or only prompt when decisions are significant?

3. **Documentation scope:** Should documentation workflow default to asking "user docs or codebase optimization docs"?

4. **Template location:** Keep templates in `workflows/templates/` or move to a more visible location?

5. **CLAUDE.md location:** Should project-specific CLAUDE.md live at project root, or in `docs/` subdirectory?
