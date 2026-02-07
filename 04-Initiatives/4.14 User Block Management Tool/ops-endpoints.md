# User Block Management Tool - API Endpoints Specification

## Overview
This document outlines the API endpoints required for the ops engineering team to build the User Block Management Tool interface. Each endpoint is mapped to specific user stories from the PRD.

---

## 1. Block User Endpoint

**User Story:** #1 - As an admin, I need to block a user so I can prevent fraudulent activity

**Endpoint:** `POST /api/admin/users/block`

**Input:**
```json
{
  "identifier": {
    "type": "email | phone | membership_id",
    "value": "string"
  },
  "admin_id": "string",
  "ticket_number": "string (required)",
  "reason": "string (required, max 500 chars)",
  "block_all_identifiers": "boolean (optional, default: false)",
  "disable_firebase_auth": "boolean (optional, default: true)"
}
```

**Output (Success - 200):**
```json
{
  "success": true,
  "data": {
    "block_id": "string (UUID)",
    "blocked_identifiers": [
      {
        "type": "email | phone | membership_id",
        "value": "string",
        "blocked_at": "ISO 8601 timestamp"
      }
    ],
    "blocked_by": "string (admin name)",
    "blocked_at": "ISO 8601 timestamp",
    "ticket_number": "string",
    "reason": "string",
    "firebase_auth_disabled": "boolean"
  }
}
```

**Output (Error - 400/500):**
```json
{
  "success": false,
  "error": {
    "code": "BLOCK_FAILED | INVALID_IDENTIFIER | USER_ALREADY_BLOCKED",
    "message": "string (user-friendly error message)",
    "details": "string (technical details for debugging)"
  }
}
```

**Acceptance Criteria:**
- Endpoint validates all required fields (identifier, ticket_number, reason)
- Reason field enforces 500 character limit
- If `block_all_identifiers` is true, endpoint fetches and blocks all linked identifiers
- Endpoint disables Firebase authentication if `disable_firebase_auth` is true
- Endpoint creates permanent audit log entry in database
- Endpoint triggers `user_blocked` analytics event
- Endpoint triggers `firebase_auth_disabled` event if applicable
- Returns error if identifier is already blocked
- Returns error if identifier format is invalid

---

## 2. Unblock User Endpoint

**User Story:** #2 - As an admin, I need to unblock a user so they can regain access after investigation

**Endpoint:** `POST /api/admin/users/unblock`

**Input:**
```json
{
  "identifier": {
    "type": "email | phone | membership_id",
    "value": "string"
  },
  "admin_id": "string",
  "ticket_number": "string (optional)",
  "reason": "string (required, max 500 chars)",
  "unblock_all_identifiers": "boolean (optional, default: false)",
  "enable_firebase_auth": "boolean (optional, default: true)"
}
```

**Output (Success - 200):**
```json
{
  "success": true,
  "data": {
    "unblock_id": "string (UUID)",
    "unblocked_identifiers": [
      {
        "type": "email | phone | membership_id",
        "value": "string",
        "unblocked_at": "ISO 8601 timestamp"
      }
    ],
    "unblocked_by": "string (admin name)",
    "unblocked_at": "ISO 8601 timestamp",
    "ticket_number": "string (nullable)",
    "reason": "string",
    "firebase_auth_enabled": "boolean"
  }
}
```

**Output (Error - 400/500):**
```json
{
  "success": false,
  "error": {
    "code": "UNBLOCK_FAILED | INVALID_IDENTIFIER | USER_NOT_BLOCKED",
    "message": "string (user-friendly error message)",
    "details": "string (technical details for debugging)"
  }
}
```

**Acceptance Criteria:**
- Endpoint validates required reason field (max 500 chars)
- Ticket number is optional but stored if provided
- If `unblock_all_identifiers` is true, endpoint fetches and unblocks all linked identifiers
- Endpoint re-enables Firebase authentication if `enable_firebase_auth` is true
- Endpoint creates permanent audit log entry (does NOT delete previous block record)
- Endpoint triggers `user_unblocked` analytics event
- Endpoint triggers `firebase_auth_enabled` event if applicable
- Returns error if identifier is not currently blocked
- Historical block records remain intact after unblock

---

## 3. User Lookup / History Endpoint

**User Story:** #3 - As an admin, I need to look up a user's complete blocking history to make informed CS/fraud decisions

**Endpoint:** `GET /api/admin/users/history`

**Input (Query Parameters):**
```
?identifier_type=email|phone|membership_id
&identifier_value=string
```

