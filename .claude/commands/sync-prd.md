# sync-prd

Sync a Linear project with a local PRD markdown file by detecting changes and updating the local file.

## Usage

```
/sync-prd [linear-project-url] [path-to-prd.md]
```

**Example:**
```
/sync-prd https://linear.app/workspace/project/user-auth-abc123 ./04-Initiatives/4.3\ Earning\ Tracker/prd.md
```

## What This Does

This command syncs a Linear project with a local PRD file by:

1. **Fetches Linear project data** - Retrieves current project information from Linear
2. **Reads local PRD file** - Parses the existing markdown PRD
3. **Detects differences** - Compares Linear project with local PRD
4. **Updates local PRD** - Applies changes from Linear to the markdown file
5. **Reports changes** - Shows what was synced

## How It Works

### 1. Extract Project ID from URL

Parse the Linear project URL to get the project identifier:
- URL format: `https://linear.app/[workspace]/project/[project-slug]-[id]`
- Extract the project ID or slug for API queries

### 2. Fetch Linear Project Data

Use Linear MCP tools to retrieve:
- Project name
- Project description (contains the full PRD content)
- Project status
- Project priority
- Project lead
- Target date / timeline
- Associated labels
- Creation and update timestamps

### 3. Read Local PRD File

Parse the local markdown file to extract:
- Title (first H1 heading)
- Metadata section (Owner, Status, Last Updated)
- Problem Statement
- Goals and Success Metrics
- Requirements sections (P0/P1/P2)
- Technical Considerations
- Dependencies
- Risks & Mitigations
- Timeline

### 4. Compare and Detect Changes

Check for differences in:

**Metadata:**
- Status changes (Draft → In Review → Approved)
- Priority changes
- Timeline/target date changes

**Content:**
- Project name/title changes
- Description/problem statement updates
- Requirements added, modified, or completed
- New sections added to project description

### 5. Update Local PRD

Apply changes detected from Linear:

**Metadata Updates:**
```markdown
**Status**: [Updated from Linear status]
**Last Updated**: [Current timestamp]
```

**Content Synchronization:**
- Update problem statement if changed
- Sync requirement checkboxes if completed in Linear
- Add new sections if they appear in Linear description
- Update timeline if target date changed

**Preserve Local Content:**
- Keep detailed requirement descriptions
- Maintain technical notes not in Linear
- Preserve local formatting and structure

### 6. Report Changes

Show a summary of what was synced:
```
✅ PRD Synced from Linear

📋 Project: [Project Name]
🔗 URL: [Linear project URL]

Changes Applied:
- Status: Draft → In Review
- Priority: Medium → High
- Target Date: Added Q1 2026
- Requirements: 3 items marked complete
- Description: Updated problem statement

Local file updated: [file path]
```

## Sync Strategy

### What Gets Synced

**Always sync from Linear to local:**
- Project status
- Priority level
- Target/due dates
- Project lead/owner
- High-level requirement completion status
- Project name/title

**Conditionally sync:**
- Description changes - Only if Linear description is more recent
- Requirement text - Only if explicitly changed in Linear
- New sections - Only if not present in local file

**Never overwrite:**
- Detailed requirement descriptions in local file
- Technical implementation notes
- Local-only sections (e.g., detailed tech specs)
- Custom formatting and structure

### Conflict Resolution

If both Linear and local file have been updated:

1. **Metadata**: Linear always wins (status, priority, dates)
2. **Content**: Prefer more detailed version
3. **Requirements**: Merge completion status from Linear with details from local
4. **Ambiguous**: Ask user which version to keep

## Detection Algorithm

### Status Sync
```
Linear Status → PRD Status:
- Backlog/Planned → Draft
- Started/In Progress → In Review
- In Review → In Review
- Completed → Approved
- Canceled → Draft (with note)
```

### Priority Sync
```
Linear Priority → PRD Priority:
- 0 (No priority) → Not specified
- 1 (Urgent) → Critical/Urgent
- 2 (High) → High
- 3 (Medium) → Medium
- 4 (Low) → Low
```

### Requirement Completion
Check Linear project issues/tasks and sync completion:
```markdown
# Before (local)
- [ ] User can log in with email

# After (synced from Linear)
- [x] User can log in with email
```

### Timeline Updates
```markdown
# Before (local)
## Timeline
TBD

# After (synced from Linear)
## Timeline
**Target Date**: Q1 2026 (March 31, 2026)
**Started**: January 15, 2026
```

## Example Workflow

### Step 1: User runs command
```bash
/sync-prd https://linear.app/heymax/project/earning-tracker-abc123 ./04-Initiatives/4.3\ Earning\ Tracker/prd.md
```

### Step 2: Fetch Linear data
```
Fetching project from Linear...
✓ Found project: "Earning Tracker"
✓ Status: In Progress
✓ Priority: High
✓ Last updated: 2 hours ago
```

### Step 3: Compare with local
```
Analyzing local PRD file...
✓ Local file last modified: 3 days ago
✓ Detected 5 changes from Linear
```

### Step 4: Show diff preview
```
Changes to apply:

1. Status: Draft → In Review
2. Priority: Medium → High
3. Target Date: Added Q1 2026
4. Requirements:
   - [x] User authentication (completed in Linear)
   - [x] Basic tracking UI (completed in Linear)
5. Description: Updated success metrics

Apply these changes? (y/n)
```

