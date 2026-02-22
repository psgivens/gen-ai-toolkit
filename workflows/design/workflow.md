# Design Decisions Workflow

## Description
Guide the user through making architectural and design decisions using an interview-based approach with recommendations and trade-offs.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/design`) or says "start design decisions" or "make architectural decisions"

## Instructions

You are guiding the user through Phase 2: Design Decisions of a structured development workflow.

**Follow the Interview Pattern** defined in `PATTERNS.md` at the workflows root (fetch from `$WORKFLOWS/PATTERNS.md` if using URL access) for conducting the design interview.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read Context and Discover Existing Patterns

1. **Read requirements:**
   - Read `claude/${TASK_FOLDER}/REQUIREMENTS.md` to understand what needs to be built
   - Read `claude/${TASK_FOLDER}/MISSION.md` to understand design tenets and priorities

2. **Check for living architecture documentation:**
   - Look for `ARCHITECTURE.md` or `docs/ARCHITECTURE.md` at project root
   - If exists: Read it thoroughly - this is the source of truth for established patterns
   - If doesn't exist: Note that you may recommend creating one after design phase

3. **Discover existing architecture and patterns in codebase:**

   Search codebase for similar features and technology choices:
   - **UI libraries/frameworks:** Look for React, Vue, Angular, etc. imports
   - **Database/ORM patterns:** Look for SQL files, ORM configurations, model definitions
   - **API patterns:** Check existing endpoints, REST vs GraphQL, error response formats
   - **Testing frameworks:** Check for Jest, Pytest, etc. in package.json or requirements.txt
   - **Build/deployment tools:** Check for webpack, vite, docker files
   - **Error handling patterns:** Look at how existing features handle errors
   - **Similar features:** If building auth, check if auth already exists; if building UI component, check existing components

   Use Glob, Grep, and Read tools to explore:
   ```
   Example commands to run:
   - Glob for package.json, requirements.txt, go.mod to see dependencies
   - Grep for "import React" to confirm frontend framework
   - Grep for "api.get" or similar to find API patterns
   - Read existing similar feature files to understand patterns
   ```

4. **Document findings:**

   Create `claude/${TASK_FOLDER}/EXISTING_PATTERNS.md`:
   ```markdown
   # Existing Patterns Discovered

   ## Technology Stack
   - **Frontend Framework:** [e.g., React 18.2 - found in package.json]
   - **Backend Framework:** [e.g., Express 4.18 - found in src/server.ts]
   - **Database:** [e.g., PostgreSQL with Prisma ORM - found in schema.prisma]
   - **Testing:** [e.g., Jest - found in package.json and __tests__ folders]

   ## Established Patterns

   ### UI Components
   - **Location:** [e.g., src/components/]
   - **Pattern:** [e.g., Functional components with hooks]
   - **Example:** [e.g., src/components/UserProfile.tsx]

   ### API Design
   - **Location:** [e.g., src/api/routes/]
   - **Pattern:** [e.g., REST with Express, JSON responses]
   - **Example:** [e.g., src/api/routes/users.ts]

   ### Database Access
   - **Location:** [e.g., src/models/]
   - **Pattern:** [e.g., Prisma ORM with repository pattern]
   - **Example:** [e.g., src/models/userRepository.ts]

   ### Error Handling
   - **Location:** [e.g., src/middleware/errorHandler.ts]
   - **Pattern:** [e.g., Custom error classes, centralized error middleware]
   - **Example:** [e.g., throw new ValidationError("message")]

   ## Design Recommendations Based on Existing Patterns

   For this feature, we should:
   - Use [existing pattern X] because it's already established
   - Follow [existing pattern Y] for consistency
   - Only introduce new technology/pattern for [specific reason if needed]

   ## New Decisions Needed

   These areas don't have established patterns yet:
   - [Area 1 that requires new decision]
   - [Area 2 that requires new decision]
   ```

5. **Identify key architectural decisions:**
   - Focus on decisions NOT already made by existing codebase
   - Prioritize questions about integrating with existing patterns
   - Only ask about new technology if existing patterns don't fit requirements

### Step 2: Conduct Design Interview
**Follow Interview Pattern** to conduct design interview:

#### Phase-Specific Focus
- **Focus:** HOW (implementation approach), not WHAT (already decided in requirements)
- **First:** Reference existing patterns discovered in Step 1
- **Then:** Focus questions on decisions not yet made by existing architecture
- **Initial questions (up to 15) should explore:**
  - **Integration with existing patterns** (How does this fit with current architecture?)
  - Technology stack **additions** or **variations** from existing (only if needed)
  - New architecture patterns (only if current patterns don't fit)
  - Data storage (reference existing DB/ORM unless new storage needed)
  - API design (reference existing API patterns unless new approach needed)
  - Error handling (reference existing strategy, extend if needed)
  - Testing approach (use existing frameworks, extend coverage if needed)
  - Security considerations (follow existing patterns, add feature-specific needs)

#### Question Format

**For decisions already made by existing codebase:**
```
I found we're using [Library/Pattern X] for [purpose] in [location].
Should we use the same approach for this feature?

