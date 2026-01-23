# /create-tickets Command

Spin up a Product Owner sub-agent to analyze PRDs (Product Requirements Documents) from Linear and break them down into actionable engineering tickets directly in Linear.

## Overview

The Product Owner agent acts as a bridge between product vision and engineering execution. It reads PRDs from Linear issues, understands requirements, and generates well-structured tickets as Linear issues that engineers can immediately begin working on.

## Usage

```
/create-tickets [linear_issue_url_or_id]
```

**Examples:**

With Linear issue URL:
```
/create-tickets https://linear.app/your-workspace/issue/ENG-123/feature-x-prd
```

With issue ID only:
```
/create-tickets ENG-123
```

Without arguments (uses current open file):
```
/create-tickets
```

When invoked without arguments, the command will:
1. Check if there's a currently open file with a PRD
2. Look for a Linear project ID reference in the file (e.g., `Linear Project: PRJ-123`)
3. Read and analyze the local PRD content
4. Create tickets in Linear using the referenced project

## Agent Responsibilities

The Product Owner sub-agent will:

1. **Fetch the PRD** - Either:
  - Use Linear MCP to retrieve the issue and its description (if URL/ID provided)
  - Read from the currently open local file (if no arguments provided)
1. **Extract Linear context** - Look for Linear project references in the PRD (e.g., `Linear Project: PRJ-123`)
2. **Analyze the PRD** - Read and understand the product requirements document
3. **Identify work items** - Break down features into discrete, actionable units
4. **Prioritize tickets** - Assign appropriate priorities based on dependencies and business value
5. **Create Linear issues** - Generate tickets directly in Linear with proper formatting and metadata
6. **Link relationships** - Set up blocking/blocked-by relationships between issues
7. **Organize with labels** - Apply appropriate labels for categorization and filtering

## Linear MCP Integration

The agent uses the Linear MCP server to:
- **Read issues**: Fetch PRD content using `linear_get_issue`
- **Create issues**: Generate new tickets using `linear_create_issue`
- **Update relationships**: Set dependencies with `linear_update_issue`
- **Apply labels**: Tag tickets for organization
- **Set priorities**: Assign Linear priority levels (No priority, Low, Medium, High, Urgent)
- **Assign to projects**: Place tickets in appropriate project/milestone

## Ticket Generation Process

### Step 1: Fetch PRD Source

**If Linear URL/ID provided:**
```
Use: linear_get_issue
Input: Issue ID or URL
Output: Issue details including title, description, labels, project
```

**If no arguments provided:**
```
1. Check for currently open file in editor
2. Read the file content
3. Look for Linear project reference in frontmatter or content:
   - YAML frontmatter: `linear_project: PRJ-123`
   - Markdown reference: `Linear Project: PRJ-123`
   - Header section: `## Linear Project\nPRJ-123`