### Step 5: Apply changes
```
✅ PRD synchronized successfully

Updated: ./04-Initiatives/4.3 Earning Tracker/prd.md

Next steps:
1. Review changes in your editor
2. Commit updated PRD to git
3. Share updates with team
```

## Handling Specific Scenarios

### Scenario 1: Project renamed in Linear
```
Linear project name: "Earnings Tracker v2"
Local PRD title: "Earning Tracker"

Action: Update H1 heading in local PRD
```

### Scenario 2: Requirements completed in Linear
```
Linear: Tasks marked complete
Local: Checkboxes unchecked

Action: Mark corresponding checkboxes as [x]
```

### Scenario 3: Description updated in Linear
```
Linear: Added new "Technical Constraints" section
Local: Section doesn't exist

Action: Add new section to local PRD
```

### Scenario 4: Local file has more detail
```
Linear: "User can log in"
Local: "User can log in with email/password, OAuth (Google, GitHub), or magic link"

Action: Keep local detailed version, sync only completion status
```

### Scenario 5: Both changed (conflict)
```
Linear: Updated yesterday
Local: Updated today

Action: Ask user which version to keep or merge manually
```

## Error Handling

**Invalid Linear URL**
- Cannot parse project URL
- Action: Show expected URL format

**Project not found**
- Project doesn't exist or no access
- Action: Verify URL and permissions

**Local file not found**
- PRD file doesn't exist
- Action: Ask if user wants to create new PRD from Linear project

**Parsing errors**
- Malformed PRD structure
- Action: Attempt best-effort sync, warn about structure issues

**Linear API errors**
- Rate limits, permissions, network issues
- Action: Report error with retry suggestion

## Advanced Options

### Dry Run
Preview changes without applying:
```bash
/sync-prd [url] [path] --dry-run
```

### Force Overwrite
Overwrite local with Linear (dangerous):
```bash
/sync-prd [url] [path] --force
```

### Specific Sections
Sync only certain sections:
```bash
/sync-prd [url] [path] --sections=status,priority,timeline
```

### Auto-commit
Automatically commit changes to git:
```bash
/sync-prd [url] [path] --commit
```

## Integration with Other Commands

**Complete workflow:**

1. **Create PRD locally**: Edit markdown file
2. **Publish to Linear**: `/publish-prd prd.md`
3. **Work in Linear**: Team updates project, marks tasks complete
4. **Sync back**: `/sync-prd [url] prd.md`
5. **Create tickets**: `/create-tickets [url]`
6. **Repeat**: Keep PRD and Linear in sync

## Best Practices

1. **Sync regularly** - Run sync after team meetings or status updates
2. **Review before applying** - Check diff preview before confirming
3. **Commit changes** - Track PRD history in git
4. **One source of truth** - Decide if Linear or local is authoritative for each section
5. **Use dry-run first** - Preview changes before applying
6. **Keep structure consistent** - Maintain same sections in both places
7. **Document local-only sections** - Note which sections don't sync to Linear
8. **Sync before editing** - Pull latest changes before making local edits

## Sync Frequency Recommendations

- **Daily**: For active projects in development
- **Weekly**: For planning-stage projects
- **After key events**: Meetings, milestones, status changes
- **Before editing**: Pull latest before making changes

## Limitations

**Not synced from Linear:**
- Individual task/issue details (use Linear as source)
- Comments and discussions
- Attachments and files
- Detailed issue descriptions
- Assignee details beyond project lead

**Direction:**
- This command syncs Linear → Local PRD
- Use `/publish-prd` for Local PRD → Linear
- Manual changes in Linear between syncs may be overwritten

## Tips for Better Results

1. **Consistent structure** - Keep same sections in Linear and local
2. **Use Linear for status** - Let Linear be source of truth for project status
3. **Use local for detail** - Keep detailed specs in local PRD
4. **Sync before meetings** - Have latest info before discussions
5. **Review changes** - Always preview before applying
6. **Tag in commit** - Reference Linear project in git commits
7. **Notify team** - Let team know PRD was updated from Linear

## Related Commands

- `/publish-prd [path]` - Publish local PRD to Linear (opposite direction)
- `/create-tickets [url]` - Break down project into implementation tickets
- `/track [type] [description]` - Track individual items locally
- `/prd` - Create or refine a PRD document

## Technical Implementation Notes

### Linear MCP Tools Used

```javascript
// Get project details
mcp__linear__get_project({ query: projectId })

// List project issues (for requirement sync)
mcp__linear__list_issues({ project: projectId })

// Get project metadata
// Returns: name, description, state, priority, lead, targetDate, etc.
```

### Markdown Parsing

Use regex patterns to extract PRD sections:
- Title: `/^#\s+(.+)$/m`
- Metadata: `/\*\*(\w+)\*\*:\s*(.+)/g`
- Sections: `/^##\s+(.+)$/gm`
- Requirements: `/^-\s*\[([ x])\]\s*(.+)/gm`

### Diff Generation

Compare sections and generate human-readable diff:
```
+ Added: New timeline section
~ Modified: Status changed from Draft to In Review
✓ Completed: 3 requirements marked done
- Removed: Old dependency section
```

## Notes

- Syncs FROM Linear TO local PRD file
- Local file is modified, Linear project is not changed
- Original local file structure is preserved
- Only specified file is modified, no other files touched
- Uses Linear API via MCP tools for all Linear operations
- Requires Linear project URL and local file path
- Backup local file before first sync if concerned about data loss
