# /plan Command
Create a new plan document for tracking development work.

## Overview
Plans are structured markdown documents with YAML frontmatter that track features, refactors, bug fixes, and other development work. They provide a single source of truth for what needs to be done, who's responsible, and current progress.
**Plans are for PLANNING, not implementation.** They answer WHAT and WHY, not HOW.

## File Location and Naming
**Location**: `nimbalyst-local/plans/[descriptive-name].md`
**Naming conventions**:
- Use kebab-case: `user-authentication-system.md`
- Be descriptive: The filename should clearly indicate what the plan is about
- Keep it concise: Aim for 2-5 words

## Required YAML Frontmatter
Every plan MUST start with this frontmatter structure:
```javascript
---
planStatus:
  planId: plan-[unique-identifier]  # Use kebab-case
  title: [Plan Title]                # Human-readable title
  status: [status]                   # See Status Values below
  planType: [type]                   # See Plan Types below
  priority: [priority]               # low | medium | high | critical
  owner: [username]                  # Primary owner/assignee
  tags:                              # Keywords for categorization
    - [tag1]
    - [tag2]
  created: "YYYY-MM-DD"             # Creation date (use today's date)
  updated: "YYYY-MM-DDTHH:MM:SS.sssZ"  # Last update timestamp (use current time via new Date().toISOString())
  progress: [0-100]                  # Completion percentage
---

```
**Optional frontmatter fields**:
- `stakeholders`: Array of people interested in this plan
- `dueDate`: Target completion date (YYYY-MM-DD)
- `startDate`: When work began (YYYY-MM-DD)

## Status Values
| Status | When to Use |
| --- | --- |
| `draft` | Just created, gathering requirements |
| `ready-for-development` | Planning complete, ready to start |
| `in-development` | Actively being implemented |
| `in-review` | Implementation done, awaiting review |
| `completed` | All acceptance criteria met |
| `rejected` | Decided not to pursue |
| `blocked` | Waiting on dependencies |
## Plan Types
| Type | Example |
| --- | --- |
| `feature` | Add dark mode, Implement user profiles |
| `bug-fix` | Fix login timeout, Resolve memory leak |
| `refactor` | Migrate to TypeScript, Clean up database |
| `system-design` | Design API architecture, Database schema |
| `research` | Evaluate frameworks, Performance analysis |
## CRITICAL: What NOT to Include
Plans are for PLANNING, not implementation. DO NOT include:
- ❌ Code blocks with implementation details
- ❌ Detailed TypeScript interfaces or function signatures
- ❌ CSS styling code
- ❌ Line-by-line implementation instructions
- ❌ Example code snippets (unless demonstrating a concept)
- ❌ Overly detailed step-by-step procedures
Plans should answer **WHAT** and **WHY**, not **HOW**. Keep it high-level and focused on:
- ✅ What needs to be built
- ✅ Why it's being built this way
- ✅ What the major components are
- ✅ What files will be affected (list them, don't show code)
- ✅ What the acceptance criteria are
**The person implementing will figure out the details. The plan is for understanding scope and approach.**

## Document Body Structure
After the frontmatter, organize the plan like this:
```javascript
# [Plan Title]

## Goals
- Clear, measurable objectives
- What success looks like
- Key deliverables

## Problem Description
Brief description of the problem or feature being addressed. Can include:
- Jobs to be Done
- Use cases
- User stories

## High-Level Approach
What will be built (not how it will be coded).

## Key Components/Phases
Major pieces or stages of work.

## Acceptance Criteria
- [ ] Checklist item 1
- [ ] Checklist item 2
- [ ] Checklist item 3

## Success Metrics
What metrics/KPIs indicate this is working well.

## Open Questions
Any unresolved questions or decisions needed.

```

## CRITICAL: Timestamp Requirements
When creating a plan:
1. Set `created` to today's date in YYYY-MM-DD format
2. Set `updated` to the CURRENT timestamp using `new Date().toISOString()` format
3. NEVER use midnight timestamps (00:00:00.000Z) - always use the actual current time
The `updated` field is used to display "last updated" times in the tracker table. Using midnight timestamps will show incorrect "Xh ago" values.

## Complete Example
```javascript
---
planStatus:
  planId: plan-user-authentication
  title: User Authentication System
  status: draft
  planType: feature
  priority: high
  owner: developer
  stakeholders:
    - developer
    - product-team
  tags:
    - authentication
    - security
    - user-management
  created: "2025-01-19"
  updated: "2025-01-19T14:30:45.123Z"
  progress: 0
  startDate: "2025-01-20"
  dueDate: "2025-02-01"
---

# User Authentication System

## Goals
- Implement secure user authentication
- Support multiple authentication providers (email/password, OAuth)
- Ensure proper session management and role-based access control

## Problem Description

The app currently has no authentication system. Users cannot create accounts, log in, or have personalized experiences. We need a complete auth system to:
- Allow users to create and manage accounts
- Protect sensitive user data
- Enable role-based features (admin, user, guest)

## High-Level Approach

Build a JWT-based authentication system with:
- Email/password registration and login
- OAuth integration (Google, GitHub)
- Role-based access control
- Secure session management

## Key Components

1. **Authentication Service**: Handle login, registration, token generation
2. **User Database**: Store user credentials and profiles
3. **Authorization Middleware**: Protect routes based on roles
4. **OAuth Integration**: Connect with external providers

## Acceptance Criteria
- [ ] Users can register with email/password
- [ ] Users can log in with email/password
- [ ] OAuth works with Google and GitHub
- [ ] JWT tokens expire after 15 minutes
- [ ] Role-based permissions function correctly
- [ ] All authentication tests passing

## Success Metrics
- Zero authentication-related security vulnerabilities
- Login success rate > 95%
- Average login time < 2 seconds

## Open Questions
- Which OAuth providers to prioritize first?
- Should we implement 2FA in this phase or later?

```

## Usage
When the user types `/plan [description]`:
1. Extract key information from the description
2. Choose appropriate `planType`, `priority`, and `status`
3. Generate unique `planId` from description (kebab-case)
4. Set `created` to today's date, `updated` to current timestamp (use `new Date().toISOString()`)
5. Create file in `nimbalyst-local/plans/` with proper frontmatter
6. Include relevant sections based on plan type

**Examples:**
```javascript
/plan Add dark mode to the application
/plan Fix memory leak in data processing
/plan Migrate authentication to OAuth
/plan Research better state management solutions

```

## Related Commands
- `/track [type] [description]` - Track bugs, tasks, ideas, or decisions
  - Example: `/track bug Login fails on Safari`

## Best Practices
- ✅ Keep plans focused (one feature/task per plan)
- ✅ Update status and progress regularly
- ✅ Use clear, descriptive titles
- ✅ Tag appropriately for filtering
- ✅ Link related plans in document body
- ✅ Break large plans into multiple focused plans
- ✅ Focus on WHAT and WHY, not HOW
- ✅ List affected files, don't show their code
- ✅ Keep it high-level - save details for implementation