# Architecture Design Workflow

## Description
Create a comprehensive architecture document by analyzing requirements and design decisions, then generating a detailed system architecture.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/architecture`) or says "create architecture design" or "design the system"

## Instructions

You are guiding the user through Phase 3: Architecture Design of a structured development workflow.

This workflow generates ARCHITECTURE.md directly based on requirements and design decisions, without an interview phase.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read Context

Read all necessary context documents:
- Check if `PROJECT_CONTEXT.md` exists at project root. If yes, read it — use it to understand current entry points and patterns before designing the new architecture.
- Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` to understand what needs to be built
- Read `claude/${TASK_FOLDER}/DESIGN.md` to understand architectural choices made
- Read `claude/${TASK_FOLDER}/MISSION.md` to understand design tenets (if applicable)
- Check for existing codebase patterns by reading `claude/${TASK_FOLDER}/EXISTING_PATTERNS.md` (if exists from design phase)
- Read project root `ARCHITECTURE.md` if exists (living architecture document)

If design is incomplete or missing, prompt:
```
Design decisions are needed before creating architecture. Please complete the design workflow first.
```

### Step 2: Generate Architecture Document

Based on the context read in Step 1, create `claude/${TASK_FOLDER}/ARCHITECTURE.md` directly.

#### Document Structure

Follow this structure when generating ARCHITECTURE.md:

```markdown
# Architecture

## Overview
[High-level description of system architecture - 2-3 paragraphs explaining
the overall approach, how components work together, and key architectural patterns]

## Entry Points

[Where execution begins — the fastest way to orient yourself or Claude in this codebase]

- `[file path]` — [What starts here, e.g., "Application startup, initializes all services"]
- `[file path]` — [e.g., "HTTP server, middleware registration"]
- `[file path]` — [e.g., "Background job processor, queue listener"]
- `[file path]` — [e.g., "CLI entrypoint"]

[Include only files where something meaningfully begins — not every file in the project]

## Key Components

### Component 1: [Name]
**Responsibility:** [What this component does]
**Technology:** [Specific tech from DESIGN.md]
**Location:** [Where this lives in codebase, e.g., src/api/]
**Interfaces:** [How other components interact with this]

### Component 2: [Name]
[Same structure]

[Continue for all major components]

## Data Flow

[Describe how data moves through the system, from input to output]

Example flow:
1. User request arrives at API endpoint
2. Controller validates input
3. Service layer processes business logic
4. Repository layer accesses database
5. Response formatted and returned

[Include ASCII diagram if helpful for complex flows]

## Technology Stack

[List specific technologies from DESIGN.md with versions]
- **Frontend:** [e.g., React 18.2 with TypeScript 5.0]
- **Backend:** [e.g., Node.js 18 with Express 4.18]
- **Database:** [e.g., PostgreSQL 15 with Prisma 5.0]
- **Testing:** [e.g., Jest 29 for unit, Playwright for E2E]
- **Build:** [e.g., Vite 4.0]

## Directory Structure

```
project-root/
├── src/
│   ├── [structure based on requirements and design]
│   └── ...
├── tests/
└── ...
```

**Rationale:** [Explain why this structure - separation of concerns, scalability, etc.]

## Common Operations

[How to perform the most frequent development tasks in this codebase.
Derive these from the directory structure and component definitions above.]

### Adding a new [primary resource type, e.g., "API endpoint"]
1. [Step with specific file path, e.g., "Create route in `src/api/routes/[resource].ts`"]
2. [Step with specific file path]
3. [Step with specific file path]
4. [Step with specific file path, e.g., "Register route in `src/api/server.ts`"]

### Adding a new [secondary resource type, e.g., "database model"]
1. [Step with specific file path]
2. [Step with specific file path]
3. [Step with specific file path]

### [Other common operation derived from requirements, e.g., "Adding a background job"]
1. [Step with specific file path]
2. [Step with specific file path]

[Include 2-4 operations covering the most common development tasks for this system]

## Anti-Patterns

[What NOT to do in this codebase — derived from design tenets, component boundaries,
and the layered architecture defined above]

- **Don't [anti-pattern]** — [Why: what goes wrong, what to do instead]
- **Don't [anti-pattern]** — [Why: what goes wrong, what to do instead]
- **Don't [anti-pattern]** — [Why: what goes wrong, what to do instead]

Examples:
- "Don't put business logic in controllers — use the service layer"
- "Don't query the database from the API layer directly — always go through repositories"
- "Don't share mutable state across request handlers — treat each request as isolated"

[Derive from design tenets in MISSION.md and from component boundary definitions above]

## Module Dependencies

[Describe how components depend on each other]
- API layer depends on Service layer
- Service layer depends on Repository layer
- Repository layer depends on Database

[Diagram if helpful]

## Error Handling Strategy

[Describe how errors flow through the system]
- **Error types:** [Custom error classes to create]
- **Error boundaries:** [Where errors are caught and handled]
- **Logging:** [Where and how errors are logged]
- **User-facing errors:** [How errors are surfaced to users]

## Security Considerations

[Security architecture based on requirements]
- **Authentication:** [How users authenticate, where tokens are validated]
- **Authorization:** [How permissions are checked, middleware approach]
- **Data protection:** [Encryption, sanitization boundaries]
- **Security boundaries:** [What's trusted vs. untrusted]

## Testing Strategy

<!-- Before writing this section: read the existing test setup.
     Check: package.json test script, tests/ directory structure, existing test files.
     Use actual test file paths and the real test command from the project. -->

**Unit Tests:**
- [What to test at unit level — name specific classes/functions that will be tested]
- [Test file location convention, e.g., `tests/unit/services/[name].test.ts`]
- [Mocking approach — e.g., in-memory SQLite, vitest mocks, real temp files]

**Integration Tests:**
- [What to test at integration level — e.g., service + DB sharing a real temp file]
- [Test file location, e.g., `tests/unit/services/[name]/integration.test.ts`]

**E2E Tests:**
- [Critical user journeys to test, if applicable]
- [Test environment setup]

**Test Command:** `[e.g., npm test]`

## Deployment Architecture

[How the system will be deployed based on design decisions]
- **Environment:** [e.g., Docker containers on AWS ECS]
- **Configuration:** [How config is managed across environments]
- **Scaling:** [Horizontal vs vertical, load balancing]

## Trade-offs

[Key architectural trade-offs made and why]
- **Trade-off 1:** [What was chosen vs. alternative, why]
- **Trade-off 2:** [What was chosen vs. alternative, why]

## Key Decisions

[Reference to significant architectural decisions documented as ADRs.
If no ADRs exist yet, omit this section.]

| Decision | Rationale | ADR |
|----------|-----------|-----|
| [e.g., PostgreSQL over MongoDB] | [e.g., Relational model required for referential integrity] | [ADR-001](docs/adrs/ADR-001-database.md) |
| [e.g., REST over GraphQL] | [e.g., Simpler client integration, caching benefits] | [ADR-002](docs/adrs/ADR-002-api-style.md) |
```

 
#### Code Entry Points (Required)
 