4. Extract project ID for ticket association
```

### Step 2: PRD Analysis
- Read the entire PRD from the issue description
- Identify key features, user stories, and acceptance criteria
- Note technical constraints and dependencies
- Understand success metrics and business goals
- Review any attached documents or links

### Step 3: Work Breakdown
Break down the PRD into ticket categories:

- **Features**: User-facing capabilities (e.g., "Enable user account creation and login")
- **Infrastructure**: Foundation work needed to support features (e.g., "Set up authentication system")
- **Research**: Discovery or technical investigation needed before building
- **Improvements**: Enhancements to existing capabilities

### Step 4: Ticket Attributes

Each Linear issue should include:

- **Title**: Action-oriented, outcome-focused (50-80 chars)
  - Focus on user value and business outcome
  - Lead with feature area, not technical component

- **Description**: Product requirements with structure:
  - **Context**: Why this matters to users/business (2-3 sentences)
  - **User Need**: What problem this solves or value it provides
  - **What Needs to Be Done**: The capability to deliver (not how to build it)
  - **Success Looks Like**: Observable user outcomes and behaviors
  - **Acceptance Criteria**: Testable, business-focused outcomes
  - **Constraints & Requirements**: Technical, security, or performance needs
  - **Out of Scope**: What should NOT be included
  - **Reference**: Links to PRD, designs, specs

- **Priority**: Urgent, High, Medium, Low, or No priority
  - Based on blocking relationships and business value

- **Labels**: For categorization (e.g., "backend", "frontend", "mvp")
  - Apply component, type, and scope labels

- **Project**: Associate with the feature project/milestone from PRD
  - MUST link to the project referenced in the PRD

- **Status**: Set to "Backlog" (not started yet)
  - All newly created tickets should start in Backlog state

- **Relationships**: Set blocking/blocked-by dependencies

- **Estimate**: Complexity size (XS/S/M/L/XL) in description

**Key Principle:** Tickets should communicate business requirements, user value, and success criteria. Engineers own the technical approach - tickets provide direction and constraints, not implementation blueprints.

### Step 5: Create Issues in Linear

For each ticket:
```
Use: linear_create_issue
Input:
  - teamId: Target team ID
  - title: Ticket title
  - description: Full ticket description in Markdown
  - priority: 0-4 (0=No priority, 1=Urgent, 2=High, 3=Medium, 4=Low)
  - labelIds: Array of label IDs
  - projectId: Feature project ID (REQUIRED - from PRD reference)
  - state: "Backlog" (set initial status)
  - parentId: For sub-tasks

CRITICAL:
- projectId MUST be extracted from the PRD (either from Linear issue or local file reference)
- state MUST be set to "Backlog" for all newly created tickets

After creation:
Use: linear_update_issue
Input:
  - issueId: Created issue ID
  - blockedByIds: Array of dependency issue IDs
```

### Step 6: Organization

Create tickets in logical order:
1. **Foundation/Infrastructure**: Core systems needed first
2. **Core Features**: Primary user-facing functionality  
3. **Integration**: API connections and third-party services
4. **Polish/Enhancement**: Nice-to-haves and refinements
5. **Testing/QA**: Validation and quality assurance work

### Step 7: Naming & Abstraction Guidelines

**Ticket Naming Best Practices:**
- Use user-facing language, not technical implementation terms
- ✅ "Enable users to save preferences" 
- ❌ "Implement UserPreferenceService with Redux store"
- Lead with feature area, not technical stack: `[User Settings]`, `[Account Management]`
- Focus on value: "Enable", "Allow", "Support", "Provide"
- Keep under 80 characters

**Appropriate Abstraction Levels:**

**Too Vague** ❌
- "Build authentication"
- "Handle user data"
- "Make login work"

**Good Balance** ✅
- "Enable users to create accounts and log in with email/password"
- "Allow users to save and retrieve their preferences"
- "Support user profile management (view, edit, delete)"

**Too Technical/Prescriptive** ❌
- "Create POST /api/v1/users endpoint with bcrypt password hashing"
- "Add users table with UUID primary key using Knex migrations"
- "Build LoginForm.tsx component with Formik validation"

**What to Specify:**
- User problems and needs being addressed
- Business value and expected outcomes
- Success criteria (measurable, observable behaviors)
- Data requirements (what needs to be captured/displayed)
- Performance expectations (speed, scale, reliability)
- Security/compliance requirements
- Integration touchpoints with other systems

**What to Leave Open:**
- Technical architecture and design patterns
- Implementation approach and technology choices
- Code structure, file organization, naming
- Database schema and data modeling
- API design and endpoint structure
- UI component structure and state management

## Linear Issue Format

The agent will create issues in Linear with the following structure:

### Issue Title Format
```
[Feature Area] User-facing outcome or capability
```

Examples:
- `[Account Management] Enable user registration and login`
- `[User Preferences] Allow users to save personalized settings`
- `[Profile] Support viewing and editing user profiles`
- `[Security] Require password reset on first login`

**Title Guidelines:**
- Keep concise (50-80 chars)
- Lead with feature area (from user perspective)
- Use outcome verbs (Enable, Allow, Support, Provide)
- Focus on user value and business outcome
- Avoid technical components or implementation details

### Issue Description Template

```markdown
## Context
[2-3 sentences explaining why this matters to users or the business, and how it fits into the larger product vision]

