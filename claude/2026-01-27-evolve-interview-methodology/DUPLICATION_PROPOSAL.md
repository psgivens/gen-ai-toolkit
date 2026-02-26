# Pattern Duplication and Consolidation Proposal

## Executive Summary

After analyzing all 6 workflows and PATTERNS.md, I've identified significant pattern overlap and duplication. The current system defines patterns that are actually **parts of the same pattern** rather than distinct patterns. This creates confusion about what "follow the Interview Pattern" means in practice.

**Core Problem**: Users should be able to say "interview me about requirements" and Claude should know exactly what to do, including prompting, waiting, iterating, and finalizing. Currently, this knowledge is split across three supposedly separate patterns that are actually inseparable.

## Pattern Overlap Analysis

### 1. Interview Pattern ⊇ Review Gate Pattern ⊇ Iteration Pattern

**Current State:**
- **Interview Pattern** defines: 15 initial questions, 5 follow-ups, bidirectional Q&A structure
- **Review Gate Pattern** defines: Explicit prompts before proceeding, waiting for user response
- **Iteration Pattern** defines: "iterate" triggers answers + 5 follow-ups, "continue" moves to next phase

**The Problem:**
These three patterns are **not independent**. They are a single integrated pattern:
1. You cannot conduct an interview without prompting the user (Review Gate)
2. You cannot have an "iterate" command outside of an interview context (Iteration Pattern)
3. The Interview Pattern references "iterate" but the actual iterate behavior is in a different pattern
4. Every workflow uses all three patterns together, always, in the same way

**Evidence from workflows:**
```markdown
# Every workflow says:
"Follow the Interview Pattern defined in PATTERNS.md"

# Then every workflow duplicates the Review Gate instructions:
"Explicitly prompt: 'What would you like to do?
- Type 'iterate' to continue...
- Type 'continue to next phase'...'"

# Then every workflow duplicates the Iteration Pattern instructions:
"When user types 'iterate':
- Read the interview file
- Extract answers and questions
- Add responses section
- Generate 5 follow-up questions
- Prompt again"
```

**What this means:**
The Interview Pattern should be **one complete pattern** that includes:
- How to structure the interview document (15 questions, bidirectional Q&A)
- How to prompt the user (Review Gate)
- What "iterate" means (answer questions + 5 follow-ups)
- What "continue to next phase" means (create output document)
- The full iteration cycle from start to finish

### 2. Task Folder Management Pattern (Missing but Duplicated Everywhere)

**Current State:**
Every single workflow has **identical Step 0: Determine Task Folder** with the exact same logic:
- Check if task folder already known from session
- Check for existing task folders under `claude/`
- Prompt user to choose or name a folder
- Create folder if needed
- Remember folder for session
- Echo to user

**The Problem:**
This is duplicated 6 times verbatim (requirements, design, architecture, plan, implement, refinement). It's not documented as a pattern in PATTERNS.md, yet it's a critical shared behavior.

**What this means:**
Should be extracted as **Task Folder Management Pattern** and referenced by all workflows.

### 3. Interview Iteration Mechanics (Duplicated in Every Workflow)

