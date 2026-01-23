# HSBC Card Acquisition Campaign

**Status:** In Progress
**Priority:** High
**Lead:** Yash Chellani
**Timeline:** Dec 5, 2025 - Jan 16, 2026
**Linear Project:** [View in Linear](https://linear.app/heymax/project/hsbc-card-acquisition-campaign-1740d80d3988)

---

## 0. Campaign Details

1. Card Application Duration
  1. 1st Feb - 31st March
2. Success Metrics
  1. Target: 200 card applications per month
  2. baseline: 600 card applications in 6 months
3. Campaign Mechanics
  - Miles Payout
    - 1st tranche (M1) - 12,500 Max Miles, Spend $500
    - 2nd tranche (M2) - 6,250 Max Miles, Spend $500
    - 3rd tranche (M3) - 6,250 Max Miles, Spend $500
  - 1st tranche eligibility = T+1 month from date of approval

### Offer Details

|  | **HeyMax New Offer** | **HSBC BAU Offer** |
| --- | --- | --- |
| **Welcome Offer (Month 1)** | **12,500 Max Miles** | **$200 cash** |
| Spend Condition | $500 | $500 |
| Value to Customer | $225 minimum | $200 |
| Issuance Criteria | HSBC to send list of users who approved |  |
| **Activation Offer 1 (Month 2)** | **6,250 Max Miles** | **$100 cash** |
| Spend Condition | $500 | $500 |
| Value to customer | $112.5 minimum | $100 |
| --- | --- | --- |
| **Activation Offer 2 (Month 3)** | **6,250 Max Miles** |  |
| Spend Condition | $500 |  |
| Value to customer | $112.5 minimum |  |
| --- | --- | --- |
| **Total Offer** | **25,000 Max Miles** | **$300 cash** |
| Spend Condition | $1,500 | $1000 |
| Value to customer | $450 minimum | $300 |

### User Timeline Payout Examples

- e.g. date of approval = 18 jan,
  - 1st trench eligibility = 18 jan - 28 feb
  - 2nd trench eligibility = 1 mar - 31 mar
  - 3rd trench eligibility = 1 apr - 30 apr
- e.g. date of approval = 31 jan,
  - 1st trench eligibility = 31 jan - 28 feb
  - 2nd trench eligibility = 1 mar - 31 mar
  - 3rd trench eligibility = 1 apr - 30 apr

---

## 1. Problem / Objective

Users applying for cards often struggle to track their multi-month minimum spend requirements. This results in confusion, missed rewards, and reduced trust in general with bank's card application experience.

This initiative aims to deliver:

1. A reliable, automated way to issue sign up rewards.
2. A clear, guided minimum spend tracking experience.
3. A backend process that reduces manual workload for Ops while maintaining data correctness.

---

## 2. What Success Looks Like

- Users clearly understand their M1/M2/M3 spend timelines.
- Rewards issuance and cancellation occur on time with limited manual intervention.
- Users receive timely reminders that lead to lower missed rewards.

---

## 3. Supporting Signals

- HSBC interest in working with us
- High user confusion around minimum spend windows.
- CS tickets to request for miles earned for card applications.

---

## 4. User Journey

![hsbc card acquisition.png](https://uploads.linear.app/cdfeb12b-32b4-4eec-9da0-5c83f2320315/58845783-429d-4f36-86fd-0d1152756102/8f547c38-4d2a-4491-a11a-094768634cfa?signature=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXRoIjoiL2NkZmViMTJiLTMyYjQtNGVlYy05ZGEwLTVjODNmMjMyMDMxNS81ODg0NTc4My00MjlkLTRmMzYtODZmZC0wZDExNTI3NTYxMDIvOGY1NDdjMzgtNGQyYS00NDkxLWExMWEtMDk0NzY4NjM0Y2ZhIiwiaWF0IjoxNzY4Mzg0MDEwLCJleHAiOjE3NjgzODQzMTB9.DVmZChb_0xLvlA5DvV4TYmpprinrIiOGwdFylP145Tg){411x443}

---

## 5. Data Required

From HSBC:

- One Time
  - card models eligible
  - excluded MCC codes for transactions of related card models
- Bi-Weekly
  - Approval File
    - `email`,
    - `approval_date`,
    - `card_name`
    - `card_bin`,
    - `card_last_4`,
    - `status` (accepted / approved / rejected)
- Monthly
  - Clawback file
    - Format TBD

To HSBC:

- Monthly
  - Spend summary events
  - performance of cohort

---

## 6. Entry Points

1. HSBC EDM (once a month during campaign period)
2. HeyMax
  1. EDM (part of regular EDM during campaign period)
  2. Telegram (once a month)
  3. Push Notification
  4. App Banner (launch month top 3 spot)
  5. Application
      1. The Hub
        1. Move Card Application Icon to 4th spot
      2. Card Explore Page
        1. HSBC Cards will be shown first with canceling & upsize amount

---

## 7. Product Requirements

| # | Module | User Story (if any) | Acceptance Criteria |
| --- | --- | --- | --- |
| 1 | Spend monitoring during minimum eligibility windows & notification triggers | As a user, I want clarity on my M1/M2/M3 spend windows so I can complete each tranche requirements confidently.\n\nAs a user, I want reminders about my spend progress so I don’t miss any tranche. | Card Page Display:\n- The Card Page for HSBC cards must display:\n  - Eligibility criteria for the card.\n  - The final date users can apply for the card.\n- A sample illustration that shows how tranche windows are calculated based on the user’s approval date.\n- The user must be able to view their current, upcoming, and completed tranche progress directly on the Card Page.\n\nEmail Communication of Personalised Tranche Windows:\n- After approval, each user must receive an email that includes their tranche windows calculated **based on their personal approval date**, not calendar month.\n- System must send a follow-up summary email when triggers are met until all three tranches have been completed or expired.\n  - Summary emails must show:\n    - Current active tranche.\n    - Upcoming tranche.\n    - Completed tranches, if any.\n  - Events are sent to Customer.io when:\n    - User reaches 70% of minimum spend\n    - User reaches 100% of minimum spend\n    - User is 5 – 7 days from window end\n    - User fails to meet spend\n  - Notes\n    - For emails of M1 tranche, users are notified that transactions made before card was linked will not be reflected but still count towards their minimum spend requirements |
| 2 | Automated Miles Issuance/Confirmation/Cancellation based off minimum spend tracking during eligibility windows | As a user, I want my rewards to appear automatically when I meet the requirements so I feel the platform is reliable. | Tranche windows logic:\n- **M1:** Approval date → last day of the next calendar month.\n- **M2:** 1st day of the following month → last day of that same month.\n- **M3:** Full month immediately after the M2 month\n\nCard Page\n- The HeyMax Cards Application Page must display the T&Cs stating:\n  - Users will receive confirmation of card approval from HSBC\n  - Users will receive a second confirmation from HeyMax within 2 weeks from the card approval date as well as pending miles in their account.\n  - For the 1st month's reward, approval will be completed by HSBC. User is to check HSBC application if they had not linked card and started spending.\n  - Reward tracking accuracy may vary if the user has not linked their card.\n1st tranche\n- When the system ingests an HSBC approval CSV, for users with status = `accepted`, the user must automatically receive the corresponding pending miles for the 1st tranche.\n- When the system ingests an HSBC approval CSV, for users with status = `approved`, the user’s pending miles should be converted to approved miles.\n  - If user has not registered with HeyMax and miles has not been issued, miles will be issued as approved when user logs in.\n  - If user does not create account within campaign period (31st March 2026), miles will be forfeited\n- Rewards must not be issued or approved if the user is not present in the CSV or has a non-accepted status.\n\n2nd & 3rd tranche\n- When the system detects that the user has met the $500 minimum spend for the respective tranche spend period, miles will be disbursed as pending to the user.\n- Tranche rewards disbursed will be automatically confirmed in 60 days from end of tranche date.\n- If HSBC does not provide 1st-tranche approval details within 120 days from date of approval, the pending miles for the 2nd and 3rd trenches will be cancelled automatically.\n- Rewards must only be triggered once per tranche spend period and must not duplicate on repeated spend detections. |

---

## 8. Technical Requirements
| # | Module | Acceptance Criteria |
| --- | --- | --- |
| 1 | Processing for HSBC files | Requirements\n- CSV template:\n  - email, approval_date, card_bin, card_last_4, status, card_name\n- Partial file failures (e.g., invalid rows) must not stop the processing of valid rows.\n- After every upload, the system must generate a processing summary report (e.g., counts of processed, failed, skipped rows).\n- Re-uploaded rows must be processed only if their status has changed.\n- If the previous status is already terminal (approved or rejected), no update is applied.\n- If a record matches an existing user, the system must issue/update miles according to status rules.\n- If a record does not match an existing user, the system must send an email prompting the person to sign up using the provided link.\n- If the user exists but the card is not linked, the system must notify the user to link their card to start tracking. (we can send event)\n- Valid records must activate or update the user’s M1/M2/M3 tranche eligibility windows.\n\nTranche & Status Processing Logic\n1. Accepted Status\n  1. When a record has status = accepted, the system must create a pending M1mile transaction (transaction_type = pending) if one does not already exist.\n2. Approved Status\n  1. When a record has status = approved:\n    1. If the user does not have a M1 transaction, create one with\n      1. transaction_type = approved\n    2. If the user already has a M1 pending transaction, update it to\n      1. transaction_type = approved\n3. Rejected Status\n  1. When a record has status = rejected:\n    1. Update the user’s M1 mile transaction to\n      1. transaction_type = cancelled (if it exists)\n    2. If the user has M2 or M3 transactions, update them to\n      1. transaction_type = cancelled as well\n\nTriggered System Behaviours\n- Successful ingestion of a file must trigger M1 trench updates immediately.\n- Tranche eligibility windows must be created or updated upon successful processing of a valid record.\n\nPost–CSV Ingestion Notifications\nFor any change in 1st-trench status during ingestion:\n- Accepted\n  - User will be sent an event which triggers an email confirming that their 1st tranche miles have been issued (pending).\n- Approved\n  - User will be sent an event which triggers an email confirming their 1st tranche miles are approved.\n- Rejected\n  - User must receive an email stating:\n    - Their miles have been cancelled,\n    - They did not meet the minimum spend,\n    - They may contact HSBC if they believe this is an error,\n    - Otherwise, the miles will be automatically cancelled in 2 weeks. |
| 2 | Monthly Clawback Processing | - System accepts a monthly CSV from HSBC\n  - attributes include\n    - user's email\n    - clawback reason\n    - trenches to clawback\n- Post Ingestion\n  - Freezes redemption of user for 2 weeks\n  - Issues email to user regarding clawback, to get user to reach out to HSBC if its an error, ignore if no issue\n  - After 2 weeks, release redemption block + proceed with negative adjustments to user reward balances\n  - Clawback / Cancellation of future tranches if required\n- Logs every clawback for auditability. |
## 9. Event Tracking Requirements

| Event Name | Attributes | Description | existing |
| --- | --- | --- | --- |
| `card_approval_received` | - user_id\n- email\n- card_name\n- card_last_four\n- approval_date\n- bank | M1 eligibility created | to create |
| `card_min_spend_updated` | - user_id\n- email\n- card_name\n- card_last_four\n- trench_number\n- spend_amount\n- spend_remaining\n- window_end_date | spend update | to create |
| `mile_transaction` | - | Pending miles issued for trench rewards | ✅ |
| `mile_transaction` | - | miles approved for trench rewards completion | ✅ |
| `mile_transaction` | • reason | miles cancelled for failure to hit minimum spend for trench rewards | to update |

---

## 10. Designs

[Figma](https://www.figma.com/design/jmZjZ7FslCLKGEwRKSZneG/-HeyMax--Card-Linked-Spend-Tracking?node-id=9-21682&t=UgzvYZH7tv34V2ft-1)

Email Designs

---


**Q: How long do I have to wait before miles becomes confirmed?**

- Expected confirmation time is show on the transaction timeline.
  - ~60 days after each trench (or auto-approval if HSBC does not respond).

---

## 12. Launch Checklist

- [ ] Confirmation of CSV template
- [ ] Confirmation of auto-cancel date for 1st trench (120 days post-approval)
- [ ] Data ingestion pipeline set up
- [ ] Spend weekly cron job configured
- [ ] Customer.io campaigns created
- [ ] App banners & marketing pages updated
- [ ] QA on trench calculation cases
- [ ] QA on refund & cancellation logic
- [ ] Internal dashboards built for Ops

---

## 13. Ops & Customer Service Workflows

See [ops-workflows.md](./ops-workflows.md) for detailed workflows including:
- CSV ingestion and batch management
- User diagnostics dashboard
- Individual user detail views
- Auto-cancellation date extension
- Alert and exception management
- Clawback processing
- Reporting and analytics
- Required admin tools

---

## 14. Future

1. explore other reward models (rewarding bonuses immediately without waiting for 60 days)