**Output (Success - 200):**
```json
{
  "success": true,
  "data": {
    "user_profile": {
      "identifiers": {
        "email": "string (nullable)",
        "phone": "string (nullable)",
        "membership_id": "string (nullable)"
      },
      "current_status": {
        "is_blocked": "boolean",
        "blocked_identifiers": ["string array"],
        "last_action": "blocked | unblocked",
        "last_action_at": "ISO 8601 timestamp"
      }
    },
    "history": [
      {
        "event_id": "string (UUID)",
        "action": "blocked | unblocked",
        "performed_by": "string (admin name)",
        "performed_at": "ISO 8601 timestamp",
        "identifier": {
          "type": "email | phone | membership_id",
          "value": "string"
        },
        "ticket_number": "string (nullable)",
        "reason": "string",
        "firebase_auth_action": "disabled | enabled | none"
      }
    ],
    "total_events": "integer"
  }
}
```

**Output (No Results - 200):**
```json
{
  "success": true,
  "data": {
    "user_profile": null,
    "history": [],
    "total_events": 0
  }
}
```

**Output (Error - 400/500):**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_IDENTIFIER | LOOKUP_FAILED",
    "message": "string (user-friendly error message)",
    "details": "string (technical details for debugging)"
  }
}
```

**Acceptance Criteria:**
- Endpoint accepts email, phone, or membership_id as lookup parameter
- Returns ALL associated identifiers for the user
- Returns complete history sorted by timestamp (most recent first)
- Each history entry includes: timestamp, action type, admin name, ticket number, reason, identifier affected
- Returns current block status for each identifier type
- Returns Firebase auth status
- Returns empty history array if no records exist (not an error)
- Endpoint triggers `user_lookup_performed` analytics event
- Response time < 2 seconds even for users with extensive history

---

## 4. System Status Check Endpoint

**User Story:** #4 - As an admin, I need to see which systems are currently blocking a user to understand the full picture

**Endpoint:** `GET /api/admin/users/system-status`

**Input (Query Parameters):**
```
?identifier_type=email|phone|membership_id
&identifier_value=string
```

**Output (Success - 200):**
```json
{
  "success": true,
  "data": {
    "identifier": {
      "type": "email | phone | membership_id",
      "value": "string"
    },
    "systems": {
      "redemption_gate": {
        "status": "active | inactive",
        "last_updated": "ISO 8601 timestamp",
        "description": "Prevents user from redeeming rewards"
      },
      "banned_member_list": {
        "status": "banned | not_banned",
        "last_updated": "ISO 8601 timestamp",
        "description": "User on permanent ban list"
      },
      "firebase_auth": {
        "status": "enabled | disabled",
        "last_updated": "ISO 8601 timestamp",
        "description": "User authentication access"
      }
    }
  }
}
```

**Output (Error - 400/500):**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_IDENTIFIER | STATUS_CHECK_FAILED",
    "message": "string (user-friendly error message)",
    "details": "string (technical details for debugging)"
  }
}
```

**Acceptance Criteria:**
- Endpoint checks status across all three systems: redemption gate, banned member list, Firebase
- Returns last updated timestamp for each system
- Returns human-readable description of what each system controls
- Response time < 1 second
- Handles gracefully if one system is unavailable (returns partial data with warning)

---

## 5. Linked Identifiers Endpoint

**User Story:** #5 - As an admin, I need to block a user across all their identifiers to prevent circumvention

**Endpoint:** `GET /api/admin/users/linked-identifiers`

**Input (Query Parameters):**
```
?identifier_type=email|phone|membership_id
&identifier_value=string
```

**Output (Success - 200):**
```json
{
  "success": true,
  "data": {
    "primary_identifier": {
      "type": "email | phone | membership_id",
      "value": "string"
    },
    "linked_identifiers": [
      {
        "type": "email | phone | membership_id",
        "value": "string",
        "is_blocked": "boolean",
        "linked_at": "ISO 8601 timestamp"
      }
    ],
    "total_linked": "integer"
  }
}
```

**Output (No Links - 200):**
```json
{
  "success": true,
  "data": {
    "primary_identifier": {
      "type": "email | phone | membership_id",
      "value": "string"
    },
    "linked_identifiers": [],
    "total_linked": 0
  }
}
```