## User Need
[The problem users face or value they'll gain. Frame from user perspective, not technical perspective]

## What Needs to Be Done
[Clear description of the capability to deliver. Focus on the outcome and business requirements, not implementation steps]

## Success Looks Like
[Observable, measurable outcomes that indicate this is complete:]
- Users can [specific behavior]
- System provides [specific capability]
- [Metric] improves by [target]

## Data & Integration Requirements
**What data is needed:**
- [Data element 1]: [Description, source, and any format/validation requirements]
- [Data element 2]: [Description and requirements]

**What this integrates with:**
- [System/service name]: [What needs to happen between systems]

## Acceptance Criteria
- [ ] [User-facing outcome - what users can do]
- [ ] [Business outcome - what value is delivered]
- [ ] [Quality requirement - performance, reliability, security]
- [ ] [Edge case handling - key scenarios that must work]

## Constraints & Requirements
- **Performance**: [Speed, scale, or efficiency requirements if applicable]
- **Security**: [Data protection, access control, or compliance needs]
- **Compatibility**: [Systems/browsers/devices this must work with]
- **Business Rules**: [Any policies or logic that must be enforced]

## Out of Scope
- [Explicitly list what should NOT be done in this ticket]
- [Helps maintain focus and prevent scope creep]

## Reference
- PRD: [Link to original PRD issue]
- Design: [Link to Figma, mockups, or design specs]
- Research: [Links to user research or data supporting this]

---
_Generated by Product Owner Agent from PRD [ENG-123]_
```

### Example: Good Product-Focused Description

```markdown
## Context
Users need a way to create accounts and access personalized features. This enables us to offer customized experiences and secure user data. This is foundational for our user engagement strategy.

## User Need
Users want to create an account so they can save their preferences, access their history, and have a personalized experience across sessions.

## What Needs to Be Done
Enable users to create accounts and log in using their email address and a password. The system should remember who they are across sessions and protect their account with secure authentication.

## Success Looks Like
- Users can successfully create a new account in under 30 seconds
- Users can log in and see a personalized greeting with their name
- Users stay logged in when they return to the site (within security timeframes)
- Unauthorized users cannot access protected features or other users' data
- Login success rate > 95% (excluding incorrect password attempts)

## Data & Integration Requirements
**What data is needed:**
- Email address: Required for account identification and communication
- Password: User-chosen, must meet minimum security standards (8+ characters)
- User profile: Name, account creation date, last login timestamp

**What this integrates with:**
- Email service: For sending welcome emails and future notifications
- Frontend application: Login/registration forms need to connect to this capability

## Acceptance Criteria
- [ ] New users can create an account with email and password
- [ ] Returning users can log in with their credentials
- [ ] Users receive clear error messages for invalid email or weak passwords
- [ ] Duplicate email addresses are rejected with helpful messaging
- [ ] Users remain authenticated across page refreshes and new sessions
- [ ] Password security follows industry best practices (hashing, no plaintext storage)
- [ ] Login attempts are rate-limited to prevent brute force attacks

## Constraints & Requirements
- **Performance**: Account creation and login must complete in under 500ms (p95)
- **Security**: Must comply with OWASP authentication guidelines
- **Compatibility**: Works on all major browsers (Chrome, Firefox, Safari, Edge)
- **Business Rules**: One account per email address; minimum 8-character passwords

## Out of Scope
- Social login (Google, Facebook) - planned for next phase
- Password reset/recovery - separate ticket (ENG-125)
- Email verification - separate ticket (ENG-126)
- Multi-factor authentication - future enhancement
- Profile editing - separate ticket (ENG-127)

## Reference
- PRD: ENG-123
- Design: [Figma link to login/registration screens]
- Research: User research doc showing 78% of users prefer email login
```

### Example: Avoid This (Too Technical)

❌ **Bad (Too Technical):**
"Create a POST /api/auth/register endpoint using Express.js with bcrypt for hashing passwords and store them in the users table with columns: id (UUID), email (VARCHAR 255), password_hash (VARCHAR 255), created_at (TIMESTAMP). Use JWT with HS256 algorithm and 24-hour expiry. Build a LoginForm.tsx component with Formik validation..."

✅ **Good (Product-Focused):**
"Enable users to create accounts and log in with email and password. Passwords must be securely stored (never in plaintext). Users should stay logged in across sessions. Login must complete in under 500ms. The system should prevent brute-force attacks through rate limiting."

**Why the good example works:**
- Focuses on what users need to do
- Specifies security and performance requirements
- Leaves implementation approach to engineers
- Provides clear success criteria
- Trusts engineers to follow existing patterns

### Title & Description Principles

**DO:**
- Frame from user/business perspective (value delivered)
- Define success with observable outcomes
- List measurable acceptance criteria
- Specify data requirements and constraints
- Note performance, security, or compliance needs
- State what's explicitly out of scope
- Trust engineers to design the solution

**DON'T:**
- Write tickets from a technical implementation perspective
- Specify exact endpoints, database schemas, or file structures
- Prescribe specific libraries or frameworks
- Include step-by-step coding instructions
- Dictate technical architecture decisions
- Over-specify how engineers should build it
- Use technical jargon where business terms work better

### Priority Mapping

Linear priorities (0-4):
- **0 = No priority**: Default, not yet prioritized
- **1 = Urgent**: Critical blockers, security issues, production down
- **2 = High**: Must-have for MVP, blocks multiple tickets
- **3 = Medium**: Important but not blocking
- **4 = Low**: Nice-to-have, future enhancements

### Label Strategy

Apply labels for:
- **Feature Area**: `account-management`, `user-preferences`, `notifications`, `search`
- **Type**: `feature`, `research`, `improvement`, `infrastructure`
- **Scope**: `mvp`, `post-mvp`, `future-enhancement`
- **Priority**: `must-have`, `should-have`, `nice-to-have`

## Dependency Management in Linear

Linear supports native issue relationships. The agent will:

1. **Create issues in dependency order**: Foundation → Core → Enhancements
2. **Set blocking relationships**: Use `blockedByIds` in `linear_update_issue`
3. **Link related issues**: Reference issue IDs in descriptions

### Relationship Types
- **Blocks**: This issue prevents another from starting
- **Blocked by**: This issue cannot start until another is done
- **Related to**: Issues that are connected but not dependent

### Setting Dependencies
```
After creating all issues:
1. Map issue titles to created issue IDs
2. For each issue with dependencies:
   - Call linear_update_issue
   - Set blockedByIds: [array of issue IDs that block this one]
```

Example dependency chain:
```
ENG-201: Setup database schema (no dependencies)
  ↓ blocks
ENG-202: Create user model (blocked by ENG-201)
  ↓ blocks
ENG-203: Build auth endpoints (blocked by ENG-202)
```

## Priority Guidelines

Map to Linear's priority levels (1-4, with 0 for unprioritized):

**1 - Urgent**: 
- Production is down or severely degraded
- Critical security vulnerability
- Data loss or corruption risk
- Blocking entire team

**2 - High**:
- Blocks multiple other tickets
- Core MVP functionality required
- Important technical foundations
- Time-sensitive feature for deadline

**3 - Medium**:
- Important but not blocking
- Secondary features
- Performance optimizations
- Standard implementation work

**4 - Low**:
- Nice-to-have enhancements
- Future considerations
- Minor improvements
- Post-MVP features

**0 - No Priority** (default):
- Newly created tickets awaiting triage
- Ideas for future discussion

## Estimation Hints

Update the estimation context for the issue (team uses story points):

**Story Points:**
- **1-2 points**: Simple, well-understood work
- **3-5 points**: Standard feature implementation
- **8 points**: Complex, some unknowns
- **13+ points**: Break down further

Add estimation reason to issue description:
```markdown
## Estimation
**Size**: Medium (3-5 days)
**Complexity**: Moderate - requires API integration and new database schema
```

## Best Practices

### For the Sub-Agent

1. **Fetch complete context**: Use `linear_get_issue` to read full PRD with all details
2. **Query team and project info**: Get team ID and project ID before creating issues
   - **CRITICAL**: Extract project ID from PRD and verify it exists
3. **Check for existing labels**: Query available labels to apply appropriate ones
4. **Frame from user perspective**: Lead with user needs and business value
5. **Define observable outcomes**: What success looks like to users/business
6. **Specify data requirements**: What information is needed and where it comes from
7. **List clear acceptance criteria**: Measurable, user-facing outcomes
8. **Note constraints, not solutions**: Requirements and limitations, not implementation
9. **Avoid technical prescriptions**: No API designs, schemas, or code structure
10. **Create in dependency order**: Build foundation capabilities first
11. **Set relationships after creation**: First create all issues, then set `blockedByIds`
12. **Link back to PRD**: Always include link to original PRD issue
13. **Define scope boundaries**: Explicitly state what's out of scope
14. **Provide business context**: Help engineers understand the "why" and "for whom"
15. **MUST link to project**: All tickets MUST include projectId from PRD
16. **MUST set status to Backlog**: All tickets MUST have state="Backlog"

### For Users

1. **Write clear PRDs in Linear**: Use Linear's issue description with proper formatting
2. **Include acceptance criteria in PRD**: Makes ticket generation more accurate
3. **Attach mockups/designs**: Link to Figma or attach images in PRD
4. **Specify constraints**: Document technical limitations, security requirements, or compliance needs
5. **Define scope clearly**: Use labels or sections to mark MVP vs future
6. **Provide examples**: Include user stories or example scenarios
7. **Link related docs**: Reference tech specs, API docs, or design docs
8. **Use consistent terminology**: Maintain naming conventions across PRD and tickets
9. **Review generated tickets**: Agent provides starting point, refine as needed
10. **Adjust priorities**: Align with current sprint and business goals
11. **Break down XL tickets**: Split large tickets into smaller chunks
12. **Add assignees**: Assign tickets to team members after generation
13. **Refine scope**: Remove implementation details that are too prescriptive
14. **Add team context**: Enhance with knowledge of team standards and patterns

## Example Workflows

### Workflow 1: From Linear Issue

```bash
# 1. User provides PRD from Linear
/create-tickets https://linear.app/your-workspace/issue/ENG-123/chat-feature-prd

# Or just the issue ID
/create-tickets ENG-123

# 2. Agent executes:
# - Calls linear_get_issue to fetch PRD content
# - Analyzes requirements and breaks down into tickets
# - Calls linear_create_issue for each ticket
# - Calls linear_update_issue to set dependencies
# - Links all tickets to the PRD issue

# 3. Agent reports back with created issues
```

### Workflow 2: From Local File

```bash
# 1. User has PRD open in editor (e.g., phase-1-prd.md)
#    File contains Linear project reference:
#    Linear Project: PRJ-456

# 2. User invokes without arguments
/create-tickets

# 3. Agent executes:
# - Reads current file content
# - Extracts Linear project ID (PRJ-456)
# - Analyzes requirements and breaks down into tickets
# - Calls linear_create_issue for each ticket with project association
# - Links tickets to extracted project

# 4. Agent reports back with created issues
```

### Post-Generation Steps

After ticket generation (both workflows):

1. **Review in Linear**
   - Open Linear workspace to see all generated tickets
   - Review and refine as needed
   - Assign to team members
   - Add to current sprint

2. **Begin implementation**
   - Engineers pick up tickets based on priority and dependencies
   - Update status as work progresses
   - Close tickets when acceptance criteria met
```

## Sub-Agent Behavior

When invoked, the Product Owner agent should:

1. **Determine PRD source**:
   - If Linear URL/ID provided: Extract issue ID from URL or use raw ID
   - If no arguments: Use currently open file from editor context

2. **Fetch PRD content**:
   - From Linear: Call `linear_get_issue` to retrieve PRD content and project association
   - From local file: Read file content and extract Linear project reference

3. **Confirm analysis**: Let user know it's analyzing the document

4. **Query Linear context**: Get team ID, project info, available labels
   - CRITICAL: Extract and verify project ID from PRD source
   - Ensure project exists and is accessible

5. **Generate tickets**: Create comprehensive ticket breakdown

6. **Create in Linear**: Use `linear_create_issue` for each ticket
   - MUST include projectId (from PRD)
   - MUST set state to "Backlog"

7. **Set relationships**: Use `linear_update_issue` for dependencies

8. **Provide summary**: Show created issues with links and organization

9. **Offer next steps**: Suggest how to proceed with refinement

## Output Message Template

```
✅ PRD Analysis Complete

📋 Source: ENG-123 - [PRD Title]
🎫 Created: [ticket_count] issues in Linear

Breakdown:
- Urgent: X | High: X | Medium: X | Low: X
- Foundation: X | Core: X | Enhancement: X

Created Issues:
1. ENG-201 - [Auth] Setup authentication infrastructure (High)
   https://linear.app/workspace/issue/ENG-201
2. ENG-202 - [Database] Create user schema (High)
   https://linear.app/workspace/issue/ENG-202
3. ENG-203 - [API] Build registration endpoint (Medium)
   https://linear.app/workspace/issue/ENG-203
[... and X more]

🔗 View all in project: [Project Name]
📊 Dependency chain: ENG-201 → ENG-202 → ENG-203

Next Steps:
1. Review tickets in Linear for accuracy
2. Adjust priorities based on current sprint
3. Assign tickets to team members
4. Add any missing context or details
5. Move high-priority items to current cycle

Would you like me to:
- Explain any specific tickets in detail?
- Adjust priorities or dependencies?
- Break down any large tickets further?
- Create additional tickets for edge cases?
```

## Related Commands

- `/track [type] [description]` - Add individual tracking items to local tracker
- `/plan [description]` - Create feature plan documents locally

Note: This command specifically works with Linear. For local tracking, use the `/track` command.

## Advanced Usage

### Specify Target Team
```
/po ENG-123 --team "Backend Team"
```
Explicitly set which Linear team to create issues in.

### Specify Target Project
```
/po ENG-123 --project "Q1 2025 Roadmap"
```
Place all tickets in a specific project/milestone.

### Custom Label Set
```
/po ENG-123 --labels "mvp,backend,high-priority"
```
Apply specific labels to all generated tickets.

### Dry Run Mode
```
/po ENG-123 --dry-run
```
Analyze and show what tickets would be created without actually creating them.

### Dependency Visualization
After ticket generation:
```
"Show me the dependency graph for the created tickets"
```
Visualize the blocking relationships.

### Ticket Refinement
```
"Break down ENG-203 into smaller tickets"
```
Further decompose large or complex tickets.

### Batch Operations
```
"Update all ENG-20X tickets to high priority"
```
Make bulk changes to generated tickets.

## Tips for Better Results

1. **Write clear PRDs in Linear**: Use Linear's issue description with proper formatting
2. **Include acceptance criteria**: Use checkboxes for clear success criteria
3. **Attach mockups/designs**: Link to Figma or attach images in PRD
4. **Specify constraints**: Document technical limitations in PRD
5. **Define scope clearly**: Use labels or sections to mark MVP vs future
6. **Provide examples**: Include user stories or example scenarios
7. **Link related docs**: Reference tech specs, API docs, or design docs
8. **Use consistent terminology**: Maintain naming conventions across PRD and tickets

## Writing Effective Tickets - Key Reminders

### Lead with User Value
Every ticket should start with why it matters:
- What problem does this solve for users?
- What value does this deliver to the business?
- How does this support our product strategy?

This helps engineers understand priority and make better tradeoff decisions.

### Define Success Clearly
✅ **DO**: "Users can recover their account within 5 minutes by clicking a link sent to their email"
❌ **DON'T**: "Implement password reset functionality"

The first describes the outcome. The second just names a feature without defining success.

### Specify Requirements, Not Implementation
✅ **DO**: "Password reset links must expire after 1 hour for security. User should receive link via email."
❌ **DON'T**: "Store reset tokens in Redis with TTL of 3600 seconds. Use nodemailer to send emails."

The first states what's needed and why. The second prescribes specific technologies.

### Trust Engineering Judgment
Your engineering team has context you don't:
- Existing code patterns and architecture
- Performance characteristics of different approaches
- Technical debt and maintenance implications
- Library/framework strengths and limitations

Good tickets provide direction and constraints, not implementation blueprints.

### When to Be Specific
**DO specify:**
- Business rules and logic (account lockout after 5 failed attempts)
- User-facing behavior (form validates on blur, not on submit)
- External contracts (3rd party API requires specific format)
- Compliance requirements (GDPR, HIPAA, PCI-DSS)
- Performance expectations (page load under 2 seconds)
- Data requirements (must capture user's timezone)

**DON'T specify:**
- Technical architecture (microservices vs monolith)
- Database design (table schemas, indexes)
- API structure (endpoint paths, HTTP methods)
- Code organization (file structure, naming)
- Library choices (React vs Vue, PostgreSQL vs MongoDB)

## Error Handling

The agent will handle common scenarios:

**PRD not found**
- Invalid issue ID or URL
- Issue doesn't exist in workspace
- Action: Verify issue ID and workspace access

**Access issues**
- No permission to read issue
- No permission to create issues in team
- Action: Check Linear permissions and team membership

**Malformed PRD**
- Empty or minimal description
- Missing key sections
- Action: Request more detail in PRD or create minimal ticket set

**Scope too large**
- PRD describes multiple major features
- Would generate 50+ tickets
- Action: Suggest breaking PRD into multiple features

**Missing context**
- Team ID not found
- Project doesn't exist
- Labels not available
- Action: Use defaults or prompt for specifics

**Rate limiting**
- Too many Linear API calls
- Action: Batch operations and retry with backoff

**Duplicate tickets**
- Similar tickets already exist
- Action: Flag potential duplicates, let user decide

## Linear MCP Commands Reference

The agent uses these Linear MCP server commands:

### Reading Operations
```
linear_get_issue
- Input: issueId (string)
- Output: Issue details including title, description, labels, project, team

linear_list_teams
- Output: Available teams in workspace

linear_list_projects
- Input: teamId (optional)
- Output: Available projects/milestones

linear_list_labels
- Input: teamId (optional)
- Output: Available labels for tagging
```

### Writing Operations
```
linear_create_issue
- Input: {
    teamId: string,
    title: string,
    description: string (markdown),
    priority: number (0-4),
    labelIds: string[],
    projectId: string (REQUIRED - must link to PRD project),
    state: string (REQUIRED - set to "Backlog"),
    parentId: string (optional for sub-tasks)
  }
- Output: Created issue with ID and URL
- NOTE: projectId and state are mandatory for all tickets

linear_update_issue
- Input: {
    issueId: string,
    blockedByIds: string[] (set dependencies),
    priority: number (update priority),
    labelIds: string[] (update labels)
  }
- Output: Updated issue details
```

### Workflow
1. Fetch PRD with `linear_get_issue`
2. Query context with `linear_list_teams`, `linear_list_projects`, `linear_list_labels`
3. Create tickets with `linear_create_issue`
4. Set dependencies with `linear_update_issue` (blockedByIds)