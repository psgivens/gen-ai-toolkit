# Optimizing Codebases for Claude Code

This guide provides practical guidance for making any codebase easier for Claude Code to navigate and understand.

## Key Understanding: No Persistent Indexing

**Important:** Claude Code doesn't maintain a persistent index between conversations. Each new conversation starts fresh, so the goal is to make discovery and navigation as efficient as possible through good documentation.

## High-Impact Documentation to Create

### 1. Architecture Overview (ARCHITECTURE.md)

This is the single most valuable document you can create:

```markdown
# Architecture Overview

## System Design
- High-level architecture diagram or description
- Major components and their responsibilities
- Data flow between components

## Directory Structure
```
internal/
├── adapters/    # External integrations (HTTP, DB, APIs)
├── core/        # Business logic and domain models
├── app/         # Application orchestration
└── plugin/      # Plugin system for extensibility
```

## Key Patterns
- Hexagonal architecture (ports & adapters)
- Feature flags via internal/feature
- Plugin-based extensibility

## Important Conventions
- Tests use Ginkgo/Gomega
- Mocks generated via mockery
- CLI built with Cobra
```

### 2. Project-Specific CLAUDE.md

Create a repo-specific CLAUDE.md for:
- Development guidelines specific to this codebase
- Learnings from past work
- Build/test commands
- Common gotchas
- Links to relevant documentation

### 3. Architecture Decision Records (ADRs)

Maintain ADRs in `docs/adrs/` for:
- Why certain architectural choices were made
- Trade-offs considered
- Context for future developers (including AI)
- Historical decisions that explain current state

### 4. Code Map for Complex Areas

For particularly complex subsystems, create a map:

```markdown
# Plugin System Guide

## How Plugins Work
1. Definition: `internal/plugin/definition.go`
2. Registration: Each plugin implements `Plugin` interface
3. Lifecycle: Managed by composite plugin in `internal/plugin/composite/`

## Adding a New Plugin
1. Create directory: `internal/plugin/{name}/`
2. Implement Plugin interface
3. Register in composite plugin
4. Add feature flag if optional

## Existing Plugins
- AWS: Identity Center authentication
- Buildkit: Certificate generation
- Claude: Claude Code configuration
- Kafka: Kafka certificate generation
```

## What NOT to Do

❌ **Don't create massive auto-generated documentation** - Tools that generate docs for every function create noise

❌ **Don't create indices of every file** - Claude can glob/grep efficiently

❌ **Don't duplicate what code comments already say** - Focus on "why" not "what"

❌ **Don't create UML diagrams for simple code** - Save diagrams for complex flows

❌ **Don't use code indexers like ctags** - Claude can't read these directly

❌ **Don't generate verbose API documentation** - Too verbose, creates noise

❌ **Don't create dependency graphs** - Unless they explain WHY, not just WHAT

## Practical Workflow Tips

### At Project Start (One-Time Setup)

When you know you'll spend significant time in a repo:

```bash
# 1. Create architecture overview
claude "Read through the codebase and create an ARCHITECTURE.md that explains:
- Directory structure and what each major folder contains
- Key architectural patterns used
- How the main components interact
- Common conventions I should know"

# 2. Document complex areas
claude "Read internal/plugin/ and create a PLUGINS.md guide explaining:
- How the plugin system works
- How to add a new plugin
- Examples of existing plugins"
```

### During Development

The documentation you created becomes a shared reference:

```bash
# Claude can reference it efficiently
claude "Following the plugin pattern in PLUGINS.md, add a new monitoring plugin"

# Much better than Claude having to re-discover the pattern each time
```

## Repository Structure Best Practices

These make navigation faster:

### Clear Organization

✅ **Clear directory names** - `internal/adapters/` is clearer than `internal/iface/`

✅ **README in each major directory** - Brief explanation of contents

✅ **Consistent naming conventions** - Claude learns patterns quickly

✅ **Co-locate related code** - Tests next to implementation

✅ **Meaningful package names** - `credential` not `cred`, `authentication` not `auth`

### Good File Names Help

```
✅ internal/plugin/claude/cost_tracker.go
❌ internal/plugin/claude/tracker.go

✅ internal/adapters/bedrock_client.go
❌ internal/adapters/client.go
```

Claude can find `cost_tracker.go` with Glob patterns easily.

### Document Entry Points

In your README or ARCHITECTURE.md:

