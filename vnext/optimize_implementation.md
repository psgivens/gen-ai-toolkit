# Optimizing implementation 

 Which model should I use to execute IMPLEMENTATION_PLAN.md? What can I do to optimize claude for executing implementation?

● Good questions. Here's my take:

  Model Choice

  Opus for this task. The implementation plan has 12 steps with significant interdependencies — the scan slice thunk needs to align with the IPC surface,
  the event hook needs to dispatch the right actions, components need to read the right selectors. Opus handles this kind of cross-file coherence better
  than Sonnet, and the cost difference is worth it for getting the wiring right the first time.

  Sonnet would be fine for individual isolated steps (like Step 12 — the type fix), but for the full plan execution where each step builds on the last, Opus
   is the better choice.

  Optimizing Execution

  1. Execute step-by-step, not all at once. Tell Claude to implement one step, verify it compiles/runs, then move to the next. This prevents cascading
  errors and keeps context focused.

  2. Provide the plan as context. Start with something like:
  Read claude/2026-02-10-index-scan-ui/IMPLEMENTATION_PLAN.md and execute
  Step 1. Read the architecture doc if you need design details.

  3. Verify between steps. After each step, run npm run build (or npx tsc --noEmit) to catch type errors before moving on. A broken Step 3 snowballs into a
  broken Step 5.

  4. Commit after each step. Each step is a logical unit — committing gives you rollback points and keeps diffs reviewable.

  5. Handle prerequisites first. Before Step 1:
  - Merge feature/outer-shell to master
  - npm install react-window @types/react-window
  - Verify ScanSearch exists in your lucide-react version

  6. Don't batch too many steps. 3-4 steps per session is a good pace. Context builds up and quality can drift if you push 12 steps in one conversation.

  7. Use the task list. Telling Claude to use the todo tracker (TaskCreate) for the steps gives you visibility into progress and helps Claude stay oriented.

  A suggested opening prompt for the implementation session:

  Read the IMPLEMENTATION_PLAN.md, ARCHITECTURE.md, and DESIGN.md in
  claude/2026-02-10-index-scan-ui/. Execute Step 1. After completing
  each step, run `npx tsc --noEmit` to verify, then move to the next
  step. Stop after Step 4 so I can review.

❯ Create an IMPLEMENTATION_REVIEW_GUIDE.md which explains what I should do after each step to verify.