**Current State:**
Every workflow that conducts an interview (5 of them) has nearly identical "Step 5: Interview Iteration" sections:
```markdown
- Read `claude/${TASK_FOLDER}/*_INTERVIEW.md` to extract:
  - User's answers
  - User's questions for Claude
- If user asked questions:
  - Research as needed
  - Add section "## Claude's Responses (Round N)"
- Based on user's answers, add "## Interview Round N+1" with up to 5 follow-up questions
- Prompt: "I've updated... with: Responses to your questions, [N] follow-up questions"
```

**The Problem:**
This is the **execution mechanics** of the Interview Pattern, duplicated 5 times with only minor variations (research focus differs by phase).

**What this means:**
Should be part of the consolidated Interview Pattern definition, not repeated in every workflow.

### 4. Document Generation Pattern (Implicit but Not Named)

**Current State:**
Every workflow eventually:
1. Reads the completed interview
2. Creates an output document (REQUIREMENTS.md, DESIGN.md, ARCHITECTURE.md, etc.)
3. Prompts for review of that document
4. Iterates on the document if needed
5. Finalizes and suggests next workflow

**The Problem:**
This is a consistent pattern across all workflows but isn't documented in PATTERNS.md. The document iteration (non-interview iteration) is different from interview iteration but uses the same "iterate" command, which is confusing.

**What this means:**
Should be extracted as **Document Generation Pattern** to distinguish it from Interview Pattern.

### 5. Prompting Language (Exact Duplication)

**Current State:**
The exact phrase appears in every workflow:
```markdown
"What would you like to do?
- Type 'iterate' to [context-specific action]
- Type 'continue to next phase' to [next action]"
```

**The Problem:**
This standardized prompting language is duplicated rather than referenced. If we want to change the prompt format, we'd need to update 6+ files.

**What this means:**
Should be defined once in a pattern and workflows should just say "Use standard iterate/continue prompt."

## Duplication Metrics

| Pattern/Section | Occurrences | Lines Duplicated |
|-----------------|-------------|------------------|
| Step 0: Determine Task Folder | 6 files | ~120 lines |
| Interview Iteration mechanics | 5 files | ~75 lines |
| Review Gate prompting | 6 files | ~48 lines |
| "What would you like to do?" prompt | 20+ times | ~100 lines |
| "When user types 'iterate'" logic | 10+ times | ~150 lines |
| **Total Estimated Duplication** | | **~493 lines** |

## Proposed Consolidated Pattern Structure

### Pattern 1: Interview Pattern (Consolidated)

**Replaces:** Current "Interview Pattern", "Review Gate Pattern", "Iteration Pattern"

**Complete Definition:**

An interview is a structured conversation where Claude and the user collaborate to gather context, make decisions, and explore details through bidirectional Q&A.

#### Interview Document Structure
```markdown
# [Phase Name] Interview

## Interview Round 1

### Question 1: [Question text]

**Your Answer:**
[Space for user to answer]

**Your Questions for Claude:**
[Space for user to ask questions back]

---

### Question 2: [Question text]
...

---

## Claude's Responses (Round 1)

### Response to Your Question from Q1:
[Detailed answer with research, examples, recommendations]

---

## Interview Round 2

### Question 1: [Follow-up based on previous answers]
...
```

#### Initial Round
1. Create interview document with **up to 15 questions** relevant to the phase
2. Each question includes:
   - **Your Answer:** field
   - **Your Questions for Claude:** field
   - Separator `---`
3. Prompt user: "I've created [FILE] with initial questions. Please:
   1. Answer questions in 'Your Answer' sections
   2. Ask any questions in 'Your Questions for Claude' sections
   3. Type 'iterate' when ready for me to respond

   What would you like to do?
   - Type 'iterate' to continue the interview (I'll answer your questions and ask follow-ups)
   - Type 'continue to next phase' to [context-specific next step]"
4. **Wait for user response** (this is the Review Gate - it's not separate)

#### Iteration Cycle (When user types 'iterate')
1. Read the interview file
2. Extract:
   - User's answers to Claude's questions
   - User's questions for Claude
3. If user asked questions:
   - Research as needed (codebase, docs, patterns, etc.)
   - Add section "## Claude's Responses (Round N)" with detailed answers
   - Include examples, code snippets, diagrams as helpful
4. Based on user's answers, generate new section "## Interview Round N+1" with **up to 5 follow-up questions**
5. Each follow-up includes same structure (Your Answer / Your Questions / separator)
6. Prompt again with same format, incrementing round number
7. **Wait for user response**
8. Repeat if user types 'iterate' again

#### Completion (When user types 'continue to next phase')
1. Read all answers from interview
2. Create output document based on gathered information
3. Prompt for review of output document
4. Allow iteration on output document (same commands)
5. Finalize and suggest next workflow

**Key Principle:** An interview is a complete cycle from initial questions → user answers → Claude responses → follow-ups → output document. It's not three separate patterns.

### Pattern 2: Task Folder Management Pattern (New)

**Currently:** Duplicated as "Step 0" in every workflow

**Complete Definition:**

Every workflow must establish which task folder to use. This pattern defines how to determine or create the task folder.

#### Logic
1. Check if task folder is already known from this session
   - If yes, use it and skip to next step
2. Check for existing task folders under `claude/`
   - If exactly one exists: Ask "I found task folder: claude/[folder-name]. Should I use this one?"
   - If multiple exist: Ask "Which task should I work on?" and list folders with names
   - If none exist: Prompt "What should I name this task folder? (Suggested format: YYYY-MM-DD-description, e.g., '2026-01-22-add-feature')"
3. Create folder if it doesn't exist: `claude/${TASK_FOLDER}/`
4. Remember folder for rest of session
5. Echo to user: "Working on task: ${TASK_FOLDER}"
6. All subsequent paths use `claude/${TASK_FOLDER}/` instead of `claude/`

**Usage in workflows:** "Follow Task Folder Management Pattern to establish task folder"

### Pattern 3: Document Generation Pattern (New)

**Currently:** Implicit in every workflow but not documented

**Complete Definition:**

After completing an interview, transform the gathered information into a structured output document.

#### Process
1. Read all answers from completed interview file
2. Read relevant context documents (REQUIREMENTS.md, DESIGN.md, etc. as needed)
3. Create output document following the appropriate template (see Document Templates section)
4. Ensure output addresses all questions asked in interview
5. Prompt: "I've generated [FILE] based on our interview.

   What would you like to do?
   - Type 'iterate' to review and refine the document
   - Type 'continue to next phase' to [move to next workflow]"
6. **Wait for user response**
7. If 'iterate': Read feedback, update document, prompt again
8. If 'continue': Announce completion and suggest next workflow

**Key Difference:** Document iteration is about refining a completed document, not continuing an interview. Same commands, different context.

### Pattern 4: Status Tracking Convention (Keep As-Is)

**Currently:** Already well-defined and distinct

No changes needed. This pattern is genuinely separate and only used in implementation/refinement workflows.

### Pattern 5: Workflow Progression Pattern (New)

**Currently:** Implied but not documented

**Complete Definition:**

How to move between workflows in the standard sequence:

1. Requirements → Design → Architecture → Plan → Implement
2. Refinement can be invoked at any time
3. When completing a phase, announce: "[Phase] complete! Continue to the [next workflow] to [next action]."
4. Use generic language (not hardcoded paths)
5. User knows how they invoked current workflow and can adapt for next

**Usage:** Provides consistent navigation between workflows

## Proposed Changes to PATTERNS.md

### Structure

```markdown
# Workflow Patterns

## Interview Pattern
[Consolidated definition including Review Gate and Iteration]

## Task Folder Management Pattern
[Extracted from duplicated Step 0]

## Document Generation Pattern
[Formalized from implicit practice]

## Status Tracking Convention
[Keep as-is]

## Workflow Progression Pattern
[Formalized from implicit practice]

## Document Templates
[Keep as-is]
```

## Proposed Changes to Workflow Files

### Before (Current)
```markdown
**Follow the Interview Pattern** defined in PATTERNS.md

### Step 0: Determine Task Folder
- If you already know the current task folder from this session...
[15 lines of detailed logic]

### Step 3: Create Requirements Interview
- Create file following Interview Pattern structure
- Start with "## Interview Round 1"
- Provide up to 15 questions...

### Step 4: Review Gate
- Explicitly prompt: "I've created... Please:
  1. Answer the questions...
  2. Ask any questions...
  3. Type 'iterate'..."
[10 lines of prompting]

### Step 5: Interview Iteration (When user types 'iterate')
- Read interview file to extract:
  - User's answers
  - User's questions for Claude
- If user asked questions:
  - Research as needed
  - Add section "## Claude's Responses (Round N)"
[20 lines of detailed mechanics]
```

### After (Proposed)
```markdown
**Follow the Interview Pattern** defined in PATTERNS.md (in same directory)

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Create Requirements Interview
**Follow Interview Pattern** to conduct requirements interview:
- Initial questions (up to 15) should focus on:
  - Desired outcomes and success criteria
  - Inputs and outputs
  - Edge cases and error handling
  - User scenarios and workflows
  - Constraints and limitations
  - [phase-specific focuses]
- Output document: `REQUIREMENTS.md`
- Next workflow: design

### Step 2: Generate Requirements Document
**Follow Document Generation Pattern** to create `REQUIREMENTS.md` with:
- Overview
- Functional requirements
- Non-functional requirements
- Constraints
- Out of scope
```

**Lines Saved:** ~25-30 lines per workflow × 6 workflows = ~150-180 lines

## Specific Consolidation Recommendations

### 1. Consolidate Three Patterns Into One

**Action:** Merge Interview Pattern, Review Gate Pattern, and Iteration Pattern into a single comprehensive "Interview Pattern"

**Rationale:**
- Cannot conduct interview without Review Gate
- Cannot use "iterate" outside interview context
- Users should understand "interview me" as a complete interaction, not three separate patterns

**Impact:**
- PATTERNS.md becomes clearer and more accurate
- Workflows become shorter (remove duplicated Review Gate and Iteration steps)
- Easier to maintain consistency (one source of truth)

### 2. Extract Task Folder Management Pattern

**Action:** Create new pattern in PATTERNS.md, remove "Step 0" from all workflows

**Rationale:**
- Identical logic in 6 places (~120 lines total duplication)
- Critical shared behavior that should be consistent
- Currently not documented as a pattern despite being universal

**Impact:**
- Workflows reduced by ~20 lines each
- Single source of truth for task folder logic
- Easier to modify folder management behavior

### 3. Formalize Document Generation Pattern

**Action:** Create new pattern in PATTERNS.md describing document creation and iteration

**Rationale:**
- Every workflow does this but it's implicit
- Helps distinguish "iterate on interview" from "iterate on document"
- Clarifies when Interview Pattern ends and Document Pattern begins

**Impact:**
- Clearer workflow structure
- Better separation of concerns
- Easier for users to understand the two types of iteration

### 4. Create Workflow Progression Pattern

**Action:** Document how workflows link together

**Rationale:**
- Currently each workflow hardcodes (or now uses generic language) progression
- Should be defined once as a standard sequence
- Helps users understand the overall methodology

**Impact:**
- Clearer navigation between workflows
- Single source of truth for workflow sequence
- Easier to add or reorder workflows

## Benefits of Consolidation

### For Users
1. **Clearer Mental Model**: "Interview me" means one complete thing, not three separate patterns
2. **Easier to Learn**: Fewer distinct concepts to understand
3. **More Predictable**: Consistent behavior across all workflows
4. **Less Confusing**: Don't have to understand when Review Gate applies vs Interview Pattern

### For Maintainers
1. **Single Source of Truth**: Change interview behavior in one place
2. **Reduced Duplication**: ~500 lines of duplication eliminated
3. **Easier to Extend**: Add new workflow by referencing patterns, not duplicating logic
4. **Better Consistency**: Impossible for workflows to implement patterns differently

### For Claude
1. **Clearer Instructions**: "Follow Interview Pattern" means do the complete interview cycle
2. **Less Ambiguity**: Don't have to interpret three overlapping patterns
3. **More Maintainable**: Patterns accurately reflect the actual structure

## Implementation Plan

### Phase 1: Update PATTERNS.md
1. Consolidate Interview/Review Gate/Iteration into single Interview Pattern
2. Add Task Folder Management Pattern
3. Add Document Generation Pattern
4. Add Workflow Progression Pattern
5. Keep Status Tracking Convention as-is
6. Keep Document Templates as-is

### Phase 2: Simplify Workflow Files
1. Replace "Step 0" with "Follow Task Folder Management Pattern"
2. Replace interview-related steps (Review Gate, Iteration mechanics) with "Follow Interview Pattern" and phase-specific focuses
3. Replace document creation steps with "Follow Document Generation Pattern" and document-specific structure
4. Update "continue to next phase" messages to reference Workflow Progression Pattern

### Phase 3: Validate
1. Test each workflow to ensure consolidated patterns work correctly
2. Verify no functionality is lost
3. Confirm line count reduction (~500 lines)
4. Ensure workflows are more readable

## Questions for User

1. **Pattern Consolidation**: Do you agree that Interview/Review Gate/Iteration are actually one pattern, not three?

2. **Task Folder Management**: Should this be a documented pattern or should each workflow continue to duplicate the logic?

3. **Document vs Interview Iteration**: Is it helpful to distinguish "iterating on an interview" from "iterating on a generated document"?

4. **Simplification Goal**: Are you comfortable with workflows saying "Follow Interview Pattern" instead of spelling out every step of the interview process?

5. **Additional Duplication**: Did I miss any other duplicated patterns or sections that should be consolidated?

## Success Criteria

- ✅ PATTERNS.md accurately reflects the actual pattern structure (not artificial separation)
- ✅ Workflows reference patterns rather than duplicating logic
- ✅ User can say "interview me about X" and Claude knows what to do
- ✅ ~500 lines of duplication eliminated
- ✅ Easier to maintain and extend workflows
- ✅ No loss of functionality or flexibility

---

**Recommendation**: Proceed with consolidation. The current pattern structure creates artificial separation between inseparable concepts, leading to duplication and confusion.
