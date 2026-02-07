# update-prd

Update a Linear project from a local PRD markdown file by pushing changes from local to Linear.

## Usage

```
/update-prd [path-to-prd.md]
```

**Example:**
```
/update-prd ./04-Initiatives/4.5\ Merchant\ Search\ Improvements/prd\ -\ boost.md
```

## What This Does

This command updates an existing Linear project from a local PRD file by:

1. **Reads local PRD file** - Parses the markdown PRD content
2. **Extracts Linear project URL** - Finds the project link in the PRD file
3. **Fetches current Linear project** - Retrieves existing project data
4. **Detects local changes** - Compares local PRD with Linear project
5. **Updates Linear project** - Pushes changes from local to Linear
6. **Reports changes** - Shows what was updated

## How It Works

### 1. Read Local PRD File

Parse the local markdown file to extract:
- Linear project URL (from `**Project:**` or `**Linear Project:**` metadata)
- Project title (first H1 heading)
- Description/content (full PRD body)
- Priority (detected from keywords or metadata)
- Status (from metadata if present)
- Target date (from Timeline section if present)
- Requirements and their completion status

### 2. Extract Project ID from PRD

Find the Linear project URL in the PRD:
```markdown
**Project:** https://linear.app/heymax/project/merchant-search-improvements-ee4e2b902196/overview

OR

**Linear Project:** https://linear.app/workspace/project/[project-slug]-[id]
```

Parse the URL to extract the project identifier:
- URL format: `https://linear.app/[workspace]/project/[project-slug]-[id]`
- Extract the project ID or slug for API queries

### 3. Fetch Current Linear Project

Use Linear MCP tools to retrieve existing project:
- Current project name
- Current description
- Current status
- Current priority
- Current lead
- Target date / timeline
- Associated labels
- Last update timestamp

### 4. Compare and Detect Changes

Check for differences in:

**Title:**
- Has the H1 heading changed from Linear project name?

**Description:**
- Has PRD content been added, modified, or reorganized?

**Priority:**
- Has priority level changed in local metadata?

**Status:**
- Has status changed in local metadata?

**Timeline:**
- Has target date changed in Timeline section?

### 5. Update Linear Project

Apply changes detected from local PRD:

Use `mcp__linear__update_project` to push changes:

```javascript
mcp__linear__update_project({
  id: projectId,
  name: updatedTitle,
  description: fullPRDContent,
  priority: detectedPriority,
  state: detectedStatus,
  targetDate: extractedTargetDate
})
```

**Title Updates:**
- If H1 heading changed, update project name

**Description Synchronization:**
- Update full project description with PRD content
- Preserve Linear's markdown formatting
- Include all sections from PRD

**Priority Mapping:**
```
PRD Keywords → Linear Priority:
- "urgent", "critical", "blocking" → 1 (Urgent)
- "high", "mvp", "must have", "p0" → 2 (High)
- "medium", "should have", "p1" → 3 (Medium)
- "low", "nice to have", "p2" → 4 (Low)
```

**Status Mapping:**
```
PRD Status → Linear Status:
- "Draft", "Planning" → "Planned"
- "In Review", "In Progress" → "Started"
- "Approved", "Ready" → "In Progress"
- "Completed", "Done", "Shipped" → "Completed"
- "Cancelled", "On Hold" → "Canceled"
```

### 6. Report Changes

Show a summary of what was updated:
```
✅ Linear Project Updated from PRD

📋 Project: [Project Name]
🔗 URL: [Linear project URL]

Changes Applied:
- Title: Updated project name
- Description: Updated with latest PRD content
- Priority: Medium → High
- Status: Planned → Started
- Target Date: Updated to Q2 2026

Linear project updated successfully
```

## Update Strategy

### What Gets Updated

**Always update from local to Linear:**
- Project description (full PRD content)
- Project title (from H1 heading)

**Conditionally update:**
- Priority - Only if explicitly detected in PRD
- Status - Only if metadata includes status field
- Target date - Only if Timeline section includes target date
- Project lead - Only if explicitly specified in PRD

**Never update:**
- Project creation date
- Project ID/URL
- Team assignment (stays with original team)
- Individual issue/task details (update issues separately)
- Comments and discussions

### When to Use This vs /sync-prd

**Use \****`/update-prd`**\*\*:**
- After editing PRD locally and want to push to Linear
- When local PRD is source of truth
- Before team meetings to share latest PRD changes
- After incorporating feedback into local PRD

