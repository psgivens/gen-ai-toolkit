# Refinement Plan: Add Refinement Skill to README

## Overview

Restructure the `claude/README.md` to present two distinct workflows:
1. **Development Activity** - The existing 5-phase workflow for building new features
2. **Refinement Activity** - A streamlined workflow for maintenance tasks

This change introduces refinement as a first-class workflow option while preserving all existing development workflow documentation.

## Scope

**Will change:**
- `claude/README.md` - Major restructuring to support two workflows

**Will NOT change:**
- Skill files (`.claude/skills/*/skill.md`)
- Example files
- Other documentation files

## Risk Analysis

**Risks:**
- Breaking existing links or references to sections
- Confusing users with too many options
- Making the README too long

**Mitigation:**
- Preserve all existing section content, just reorganize
- Use clear headers and structure to distinguish workflows
- Provide decision guidance early in the document

## Prerequisites

- [X] Backup exists (git history)
- [X] Current README reviewed
- [X] User requirements understood

## Refactoring Steps

### Step 1: Update "What Is This?" Section
**Files:** `claude/README.md`
**Impact:** Non-breaking
**Description:** Introduce both workflows in the opening section

**Changes:**
- Add brief mention of two workflow options
- Keep it high-level (2-3 sentences each)
- Set expectation that both will be detailed later

### Step 2: Add "Choosing Your Workflow" Section
**Files:** `claude/README.md`
**Impact:** Non-breaking (new content)
**Description:** Help users decide between development and refinement

**Changes:**
- Create new section after "What Is This?"
- Provide decision criteria
- Include examples of when to use each workflow
- **Key message:** Both workflows maintain the same deliberate, human-in-the-loop approach (questions → plan → execute with review gates)
- Emphasize: Refinement is streamlined for scope, not for control

### Step 3: Restructure Content with "Development Activity" Section
**Files:** `claude/README.md`
**Impact:** Non-breaking (organizational change)
**Description:** Move existing 5-phase content under "Development Activity" heading

**Changes:**
- Add "## Development Activity" header
- Keep all existing subsections intact:
  - Why This Approach?
  - Quick Start
  - The Workflow in Detail (all 5 phases)
  - Skills Reference table (updated with activity column)

### Step 4: Add "Refinement Activity" Section
**Files:** `claude/README.md`
**Impact:** Non-breaking (new content)
**Description:** Document the refinement workflow in detail

**Changes:**
- Add "## Refinement Activity" section
- Include:
  - What refinement is for (maintenance tasks: documentation, refactoring, cleanup, renaming)
  - **Why use refinement:** Still want Claude to ask questions, create a plan, and get approval before executing
  - When to use it vs. development workflow
  - The refinement workflow: REFINEMENT.md → questions → plan → execute
  - Quick start instructions (`execute .claude/skills/refinement`)
  - Detailed workflow walkthrough (emphasize the question/plan/review steps)
  - Review gates and iteration pattern (same as development workflow)

### Step 5: Update Skills Reference Table
**Files:** `claude/README.md`
**Impact:** Non-breaking
**Description:** Add "Activity" column to distinguish development vs. refinement skills

**Changes:**
- Add "Activity" column to skills table
- Mark 5 development skills as "Development"
- Add refinement skill row marked as "Refinement"

### Step 6: Update Examples and Best Practices
**Files:** `claude/README.md`
**Impact:** Non-breaking
**Description:** Ensure examples mention both workflows appropriately

**Changes:**
- Update "Example Session" to clarify it's showing development workflow
- Add brief refinement example
- Update "Best Practices" if needed

### Step 7: Update Navigation and Cross-References
**Files:** `claude/README.md`
**Impact:** Non-breaking
**Description:** Ensure internal links and references still work

**Changes:**
- Verify all section references
- Update table of contents if one exists
- Ensure "Next Steps" section mentions both workflows

## Status Tracking

| Step | Status | Notes |
|------|--------|-------|
| 1. Update "What Is This?" Section | Complete | Both workflows introduced |
| 2. Add "Choosing Your Workflow" Section | Complete | Decision criteria added |
| 3. Restructure with "Development Activity" | Complete | Sections reorganized |
| 4. Add "Refinement Activity" Section | Complete | Comprehensive refinement docs added |
| 5. Update Skills Reference Table | Complete | Activity column added, refinement included |
| 6. Update Examples and Best Practices | Complete | Examples clarified, Next Steps updated |
| 7. Update Navigation and Cross-References | Complete | Directory structure and best practices updated |

## Validation Steps

After completing all steps:

1. **Read through the entire README** to verify flow and coherence
2. **Check for broken links** or section references
3. **Verify both workflows are clearly explained** and distinguished
4. **Ensure consistency** in terminology and formatting
5. **Get user approval** before considering complete

## Rollback Plan

If issues arise:
- Git history preserves original README
- Can revert with: `git checkout HEAD -- claude/README.md`
- Or manually restore sections from git history

## Expected Outcome

**Before:**
- Single workflow (5 phases)
- No mention of refinement
- Users may not know lighter-weight option exists

**After:**
- Two clearly distinguished workflows
- Decision guidance for choosing between them
- **Clear messaging:** Both workflows maintain human control with questions → plan → execute pattern
- Refinement positioned as streamlined for maintenance tasks, not as "quick and dirty"
- Refinement documented with appropriate detail level
- Skills table shows which activity each skill belongs to
- Users can confidently choose the right workflow for their task

## Non-Breaking Changes Guarantee

All changes are additive or organizational:
- No content is removed
- All existing sections are preserved
- Only additions and reorganization
- Existing skill files unchanged
- No changes to project structure
