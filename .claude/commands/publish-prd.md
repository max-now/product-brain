# publish-prd

Convert a PRD markdown file into a Linear project with proper metadata and structure.

## Usage

```
/publish-prd [path-to-prd.md]
```

**Example:**
```
/publish-prd nimbalyst-local/Product/PRDs/user-authentication-prd.md
```

## What This Does

This command takes a PRD markdown file and:

1. **Reads the PRD content** - Parses the markdown file
2. **Extracts key information** - Pulls out title, problem statement, goals, requirements
3. **Creates a Linear project** - Generates a new project in Linear
4. **Sets metadata** - Configures project with appropriate settings
5. **Formats description** - Converts PRD content to Linear-friendly format

## Linear Project Configuration

The created project will have:

- **Team**: Engineering
- **Status**: Planned
- **Lead**: David Wang (02ef61ee-1681-466c-a2f6-eae385814cae)
- **Priority**: Based on PRD urgency or defaults to Medium (3)
- **Description**: Full PRD content formatted in markdown
- **Name**: Extracted from PRD title (first H1 heading)
- **Tag:** Boost

## PRD File Structure Expected

The command works best with PRDs following this structure:

```markdown
# [Feature/Product Name]

**Owner**: [PM Name]
**Status**: [Draft/In Review/Approved]
**Last Updated**: [Date]

---

## Problem Statement

[Problem description]

## Goals

**User Goals**:
- Goal 1

**Business Goals**:
- Goal 1

**Success Metrics**:
- Metric 1: Target

## Requirements

### Must Have (P0)
- [ ] Requirement 1

### Should Have (P1)
- [ ] Requirement 2

[... rest of PRD ...]
```

## Workflow

1. **Read the PRD file**
  - Load markdown content from specified path
  - Parse structure and extract key sections

2. **Extract project metadata**
  - Title: First H1 heading in document
  - Summary: Problem statement (first 255 chars)
  - Description: Full PRD content as markdown
  - Priority: Detected from urgency indicators or defaults to Medium

3. **Query Linear context**
  - Get "Engineering" team ID
  - Get "Planned" status ID
  - Verify user ID for lead assignment

4. **Create Linear project**
```
   Use: mcp__linear__create_project
   Input:
     - name: PRD title
     - team: "Engineering" (resolved to team ID)
     - lead: "02ef61ee-1681-466c-a2f6-eae385814cae" (David Wang)
     - state: "Planned"
     - description: Full PRD markdown
     - summary: First 255 chars of problem statement
     - priority: 3 (Medium) or detected from PRD
```

5. **Update the PRD file with Linear project URL**
```
   Use: Edit tool
   Action: Add the Linear project URL to the top of the PRD

   Insert after the H1 title:

   **Linear Project:** [project-url]

   ---

   This allows `/sync-prd` to automatically find the project without manual URL input.
```

6. **Return project details**
  - Project URL in Linear
  - Confirmation of settings
  - Link to created project
  - Confirmation that PRD file was updated with the project URL

## Processing Steps

### 1. Parse PRD Markdown

Extract these key elements:
- **Title**: First `# Heading` becomes project name
- **Problem Statement**: Used for project summary
- **Goals**: Included in description
- **Requirements**: Prioritised sections included
- **Success Metrics**: Highlighted in description
- **Timeline**: If present, noted in description

### 2. Format for Linear

Convert PRD to Linear project description:

```markdown
## Problem Statement
[Extracted from PRD]

## Goals & Success Metrics
[Extracted from PRD]

## Requirements

### Must Have (P0)
[List of P0 requirements]

### Should Have (P1)
[List of P1 requirements]

### Nice to Have (P2)
[List of P2 requirements]

## Technical Considerations
[Extracted from PRD]

## Dependencies
[Extracted from PRD]

## Risks & Mitigations
[Extracted from PRD]

## Timeline
[Extracted from PRD]

---
_Generated from PRD: [filename]_
_Published: [timestamp]_
```

### 3. Determine Priority

Map PRD urgency to Linear priority:
- **Urgent/Critical** → Priority 1 (Urgent)
- **High/MVP/P0** → Priority 2 (High)
- **Medium/Standard** → Priority 3 (Medium)
- **Low/Future/P2** → Priority 4 (Low)
- **Default** → Priority 3 (Medium)

