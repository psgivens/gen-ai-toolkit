# Documentation Workflow

## Description
Create comprehensive documentation including user-facing guides and codebase navigation documentation.

This workflow creates two types of documentation:
1. **User documentation** (`docs/`) - For end-users and API consumers
2. **Codebase documentation** (`docs/code/`) - For developers navigating the codebase

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/documentation`) or says "create documentation" or "document the project"

## Instructions

You are creating comprehensive documentation for a project. This workflow generates both user-facing documentation and developer navigation documentation in separate steps.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read Context

Read all available context to understand what documentation is needed:

**From task folder (if exists):**
- `claude/${TASK_FOLDER}/REQUIREMENTS.md` - User-facing functionality
- `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md` - What was built
- `claude/${TASK_FOLDER}/ARCHITECTURE.md` - System structure
- `claude/${TASK_FOLDER}/DESIGN.md` - Design decisions
- `claude/${TASK_FOLDER}/MISSION.md` - Project goals and tenets

**From codebase:**
- Read key source files to understand implementation
- Explore directory structure
- Identify entry points
- Find complex subsystems
- Check existing documentation (README.md, docs/)

### Step 2: Assess Documentation Needs

Analyze what documentation currently exists and what's needed.

Create `claude/${TASK_FOLDER}/DOCUMENTATION_ASSESSMENT.md`:

```markdown
# Documentation Assessment

## Current State

