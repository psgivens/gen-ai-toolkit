# Example Mission Statements

This folder contains example MISSION.md files to help you understand what level of detail to provide.

## EXAMPLE_MISSION.md

A real-world example of a CSV to JSON converter tool. Notice:

- **Clear problem statement**: Explains why this is needed
- **Specific success criteria**: Measurable outcomes
- **Relevant context**: Language preference, target users, environment
- **Constraints**: Boundaries that guide design decisions

## Tips for Writing Your Mission

### Be Specific About What
- "A tool that syncs GitLab projects to local git repos" ✓
- "Something to work with GitLab" ✗

### Include Why
- Helps Claude understand priorities
- Guides trade-off decisions
- Provides context for edge cases

### Define Success
- "Successfully syncs 50 projects without errors" ✓
- "Works well" ✗

### Mention Constraints Early
- Technology preferences (Python, Node, etc.)
- Performance requirements
- Integration points
- Security considerations

### Don't Over-Specify How
- Let requirements and design phases explore approaches
- Focus on problems and outcomes, not solutions
- Exception: If you have a strong preference, mention it as context

## Example Templates

### Tool/Script
```markdown
# Mission: [Tool Name]

## What I Want to Build
[Description of the tool]

## Problem I'm Solving
[The pain point this addresses]

## Success Criteria
- [Measurable outcome 1]
- [Measurable outcome 2]

## Context
- Language: [preference]
- Users: [who will use this]
- Environment: [where it runs]

## Constraints
- [Technical constraints]
- [Time/resource constraints]
```

### Feature Addition
```markdown
# Mission: Add [Feature] to [Project]

## What I Want to Build
[Description of new feature]

## Problem I'm Solving
[Why existing functionality isn't sufficient]

## Success Criteria
[How to measure success]

## Context
- Existing project: [link/description]
- Current architecture: [relevant details]
- Integration points: [what this touches]

## Constraints
- Must maintain backward compatibility
- [Other constraints]
```

### Bug Fix / Enhancement
```markdown
# Mission: Fix [Issue] in [Component]

## Problem Description
[What's wrong and how to reproduce]

## Desired Outcome
[What should happen instead]

## Context
[Relevant system information]

## Success Criteria
- Bug no longer reproduces
- No regressions in related functionality
- [Other criteria]
```