Document the main entry points for this feature/system:
 
```markdown
## Code Entry Points
 
- **[Feature area]:** `[file path]` — [what it does, where execution starts]
- **[Feature area]:** `[file path]` — [what it does]
- **IPC handler (if applicable):** `[file path]` — [channels handled]
- **Main process entry:** `[file path]` — [description]
- **Renderer entry:** `[file path]` — [description]
```
 
**Why required:** Without explicit entry points, Claude must grep and explore to find where to begin implementing — this is repeated every session. Entry points cut per-session orientation time significantly.
 
#### Generation Guidelines

When creating ARCHITECTURE.md:
1. **Be specific** - Use actual technology names and versions from DESIGN.md
2. **Reference requirements** - Ensure all functional requirements have architectural support
3. **Apply design tenets** - If tenets exist in MISSION.md, reference them in trade-offs and anti-patterns
4. **Follow existing patterns** - If EXISTING_PATTERNS.md exists, maintain consistency
5. **Explain decisions** - Don't just state what, explain why
6. **Be implementation-ready** - Directory structure and component definitions should be clear enough to start coding
7. **Include diagrams** - Use ASCII art or markdown for data flows and dependencies if helpful
8. **Testing Strategy** - Before writing this section, read the real test setup: `package.json` test scripts, `tests/` directory structure, and 1-2 existing test files to understand naming conventions and mocking patterns. Populate with real test file paths, not placeholders.
9. **Entry Points** - Identify every file where meaningful execution begins; use actual paths from the directory structure defined above
10. **Common Operations** - Derive 2-4 step-by-step guides from the component layers and directory structure; use actual file paths; focus on the tasks a developer will perform most often
11. **Anti-patterns** - Derive from design tenets (MISSION.md) and component boundary definitions; each anti-pattern should name a specific wrong thing to do and explain what breaks
12. **Key Decisions** - Only include if ADRs exist in docs/adrs/; link to the actual ADR files

### Step 3: Validation

After generating ARCHITECTURE.md, validate it:
- All requirements from REQUIREMENTS.md have architectural support
- Consistent with technology choices in DESIGN.md
- Directory structure is practical and follows conventions
- Component responsibilities are clear and well-defined
- No circular dependencies between components
- Entry points are real files (not abstractions) with specific paths
- Common Operations use actual file paths from the directory structure
- Anti-patterns are specific (name the wrong thing) not generic advice
- Key Decisions section only present if ADRs actually exist

### Step 4: Prompt for Review

```
I've created claude/${TASK_FOLDER}/ARCHITECTURE.md with the system architecture.

Key components:
- [List major components]

What would you like to do next?
- Tell me specific changes to make (e.g., "Add component for X", "Change directory structure")
- Continue to the plan workflow to create the implementation plan
```

Wait for user response. If changes requested, update ARCHITECTURE.md and repeat this prompt.

### Step 5: Completion

When user continues to next phase:
```
Architecture phase complete! Continue to the plan workflow to create the implementation plan.
```

## Best Practices
- Be specific with technology choices (versions, libraries, etc.)
- Show how components interact (data flow is critical)
- Explain WHY architectural choices were made (reference DESIGN.md)
- Keep it practical and implementation-focused
- Identify potential risks or challenges
- Make sure architecture is consistent with design decisions
- Use diagrams or ASCII art if helpful for clarity
- When user asks questions, provide concrete examples (directory structures, component diagrams, code patterns)
- Generate follow-up questions that explore component boundaries and interactions