**Use \****`/sync-prd`**\*\*:**
- After team updates project in Linear
- When Linear is source of truth (status, completion)
- To pull latest status and requirements back to local
- After issues are marked complete in Linear

**Typical workflow:**
1. Edit PRD locally → `/update-prd` → pushes to Linear
2. Team works in Linear, marks tasks complete
3. Pull updates back → `/sync-prd` → syncs to local
4. Repeat cycle

## Detection Algorithm

### Priority Detection

Look for keywords in PRD content:

```javascript
// Scan PRD for priority indicators
if (content.match(/urgent|critical|blocking|production/i)) {
  priority = 1; // Urgent
} else if (content.match(/high priority|mvp|must have|p0/i)) {
  priority = 2; // High
} else if (content.match(/medium|should have|p1/i)) {
  priority = 3; // Medium
} else if (content.match(/low|nice to have|p2|future/i)) {
  priority = 4; // Low
}
```

Also check metadata section:
```markdown
**Priority**: High → maps to priority 2
```

### Status Detection

Look for status in metadata:
```markdown
**Status**: In Progress
```

Map to Linear status:
- Draft → Planned
- In Progress → Started
- Completed → Completed

### Target Date Extraction

Look for Timeline section:
```markdown
## Timeline
**Target Date**: Q2 2026 (June 30, 2026)
```

Extract date and convert to ISO format for Linear.

## Example Workflow

### Step 1: User edits PRD locally

User makes changes to PRD file:
- Updates problem statement
- Adds new requirements
- Changes priority to "High"

### Step 2: User runs command
```bash
/update-prd ./04-Initiatives/4.5\ Merchant\ Search\ Improvements/prd\ -\ boost.md
```

### Step 3: Read and parse PRD
```
Reading local PRD file...
✓ Found project URL: https://linear.app/heymax/project/merchant-search-improvements-ee4e2b902196
✓ Extracted project ID: ee4e2b902196
✓ Title: Merchant Search Improvements - Boost
✓ Priority: High (detected)
```

### Step 4: Fetch current Linear project
```
Fetching current project from Linear...
✓ Found project: "Merchant Search Improvements"
✓ Current status: Planned
✓ Current priority: Medium
✓ Last updated: 2 days ago
```

### Step 5: Show diff preview
```
Changes to apply to Linear:

1. Title: "Merchant Search Improvements" → "Merchant Search Improvements - Boost"
2. Description: Updated with latest PRD content (3 sections changed)
3. Priority: Medium → High
4. Status: No change (remains Planned)

Apply these changes to Linear? (y/n)
```

### Step 6: Apply changes
```
✅ Linear project updated successfully

Updated: https://linear.app/heymax/project/merchant-search-improvements-ee4e2b902196

Changes applied:
- Project name updated
- Description synced from PRD
- Priority raised to High

Next steps:
1. Review changes in Linear
2. Share updated project with team
3. Use /create-tickets to generate implementation tasks
```

## Handling Specific Scenarios

### Scenario 1: PRD title changed

```
Local PRD: # Merchant Search Improvements - Boost
Linear project name: "Merchant Search Improvements"

Action: Update Linear project name to match PRD
```

### Scenario 2: Content extensively revised

```
Local PRD: Added 3 new sections, revised requirements
Linear description: Original PRD content

Action: Replace Linear description with updated PRD content
```

### Scenario 3: Priority changed locally

```
Local PRD: Contains "High priority" in problem statement
Linear: Priority set to Medium

Action: Update Linear priority to High
```

### Scenario 4: No project URL in PRD

```
Local PRD: Missing project URL metadata
Linear: N/A

Action: Error - ask user to run /publish-prd first or add project URL
```

### Scenario 5: Project not found

```
Local PRD: Contains invalid or old project URL
Linear: Project doesn't exist or no access

Action: Error - verify project URL and permissions
```

## Error Handling

**No project URL found**
- PRD doesn't contain Linear project URL
- Action: Ask user to add project URL or use /publish-prd first

**Project not found**
- URL is invalid or project deleted
- Action: Verify project exists and user has access

**Permission denied**
- User doesn't have edit access to project
- Action: Request access from project owner

**Linear API errors**
- Rate limits, network issues
- Action: Report error with retry suggestion

**Malformed PRD**
- Can't parse title or content
- Action: Attempt best-effort update with warnings

## Advanced Options

### Dry Run
Preview changes without applying:
```bash
/update-prd [path] --dry-run
```

### Update Specific Fields
Update only certain fields:
```bash
/update-prd [path] --fields=description,priority
```

