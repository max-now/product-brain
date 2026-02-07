# Prd

## Problem / Objective
Today, our user blocking system is fragmented across multiple tools (Statsig, Firebase Auth, Postgres) with no centralized audit trail. When we unblock a user, we lose all historical context of previous blocks. Critical information like who blocked/unblocked users, when actions occurred, and why decisions were made is not tracked, making fraud investigations and CS decision-making difficult.

**Objective:** Build a centralized admin tool that provides complete visibility and audit history for all user blocking actions across phone numbers, emails, and membership IDs, while maintaining the ability to disable authentication at the Firebase level.

## What Success Looks Like
- Admins can block/unblock users in one centralized location instead of managing multiple systems
- Complete audit trail preserved permanently for all block/unblock actions
- CS and fraud teams can quickly view a user's full blocking history to make informed decisions
- Zero loss of historical data when users are unblocked
- Firebase authentication disabled/enabled programmatically through the tool

## Supporting Signals
- CS and fraud teams frequently need to reference why users were blocked previously
- Multiple concurrent systems (Statsig, Postgres, Firebase) create confusion and inconsistent states
- Lack of audit logs makes compliance and internal reviews difficult
- Ticket resolution times increase when agents must check multiple systems

## Data
**To track:**
- Block/unblock events with timestamps
- Actor (admin who performed action)
- Reason/notes (free text)
- Associated ticket numbers
- User identifiers: email, phone number, membership ID
- Current block status (active/inactive)
- Firebase auth disable/enable status
**Data retention:** Permanent - never delete historical records

## Who Is This For
**Primary users:** Admin-level support staff, fraud investigation team
**Access control:** Admin access only, integrated within existing support tools interface
---
## Product Requirements
| # | User Story | Acceptance Criteria (Expected Outputs) |
| --- | --- | --- |
| 1 | As an admin, I need to block a user so I can prevent fraudulent activity | **User should see:**\n• Input fields to enter email, phone number, OR membership ID\n• Required fields for ticket number and reason/notes with character counter\n• "Block User" button that becomes active when all required fields are filled\n• Loading indicator while block is processing\n• Success confirmation message showing: "User [identifier] has been blocked by [admin name] at [timestamp]"\n• Error message if block fails with clear next steps\n• User's current status updated to "Currently Blocked" with red badge |
| 2 | As an admin, I need to unblock a user so they can regain access after investigation | **User should see:**\n• Input fields to enter email, phone number, OR membership ID\n• Required field for reason/justification with character counter\n• Optional field for ticket number\n• Warning message: "This will restore user access immediately. Confirm unblock reason is documented."\n• "Unblock User" button\n• Loading indicator while unblock is processing\n• Success confirmation message showing: "User [identifier] has been unblocked by [admin name] at [timestamp]"\n• User's status updated to show "Not Blocked" with green badge\n• New entry added to history timeline |
| 3 | As an admin, I need to look up a user's complete blocking history to make informed CS/fraud decisions | **User should see:**\n• Search bar with dropdown to select search type (email/phone/membership ID)\n• "Search" button\n• Loading indicator while searching\n• User profile card at top showing: all associated identifiers, current block status with color-coded badge, Firebase auth status\n• Timeline view of all block/unblock events showing:\n  - Date and time (most recent first)\n  - Action type with icon (blocked/unblocked)\n  - Admin name who performed action\n  - Ticket number as clickable link\n  - Full reason/notes text\n• "No results found" message if user has no history\n• Export button to download history as CSV |
| 4 | As an admin, I need to see which systems are currently blocking a user to understand the full picture | **User should see:**\n• "Block Status Overview" panel showing status indicators for:\n  - Redemption Gate: Active/Inactive with toggle icon\n  - Banned Member List: Yes/No\n  - Firebase Authentication: Enabled/Disabled\n• Color-coded status (red = blocked, green = active)\n• Last updated timestamp for each system\n• Tooltip explaining what each system controls |
| 5 | As an admin, I need to block a user across all their identifiers to prevent circumvention | **User should see:**\n• When searching for a user, all linked identifiers displayed (email, phone, membership ID)\n• Checkbox option: "Block all associated identifiers"\n• When checked, all identifiers pre-filled in block form\n• Confirmation dialog listing all identifiers that will be blocked\n• After blocking, each identifier shown with individual "Blocked" status |
---
## Events Tracking
| Event Name | Event Attributes | Description |
| --- | --- | --- |
| `user_blocked` | `user_email`, `user_phone`, `membership_id`, `admin_id`, `ticket_number`, `reason`, `timestamp`, `block_method` (email/phone/membership) | Fired when admin blocks a user |
| `user_unblocked` | `user_email`, `user_phone`, `membership_id`, `admin_id`, `ticket_number`, `reason`, `timestamp`, `unblock_method` | Fired when admin unblocks a user |
| `user_lookup_performed` | `search_term`, `search_type` (email/phone/membership), `admin_id`, `timestamp`, `results_count` | Fired when admin searches for user history |
| `firebase_auth_disabled` | `user_email`, `admin_id`, `timestamp` | Fired when Firebase authentication is disabled |
| `firebase_auth_enabled` | `user_email`, `admin_id`, `timestamp` | Fired when Firebase authentication is re-enabled |
| `bulk_block_performed` | `identifier_count`, `admin_id`, `timestamp`, `ticket_number` | Fired when admin blocks multiple identifiers for one user |
---
## FAQs
**Q: What happens to existing blocks in Statsig, Postgres, and Firebase?**
A: Migration plan needed - recommend one-time sync of existing blocked users into new system, then deprecate old systems post-launch.
**Q: Can users be blocked by multiple identifiers simultaneously?**
A: Yes, if a user has multiple identifiers on file, admins should block all associated identifiers to prevent circumvention.
**Q: What if we unblock by email but phone is still blocked?**
A: The tool shows all associated identifiers and their individual block statuses. Admins must explicitly unblock each identifier.
**Q: How does this integrate with the redemption gate?**
A: The tool updates the redemption gate configuration when blocks are added/removed. Details TBD based on redemption gate API.
**Q: What's the backup plan if the tool is down?**
A: Document emergency procedures for direct Firebase/database access. Tool should have high availability SLA.
---
## Future Considerations
- Automatic goodwill approval gating based on blocking history
- Risk scoring integration (e.g., multiple unblock/reblock cycles flag for review)
- Bulk block/unblock functionality for fraud ring investigations
- Export audit history for compliance reporting
- Integration with case management system for automatic ticket linking