Detection keywords:
- Priority 1: "urgent", "critical", "blocking", "production"
- Priority 2: "high priority", "mvp", "must have", "p0"
- Priority 3: "medium", "should have", "p1"
- Priority 4: "low", "nice to have", "p2", "future"

### 4. Set Project Status

Always set to "Planned" initially. User can update in Linear after review.

## Output Format

After creating the project:

```
✅ PRD Published to Linear

📋 Project: [Project Name]
🔗 URL: https://linear.app/workspace/project/[project-id]

Settings:
- Team: Engineering
- Status: Planned
- Lead: David Wang
- Priority: Medium

Next Steps:
1. Review project in Linear and adjust details
2. Add team members as needed
3. Create implementation tickets with /create-tickets
4. Move to "In Progress" when ready to start
5. Link related documents and designs

View project: [clickable URL]
```

## Error Handling

**File not found**
- Invalid path or file doesn't exist
- Action: Verify file path and try again

**Malformed PRD**
- Missing title (H1 heading)
- Empty or minimal content
- Action: Use filename as title, create basic project

**Linear API errors**
- Team not found
- User not found
- Permission issues
- Action: Report error with helpful message

**Team not found**
- "Engineering" team doesn't exist
- Action: List available teams and ask user to specify

**Status not found**
- "Planned" status not available in workspace
- Action: Use default status or ask user

## Best Practices

1. **Review PRD first** - Ensure PRD is complete before publishing
2. **Use descriptive titles** - Clear H1 heading becomes project name
3. **Include success metrics** - Helps with project tracking
4. **Document dependencies** - Important for planning
5. **Update after creation** - Refine in Linear as needed
6. **Link designs** - Add Figma/mockup links in Linear
7. **Add labels** - Tag with relevant project labels in Linear
8. **Set timeline** - Update target dates in Linear project

## Example Usage

```bash
# Publish a new feature PRD
/publish-prd nimbalyst-local/Product/PRDs/dark-mode-prd.md

# Result:
# ✅ Created project "Dark Mode Support" in Linear
# 🔗 https://linear.app/heymax/project/dark-mode-support
# Team: Engineering | Status: Planned | Lead: David Wang
```

## Integration with Other Commands

After publishing a PRD to Linear:

1. **Create tickets**: Use `/create-tickets [project-url]` to break down into tasks
2. **Track progress**: Monitor in Linear workspace
3. **Update PRD**: Keep local markdown file in sync with project changes
4. **Generate docs**: Use `/documentation` to create technical specs

## Advanced Options

### Custom Priority
If you want to override auto-detected priority, mention it in the command:
```
/publish-prd path/to/prd.md --priority high
```

### Custom Team
Override default "Engineering" team:
```
/publish-prd path/to/prd.md --team "Product"
```

### Custom Status
Override default "Planned" status:
```
/publish-prd path/to/prd.md --status "In Progress"
```

### Dry Run
Preview what would be created without actually creating:
```
/publish-prd path/to/prd.md --dry-run
```

## Tips for Better Results

1. **Use consistent PRD template** - Follow the standard format
2. **Write clear problem statements** - Becomes project summary
3. **Prioritize requirements** - Use P0/P1/P2 labels
4. **Include success metrics** - Measurable goals help tracking
5. **Document risks** - Important for project planning
6. **Link related docs** - Reference designs, specs, research
7. **Keep PRD updated** - Sync changes back to markdown file
8. **Review before publishing** - Check for completeness

## Related Commands

- `/prd` - Create or refine a PRD document
- `/create-tickets [project-url]` - Break down PRD into implementation tickets
- `/plan [description]` - Create feature plan documents
- `/track [type] [description]` - Track individual items locally

## Notes

- Project is created in "Planned" status - update when ready to start
- David Wang is automatically set as project lead
- Engineering team is the default team
- Full PRD markdown is preserved in project description
- **PRD file is automatically updated with the Linear project URL** after publishing
- The URL is added at the top of the file in the format: `**Linear Project:** [url]`
- This enables `/sync-prd` to work seamlessly without manual URL input
- You can update project details in Linear after creation
