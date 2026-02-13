# Building process with AI

This document contains the 'steps' I use when building with claude code.
There are steps that I repeat (Steps 2 and 5 are designed for iteration).

## About the Workflow

**Conversational approach:** Most steps execute in the main conversation to maintain context and enable natural back-and-forth discussion. This conversational flow is a key benefit of the naive approach—Claude remembers what you discussed and can ask clarifying questions as you progress.

**When to use subagents:** Only Step 8 (Review the plan) uses a subagent. This is intentional—validation benefits from a "fresh eyes" perspective, while all other steps benefit from maintaining conversational context.

## Building the scripts. 


Step 1. Ask and answer questions about requirements
Prompt:
> Read MISSION.md to determine what we are doing.
> Create GATHER_REQUIREMENTS.md and ask me 8-10 questions to help determine requirements.
> Focus on WHAT I want to happen, inputs, outputs, and edge cases. Do not ask
> about implementation or HOW we will achieve it.
> Leave space after each question for my answers. 

Step 2: Read answers and ask follow up questions
Prompt:
> I've answered the questions in GATHER_REQUIREMENTS.md. Read my answers and create a new
> section with up to 5 follow-up questions based on my responses.

Step 3: Build requirements document
Prompt:
> Based on our mission in MISSION.md and the answers I've given you in
> GATHER_REQUIREMENTS.md, create a requirements document REQUIREMENTS.md.
> Include: functional requirements, non-functional requirements, constraints,
> and explicitly state what is out of scope.

Step 4: Ask and answer questions about implementation decisions
Prompt: 
> Based on the MISSION.md and REQUIREMENTS.md document, ask me to make
> design/architectural decisions in DECISIONS.md. 
> 
> * Lead with an opinion. It should feel like you are proposing a choice 
> where possible. 
> * Provide options and trade offs, but keep it brief.
> * Provide a space for me to provide my answer and any follow up questions
> I may have. 

Step 5: Review and update DECISIONS
Prompt:
> I've made edits to DECISIONS.md including making decisions and asking
> follow-up questions. Where the decision seems final, mark it as DECIDED.
> Where there are questions, answer them and update the decision request.
> If a decision is no longer valid based on other decisions, mark it as
> INVALIDATED or remove it. 

Step 6. Create a design document
Prompt: 
> Read the REQUIREMENTS.md and DECISIONS.md and create a design/architecture
> document, DESIGN.md. 

Step 7. Create an implementation plan
Prompt:
> Based on the REQUIREMENTS.md and DESIGN.md documents, create an implementation
> plan IMPLEMENTATION_PLAN.md. The plan should include:
> - Overview of what we are trying to accomplish
> - Numbered implementation steps
> - Status tracking table
> - Each step should contain enough detail that it could be executed independently
> When a user tells Claude to execute the plan, Claude should execute each step
> sequentially and update the status tracking as each step completes. 

Step 8. Review the plan
Prompt (execute in a subagent):
> Read IMPLEMENTATION_PLAN.md, REQUIREMENTS.md, DECISIONS.md, and DESIGN.md.
> Create PLAN_ANALYSIS.md which evaluates whether the implementation plan will
> achieve what is set out in the requirements and honor the decisions made.
> Identify any gaps, risks, or missing steps.

**Note:** This is the only step that uses a subagent. Why? Independent validation benefits from a fresh perspective without prior conversation context. The subagent acts as an independent reviewer, more likely to catch gaps or inconsistencies. All other steps maintain conversational context to enable natural iteration and clarification.

Step 9. Update the plan
Prompt:
> Read IMPLEMENTATION_PLAN.md, REQUIREMENTS.md, DECISIONS.md, and based
> on the analysis in PLAN_ANALYSIS.md, update IMPLEMENTATION_PLAN.md to
> address any gaps identified. 

Step 10. Execute the implementation plan
Prompt:
> Execute IMPLEMENTATION_PLAN.md and update the status tracking along the way. 

