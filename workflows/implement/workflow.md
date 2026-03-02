# Execute Implementation Workflow

## Description
Execute the implementation plan step by step, using an interview-based approach for addressing blockers and questions during execution.

## Trigger
When user invokes this workflow (e.g., `execute ~/.workflows/implement`) or says "execute the plan" or "start implementation"

## Instructions

You are guiding the user through Phase 5: Execute Implementation of a structured development workflow.

**Follow the Interview Pattern** defined in `PATTERNS.md` at the workflows root (fetch from `$WORKFLOWS/PATTERNS.md` if using URL access) when addressing blockers or questions during implementation.

### Step 0: Determine Task Folder
**Follow Task Folder Management Pattern** to establish task folder

### Step 1: Read the Plan

- Check if `PROJECT_CONTEXT.md` exists at project root. If yes, read it first.
- Read `claude/${TASK_FOLDER}/MISSION.md` if it exists — note the **Out of Scope** section
- Read `claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md` to understand all steps
- Read `claude/${TASK_FOLDER}/ARCHITECTURE.md` for architectural guidance
- Verify you understand the full scope before starting

**Out of Scope validation:** Scan all implementation steps and flag any that may implement something listed as Out of Scope in MISSION.md. If a conflict is found, notify the user: "Step [N] may be implementing [X] which is listed as Out of Scope in MISSION.md. Should we proceed, modify, or skip this step?"

**Create PARKING_LOT.md:**
Create `claude/${TASK_FOLDER}/PARKING_LOT.md` with initial content:
```markdown
# Parking Lot

Items discovered during implementation that are out of scope for the current epic.
See MISSION.md "Out of Scope" section for what's explicitly excluded.

## Items

(empty — add items as discovered)
```

### Step 2: Confirm Execution Mode

Before starting, confirm how much autonomy the user wants:

```
Ready to execute [N] steps.

Execution mode:
- **Autonomous** (default): I'll run all steps without stopping, echo a one-line status after each,
  and only pause if a blocker, test failure, or scope issue arises. You can type at any time to interrupt.
- **Interactive**: I'll stop after each step and wait for your "continue" before proceeding.

Which mode? (Press Enter or say "go" for autonomous, or say "interactive" to stop after each step.)
```

Wait for user response. Default to **autonomous** if user says "go", "continue", "start", or just presses Enter.

### Step 3: Execute Implementation Steps

#### Autonomous Execution (default)

Run all steps sequentially without pausing between them. After each step:

1. **Implement the step**
   - Execute the step (write code, create files, etc.)
   - Follow the architecture and patterns defined in ARCHITECTURE.md

2. **Write unit tests if new code was introduced**
   - If the step creates any new function, class, or service: write unit tests for it before marking the step complete
   - Use the test file named in the step's Verification section (from IMPLEMENTATION_PLAN.md)
   - Run `npm test` (or project test command) and confirm all new tests pass
   - Do NOT defer unit tests to a later step — inline testing is the rule

3. **Update Status Tracking immediately**
   - Change status: "Not Started" → "In Progress" → "Complete"
   - Add brief notes about what was done

4. **Echo one-line status** (do NOT stop and wait):
   ```
   ✓ Step [N]/[Total]: [brief summary] — [N items deferred to parking lot / no diversions]
   ```
   Then immediately proceed to the next step.

5. **STOP only for genuine blockers:**
   - A test fails and can't be quickly fixed
   - A blocker requires a design decision (create IMPLEMENTATION_INTERVIEW.md)
   - A step would implement something in MISSION.md's Out of Scope
   - An unexpected dependency or prerequisite is missing

6. **Test as You Go**
   - Unit tests are written inline (step 2 above), not batched at the end
   - After completing each step (whether or not it introduced new code), run the full test suite
   - If tests pass: echo result and continue
   - If tests fail: STOP, report failure, propose fix or use Diversion Protocol

#### Interactive Execution (if user requested)

Stop after each step and prompt:
```
Step [N] complete: [brief summary].
Scope check: Items deferred to PARKING_LOT.md: [N]

Type 'continue' to proceed to Step [N+1], or tell me what to change.
```
Wait for user response before proceeding.

#### Diversion Protocol

When something out-of-scope arises during implementation:

```
Out-of-scope work discovered. Is it blocking the current step?
├─ YES → Create IMPLEMENTATION_INTERVIEW.md (Problem → Options with pros/cons → Decision Question)
│        Present options to user, wait for decision before proceeding
└─ NO → Is it worth pursuing later?
   ├─ YES → Add to PARKING_LOT.md, continue current step
   └─ NO → Acknowledge and discard, continue current step
```

Do NOT interrupt implementation flow for non-blocking discoveries. Add to PARKING_LOT.md and continue.

**Research spike time-box:** If a step requires investigation (testing library behavior, checking feasibility):
- Time-box to 30 minutes
- If not resolved in 30 minutes, escalate: create IMPLEMENTATION_INTERVIEW.md describing what was investigated, what was found, and what decision is needed
- Do not continue open-ended research without a structured decision point

#### Handling Issues and Blockers

If you encounter problems during implementation:
1. Mark the step as "In Progress" with notes about the issue
2. **Use Interview Pattern** to address the blocker:
   - Create or update `claude/${TASK_FOLDER}/IMPLEMENTATION_INTERVIEW.md`
   - Ask questions about the blocker (e.g., "How should we handle [specific issue]?")
   - Propose 2-3 solutions with trade-offs
   - Leave space for user's answer and their questions
   - Wait for user guidance
   - When user responds with "iterate", answer their questions and ask follow-ups if needed
3. Don't skip steps or mark them complete if they have issues

### Step 4: Continue Through All Steps
- Work through each step sequentially without pausing (autonomous mode)
- Keep status tracking updated after every step
- Stay focused on the plan (don't add features not in requirements)
- If user types anything mid-execution, pause, acknowledge, and handle before continuing

### Step 5: Final Verification
When all steps are complete:
1. Perform final testing
2. Verify all requirements from `claude/${TASK_FOLDER}/REQUIREMENTS.md` are met
3. Check code follows architecture from `claude/${TASK_FOLDER}/ARCHITECTURE.md`
4. Prompt:
   ```
   Implementation complete! All steps in claude/${TASK_FOLDER}/IMPLEMENTATION_PLAN.md are done.

   What would you like to do next?
   - Tell me about any issues to fix or refinements to make
   - Continue to the documentation workflow to create user-facing documentation
   ```

## Best Practices
- **Default to autonomous execution** — don't stop and ask unless something is genuinely wrong
- Update status tracking immediately after each step (don't batch updates)
- Be honest about issues or blockers (don't mark things complete if they're not)
- Follow the architecture and patterns defined in ARCHITECTURE.md
- Write clean, maintainable code that follows project standards
- Write unit tests inline — if a step creates a new function, class, or service, write unit tests for it before marking the step complete; run `npm test`; pass: continue; fail: fix and rerun before proceeding
- If you discover requirements issues during implementation, add to PARKING_LOT.md and continue
- Don't add scope or features beyond what's in REQUIREMENTS.md
- If you need to deviate from the plan, note the deviation in status tracking and continue (unless it touches Out of Scope)
- Use the interview pattern (IMPLEMENTATION_INTERVIEW.md) only for genuine blockers that require a user decision
- The bar for stopping is: blocker / test failure / scope violation / user interruption — not routine step completion