**Recommendation:** Yes, use [X] [✓✓✓ High Confidence]
**Why:** Maintains consistency with existing codebase, team already familiar with it
**Alternative:** Only consider alternatives if there's a strong reason (performance issue, missing capability)
```

**For new decisions (no existing pattern):**
```
What X should we use?

**Recommendation:** Y [✓✓/✓✓✓ confidence level]
**Why:** [Specific reasons based on requirements and constraints]
**Alternatives:**
- A: [Pros/cons]
- B: [Pros/cons]
```

**For decisions that might need to differ from existing patterns:**
```
I found we're using [X] for [purpose], but [reason this might not fit].
Should we continue with [X] or consider alternatives?

**Recommendation:** [Continue with X / Switch to Y] [✓✓ confidence]
**Why:** [Analysis of trade-offs]
**Alternatives:**
- [X]: [Pros: consistency; Cons: specific limitations]
- [Y]: [Pros: better fit; Cons: introduces inconsistency]
```

Follow-up questions should also reference existing patterns and include recommendations + alternatives

#### Applying Design Tenets

Design tenets from MISSION.md guide trade-off decisions. Always reference relevant tenets when making recommendations.

**How to use tenets:**

1. **Read tenets from MISSION.md** in Step 1
2. **Identify when a tenet applies** - Does this decision involve a trade-off the tenet addresses?
3. **Explicitly reference the tenet** in your recommendation rationale
4. **Explain how the recommendation aligns** with the tenet

**Example with tenet "Robustness over performance":**

```
What database should we use?

**Recommendation:** PostgreSQL [✓✓✓ High Confidence]
**Why:**
- Aligns with Tenet "Robustness over performance" - ACID guarantees and data
  integrity are more important than raw speed for this application