```markdown
## Entry Points
- `main.go` - Application entry
- `cmd/root.go` - CLI root command
- `internal/plugin/composite/composite.go` - Plugin orchestration
```

## Priority Order

### If you have 1 hour:
1. Create ARCHITECTURE.md (30 min)
2. Add README to each major internal/ subdirectory (30 min)

### If you have 4 hours:
1. Create ARCHITECTURE.md (45 min)
2. Document your most complex subsystem in detail (60 min)
3. Create ADRs for major decisions (90 min)
4. Add directory READMEs (45 min)

### If you maintain this long-term:
- Update ARCHITECTURE.md when patterns change
- Add ADRs for significant decisions
- Keep CLAUDE.md updated with learnings
- Document new patterns as they emerge

## Documentation Templates

### ARCHITECTURE.md Template

```markdown
# Architecture Overview

## Purpose
[What does this system do?]

## High-Level Design
[Diagram or description of major components]

## Directory Structure
```
[tree output with brief descriptions]
```

## Key Patterns
- [Pattern 1]: Description
- [Pattern 2]: Description

## Important Conventions
- [Convention 1]
- [Convention 2]

## Entry Points
- [Main entry point]: Description
- [Key orchestration]: Description

## Common Operations
### [Operation Name]
1. Step 1
2. Step 2

## Testing Strategy
[How tests are organized and run]

## Build & Deploy
[How to build and deploy]
```

### Component Guide Template

```markdown
# [Component Name] Guide

## Overview
[What this component does]

## Key Files
- `file1.go`: Purpose
- `file2.go`: Purpose

## How It Works
1. [Step 1]
2. [Step 2]

## Adding New [Feature]
1. [Step 1]
2. [Step 2]

## Examples
### [Example Name]
```code```

## Testing
[How to test this component]

## Common Issues
- [Issue 1]: Solution
```

### Directory README Template

```markdown
# [Directory Name]

[Brief description of what's in this directory]

## Key Files
- `file1.go` - [Purpose]
- `file2.go` - [Purpose]

## Related Documentation
- [Link to detailed guide if it exists]
```

## Session-Specific Optimizations

Within a single conversation, Claude maintains context through automatic summarization. You can help by:

1. **State your goal upfront**: "I'll be working on the authentication system today"
2. **Reference previous work**: "Using the pattern we established for AWS plugin..."
3. **Ask Claude to remember key info**: "Remember that plugins are registered in composite.go"
4. **Build incrementally**: Small changes with tests between iterations

## Real-World Example Workflow

### Starting a New Feature

```bash
# 1. Orient Claude to the relevant area
claude "Read internal/plugin/ and explain how the plugin system works"

# 2. Create documentation if it doesn't exist
claude "Create docs/PLUGIN_DEVELOPMENT.md documenting the plugin pattern"

# 3. Now implement using that documentation
claude "Following the pattern in docs/PLUGIN_DEVELOPMENT.md,
add a new monitoring plugin that tracks system metrics"

# 4. Future work references the doc
claude "Add another feature to the monitoring plugin per PLUGIN_DEVELOPMENT.md"
```

### Maintaining a Complex Codebase

```bash
# Weekly: Update key documentation as patterns evolve
claude "Review recent changes to internal/plugin/ and update
docs/PLUGIN_DEVELOPMENT.md if patterns have changed"

# Monthly: Audit documentation
claude "Check if ARCHITECTURE.md still accurately reflects the codebase structure"

# As needed: Create ADRs
claude "Create an ADR for why we chose to use feature flags
instead of configuration files for plugin control"
```

## Measuring Effectiveness

You'll know your documentation is working when:

✅ Claude can start work without extensive exploration
✅ Claude references your docs when implementing features
✅ You don't have to explain the same patterns repeatedly
✅ New contributors (human or AI) can onboard faster
✅ Architectural decisions are clear and justified

## Summary

**Most valuable investment of time:**
1. ARCHITECTURE.md - Single source of truth for system design
2. Component guides for complex areas
3. ADRs for major decisions
4. Directory READMEs for quick orientation

**Continuously maintain:**
- CLAUDE.md with development learnings
- Update ARCHITECTURE.md when patterns change
- Add ADRs for significant decisions

**Don't waste time on:**
- Auto-generated API docs
- Code indices that Claude can't read
- Documenting obvious code
- Creating diagrams for simple flows

---

*The goal is to create just enough documentation to make navigation efficient, without creating maintenance burden through over-documentation.*
