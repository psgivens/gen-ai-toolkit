Here are some notes. 


Akward: "Type 'iterate' to review and refine the requirements document"
This doesn't tell me where to put the feedback. Iterate, should go back to the interview and ask a single question, what is your feedback of the requirements document. And now we are interviewing again. 


This is akward.

      What would you like to do?
      - Type 'iterate' to review and refine the requirements document
      - Type 'continue to next phase' to move to the design workflow
    
    ✻ Cogitated for 1m 6s
    
    ❯ What does it mean? "Type 'iterate' to review and refine the requirements document"
    
    ● It means if you see anything in REQUIREMENTS.md you want to change -- wording you disagree with, missing details, something that doesn't match your intent
       -- you'd say "iterate" and tell me what to fix, and I'd update the document accordingly.
    
      If you're satisfied with the requirements as they are, "continue to next phase" moves us to the design workflow where we'll make architectural and
      technology decisions.
    
    ❯ continue to next phase
    
    ● Requirements phase complete! Continue to the design workflow to begin design decisions.
    
    ❯ execute ~/.workflows/design


I need the ability to stop the interview to produce a research spike. For instance, give me instructions to get you data you need. I don't expect to get another 5 questions, just the research instructions. Each round questions should list pending research spikes.

It completed without creating user docs.

Explore removing interviews for architecture and plan.

Review the workflows to determine if there is explicit mention of how to test and when to test or if this should be a separate process. Should we build in the ralph wiggum loop. 

I need to build out a workflow for working through a product roadmap and/or backlog. 

I often bite off more than I can chew. When we are working through requirements, I need to build out prompt-instructions for 1) making recommendations to break down the work and 2) making the changes if I agree.  

Anecdote: When designing a new feature, the design asked me which context menu library to use. Other features already had a context menu, so it should have referenced that. 
Problem: Design recommendations are not based on existing architecture/design. 
Solution thoughts: Have a living design/architecture document which describes how we do things and ask design workflow to reference it when making decisions. 

For design: we should also ask for confidence level of recommendation. 

For design: We should ask for tenets up front so that claude can make better design decisions. e.g., I value robustness over smaller size because this is a desktop app so I don't have to worry about network latency. 

Review ./claude/2026-02-10-index-scan-ui/ARCHITECTURE_INTERVIEW.md
Answer the questions in the provided answer section.
If you have follow up questions, ask them in the follow up questions section.

After a document is created (DESIGN.md, ARCHITECTURE.md, etc.), it asks if I want to 'iterate' or 'continue', but I don't know what 'iterate' means. Maybe it should asks, what do you want to do next? Just tell me what edits to make or type 'execute ~/.workflows/XXX' to execute the next workflow. 