### Force Update
Skip confirmation prompt:
```bash
/update-prd [path] --force
```

### Auto-commit
Commit timestamp to PRD after update:
```bash
/update-prd [path] --commit-timestamp
```

## Integration with Other Commands

**Complete workflow:**

1. **Create PRD locally**: Write markdown file
2. **Publish to Linear**: `/publish-prd prd.md` (first time)
3. **Edit PRD locally**: Make changes
4. **Update Linear**: `/update-prd prd.md` (pushes changes)
5. **Team works in Linear**: Updates status, completes tasks
6. **Sync back**: `/sync-prd [url] prd.md` (pulls updates)
7. **Create tickets**: `/create-tickets [url]`
8. **Repeat**: Edit local → `/update-prd` → Team works → `/sync-prd`

## Best Practices

1. **Update after local edits** - Run after making changes to PRD
2. **Review before applying** - Check diff preview before confirming
3. **Sync before editing** - Run `/sync-prd` first to get latest from Linear
4. **Use descriptive titles** - Clear H1 headings make good project names
5. **Include project URL** - Always keep Linear project URL in PRD metadata
6. **Document priority** - Use clear priority keywords in PRD
7. **Keep structure consistent** - Maintain same sections for easier syncing
8. **Notify team** - Let team know Linear project was updated from PRD

## Update Frequency Recommendations

- **After significant edits**: When making major changes to PRD
- **Before meetings**: To share latest thinking with team
- **After feedback**: When incorporating stakeholder input
- **Weekly**: For active projects being refined
- **Before milestone reviews**: To ensure Linear reflects latest plan

## Limitations

**Not updated from local PRD:**
- Individual issues/tasks (manage in Linear directly)
- Issue assignees (set in Linear)
- Comments and discussions (Linear only)
- Attachments and files (Linear only)
- Project members/collaborators (Linear only)

**Direction:**
- This command updates Linear FROM local PRD
- Use `/sync-prd` for Linear → local updates
- Use `/publish-prd` to create new projects

## Tips for Better Results

1. **Keep project URL visible** - Put Linear project URL at top of PRD
2. **Use consistent format** - Follow standard PRD template
3. **Clear priority signals** - Use explicit priority keywords
4. **Descriptive title** - H1 heading becomes project name
5. **Complete sections** - Include all relevant PRD sections
6. **Review diff** - Always check what will change before confirming
7. **Sync regularly** - Balance local edits with Linear updates
8. **Tag in Linear** - Add relevant labels after updating

## Related Commands

- `/publish-prd [path]` - Create new Linear project from PRD (first time)
- `/sync-prd [url] [path]` - Pull updates from Linear to local PRD
- `/create-tickets [url]` - Break down project into implementation tickets
- `/prd` - Create or refine a PRD document

## Technical Implementation Notes

### Linear MCP Tools Used

```javascript
// Get project details
mcp__linear__get_project({ query: projectId })

// Update project
mcp__linear__update_project({
  id: projectId,
  name: newName,
  description: newDescription,
  priority: newPriority,
  state: newStatus,
  targetDate: newTargetDate
})
```

### Markdown Parsing

Use regex patterns to extract:
- Title: `/^#\s+(.+)$/m`
- Project URL: `/\*\*(?:Linear )?Project\*\*:\s*(https:\/\/linear\.app\/.+)/i`
- Priority: `/\*\*Priority\*\*:\s*(\w+)/i` or keyword detection
- Status: `/\*\*Status\*\*:\s*(.+)/i`
- Sections: `/^##\s+(.+)$/gm`

### Change Detection

Compare local PRD with Linear project:
```javascript
const changes = {
  title: localTitle !== linearProject.name,
  description: localContent !== linearProject.description,
  priority: detectedPriority !== linearProject.priority,
  status: detectedStatus !== linearProject.state,
  targetDate: extractedDate !== linearProject.targetDate
};
```

### Diff Generation

Show human-readable changes:
```
→ Title: "Old Name" → "New Name"
→ Priority: Medium → High
✓ Description: Updated (15 sections)
- Status: No change
```

## Notes

- Updates FROM local PRD TO Linear project
- Linear project is modified, local file is not changed
- Requires Linear project URL to be present in PRD file
- Use `/publish-prd` first if project doesn't exist yet
- Preserves Linear metadata not in PRD (created date, etc.)
- Use with `/sync-prd` for bidirectional workflow
- Always review changes before applying to avoid overwriting team updates