- Supports complex queries needed for reporting requirements
- Mature ecosystem with strong tooling
**Alternatives:**
- MongoDB: Faster for simple operations but sacrifices robustness (conflicts with Tenet #1)
- SQLite: Simple but not robust enough for multi-user scenarios
```

**Example with tenet "Simplicity over features":**

```
What state management should we use?

**Recommendation:** React Context [✓✓ Medium Confidence]
**Why:**
- Aligns with Tenet "Simplicity over features" - Context API is simpler and
  built-in, no external dependency
- Sufficient for our moderate state management needs
- Easier to understand and maintain
**Alternatives:**
- Redux: More features but adds complexity (conflicts with Tenet #1)
- Zustand: Good middle ground, consider if Context becomes limiting
```

**When tenet conflicts exist:**

If user has conflicting tenets or decision doesn't clearly align:
```
**Recommendation:** [Choice] [✓✓ Medium Confidence]
**Why:** This involves a trade-off between Tenet 1 "[X]" and Tenet 2 "[Y]".
I prioritized Tenet 1 because [reasoning], but [alternative] would better serve Tenet 2.
```

**If no tenets provided:** Focus recommendations on requirements and technical merit without tenet references.

#### Confidence Levels

Every recommendation should include a confidence level indicator: ✓✓✓, ✓✓, or ✓

**✓✓✓ High Confidence** - Clear best choice based on requirements and constraints

Use when:
- Requirement clearly favors one option (e.g., "need ACID guarantees" → PostgreSQL)
- One option has significant advantages with minimal downsides
- Industry best practice applies directly
- Existing codebase already uses this pattern
- Strong evidence or experience supports this choice

Example:
```
**Recommendation:** PostgreSQL [✓✓✓ High Confidence]
**Why:** Requirements specify complex relational queries and ACID guarantees.
PostgreSQL excels at both. Team has 5 years PostgreSQL experience.
```

**✓✓ Medium Confidence** - Solid choice but reasonable alternatives exist

Use when:
- Multiple options are viable but one has slight edge
- Trade-offs exist but one option fits requirements better
- Some uncertainty about requirements that could affect choice
- Limited experience with recommended option
- Choice depends on preferences or priorities

Example:
```
**Recommendation:** REST API [✓✓ Medium Confidence]
**Why:** Requirements are simple CRUD operations, REST is straightforward and
team knows it. GraphQL would also work but adds complexity we don't need yet.
```

**✓ Low Confidence** - Multiple equally valid options, preference-driven

Use when:
- Multiple options are equally valid technically
- Decision is largely aesthetic or preference-based
- More information needed to make confident recommendation
- Unfamiliar with all options (research needed)
- Requirements don't strongly favor any option

Example:
```
**Recommendation:** ESLint [✓ Low Confidence]
**Why:** Both ESLint and Biome are good linters. ESLint has larger ecosystem,
Biome is faster. Either works fine, depends on team preference for speed vs. plugins.
```

**When uncertain about confidence level:** Default to ✓✓ and explain the uncertainty in your rationale.

#### Output Documents
- **Interview file:** `claude/${TASK_FOLDER}/DESIGN_INTERVIEW.md`
- **Output document:** `claude/${TASK_FOLDER}/DESIGN.md`

#### Document Structure
When generating DESIGN.md, follow this structure:
- Architecture overview (high-level approach)
- Key components and their responsibilities
- Data flows
- Technology choices (based on user's decisions in interview)
- Error handling strategy
- Trade-offs made (briefly explain why certain choices were made)

### Step 3: Update Living Architecture Document

After generating and finalizing DESIGN.md:

1. **Check if project has living architecture doc:**
   - Look for `ARCHITECTURE.md` or `docs/ARCHITECTURE.md` at project root
   - Read it if it exists

2. **If living architecture doc exists:**

   Analyze what needs updating based on this design phase:
   - New technology choices
   - New patterns established
   - New design principles
   - Architectural decisions made

   Prompt:
   ```
   This project has a living architecture document at [path]. Based on this design phase,
   I recommend updating it with:

   - [List specific additions/changes needed]
   - [e.g., "Add FastAPI to Backend Framework section"]
   - [e.g., "Add Decision Log entry for choosing REST over GraphQL"]

   Would you like me to update the architecture document?
   - Type 'yes' to update it now
   - Type 'later' to skip for now
   ```

   If user says yes:
   - Make the updates to ARCHITECTURE.md
   - Add decision log entry if significant architectural decision was made
   - Confirm what was updated

3. **If living architecture doc doesn't exist:**

   Prompt:
   ```
   This project doesn't have a living architecture document yet. I recommend creating one
   to capture patterns and decisions for future features.

   Benefits:
   - Future design phases will reference it for consistency
   - New team members can understand architectural decisions
   - Prevents pattern drift across features

   Would you like me to create ARCHITECTURE.md based on:
   - Existing codebase patterns discovered in EXISTING_PATTERNS.md
   - Design decisions from this feature

   - Type 'yes' to create it now
   - Type 'later' to skip for now
   ```

   If user says yes:
   - Use template from `templates/ARCHITECTURE_TEMPLATE.md` at the workflows root (fetch from `$WORKFLOWS/templates/ARCHITECTURE_TEMPLATE.md` if using URL access)
   - Fill in sections based on EXISTING_PATTERNS.md and DESIGN.md
   - Create `ARCHITECTURE.md` at project root
   - Add decision log entry for major design decisions

4. **Confirm completion:**
   ```
   [If updated/created]: I've [updated/created] ARCHITECTURE.md with [summary of changes].

   Design phase complete! Continue to the architecture workflow to create the detailed architecture.
   ```

### Step 3b: Create ADR for Significant Decisions

If this design phase involved a **significant architectural decision**, create an Architecture Decision Record (ADR) to document the "why" behind the choice.

**What qualifies as "significant":**
- ✅ Changes that are hard to reverse later (database selection, framework choice)
- ✅ Choices between fundamentally different approaches (microservices vs monolith, REST vs GraphQL)
- ✅ Decisions that impact multiple components or teams
- ✅ Trade-offs with long-term implications (performance vs maintainability, cost vs features)
- ✅ Technology selections (databases, state management, major libraries)
- ❌ Trivial choices (linter selection, code formatting rules) - don't need ADRs

**Examples of significant decisions:**
- Choosing PostgreSQL over MongoDB
- Selecting REST vs GraphQL API style
- Deciding on authentication strategy (JWT vs sessions)
- State management approach (Redux vs Zustand vs Context)
- Microservices vs monolith architecture
- Event-driven vs request-response pattern

**Evaluate this design phase:**

1. **Identify significant decisions made:**
   - Review DESIGN_INTERVIEW.md and DESIGN.md
   - Look for decisions marked with ✓✓✓ or ✓✓ confidence
   - Identify technology selections or architectural patterns chosen
   - Check if any design tenets were applied to trade-offs

2. **If one or more significant decisions were made:**

   Prompt:
   ```
   This design phase made [N] significant architectural decision(s):

   1. [Decision 1, e.g., "Chose PostgreSQL over MongoDB for primary database"]
   2. [Decision 2, if applicable]

   Would you like me to create an ADR (Architecture Decision Record) to document this?

   Benefits:
   - Future developers understand the "why" behind this choice
   - Provides context for alternatives that were considered
   - References trade-offs and rationale for easier future review
   - Creates historical record of architectural evolution

   - Type 'yes' to create ADR(s) in docs/adrs/
   - Type 'no' to skip
   ```

3. **If user says yes:**

   a. **Determine next ADR number:**
      - Check if `docs/adrs/` directory exists
      - If not, create it
      - Find highest numbered ADR (e.g., ADR-003)
      - Use next number (e.g., ADR-004)

   b. **Create ADR for each significant decision:**
      - Use template from `templates/ADR_TEMPLATE.md` at the workflows root (fetch from `$WORKFLOWS/templates/ADR_TEMPLATE.md` if using URL access)
      - Fill in based on DESIGN_INTERVIEW.md conversation:
        * **Context:** Why this decision was needed
        * **Decision:** What was chosen
        * **Rationale:** Why this option (reference confidence level, design tenets)
        * **Alternatives Considered:** Options from interview with pros/cons
        * **Consequences:** Positive, negative, neutral impacts
      - Save as `docs/adrs/ADR-[NUMBER]-[kebab-case-title].md`
      - Example: `docs/adrs/ADR-004-use-postgresql-for-primary-database.md`

   c. **Update ADR index (if exists):**
      - If `docs/adrs/README.md` exists, add entry
      - If doesn't exist, create it with list of ADRs

   d. **Confirm creation:**
      ```
      I've created:
      - docs/adrs/ADR-[NUMBER]-[title].md

      The ADR documents [summary of decision] with rationale and alternatives considered.
      ```

4. **If user says no or no significant decisions:**
   - Continue to next step (no ADR created)

#### Next Workflow
After completing Steps 3 and 3b, say:
"Design phase complete! Continue to the architecture workflow to create the detailed architecture."

## Best Practices
- Always lead with a recommended option in each question (don't just list choices without guidance)
- Keep trade-off analysis brief but meaningful (2-3 sentences)
- Focus on decisions that impact implementation, not trivial choices
- If a decision depends on another, note that dependency in the question
- Highlight decisions that are harder to reverse later
- When user asks questions, research thoroughly before responding
- Provide code examples or architectural diagrams when helpful
- Generate follow-up questions that build on previous design choices
