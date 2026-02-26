# Refinement Clarification Questions

## Question 1: Interview Document Structure

What should the exact structure of each interview question look like in the markdown files?

For example, should it be:

**Option A:**
```markdown
### Question 1: [Question text]

**Your Answer:**
[Space for answer]

**Your Questions for Claude:**
[Space for user questions]

---
```

**Option B:**
```markdown
## Q1: [Question text]

### Answer:
[Space]

### Questions:
[Space]
```

Or something else?

**Your Answer:**
I like Option A, but be sure to maintain the 'Question' section may have more than just the question as specified in the instructions. 



**Your Questions for Claude:**




---

## Question 2: Iteration Cycle Details

When the user types "iterate" and Claude reads their answers and questions:

1. Should Claude's answers to user questions be written **in the same INTERVIEW.md file** (perhaps in a new section like "### Claude's Responses")?
2. Or should they go in a **separate file** like `INTERVIEW_RESPONSES.md`?
3. Should the 5 new follow-up questions be **appended** to the existing INTERVIEW.md or **replace** the old questions?

**Your Answer:**
Append to the end of the file. 



**Your Questions for Claude:**




---

## Question 3: Phase-Specific Interview Customizations

Each phase has unique characteristics:

- **Requirements**: Focus on WHAT not HOW, understand user needs
- **Design**: Provide recommendations, trade-off analysis, alternatives with pros/cons
- **Architecture**: Key components, data flows, technology choices
- **Plan**: Implementation steps, status tracking
- **Implement**: Execution of steps

For the **Design interview** specifically, you mentioned it should "still provide recommendations." Should Claude:
1. Present recommendations **within each question** (e.g., "What architecture pattern should we use? I recommend X because...")?
2. Or present recommendations in a **separate section** before the questions?
3. Or present them as the **first few questions** with built-in recommendations?

How should this work for other phases?

**Your Answer:**




**Your Questions for Claude:**




---

## Question 4: Transition and Migration Strategy

Since we're not maintaining backwards compatibility:

1. Should we **rename** the existing skills (e.g., `decisions` → `design-interview`) or keep the folder names but change the internal documents?
2. Should old artifact names like `GATHER_REQUIREMENTS.md` be mentioned at all in the new skills, or completely removed from documentation?
3. Should there be any migration guide for users with existing task folders using the old format?

**Your Answer:**
No need for any of that. Just update the skill. 



**Your Questions for Claude:**




---

## Question 5: Testing and Validation

How should we validate that these changes work correctly?

1. Should we create a **test task folder** using the new interview methodology to verify the flow?
2. Are there specific scenarios or edge cases we should test (e.g., user asks 10 questions, Claude needs to do research)?
3. What does "success" look like for this refinement? What criteria confirm the interview methodology is working as intended?

**Your Answer:**




**Your Questions for Claude:**




---

**Next Step:** Please answer these questions in the spaces provided. Type "iterate" when ready for follow-up questions, or "ready for plan" to proceed with creating the execution plan.