**Output (Error - 400/500):**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_IDENTIFIER | LOOKUP_FAILED",
    "message": "string (user-friendly error message)",
    "details": "string (technical details for debugging)"
  }
}
```

**Acceptance Criteria:**
- Endpoint returns all identifiers associated with the searched identifier
- Each linked identifier shows current block status
- Returns timestamp of when identifiers were linked
- Returns empty array if no linked identifiers found (not an error)
- Response time < 1 second

---

## 6. Export History Endpoint

**User Story:** #3 (Export feature) - As an admin, I need to export blocking history for reporting

**Endpoint:** `GET /api/admin/users/export-history`

**Input (Query Parameters):**
```
?identifier_type=email|phone|membership_id
&identifier_value=string
&format=csv
```

**Output (Success - 200):**
- Content-Type: `text/csv` or `application/json`
- Response: File download stream

**CSV Format:**
```
Event ID,Action,Performed By,Performed At,Identifier Type,Identifier Value,Ticket Number,Reason,Firebase Auth Action
```

**Output (Error - 400/500):**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_IDENTIFIER | EXPORT_FAILED",
    "message": "string (user-friendly error message)",
    "details": "string (technical details for debugging)"
  }
}
```

**Acceptance Criteria:**
- Endpoint returns complete history in CSV format
- CSV includes all fields from history records
- Filename format: `user-block-history-{identifier}-{timestamp}.csv`
- Returns 200 with empty CSV if no history exists
- Response time < 3 seconds even for extensive history

---

## 7. Bulk Block Endpoint (Future)

**User Story:** Future consideration - Bulk block for fraud ring investigations

**Endpoint:** `POST /api/admin/users/bulk-block`

**Input:**
```json
{
  "identifiers": [
    {
      "type": "email | phone | membership_id",
      "value": "string"
    }
  ],
  "admin_id": "string",
  "ticket_number": "string (required)",
  "reason": "string (required, max 500 chars)",
  "disable_firebase_auth": "boolean (optional, default: true)"
}
```

**Output (Success - 200):**
```json
{
  "success": true,
  "data": {
    "total_requested": "integer",
    "successfully_blocked": "integer",
    "failed": [
      {
        "identifier": {
          "type": "email | phone | membership_id",
          "value": "string"
        },
        "error": "string"
      }
    ],
    "performed_by": "string (admin name)",
    "performed_at": "ISO 8601 timestamp",
    "ticket_number": "string"
  }
}
```

**Acceptance Criteria:**
- Endpoint accepts array of identifiers (max 100 per request)
- Processes all identifiers even if some fail
- Returns detailed success/failure status for each identifier
- Creates individual audit log entries for each block
- Triggers `bulk_block_performed` analytics event
- Implements rate limiting to prevent abuse

---

## Common Error Codes

| Code | HTTP Status | Description |
| --- | --- | --- |
| `INVALID_IDENTIFIER` | 400 | Identifier format is invalid or missing |
| `USER_ALREADY_BLOCKED` | 400 | User is already blocked with active block |
| `USER_NOT_BLOCKED` | 400 | User is not currently blocked, cannot unblock |
| `MISSING_REQUIRED_FIELD` | 400 | Required field is missing from request |
| `INVALID_FIELD_LENGTH` | 400 | Field exceeds max character limit |
| `UNAUTHORIZED` | 401 | Admin authentication failed |
| `FORBIDDEN` | 403 | Admin lacks permission for this action |
| `USER_NOT_FOUND` | 404 | No user found with given identifier |
| `BLOCK_FAILED` | 500 | Block operation failed due to system error |
| `UNBLOCK_FAILED` | 500 | Unblock operation failed due to system error |
| `LOOKUP_FAILED` | 500 | History lookup failed due to system error |
| `STATUS_CHECK_FAILED` | 500 | System status check failed |
| `EXPORT_FAILED` | 500 | Export operation failed |

---

## General Requirements

**Authentication:**
- All endpoints require admin-level authentication
- Include `Authorization: Bearer {token}` header
- Validate admin permissions before executing any operation

**Rate Limiting:**
- Block/Unblock endpoints: 100 requests per minute per admin
- Lookup/History endpoints: 200 requests per minute per admin
- Bulk operations: 10 requests per minute per admin

**Logging:**
- Log all requests with admin_id, timestamp, and action
- Log all errors with full stack trace for debugging
- Ensure audit trail is written to permanent storage before returning success

**Performance SLAs:**
- Block/Unblock operations: < 1 second response time
- History lookup: < 2 seconds response time
- System status check: < 1 second response time
- 99.9% uptime requirement

**Data Retention:**
- ALL audit records are permanent (never deleted)
- Implement soft delete if block records need to be "removed" from active view
