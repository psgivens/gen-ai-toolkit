# ADR [NUMBER]: [TITLE]

**Status:** [Proposed | Accepted | Deprecated | Superseded by ADR-XXX]

**Date:** [YYYY-MM-DD]

**Deciders:** [Who made this decision, e.g., "Engineering team", "Jane Doe, John Smith"]

**Tags:** [e.g., architecture, database, api, security, performance]

---

## Context

[Describe the issue or problem that needs a decision. Include:]

- **What** is the issue we're trying to solve?
- **Why** does this decision need to be made now?
- **What** constraints or requirements do we have?
- **What** is the current state (if applicable)?

[Provide relevant technical, business, and project context. Be specific about:]
- Performance requirements
- Scale considerations
- Team expertise
- Budget/time constraints
- Existing systems or patterns

**Example:**
> We need to choose a state management solution for our React application. The app will have complex data flows between 20+ components, including real-time updates from WebSockets. The team has limited experience with Redux but strong JavaScript fundamentals. We need a decision by end of week to unblock feature development.

---

## Decision

[State the change we're actually making. Be specific and concrete.]

**We will [specific decision].**

**Example:**
> We will use Zustand for state management in our React application, with separate stores for different feature domains (auth, notifications, data).

---

## Rationale

[Explain WHY we chose this option. What factors influenced the decision?]

**Key factors:**
1. **[Factor 1]:** [Explanation]
2. **[Factor 2]:** [Explanation]
3. **[Factor 3]:** [Explanation]

[Reference design tenets from MISSION.md if applicable]

**Example:**
> **Key factors:**
> 1. **Simplicity:** Zustand has a minimal API and doesn't require boilerplate (aligns with "Simplicity over features" tenet)
> 2. **Learning curve:** Team can be productive in < 1 day vs multiple weeks for Redux
> 3. **Performance:** Zustand's selector-based updates prevent unnecessary re-renders
> 4. **Bundle size:** 1KB vs 8KB+ for Redux + middleware
> 5. **TypeScript support:** Excellent out-of-the-box TypeScript support

---

## Consequences

### Positive

- ✅ [Good consequence 1]
- ✅ [Good consequence 2]
- ✅ [Good consequence 3]

### Negative

- ❌ [Bad consequence 1 and mitigation if any]
- ❌ [Bad consequence 2 and mitigation if any]

### Neutral

- ⚪ [Neutral consequence 1 - neither good nor bad but worth noting]
- ⚪ [Neutral consequence 2]

**Example:**
> ### Positive
> - ✅ Developers can start building features immediately with minimal training
> - ✅ Less boilerplate code means faster feature development
> - ✅ Smaller bundle size improves page load times
> - ✅ Built-in DevTools support for debugging
>
> ### Negative
> - ❌ Smaller ecosystem than Redux means fewer third-party integrations
>   - *Mitigation:* Most integrations we need (persist, devtools) are available
> - ❌ Less prescriptive architecture could lead to inconsistent patterns
>   - *Mitigation:* We'll establish patterns in CLAUDE.md and enforce in code review
>
> ### Neutral
> - ⚪ Different from what some team members used at previous companies
> - ⚪ Will need to document our store organization conventions

---

## Alternatives Considered

### Alternative 1: [Name, e.g., "Redux Toolkit"]

**Pros:**
- [Pro 1]
- [Pro 2]

**Cons:**
- [Con 1]
- [Con 2]

**Why rejected:** [Specific reason this wasn't chosen]

**Example:**
> ### Alternative 1: Redux Toolkit
>
> **Pros:**
> - Industry standard with massive ecosystem
> - Excellent TypeScript support
> - Well-documented patterns and best practices
> - Many team members familiar from other projects
>
> **Cons:**
> - Significant boilerplate even with Toolkit
> - Steep learning curve for team members without Redux experience
> - Larger bundle size (8KB+ for core + middleware)
> - More complex setup and configuration
>
> **Why rejected:** The learning curve and boilerplate overhead outweigh the ecosystem benefits for our team size and timeline. The "Simplicity over features" tenet applies here.

### Alternative 2: [Name, e.g., "React Context + useReducer"]

**Pros:**
- [Pro 1]
- [Pro 2]

**Cons:**
- [Con 1]
- [Con 2]

**Why rejected:** [Reason]

### Alternative 3: [Name, e.g., "Jotai"]

**Pros:**
- [Pro 1]
- [Pro 2]

**Cons:**
- [Con 1]
- [Con 2]

**Why rejected:** [Reason]

---

## Implementation Notes

[Specific guidance for implementing this decision. Include:]

- **Files/modules affected:** [Where changes will be made]
- **Migration path:** [How to transition from current state, if applicable]
- **Testing approach:** [How to verify the decision is implemented correctly]
- **Rollout plan:** [Phased rollout, all-at-once, feature flag, etc.]
- **Success criteria:** [How we'll measure if this decision was good]

**Example:**
> ### Implementation
>
> **Files affected:**
> - Create `src/stores/` directory for all Zustand stores
> - Update `src/App.tsx` to provide store context
> - Migrate existing Context providers in `src/contexts/` to Zustand stores
>
> **Migration path:**
> 1. Install zustand: `npm install zustand`
> 2. Create base store structure in `src/stores/template.ts`
> 3. Migrate auth context first (low risk, isolated)
> 4. Migrate remaining contexts one by one
> 5. Remove old context files after migration confirmed
>
> **Testing:**
> - All existing tests must pass after migration
> - Add integration tests for store interactions
> - Manual testing of all features using state management
>
> **Rollout:**
> - Migrate feature-by-feature behind feature flags
> - Test each migration in staging before production
> - Complete migration within 2 sprints
>
> **Success criteria:**
> - No production issues related to state management
> - Developer feedback is positive (survey after 1 month)
> - Feature development velocity maintained or improved
> - State-related bugs decrease by 30%

---

## References

[Links to related resources:]

- **Discussion:** [Link to RFC, GitHub discussion, Slack thread, etc.]
- **Documentation:** [Link to official docs, guides, tutorials]
- **Prototypes:** [Link to proof-of-concept code, benchmark results]
- **Related ADRs:** [Link to ADRs that this relates to or supersedes]
- **Design tenets:** [Link to MISSION.md tenets that influenced this decision]

**Example:**
> - **Discussion:** https://github.com/company/project/discussions/123
> - **Zustand docs:** https://github.com/pmndrs/zustand
> - **Prototype:** https://github.com/company/project/tree/spike/zustand-poc
> - **Benchmark results:** docs/benchmarks/state-management-comparison.md
> - **Related:** Supersedes ADR-005 (React Context for state management)
> - **Design tenets:** MISSION.md - "Simplicity over features"

---

## Update History

[Track significant changes to this ADR:]

- **[YYYY-MM-DD]:** Status changed from Proposed to Accepted - [Reason]
- **[YYYY-MM-DD]:** Updated implementation notes after team review
- **[YYYY-MM-DD]:** Status changed to Deprecated - [Reason, link to replacement ADR]

**Example:**
> - **2026-01-15:** Status changed from Proposed to Accepted after team vote (5-1)
> - **2026-02-01:** Added migration path details after sprint planning
> - **2026-03-15:** Implementation complete, success criteria met

---

## Template Usage Notes

*Remove this section when creating actual ADR*

### When to Create an ADR

Create an ADR for decisions that:
- Are hard to reverse later
- Impact multiple components or teams
- Involve significant trade-offs
- Select between fundamentally different approaches
- Make technology selections (databases, frameworks, major libraries)

### ADR Numbering

- Use sequential numbers: ADR-001, ADR-002, etc.
- Check `docs/adrs/` to find next number
- Use leading zeros for sorting: ADR-001 through ADR-999

### ADR Status Flow

1. **Proposed** - Under discussion
2. **Accepted** - Decision made and approved
3. **Deprecated** - No longer recommended (link to replacement)
4. **Superseded** - Replaced by newer ADR (link to replacement)

### Tips for Writing Good ADRs

- **Be specific:** "Use PostgreSQL 15" not "Use a database"
- **Explain trade-offs:** Why this over alternatives
- **Include examples:** Show concrete code or architecture
- **Think long-term:** Future developers (including AI) will read this
- **Update when needed:** Don't let ADRs become outdated
- **Link context:** Reference design tenets, related ADRs, discussions
