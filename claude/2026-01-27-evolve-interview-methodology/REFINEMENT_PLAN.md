# Refinement Plan: Interview Pattern Implementation

## Overview

Implement the centralized Interview Pattern methodology across all workflow skills. This replaces the current question/answer approach with a bidirectional Q&A system that enables users to ask questions back to Claude during any phase.

## Scope

### What Will Change
- Add "Interview Pattern" section to `.claude/CLAUDE.md`
- Update 6 skill files to reference the interview pattern
- Rename artifact files from `GATHER_REQUIREMENTS.md` → `REQUIREMENTS_INTERVIEW.md`, `DECISIONS.md` → `DESIGN_INTERVIEW.md`, etc.
- Rename `decisions` skill to `design` for consistency

### What Won't Change
- Output artifact structures (REQUIREMENTS.md, DESIGN.md, etc.) remain the same
- Review Gate Pattern and core iteration behavior
- Task folder management and naming conventions
- Status tracking tables in implementation plans

## Risk Analysis

### Low Risk Changes
- Adding new section to CLAUDE.md (additive, doesn't break existing)
- Updating skill instructions (isolated to each skill)

### Medium Risk Changes
- Renaming `decisions` → `design` skill (users may reference old name)
- Changing artifact naming convention (GATHER_REQUIREMENTS → REQUIREMENTS_INTERVIEW)

### Mitigation
- Keep changes focused and test incrementally
- Document the new pattern clearly in CLAUDE.md
- Skills will create new interview files, not modify existing ones

## Prerequisites

- [x] INTERVIEW_PATTERN_PROPOSAL.md reviewed and accepted
- [x] Working directory: `/home/phillipgivens/repos/gen-ai-dev-kit/template/`
- [ ] Backup current state (optional, git provides version control)

## Refactoring Steps

| Step | Status | Notes |
|------|--------|-------|
| 1. Add Interview Pattern to CLAUDE.md | Complete | Core pattern definition added |
| 2. Update requirements skill | Complete | References Interview Pattern, uses REQUIREMENTS_INTERVIEW.md |
| 3. Rename and update decisions → design skill | Complete | Folder renamed, references Interview Pattern, uses DESIGN_INTERVIEW.md |
| 4. Update architecture skill | Complete | References Interview Pattern, uses ARCHITECTURE_INTERVIEW.md |
| 5. Update plan skill | Complete | References Interview Pattern, uses PLAN_INTERVIEW.md |
| 6. Update implement skill | Complete | References Interview Pattern, uses IMPLEMENTATION_INTERVIEW.md for blockers |
| 7. Update refinement skill | Complete | References Interview Pattern, uses REFINEMENT_INTERVIEW.md |
| 8. Update CLAUDE.md document templates | Complete | Already updated in Step 1 |

## Step Details

### Step 1: Add Interview Pattern to CLAUDE.md
**Files:** `.claude/CLAUDE.md`

**Changes:**
- Add new "Interview Pattern" section after "Iteration Pattern"
- Define interview document structure
- Explain iteration cycle (15 initial, 5 follow-up questions)
- Document how skills reference the pattern

**Impact:** Non-breaking (additive only)

**Testing:** Read the file to verify section is clear

---

### Step 2: Update Requirements Skill
**Files:** `.claude/skills/requirements/skill.md`

**Changes:**
- Reference Interview Pattern from CLAUDE.md
- Change artifact name: `GATHER_REQUIREMENTS.md` → `REQUIREMENTS_INTERVIEW.md`
- Add phase-specific interview guidance
- Update step instructions to follow interview cycle

**Impact:** Non-breaking (creates new file names)

**Testing:** Review the skill instructions for clarity

---

### Step 3: Rename and Update Decisions → Design Skill
**Files:**
- `.claude/skills/decisions/` → `.claude/skills/design/`
- `.claude/skills/design/skill.md`

**Changes:**
- Rename folder from `decisions` to `design`
- Reference Interview Pattern from CLAUDE.md
- Change artifact name: `DECISIONS.md` → `DESIGN_INTERVIEW.md`
- Keep recommendation format in questions
- Add phase-specific interview guidance

**Impact:** Breaking (skill command changes from `execute .claude/skills/decisions` → `execute .claude/skills/design`)

**Testing:** Verify folder rename successful, review skill instructions

---

### Step 4: Update Architecture Skill
**Files:** `.claude/skills/architecture/skill.md`

**Changes:**
- Reference Interview Pattern from CLAUDE.md
- Add artifact name: `ARCHITECTURE_INTERVIEW.md`
- Add phase-specific interview guidance
- Update step instructions to follow interview cycle

**Impact:** Non-breaking

**Testing:** Review skill instructions

---

### Step 5: Update Plan Skill
**Files:** `.claude/skills/plan/skill.md`

**Changes:**
- Reference Interview Pattern from CLAUDE.md
- Add artifact name: `PLAN_INTERVIEW.md`
- Add phase-specific interview guidance
- Update step instructions to follow interview cycle

**Impact:** Non-breaking

**Testing:** Review skill instructions

---

### Step 6: Update Implement Skill
**Files:** `.claude/skills/implement/skill.md`

**Changes:**
- Reference Interview Pattern from CLAUDE.md
- Add artifact name: `IMPLEMENTATION_INTERVIEW.md` (for ongoing communication)
- Add phase-specific interview guidance
- Update step instructions to follow interview cycle

**Impact:** Non-breaking

**Testing:** Review skill instructions

---

### Step 7: Update Refinement Skill
**Files:** `.claude/skills/refinement/skill.md`

**Changes:**
- Reference Interview Pattern from CLAUDE.md
- Change artifact name: `REFINEMENT_QUESTIONS.md` → `REFINEMENT_INTERVIEW.md`
- Add phase-specific interview guidance
- Update step instructions to follow interview cycle

**Impact:** Non-breaking

**Testing:** Review skill instructions

---

### Step 8: Update CLAUDE.md Document Templates
**Files:** `.claude/CLAUDE.md`

**Changes:**
- Update "Document Templates" section
- Add references to `*_INTERVIEW.md` files
- Update naming conventions (GATHER_REQUIREMENTS → REQUIREMENTS_INTERVIEW, etc.)
- Update workflow phase descriptions

**Impact:** Non-breaking (documentation update)

**Testing:** Review for consistency

---

## Validation Steps

After each step:
1. Read the modified file to verify changes
2. Check that references are consistent
3. Ensure phase-specific guidance is preserved

After all steps:
1. Review CLAUDE.md for completeness
2. Review all skill files for consistency
3. Verify interview pattern is clearly defined
4. Check that all file paths are correct

## Rollback Plan

If issues arise:
1. Git provides version control - can revert individual commits
2. Each step is isolated - can rollback specific skills without affecting others
3. No data loss risk - new files are created, old files aren't deleted

## Success Criteria

- [ ] Interview Pattern section added to CLAUDE.md with complete definition
- [ ] All 6 skills reference the interview pattern
- [ ] All skills include phase-specific interview guidance
- [ ] `decisions` skill renamed to `design`
- [ ] All artifact naming updated to `*_INTERVIEW.md` pattern
- [ ] Document templates section updated in CLAUDE.md
- [ ] All file paths are relative (`.claude/` not `template/.claude/`)

---

**Status:** ✅ COMPLETE
**Approved by:** User accepted proposal
**Completed:** 2026-01-27

## Completion Summary

All steps executed successfully:

✅ **Step 1:** Added Interview Pattern section to `.claude/CLAUDE.md` with complete definition
✅ **Step 2:** Updated requirements skill to use `REQUIREMENTS_INTERVIEW.md`
✅ **Step 3:** Renamed `decisions` → `design` skill, uses `DESIGN_INTERVIEW.md`
✅ **Step 4:** Updated architecture skill to use `ARCHITECTURE_INTERVIEW.md`
✅ **Step 5:** Updated plan skill to use `PLAN_INTERVIEW.md`
✅ **Step 6:** Updated implement skill to use `IMPLEMENTATION_INTERVIEW.md` for blockers
✅ **Step 7:** Updated refinement skill to use `REFINEMENT_INTERVIEW.md`
✅ **Step 8:** Document templates updated in Step 1

### Validation Results

- ✅ Interview Pattern section exists in `.claude/CLAUDE.md` (line 136)
- ✅ All 6 skills reference the Interview Pattern (12 references found)
- ✅ `decisions` skill successfully renamed to `design`
- ✅ All file paths use relative paths (`.claude/` not `template/.claude/`)
- ✅ Skills list updated in CLAUDE.md (`execute .claude/skills/design`)
- ✅ Workflow Patterns section updated with new naming
- ✅ Review Gate examples updated to use interview naming

### Files Modified

1. `.claude/CLAUDE.md` - Added Interview Pattern, updated references
2. `.claude/skills/requirements/skill.md` - Interview-based approach
3. `.claude/skills/design/skill.md` - Renamed from decisions, interview-based
4. `.claude/skills/architecture/skill.md` - Interview-based approach
5. `.claude/skills/plan/skill.md` - Interview-based approach
6. `.claude/skills/implement/skill.md` - Interview for blockers
7. `.claude/skills/refinement/skill.md` - Interview-based approach