### Existing User Documentation
- README.md: [Exists? Quality? What's missing?]
- docs/: [What exists? User guides? API docs?]
- **Gaps:** [What user-facing docs are missing?]

### Existing Codebase Documentation
- ARCHITECTURE.md: [Exists at root? Quality?]
- docs/code/: [What exists? Component guides?]
- docs/CLAUDE.md: [Exists? Up-to-date?]
- docs/adrs/: [Architecture Decision Records exist?]
- Directory READMEs: [Which directories have them?]
- **Gaps:** [What navigation docs are missing?]

## Codebase Characteristics

- **Size:** [Lines of code, file count]
- **Complexity:** [Simple/Moderate/Complex]
- **Age:** [New/Established/Legacy]
- **Languages:** [List primary languages]
- **Frameworks:** [Major frameworks used]

### Complex Subsystems Identified

**Subsystem 1:** [e.g., "Plugin System"]
- **Location:** [Directory]
- **Complexity:** [High/Medium/Low]
- **Needs guide:** [Yes/No - why?]

**Subsystem 2:** [e.g., "State Management"]
[Same structure]

### Entry Points Identified

- Main: `[file path]`
- CLI: `[file path if applicable]`
- API: `[file path if applicable]`
- Key orchestration: `[file path]`

## Documentation Plan

### Phase 1: User Documentation (docs/)
Priority user-facing documentation to create/update:

1. **[Document 1, e.g., "README.md"]**
   - Status: [Create/Update]
   - Target audience: [Who]
   - Purpose: [Why]

2. **[Document 2, e.g., "docs/API.md"]**
   - Status: [Create/Update]
   - Target audience: [Who]
   - Purpose: [Why]

### Phase 2: Codebase Documentation (docs/code/)
Priority navigation documentation to create:

1. **[Document 1, e.g., "ARCHITECTURE.md (at root)"]**
   - Status: [Create/Update]
   - Purpose: [Single source of truth for system design]

2. **[Document 2, e.g., "docs/CLAUDE.md"]**
   - Status: [Create/Update]
   - Purpose: [Project-specific development guidelines]

3. **[Document 3, e.g., "docs/code/PLUGIN_GUIDE.md"]**
   - Status: [Create]
   - Purpose: [Guide for plugin subsystem]

4. **Directory READMEs**
   - [List directories that need READMEs]
```

---

## PHASE 1: USER DOCUMENTATION

Create user-facing documentation in `docs/` directory.

### Step 3: Generate User Documentation Plan

Create detailed plan for user documentation in `claude/${TASK_FOLDER}/USER_DOCS_PLAN.md`:

```markdown
# User Documentation Plan

## Target Audiences
- **End Users:** [Description of who will use the software]
- **API Consumers:** [Developers integrating with the API]
- **System Administrators:** [People deploying/managing the system]

## Documentation Items

### Item 1: README.md
**Location:** Project root
**Status:** [Create/Update]
**Target audience:** First-time users, potential adopters
**Purpose:** Project overview and quick start
**Key sections:**
- Project overview and purpose
- Features
- Installation/setup
- Quick start guide
- Links to detailed documentation

### Item 2: docs/USER_GUIDE.md
**Location:** docs/USER_GUIDE.md
**Status:** [Create/Update]
**Target audience:** End users
**Purpose:** Comprehensive usage guide
**Key sections:**
- Getting started
- Core features walkthrough
- Common workflows
- Troubleshooting
- FAQ

### Item 3: docs/API.md
**Location:** docs/API.md
**Status:** [Create/Update]
**Target audience:** API consumers, integration developers
**Purpose:** API reference
**Key sections:**
- Authentication
- Endpoints with examples
- Request/response formats
- Error codes
- Rate limiting

### Item 4: [Additional docs as needed]
[Same structure]

## Status Tracking

| Item | Status | Notes |
|------|--------|-------|
| 1. README.md | Not Started | |
| 2. USER_GUIDE.md | Not Started | |
| 3. API.md | Not Started | |
```

### Step 4: Generate User Documentation

For each item in user documentation plan:

1. **Announce:**
   ```
   Creating [Document Name] for [Target Audience]...
   ```

2. **Generate the documentation:**
   - Follow the plan's outline
   - Include concrete examples from actual implementation
   - Use clear, simple language appropriate for target audience
   - Add code snippets where helpful
   - Test any commands/examples if possible

3. **Update status tracking:**
   - Mark item "Complete" in USER_DOCS_PLAN.md
   - Add notes about what was created

4. **Prompt for review:**
   ```
   I've created [FILE]. [Brief summary of contents].

   What would you like to do next?
   - Tell me changes to make to this document
   - Type 'continue' to proceed to next user documentation item
   ```

5. **Wait for user response** before proceeding

### Step 5: User Documentation Complete

```
Phase 1 complete! User documentation created in docs/:
- [List files created/updated]

Proceeding to Phase 2: Codebase Documentation...
```

---

## PHASE 2: CODEBASE DOCUMENTATION

Create developer navigation documentation following CLAUDE_PREP.md principles.

### Step 6: Generate Codebase Documentation Plan

Create detailed plan for codebase documentation in `claude/${TASK_FOLDER}/CODEBASE_DOCS_PLAN.md`:

```markdown
# Codebase Documentation Plan

Based on CLAUDE_PREP.md principles: Focus on high-value navigation docs, avoid over-documentation.

## Documentation Items

### Item 1: ARCHITECTURE.md (at project root)
**Location:** Project root (`ARCHITECTURE.md`)
**Status:** [Create/Update]
**Purpose:** Single source of truth for system design and patterns
**Template:** workflows/templates/ARCHITECTURE_TEMPLATE.md
**Key sections:**
- Directory structure with descriptions
- Entry points
- Architectural patterns
- Common operations (how to add X, modify Y)
- Technology stack
- Design principles

**Time estimate:** 30-45 minutes

### Item 2: docs/CLAUDE.md
**Location:** docs/CLAUDE.md
**Status:** [Create/Update]
**Purpose:** Project-specific development guidelines
**Template:** workflows/templates/CLAUDE_PROJECT_TEMPLATE.md
**Key sections:**
- Build/test commands (actual working commands)
- Key patterns specific to this codebase
- Common gotchas and solutions
- Integration points with external systems
- Development workflow

**Time estimate:** 30-45 minutes

### Item 3: docs/code/[SUBSYSTEM]_GUIDE.md
**Location:** docs/code/[SUBSYSTEM_NAME]_GUIDE.md
**Status:** Create
**Purpose:** Deep dive on [complex subsystem name]
**Why needed:** [Explain complexity - plugin system, state management, etc.]
**Key sections:**
- Overview (what this subsystem does)
- Key files
- How it works
- Common operations (how to add/modify)
- Testing
- Common issues

**Time estimate:** 45-60 minutes per subsystem

### Item 4: Directory READMEs
**Locations:**
- [directory 1]/README.md
- [directory 2]/README.md
- [directory 3]/README.md

**Status:** Create
**Purpose:** Quick orientation to directory contents
**Template:** Brief (1-2 paragraphs + file list)

**Time estimate:** 10 minutes per directory

## Status Tracking

| Item | Status | Notes |
|------|--------|-------|
| 1. ARCHITECTURE.md | Not Started | |
| 2. docs/CLAUDE.md | Not Started | |
| 3. [Subsystem] guide | Not Started | |
| 4. Directory READMEs | Not Started | |

## Priority Order

Following CLAUDE_PREP.md recommendations:

**Essential (1 hour):**
1. ARCHITECTURE.md - Most valuable single document
2. Directory READMEs - Quick wins for orientation

**High-value (additional 3 hours):**
3. docs/CLAUDE.md - Development guidelines
4. Complex subsystem guide(s) - For most complex area(s)
5. Update/create ADRs (if not done in design phase)

**Nice-to-have:**
- Additional subsystem guides
- Additional directory READMEs
```

### Step 7: Generate ARCHITECTURE.md

If ARCHITECTURE.md doesn't exist or needs updating:

1. **Use template:** `workflows/templates/ARCHITECTURE_TEMPLATE.md`

2. **Explore codebase:**
   - Use Glob to map directory structure
   - Use Grep to find patterns (frameworks, libraries)
   - Read entry point files
   - Identify architectural patterns (MVC, hexagonal, microservices, etc.)

3. **Create ARCHITECTURE.md at project root:**
   - Fill in all sections from template
   - Directory Structure: Complete tree with purposes
   - Entry Points: List main files with purposes
   - Architectural Patterns: API, database, error handling, state, testing
   - Common Operations: How to add endpoint, component, database table, etc.
   - Technology Stack: Specific versions from codebase
   - Design Principles: Reference tenets from MISSION.md if available

4. **Validate:**
   - [ ] Directory structure is complete
   - [ ] Entry points identified
   - [ ] Key patterns explained
   - [ ] Common operations documented
   - [ ] Specific technology versions listed

5. **Update status and confirm:**
   ```
   Created ARCHITECTURE.md at project root.

   Key sections:
   - [N] entry points identified
   - [N] architectural patterns documented
   - [N] common operations explained

   What would you like to do next?
   - Tell me changes to make
   - Type 'continue' to proceed to docs/CLAUDE.md
   ```

### Step 8: Generate docs/CLAUDE.md

Create project-specific development guidelines:

1. **Create docs/ directory if needed**

2. **Use template:** `workflows/templates/CLAUDE_PROJECT_TEMPLATE.md`

3. **Fill in based on codebase:**
   - **Build & Test Commands:** Find actual commands from package.json, Makefile, etc.
   - **Key Patterns:** Extract from code analysis (e.g., repository pattern, error handling)
   - **Common Gotchas:** Infer from code comments, error handling, TODO comments
   - **Integration Points:** Find external API calls, database connections, etc.
   - **Testing Guidelines:** Check test structure, coverage requirements

4. **Make it actionable:**
   - All commands should be copy-paste ready
   - All patterns should have code examples
   - All gotchas should have solutions
   - All file locations should be specific paths

5. **Update status and confirm:**
   ```
   Created docs/CLAUDE.md with project-specific guidelines.

   Key sections:
   - Build/test commands ready to use
   - [N] key patterns documented with examples
   - [N] common gotchas with solutions
   - [N] integration points documented

   What would you like to do next?
   - Tell me changes to make
   - Type 'continue' to proceed to subsystem guides
   ```

### Step 9: Generate Complex Subsystem Guides

For each complex subsystem identified in assessment:

1. **Create docs/code/ directory if needed**

2. **For each subsystem:**

   **Use Component Guide structure:**
   ```markdown
   # [Subsystem Name] Guide

   ## Overview
   [What this subsystem does - 2-3 sentences]

   ## Key Files
   - `[file1]` - [Purpose]
   - `[file2]` - [Purpose]

   ## How It Works
   [Step-by-step explanation]

   ## Common Operations

   ### Adding New [Feature]
   1. [Step with file references]
   2. [Step with file references]

   **Example:**
   ```code
   [Concrete example from codebase]
   ```

   ### Modifying Existing [Feature]
   [Same pattern]

   ## Testing This Subsystem
   [How to test, where tests live]

   ## Common Issues
   - **Issue:** [Description]
     - **Cause:** [Why]
     - **Solution:** [How to fix]
   ```

3. **Update status for each guide created**

4. **Prompt after each:**
   ```
   Created docs/code/[SUBSYSTEM]_GUIDE.md.

   What would you like to do next?
   - Tell me changes to make
   - Type 'continue' to proceed to [next subsystem / directory READMEs]
   ```

### Step 10: Generate Directory READMEs

For major directories without READMEs:

1. **For each directory:**

   **Use brief template:**
   ```markdown
   # [Directory Name]

   [1-2 sentence description of what's in this directory]

   ## Contents

   - `[file1.ext]` - [Brief purpose]
   - `[file2.ext]` - [Brief purpose]
   - `[subdirectory/]` - [What's in subdirectory]

   ## Related Documentation
   - See [link to detailed guide if exists]
   - See ARCHITECTURE.md section [link]
   ```

2. **Keep it minimal** - Just enough for quick orientation

3. **Batch creation:**
   ```
   Created directory READMEs in:
   - [directory 1]/README.md
   - [directory 2]/README.md
   - [directory 3]/README.md

   What would you like to do next?
   - Tell me changes to make
   - Type 'continue' if all directory READMEs are done
   ```

---

## COMPLETION

### Step 11: Final Validation

Validate all documentation created:

**User Documentation:**
- [ ] README.md exists and is comprehensive
- [ ] Key user-facing docs created (guides, API docs)
- [ ] All commands/examples tested
- [ ] Documentation is accurate

**Codebase Documentation:**
- [ ] ARCHITECTURE.md exists at project root
- [ ] docs/CLAUDE.md has practical commands and patterns
- [ ] Complex subsystems have guides
- [ ] Major directories have READMEs
- [ ] Entry points clearly documented
- [ ] Common operations documented
- [ ] No over-documentation (focused on high-value info)

### Step 12: Summary and Next Steps

```
Documentation complete!

**User Documentation (docs/):**
- [List files created/updated]

**Codebase Documentation:**
- ARCHITECTURE.md (project root)
- docs/CLAUDE.md
- docs/code/[subsystem guides]
- [N] directory READMEs

**Maintenance:**
- Keep ARCHITECTURE.md updated as patterns evolve
- Add to docs/CLAUDE.md when new learnings occur
- Create ADRs for new architectural decisions (use design workflow)
- Update directory READMEs as new areas develop

The project now has comprehensive documentation for both users and developers.
```

---

## Documentation Best Practices

### Writing Style (User Docs)
- Use clear, simple language
- Avoid jargon or explain it
- Use active voice ("Run the command" not "The command should be run")
- Break complex topics into digestible sections
- Use examples liberally

### Writing Style (Codebase Docs)
- Be specific with file paths and commands
- Explain "why" not just "what"
- Include concrete examples from actual codebase
- Keep directory READMEs brief
- Focus on high-value navigation information

### What to Document
✅ **Do document:**
- Entry points and orchestration
- Architectural patterns and rationale
- Complex subsystems
- Common operations (how-to guides)
- Integration points
- Build/test commands that actually work
- Common gotchas with solutions

❌ **Don't document:**
- Every function (creates noise)
- Obvious code
- Generated code
- Framework documentation (link instead)
- File indices (Claude can search efficiently)

### Code Examples
- Show complete, runnable examples
- Include expected output
- Test examples to ensure they work
- Explain what each example demonstrates

### Keeping Documentation Current
- Update ARCHITECTURE.md when patterns change
- Add to CLAUDE.md when new gotchas discovered
- Create ADRs for architectural decisions
- Remove outdated information immediately
- **Outdated docs are worse than no docs**
