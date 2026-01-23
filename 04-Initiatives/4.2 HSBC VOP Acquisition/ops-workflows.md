# HSBC Card Acquisition - Ops & Customer Service Workflows

**Related:** [prd.md](./prd.md)

---

### Priority List

P0 - User Diagnostics Dashboard
P1 - Individual User Detail View
P2 - Extend Auto-Cancellation Date (M1 Rewards)
P2 - Batch Management View
P2 - Clawback Processing

---

## 1. CSV Ingestion Workflow x Batch Management View

**Purpose:** Process bi-weekly approval files from HSBC and handle user eligibility

**Steps:**
1. **Upload CSV File**
  - Ops uploads HSBC approval CSV via admin portal
  - System validates file format (email, approval_date, card_bin, card_last_4, status, card_name)
  - System generates upload confirmation with batch ID and timestamp

2. **Processing & Validation**
  - System processes each row and logs:
    - Successfully processed records
    - Failed records with error reasons (invalid email, missing fields, duplicate entries)
    - Status changes (accepted → approved, approved → rejected)
  - System generates processing summary report:
    - Total rows: X
    - Processed: Y
    - Failed: Z
    - Skipped (no status change): W

3. **Post-Processing Review**
  - Ops reviews processing summary for any failures
  - Ops investigates failed records and determines if manual intervention needed
  - Ops marks batch as "Reviewed" in system

**Tools Required:**
- CSV upload interface with drag-and-drop
- Real-time processing status indicator
- Processing summary report (downloadable as CSV/PDF)
- Error log viewer with filtering capabilities

**Table View:**
| Batch ID | Upload Date | Upload By | File Name | Total Rows | Processed | Failed | Skipped | Status | Actions |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| BATCH_20260115_01 | 2026-01-15 14:23 | ops@heymax.ai | hsbc_approval_20260115.csv | 150 | 145 | 3 | 2 | Reviewed | View Users, Download Report |
| BATCH_20260101_01 | 2026-01-01 09:15 | ops@heymax.ai | hsbc_approval_20260101.csv | 200 | 198 | 2 | 0 | Reviewed | View Users, Download Report |
**Actions:**
- **View Users:** Opens User Diagnostics Dashboard filtered to that batch
- **Download Report:** Downloads processing summary + error log
- **Reprocess Failed:** Ability to reprocess only failed rows after correction

---

## 2. User Diagnostics Dashboard

**Purpose:** View comprehensive status of users in the HSBC campaign for troubleshooting

**Tools Required: User Search & Overview Table**

**Search Filters:**
- Email / User ID
- Card Last 4
- Batch ID (which CSV ingestion batch)

**Table View Columns:**
| User Email | User ID | Batch ID | Card Type | Card Last 4 | Approval Date | M1 End Date | M2 End Date | M3 End Date | Current Tranche | Tranche Status | Current Tranche Eligible Spend Progress | Spend Days Remaining | Card Linked | Last Updated |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| user@email.com | 12345 | BATCH_20260115_01 | HSBC Revolution | 4532 | 2026-01-18 | 2026-02-28 | 2026-03-30 | 2026-04-31 | M1 | Active | $350 / $500 (70%) | 44 | Yes | 2026-01-14 |

---

## 3. Individual User Detail View

Information of the user will be filled when clicking on cell of the user

**Sections:**

**A. User Overview**
- Email, User ID, Phone Number
- Creation Timestamp, Card Application Date
- Card Link Status (linked / not linked)

**B. Campaign Timeline**
- Application Date
- CSV Ingestion Date (which batch)
- Card Approval Date (from HSBC)
- Reward status (pending, approved, cancelled)
- Each tranche window (start date, end date, days remaining/elapsed)

**C. Tranche Details Table**
| Tranche | Window Start | Window End | Spend Required | Current Spend | Progress | Status | Reward Amount | Reward Status | Auto-Cancel Date | Actions |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| M1 | 2026-01-18 | 2026-02-28 | $500 | $350 | 70% | Active | 12,500 miles | Pending | 2026-05-18 (120d) | Extend Cancel Date |
| M2 | 2026-03-01 | 2026-03-31 | $500 | $0 | 0% | Upcoming | 6,250 miles | Not Issued | - | - |
| M3 | 2026-04-01 | 2026-04-30 | $500 | $0 | 0% | Upcoming | 6,250 miles | Not Issued | - | - |

**D. Spend Transaction History**
- List of all transactions within campaign period
- Columns: Date, Merchant, Amount, MCC Code, Qualified (Y/N), Reason if Excluded
- Filter by: Date range, Excluded transactions only

---

## 4. Extend Auto-Cancellation Date (M1 Rewards)

**Purpose:** Manually extend the 120-day auto-cancellation deadline for M1 rewards when HSBC approval is delayed

**Workflow:**
1. CS/Ops navigates to User Detail View
2. In the Tranche Details Table, clicks "Extend Cancel Date" button for M1
3. Modal appears:
  - Current auto-cancel date: 2026-05-18
  - Reason for extension: [Dropdown: HSBC Delay, User Dispute, Manual Override, Other]
  - New auto-cancel date: [Date Picker]
  - Internal notes: [Text field]
4. CS/Ops submits extension
5. System logs the change with timestamp and agent name
6. User receives email notification about extension (optional toggle)

**Validation Rules:**
- New date must be after current auto-cancel date
- Maximum extension: +60 days per request
- Requires approval for extensions >30 days (manager approval flow)

---

## 5. Clawback Processing Workflow

**Purpose:** Handle monthly clawback files from HSBC and reverse rewards

**Workflow:**
1. **Upload Clawback CSV**
  - Ops uploads monthly clawback CSV
  - Expected columns: email, clawback_reason, tranches_to_clawback (M1/M2/M3)

2. **Pre-Processing Review**
  - System generates clawback impact report:
    - Total users affected: X
    - Total miles to be clawed back: Y
    - Breakdown by tranche
    - Users with insufficient balance (will go negative)

3. **Execute Clawback**
  - Ops reviews impact report
  - Ops confirms clawback execution
  - System processes:
    - Freezes user redemption for 2 weeks
    - Sends email to affected users (reason, amount, dispute instructions)
    - Logs clawback transaction with pending status

4. **Post-Clawback Actions (After 2 Weeks)**
  - System automatically:
    - Processes negative adjustment to user balance
    - Cancels future tranches if applicable
    - Unfreezes redemption
    - Sends confirmation email to user

**Tools Required:**
- Clawback CSV upload interface
- Impact report generator
- Clawback execution confirmation modal with impact summary
- Clawback tracking dashboard (similar to batch management)
- User redemption freeze status indicator

---

## 6. Reporting & Analytics (done on superset)

**Purpose:** Track campaign performance and ops efficiency

**Reports Needed:**

1. **Campaign Performance Dashboard**
  - Total applications processed
  - Breakdown by status (accepted, approved, rejected)
  - Total miles issued (pending vs. approved)
  - Spend completion rates by tranche
  - Conversion funnel: Approved → M1 Complete → M2 Complete → M3 Complete

2. **User Engagement Metrics**
  - Email open/click rates by notification type
  - Card link rate (approved users who linked cards)
  - Spend velocity (average days to reach 70%, 100% spend)

4. **Exportable Reports**
  - Monthly spend summary for HSBC
  - Cohort performance report
  - Audit log for compliance (all system actions, manual overrides)