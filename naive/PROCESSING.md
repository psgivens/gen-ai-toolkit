# Building process with AI

This document contains the 'steps' I use when building with claude code.
There are steps that I repeat. 


## Building the scripts. 


Step 1. Ask and answer questions about requirements
Prompt:
> Read the MISSION.md to determine what we are doing. 
> Ask me questions in QUESTIONS.md to help determine requirements. 
> Ask me about what I want to happen, inputs, and outputs. Do not ask
> me about implementation or how we are going to acheive it. Leave
> an area for me to provide my answers. 

Step 2: Read answers and ask follow up questions
Prompt: 
> I've answered the questions in QUESTIONS.md. Create a new section with any follow up questions you may have. Keep this short, maybe 5 questions

Step 3: Build requirements document
Prompt: 
> Based on our mission in MISSION.md and the answers I've given you in
> QUESTIONS.md, create an a requirements document REQUIREMENTS.md

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
> I've made dedits to DECISIONS.md including making decisions and asking follow up questions. Where the decision seems final, document it that way. Where there are questions, answer the questions and update the decision request. If a decision is no longer valid based 
> on other decisions, you can remove it. 

Step 6. Create a design document
Prompt: 
> Read the REQUIREMENTS.md and DECISIONS.md and create a design/architecture
> document, DESIGN.md. 

Step 7. Create an implementation plan
Prompt: 
> Based on the REQUIREMENTS.md and DESIGN.md documents, create an implementation 
> plan. The plan should have an overview of what we are trying to accomplish,
> steps to implement the script, and status tracking. 
> Each step should contain a prompt in order to execute the step and should 
> tell claude to execute the step within a subagent. 
> When a user tells claude to execute the plan, claude should have enough instructions
> to know to execute each step and to update the status tracking. 

Step 8. Review the plan
Prompt: In a subagent
> Read the IMPLEMENTATION_PLAN.md, REQUIREMENTS.md, DECISIONS.md and DESIGN.md. 
> Write a PLAN_ANALYSIS.md which tells me if the implementation plan will achieve 
> what is set out in the requirements and decisions made. 

Step 9. Update the plan
> Read the IMPLEMENTATION_PLAN.md, REQUIREMENTS.md, and DECISIONS.md and based 
> on analysis in PLAN_ANALYSIS.md, update the IMPLEMENTATION_PLAN.md to 
> address any gaps. 

Step 10. Execute the implementaiton plan
Prompt: 
> Execute IMPLEMENTATION_PLAN.md and update the status tracking along the way. 

