# Naive Approach: Building Software with AI

A straightforward, document-driven workflow for building software with Claude Code using pre-written prompts executed in logical order.

## Overview

The naive approach is a practical method for AI-assisted development that breaks down the software creation process into a series of well-defined steps. Rather than figuring out what to ask Claude on the fly, you follow a structured sequence of pre-written prompts from [PROCESSING.md](./PROCESSING.md) that guide you through requirements gathering, design decisions, and implementation.

As you work through the steps, Claude will create a series of documents (REQUIREMENTS.md, DECISIONS.md, DESIGN.md, etc.) that capture your requirements, decisions, and implementation plan. These documents build on each other as you progress through the workflow.

This approach is called "naive" not because it's simplistic, but because it takes a direct, straightforward path through the development process without complex orchestration or tooling beyond Claude Code itself.

## Why This Approach Works

Based on real-world usage, the naive approach offers several compelling benefits for developers:

- **It works great in practice** - The method has proven effective for building real projects
- **Focus on decisions, not code** - You spend your time making important product and architectural decisions while Claude handles the implementation details
- **Simple execution model** - Just tell Claude "execute step 3 from PROCESSING.md" to run any specific step
- **Natural conversation flow** - The process unfolds as a long-form conversation with clearly defined decision points
- **Claude does the heavy lifting** - Claude builds the implementation plan and executes it, freeing you to focus on what matters

## The 10-Step Workflow

The workflow consists of 10 sequential steps, with each step producing or refining specific documents. You execute these steps in order by instructing Claude to run them from [PROCESSING.md](./PROCESSING.md).

### Steps Overview

1. **Ask and answer questions about requirements** - Claude reads your MISSION.md and creates a GATHER_REQUIREMENTS.md file with initial questions
2. **Read answers and ask follow-up questions** *(iterative)* - Claude reviews your answers and adds clarifying questions to GATHER_REQUIREMENTS.md (repeat as needed)
3. **Build requirements document** - Claude creates a new REQUIREMENTS.md file based on your mission and answers
4. **Ask and answer questions about implementation decisions** - Claude creates a DECISIONS.md file with design choices, options, and trade-offs
5. **Review and update DECISIONS** *(iterative)* - Claude refines the decisions based on your feedback and answers (repeat as needed)
6. **Create a design document** - Claude creates a DESIGN.md file outlining the technical architecture
7. **Create an implementation plan** - Claude creates an IMPLEMENTATION_PLAN.md file with detailed steps and prompts
8. **Review the plan** - Claude analyzes the plan in a subagent and creates a PLAN_ANALYSIS.md file
9. **Update the plan** - Claude updates IMPLEMENTATION_PLAN.md to address any gaps identified in the analysis
10. **Execute the implementation plan** - Claude implements the solution and updates status tracking in IMPLEMENTATION_PLAN.md

See [PROCESSING.md](./PROCESSING.md) for the complete prompts for each step.

## Key Characteristics

### Iterative Review-and-Refine Cycles

Two steps in the workflow are explicitly designed for iteration:

- **Step 2** (Follow-up questions): Repeat this step as many times as needed to fully explore requirements. Each cycle adds ~5 follow-up questions based on your previous answers.
- **Step 5** (Review decisions): Iterate on implementation decisions until all choices are finalized. Claude will answer your follow-up questions, update decision requests, and remove decisions that are no longer valid.

These iterative steps ensure thorough exploration before committing to requirements or design decisions.

### User Review Points

Between each step, you review the generated documents and can:
- Edit content directly
- Answer questions Claude has posed
- Provide additional context or constraints
- Validate that the output meets your expectations

This human-in-the-loop approach keeps you in control while leveraging Claude's capabilities.

### Conversational Flow and Subagents

The naive approach intentionally maintains a **continuous conversation** for most steps. This conversational flow is one of the workflow's key benefits—Claude retains context from previous steps, enabling natural back-and-forth discussion and iteration.

**Why most steps stay in the main conversation:**
- Enables quick clarifications and follow-up questions
- Maintains context across related steps
- Supports iterative refinement (especially Steps 2 and 5)
- Feels collaborative rather than mechanical

**Why Step 8 uses a subagent:**
- **Fresh perspective** - Validation benefits from "fresh eyes" without prior conversation bias
- **Independent review** - Acts as an objective reviewer more likely to catch gaps
- **No iteration needed** - Produces a single analysis document, doesn't require back-and-forth

This selective use of subagents balances the benefits of conversational flow with the value of independent validation.

### Visual Workflow

For a detailed visual representation of how these steps flow together, including the iterative loops and document dependencies, see [WORKFLOW.md](./WORKFLOW.md).

## Getting Started

The naive approach is a solid option for building software with AI assistance. Here's how to use it:

1. **Create your mission** - Write a MISSION.md describing what you want to build
2. **Start at step 1** - Tell Claude: "Execute step 1 from PROCESSING.md"
3. **Review and respond** - After each step, review the generated documents and provide the requested information
4. **Progress sequentially** - Continue through the steps in order, repeating steps 2 and 5 as needed
5. **Execute the plan** - When you reach step 10, Claude will build your solution

The key is to work through the steps systematically, taking time at the decision points to make thoughtful choices about what you want to build and how it should work.

## Documents Generated

Throughout the workflow, Claude will create a set of documents that capture the evolution of your project:

- **MISSION.md** - Your starting point (you create this before step 1)
- **GATHER_REQUIREMENTS.md** - Requirements discovery questions and your answers (created in steps 1-2)
- **REQUIREMENTS.md** - Functional requirements document (created in step 3)
- **DECISIONS.md** - Implementation decisions with options and trade-offs (created in steps 4-5)
- **DESIGN.md** - Technical design and architecture (created in step 6)
- **IMPLEMENTATION_PLAN.md** - Detailed implementation plan with executable prompts (created in steps 7 and 9)
- **PLAN_ANALYSIS.md** - Quality check on plan alignment with requirements (created in step 8)

These documents don't exist until you run the workflow. They serve as both the process artifacts and the documentation for your project.

---

**Ready to try it?** Start by creating a MISSION.md describing what you want to build, then execute step 1 from [PROCESSING.md](./PROCESSING.md).
