# Project Refinement

<!--
Replace this template with your refinement goals.
Describe what you want to improve, refactor, or reorganize.
-->

## Type of Refinement

- [x] Code refactoring (improve internal structure)
- [ ] Reorganization (move files, restructure directories)
- [ ] Global renaming (rename functions, classes, variables)
- [x] Code cleanup (remove unused code, improve consistency)
- [ ] Performance optimization
- [x] Other: Methodology evolution - changing from questions/decisions to interview-based approach

## What I Want to Refine

Transform the entire workflow methodology from a "questions and decisions" pattern to an "interview-based" pattern. This affects all workflow skills (requirements, decisions, architecture, plan, implement) and the refinement skill itself.

## Current Issues

The current approach uses files named like:
- GATHER_REQUIREMENTS.md
- DECISIONS.md

And has a simple question/answer pattern without the ability for users to ask questions back to Claude.

## Desired Outcome

1. **Rename artifacts** to use "INTERVIEW" pattern:
   - REQUIREMENTS_INTERVIEW.md (instead of GATHER_REQUIREMENTS.md)
   - DESIGN_INTERVIEW.md (instead of DECISIONS.md)
   - Similar renames for other phases

2. **New interview structure** for all phases:
   - Claude provides up to 15 questions initially
   - Each question has:
     - Space for user answer
     - Space for user to ask their own questions
   - When user types "iterate":
     - Claude reads answers
     - Claude answers user's questions (doing research if needed)
     - Claude generates 5 new follow-up questions
     - Repeat

3. **Preserve phase-specific behaviors**:
   - Design interview: Still provide recommendations and trade-offs
   - Requirements interview: Still focus on WHAT not HOW
   - Architecture interview: Still provide architectural options
   - etc.

## Scope

Files to modify:
- `template/.claude/skills/requirements/skill.md`
- `template/.claude/skills/decisions/skill.md`
- `template/.claude/skills/architecture/skill.md`
- `template/.claude/skills/plan/skill.md`
- `template/.claude/skills/implement/skill.md`
- `template/.claude/skills/refinement/skill.md`
- `template/.claude/CLAUDE.md` (update document templates and references)

## Constraints

- Does not need to maintain backwards compatibility with existing task folders that use the old naming
- Must preserve the phase-specific guidance (e.g., design interviews still provide recommendations)
- Must maintain the review gate pattern

---

**Next Step**: Once you've filled this out, tell Claude you're ready to proceed.
