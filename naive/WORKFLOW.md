# Naive Approach Workflow

This diagram illustrates the workflow for building scripts with Claude Code using the naive approach documented in PROCESSING.md.

## Key Characteristics

- **User Review Points**: Between each step, the user reviews and potentially edits the generated documents
- **Iterative Steps**: Steps 2 and 5 are designed for review-and-iterate cycles before finalizing
- **Document-Driven**: Each step produces or updates specific documents that inform subsequent steps

## Workflow Diagram

```plantuml
@startuml Naive Approach Workflow

skinparam defaultTextAlignment center
skinparam BoxPadding 10

|User|
start
:Create MISSION.md;
note right
  Describe what you are
  trying to accomplish
end note

|Claude|
:Step 1: Ask questions
about requirements;
note right
  Read MISSION.md
  Generate initial questions
  Create QUESTIONS.md
end note

|User|
:Review and answer
questions in QUESTIONS.md;
note right
  User provides answers
  to initial questions
end note

|Claude|
repeat
  :Step 2: Read answers
  and ask follow-up questions;
  note right
    Review user answers
    Generate 5 follow-up questions
    Update QUESTIONS.md
  end note

  |User|
  :Review follow-up questions
  and provide answers;

  |User|
  backward:User wants more clarification?;

repeat while (Questions finalized?) is (no)
->yes;

|Claude|
:Step 3: Build requirements
document;
note right
  Read MISSION.md and QUESTIONS.md
  Create REQUIREMENTS.md
end note

|User|
:Review and edit
REQUIREMENTS.md;

|Claude|
:Step 4: Ask questions about
implementation decisions;
note right
  Read MISSION.md and REQUIREMENTS.md
  Lead with opinions
  Provide options and trade-offs
  Create DECISIONS.md
end note

|User|
:Review and make
initial decisions;

|Claude|
repeat
  :Step 5: Review and update
  DECISIONS.md;
  note right
    Finalize clear decisions
    Answer follow-up questions
    Update decision requests
    Remove invalid decisions
  end note

  |User|
  :Review decisions,
  provide answers to
  follow-up questions;

  |User|
  backward: User has more questions?;

repeat while (Decisions finalized?) is (no)
->yes;

|Claude|
:Step 6: Create design
document;
note right
  Read REQUIREMENTS.md and DECISIONS.md
  Create DESIGN.md
end note

|User|
:Review and edit
DESIGN.md;

|Claude|
:Step 7: Create implementation
plan;
note right
  Read REQUIREMENTS.md and DESIGN.md
  Include overview, steps, status tracking
  Include prompts for each step
  Create IMPLEMENTATION_PLAN.md
end note

|User|
:Review and edit
IMPLEMENTATION_PLAN.md;

|Claude|
:Step 8: Review the plan
(in subagent);
note right
  Read all documents
  Analyze plan alignment
  Create PLAN_ANALYSIS.md
end note

|User|
:Review
PLAN_ANALYSIS.md;

|Claude|
:Step 9: Update the plan;
note right
  Address gaps from analysis
  Update IMPLEMENTATION_PLAN.md
end note

|User|
:Review updated
IMPLEMENTATION_PLAN.md;

|Claude|
:Step 10: Execute
implementation plan;
note right
  Execute steps sequentially
  Update status tracking
  Generate code/scripts
end note

|User|
:Review implementation
results;

stop

@enduml
```

## Process Flow Summary

### Sequential Steps (1, 3, 4, 6, 7, 8, 9, 10)
These steps follow a linear progression where Claude generates a document and the user reviews/edits before proceeding to the next step.

### Iterative Steps (2, 5)
- **Step 2**: Review-and-iterate on requirements questions until all necessary information is gathered
- **Step 5**: Review-and-iterate on implementation decisions until all design choices are finalized

### Documents Created

1. **MISSION.md** - User-created description of what they're trying to accomplish (Initial step)
2. **QUESTIONS.md** - Requirements discovery questions and answers (Steps 1-2)
3. **REQUIREMENTS.md** - Functional requirements document (Step 3)
4. **DECISIONS.md** - Implementation decisions with options and trade-offs (Steps 4-5)
5. **DESIGN.md** - Technical design/architecture document (Step 6)
6. **IMPLEMENTATION_PLAN.md** - Detailed implementation plan with prompts (Steps 7, 9)
7. **PLAN_ANALYSIS.md** - Analysis of plan alignment with requirements (Step 8)

### User Role

Throughout the process, the user:
- Creates the initial MISSION.md describing what they want to accomplish
- Reviews generated documents after each step
- Provides answers to questions
- Makes implementation decisions
- Edits documents as needed before proceeding
- Validates that each step produces the expected output
