# Feature Breakdown Guide

**When to use this:** You have a large project or multiple features to build and want to break them down BEFORE starting requirements workflow.

## Current Approach (No Workflow Yet)

Since the roadmap workflow doesn't exist yet, here's how to break down features manually:

### Step 1: Ask Claude for Breakdown Recommendations

In your conversation, paste this prompt:

```
I'm planning to build [describe your project]. Before I start the requirements workflow,
I want to break this down into smaller features.

Can you:
1. Analyze the scope
2. Recommend how to break this into 2-5 smaller features
3. Suggest which feature to build first and why
4. For each feature, estimate size (Small/Medium/Large)

Here's what I want to build:
[paste your project description]
```

### Step 2: Create Task Folders for Each Feature

After Claude recommends a breakdown, create separate task folders:

```bash
# Example breakdown into 3 features
mkdir -p claude/2026-02-13-user-authentication
mkdir -p claude/2026-02-13-data-import
mkdir -p claude/2026-02-13-reporting-dashboard
```

### Step 3: Document the Breakdown

Create a tracking document:

```bash
# Create a roadmap file
cat > claude/ROADMAP.md << 'EOF'
# Project Roadmap

## Features

### Phase 1: User Authentication
- **Folder:** claude/2026-02-13-user-authentication
- **Status:** Not Started
- **Size:** Medium
- **Priority:** High (dependency for other features)

### Phase 2: Data Import
- **Folder:** claude/2026-02-13-data-import
- **Status:** Not Started
- **Size:** Large
- **Priority:** High
- **Depends on:** User Authentication

### Phase 3: Reporting Dashboard
- **Folder:** claude/2026-02-13-reporting-dashboard
- **Status:** Not Started
- **Size:** Medium
- **Priority:** Medium
- **Depends on:** Data Import

## Recommended Sequence
1. User Authentication (enables other features)
2. Data Import (core functionality)
3. Reporting Dashboard (enhancement)
EOF
```

### Step 4: Run Requirements for First Feature Only

```bash
# Start with first feature
cd /path/to/your/project
execute ~/.workflows/requirements
# When prompted for task folder, use: 2026-02-13-user-authentication
```

### Step 5: Complete First Feature Before Starting Next

Go through the full workflow for feature 1:
- Requirements → Design → Architecture → Plan → Implement

Then start feature 2's requirements workflow.

## Concrete Example

Let's say you tell Claude: "I want to build a task management app with user accounts, task CRUD, tagging, and email notifications."

### What Claude Should Respond With:

```
This is a Large project. I recommend breaking it into 4 features:

**Feature 1: User Authentication & Basic Task CRUD**
- Size: Medium
- Value: Core functionality users need immediately
- Scope: Login, signup, create/read/update/delete tasks
- Why first: Foundation for everything else

**Feature 2: Task Organization (Tags & Filters)**
- Size: Small
- Value: Makes task management actually useful
- Scope: Add tags, filter by tag, search tasks
- Why second: Enhances core feature

**Feature 3: Email Notifications**
- Size: Medium
- Value: Keeps users engaged
- Scope: Email reminders, task assignment notifications
- Why third: Enhancement, not critical for MVP

**Feature 4: Advanced Features**
- Size: Small-Medium
- Value: Nice-to-have improvements
- Scope: Task attachments, recurring tasks, etc.
- Why last: Can defer if time is tight

Recommendation: Start with Feature 1 only. Create:
- claude/2026-02-13-task-app-auth-crud/

Then run: execute ~/.workflows/requirements
```

### What You Do Next:

1. Accept the breakdown (or ask for revisions)
2. Create folder for Feature 1: `mkdir -p claude/2026-02-13-task-app-auth-crud`
3. Run: `execute ~/.workflows/requirements`
4. Complete the full workflow for Feature 1
5. After Feature 1 is done, start Feature 2

## When the Roadmap Workflow Exists (Future)

Eventually, suggestion #6 proposes creating:

```bash
execute ~/.workflows/roadmap
```

This would automate the breakdown process with an interview format. But **it doesn't exist yet**, so use the manual approach above.

## Quick Decision Tree

```
Do you have multiple features to build?
├─ No → execute ~/.workflows/requirements (start normal flow)
└─ Yes ↓

   Is it a large/complex project?
   ├─ No (2-3 small features) → execute ~/.workflows/requirements (handle in one go)
   └─ Yes (large project or 4+ features) ↓

      1. Ask Claude for breakdown recommendations (manual prompt)
      2. Create task folders for each feature
      3. Document breakdown in claude/ROADMAP.md
      4. execute ~/.workflows/requirements for Feature 1 ONLY
      5. Complete Feature 1 fully before starting Feature 2
```

## Why This Matters

**Bad approach:**
- Start requirements workflow with "build entire task management system"
- End up with 30-step implementation plan
- Get overwhelmed, never finish

**Good approach:**
- Break into "user auth + basic CRUD" first
- Get to working software in 5 days
- Ship something usable
- Learn and iterate before building next feature

## Summary

**Today:** No special command. Just ask Claude "Help me break down this project into features" before running `execute ~/.workflows/requirements`.

**Future:** When roadmap workflow exists, run `execute ~/.workflows/roadmap` first.
