# HSBC Card Acquisition - Customer Support Scenarios & Required Tooling

**Purpose:** This document outlines customer issues that require CS intervention and what tools/endpoints are needed to resolve them.

---

## Customer Issue #1: "I applied for the card but haven't received my miles"

### What the customer says:
- "I was approved for HSBC card 2 weeks ago, where are my 12,500 miles?"
- "I got approved but don't see any pending miles in my account"
- "HSBC confirmed my card but HeyMax hasn't given me anything"

### Common Causes:
1. **Wrong email mismatch**: User signed up with different email with HSBC
2. **Too early**: User just got approved, we haven't received CSV from HSBC yet
3. **Card linked to wrong account**: User has card linked but to different HeyMax account

### What CS needs to check:
1. What email did user use for HSBC application? (ask customer if the current account can't be found)
2. Search for email in system by that email
3. If found: Check if they're in our system and their approval status
4. If found: Check if card is already linked (may be linked to wrong account)

### Required Tool:
**User Lookup by Email**
- Search for user by email (the one they used for HSBC)
- See if they appear in any batch
- Check their mile transaction status (pending/approved/not issued)
- Check if their card is linked to an account
- See what CSV batch they were in and when it was processed

### Required Endpoints:
- `GET /api/v1/hsbc/users/search?email={user_email}` - Find user by email
- `GET /api/v1/hsbc/users/{user_id}` - Get user campaign details

**What CS sees:**
- Whether email exists in our system
- User's approval status from HSBC (if in CSV provided)
- When we received their data (which batch, which date)
- Mile transaction status (pending/approved/not issued)
- Card link status (linked to which account)
- Any errors during processing

**Resolution Paths:**

**Path A: User not in our system yet**
- Check when user was approved by HSBC
- If < 2 weeks ago: "We receive approval files bi-weekly from HSBC. Your approval should appear in our next batch. Please wait."
- Remind user: "Your M1 (first month) spend is tracked by HSBC directly. Check HSBC app for M1 spend. Please link your card in HeyMax app now to prepare for M2 and M3 tracking."

**Path B: User in system, but wrong email/account**
- Ask: "Which email did you use to sign up for HeyMax?"
- If different from HSBC email: "I see your card is approved under {hsbc_email} but you're logged into HeyMax with {heymax_email}"
- If card already linked to wrong account: "Your card is already linked to another HeyMax account. Please unlink it first, then link to your current account."
- Guide user to link card to correct account

**Path C: User in system, processing failed**
- Check error reason in system
- Escalate to tech team with batch ID and error details

**Path D: Miles already issued**
- Show user where to find pending miles in app
- Explain they'll be confirmed in 60 days or when HSBC approves (whichever is earlier)

---

## Customer Issue #2: "My spend isn't tracking correctly"

### What the customer says:
- "I spent $300 but the app shows $0"
- "I completed the $500 spend, but I don't see the miles in my account yet"
- "I made purchases but they're not showing up"

### Common Causes:
1. **Excluded transactions**: User made purchases with excluded MCC codes (cash advance, bill payments, etc.)
2. **Transaction data dropped**: Our system didn't receive some transactions from the bank
3. **Card not linked**: User hasn't linked their HSBC card yet

### What CS needs to check:
1. Is the user's HSBC card linked to HeyMax?
2. Are transactions appearing in our system at all?
3. Which transactions are showing as excluded and why?
4. What's the difference between total spend vs qualified spend?
5. Are there legitimate transactions that should count but aren't appearing?

### Required Tool:
**Transaction History Viewer**
- See all user's transactions for the campaign period
- Filter to show excluded transactions only
- See exclusion reasons (specific MCC code, transaction type)
- Compare total spend vs qualified spend
- See transaction dates and which tranche they count towards

### Required Endpoints:
- `GET /api/v1/hsbc/users/{user_id}` - Check if card is linked
- `GET /api/v1/hsbc/users/{user_id}/transactions` - Get transaction history with exclusion details

**What CS sees:**
- Card link status (linked or not linked)
- All transactions with qualified/excluded flag
- Exclusion reasons for each excluded transaction (e.g., "MCC 6011: Cash Advance", "MCC 4900: Utilities Bill Payment")
- Total spend vs qualified spend amounts
- Transaction dates and which tranche window they fall into

**Resolution Paths:**

**Path A: Card not linked**
- "I see your HSBC card isn't linked to HeyMax yet."
- Guide user to link card in the app
- Note: "Transactions made before linking won't appear in the app, but they still count towards your M1 minimum spend. HSBC is tracking your M1 spend. M2 and M3 spend requires your card to be linked to HeyMax" 

**Path B: Transactions excluded (legitimate reason)**
- Show user the excluded transactions
- Explain: "These transactions don't count towards minimum spend because:"
  - Cash advances (MCC 6011)
  - Bill payments (MCC 4900)
  - Balance transfers
  - [List specific MCC categories from HSBC exclusion list]
- Direct user to HSBC's terms for full list of excluded categories

**Path C: Legitimate transactions missing**
- Review transaction list with user
- If user mentions that the transaction doesn't appear at all:
  - Check transaction date (may not be processed yet, usually takes 1-2 days)
  - Create tech ticket: "User reports transaction on {date} at {merchant} for ${amount} not appearing. User ID: {id}, Card Last 4: {xxxx}"
  - Escalate to ENG team to investigate data feed issue

**Path D: User confused about tranche windows**
- Explain which transactions count for which tranche
- "Transactions from {M1_start} to {M1_end} count for M1 reward"
- "Your M2 window is {M2_start} to {M2_end}"

---

## Customer Issue #3: "When will my miles be confirmed?"

### What the customer says
- "How long do I have to wait for my miles to be approved?"
- "It's been 2 months and my miles are still pending"

### Common Causes:
1. **User didn't check transaction details**: Confirmation date is shown in the app but user missed it
2. **Systemic delay**: Multiple users' miles are delayed, indicating a processing issue

### What CS needs to check:
1. What is the current status of each tranche?
2. When did the tranche window end?
3. What is the expected confirmation date displayed based on the user's transaction?
4. Is the user past their expected confirmation date?

### Required Tool:
**Tranche Status Viewer**
- See all 3 tranches (M1/M2/M3) with dates and progress
- See reward status (not issued/pending/approved/cancelled)
- See auto-confirmation date for each tranche
- Days remaining until confirmation/cancellation

### Required Endpoints:
- `GET /api/v1/hsbc/users/{user_id}` - Get tranche details

**What CS sees:**
- Each tranche window (start/end dates)
- Spend progress and completion status per tranche
- Reward status and amounts (12,500 / 6,250 / 6,250 miles)
- Auto-confirmation date (60 days from tranche end)
- For M1: Auto-cancel date (90 days from M1 end if HSBC hasn't approved)
- Days remaining until each milestone

**Resolution Paths:**

**Path A: Normal waiting period (within 60 days of tranche end)**
- "Your miles are pending and will be automatically confirmed on {confirmation_date}, which is {X} days from now."
- Direct user: "You can see this date in the app under Miles > Transaction Details"
- Explain: "All tranche rewards are automatically confirmed 60 days after the tranche period ends, or when HSBC sends final approval (whichever comes first)"

**Path B: M1 specific - explain approval flow**
- "For M1 (first month), we're waiting for final approval from HSBC."
- "If HSBC doesn't respond by {auto_cancel_date} (90 days from end of M1), your M1 miles will be automatically cancelled."
- "Your M2 and M3 miles depend on M1 approval, so they'll be affected too."

**Path C: Past expected confirmation date (potential issue)**
- Check confirmation date vs today's date
- If past expected date by >3 days: "I see your miles should have been confirmed by {date}. Let me escalate this to our tech team to investigate."
- Create tech ticket with:
  - User ID
  - Tranche details
  - Expected confirmation date
  - Current status
- Follow up: "Our team will investigate and update you within 1-2 business days"

**Path D: Multiple users affected (systemic issue)**
- If CS is getting multiple similar reports: Escalate to ops/tech team immediately
- Check if there's a known issue with auto-confirmation cron job
- Inform user: "We're aware of a delay affecting multiple users. Our team is working on it and will process confirmations manually if needed."

---

## Customer Issue #4: "My miles are about to be rejected / were cancelled, why?"

### What the customer says:
- "My 12,500 miles was rejected!"
- "I got an email saying my miles were cancelled"
- "HSBC says I was approved but HeyMax cancelled my miles"
- "I have 2 weeks to dispute, what should I do?"

### Common Causes:

**For M1 (HSBC-tracked):**
1. **HSBC rejected M1 application**: HSBC sent rejection status, user failed M1 minimum spend at HSBC's end
2. **User ignored rejection email**: Got notified but didn't act within 4-week dispute period
3. **90-day timeout**: HSBC didn't send final approval within 90 days of M1 end
4. **Clawback from HSBC**: Bank discovered fraud/violation and requested reversal

**For M2/M3 (HeyMax-tracked):**
5. **M2/M3 spend dropped below $500**: User did chargebacks/reversals after miles were issued, HeyMax detected final posted amount < $500

**Note:** M1 rejections come from HSBC's CSV. M2/M3 rejections are processed by HeyMax based on transaction data.

### What CS needs to check:
1. Which tranche was cancelled? (M1, M2, or M3?)
2. What was the user's approval status from HSBC? (accepted vs approved vs rejected)
3. When was the rejection/cancellation email sent to user?
4. Is user still within the 4-week dispute period?
5. Were miles auto-cancelled due to 90-day timeout?
6. Is there a clawback from HSBC?
7. For M2/M3: Did the user's final posted spend drop below $500 due to chargebacks/reversals?
8. What is the specific cancellation reason?

### Required Tool:
**Mile Transaction History & Status Checker**
- See all mile transactions (issued/approved/cancelled)
- See specific cancellation reason
- See rejection timeline (when email sent, when auto-cancel happens)
- Check if user is under clawback freeze
- See HSBC approval status history (accepted → rejected)

### Required Endpoints:
- `GET /api/v1/hsbc/users/{user_id}` - See approval status and mile transaction history
- `GET /api/v1/hsbc/users/{user_id}/clawback-status` - Check if under clawback, redemption status

**What CS sees:**
- Which tranche was affected (M1/M2/M3)
- HSBC approval status (accepted/approved/rejected) and when it changed
- Mile transaction history with cancellation reasons
- Rejection email sent date
- Auto-cancel date (4 weeks from rejection notification)
- Days remaining in dispute period
- If clawback: reason, timeline for resolution, redemption status (redeemed/unredeemed)
- If timeout: when 90-day period expired
- For M2/M3: Transaction history showing chargebacks/reversals and final posted spend amount

**Resolution Paths:**

**Path A: M1 rejection from HSBC (within 4-week dispute period)**
- Check days remaining: "You have {X} days left to dispute with HSBC."
- Explain: "HSBC sent us a rejection for your M1 (first month) application. This usually means:"
  - Didn't meet M1 minimum spend of $500 at HSBC's end
  - Card was cancelled during the campaign period
  - Fraud or violation detected by HSBC
- Important: "M1 is tracked by HSBC, not HeyMax. Only HSBC can confirm why this was rejected."
- Action: "Please contact HSBC directly at [HSBC customer service number] to understand why your M1 was rejected."
- "If HSBC can resolve this and update your status, your miles can be reinstated."
- "If not resolved within {X} days, miles will be automatically cancelled."
- Note: "This affects M2 and M3 as well, since they depend on M1 approval."

**Path A1: User claims they hit M1 spend but HSBC rejected (marketing consent issue)**
- Special case: User says "I definitely spent $500, I even got your emails saying I completed it!"
- Check: Look at user's M1 transaction history in HeyMax system vs HSBC's rejection
- Explain: "I can see from our tracking that you appear to have met the spend requirement. However, HSBC is the final authority on M1 spend validation."
- Likely cause: "This sometimes happens if you opted out of marketing communications with HSBC. HSBC may not have shared your final spend data with us."
- Action: "Please contact HSBC directly and ask them to:"
  1. Verify your M1 spend from {M1_start} to {M1_end}
  2. Reinstate your approval if you met the requirement
  3. Update HeyMax immediately once rectified
- "HSBC can correct this in their next bi-weekly approval file, and your miles will be reinstated automatically."
- "You have {X} days left in the dispute period to get this resolved with HSBC."

**Path B: M1 rejection already auto-cancelled (past 4 weeks)**
- "I see your M1 miles were cancelled on {date} as HSBC rejected your application."
- Check: "Did you contact HSBC about this rejection?"
- If no: "Unfortunately, the 4-week dispute period has passed. As per our Terms & Conditions, miles cannot be reinstated after the dispute period expires. You can still contact HSBC to understand what happened."
- If yes (HSBC says it was a mistake): Escalate to ops team with HSBC reference number
- Note: "Your M2 and M3 miles were also cancelled since they depend on M1 approval."

**Path C: M1 - 90-day timeout (HSBC never sent final approval)**
- "Your M1 miles were cancelled because HSBC didn't send final approval within 90 days of your M1 tranche ending."
- "Your M1 status remained as 'accepted' but never moved to 'approved'."
- "This affects your M2 and M3 miles as well, since they depend on M1 approval."
- Explain: "We wait 90 days for HSBC to confirm M1 approval. If they don't respond, we automatically cancel to avoid holding miles indefinitely."
- Action: "Please contact HSBC to ask why final approval wasn't sent. If they can confirm approval now, we can potentially reinstate your miles."
- If user confirms with HSBC: Escalate to ops team to request auto-cancel date extension

**Path D: M2/M3 cancelled by HeyMax (chargebacks dropped spend below $500)**
- Check transaction history: Look for negative transactions (refunds, chargebacks, reversals)
- Calculate final posted spend for the tranche
- Explain: "I can see your {M2/M3} miles were cancelled because your final posted spend for that tranche dropped below the $500 minimum."
- Important: "M2 and M3 are tracked by HeyMax based on your transaction data. When transactions are reversed (chargebacks, refunds), we recalculate your final spend."
- Show breakdown:
  - "Initial spend: ${initial_amount}"
  - "Chargebacks/refunds: -${chargeback_amount}"
  - "Final posted spend: ${final_amount} (needs to be $500)"
- Details:
  - Show specific transactions that were reversed:
    - Date, merchant, original amount, reversal date
  - "These transactions were reversed after your miles were initially issued."
  - "The $500 minimum spend must be maintained based on your final posted transactions."
- Resolution:
  - "To meet the minimum spend requirement, you would have needed ${shortfall} more in qualified spend during the {tranche_start} to {tranche_end} window."
  - "Since the tranche period has ended, these miles cannot be reinstated."
  - Note: "Your other tranches are not affected unless they also have chargebacks that bring them below $500."
  - Note: "M1 is tracked by HSBC, so M1 cancellations would come from HSBC, not from HeyMax."

**Path E: Clawback from HSBC (applies to any tranche)**
- "HSBC has requested a clawback for the following reason: {clawback_reason}"
- "Your redemption is frozen for 2 weeks while we process this."
- Explain: "This is different from a rejection. HSBC discovered an issue after initially approving, and is now requesting we reverse the miles."
- Action: "If you believe this is an error, contact HSBC immediately at [HSBC customer service number]."
- "If not resolved within 2 weeks, the miles will be deducted from your account."
- Check redemption status:
  - If user has already redeemed miles: Note in ticket for ops team - may need to coordinate with HSBC on payment reconciliation
  - If miles are still in account: Freeze redemption capabilities of user, deducted miles within 2-week period
- Show current balance and projected balance after clawback

---

## Existing Support Tools

### Appsmith Linked Card Search Tool
**Purpose**: Search and view user's linked card information

**What it shows:**
- User ID or email search
- All cards linked to user account
- Card linking history (when cards were added/removed)
- Transaction history for each linked card
- Which specific card was used for HSBC campaign tranches

**Use cases:**
- Verify which HSBC card user linked for the campaign
- Check if user unlinked/relinked card during campaign period
- View transaction-level details to understand spend patterns
- Confirm which card transactions were counted toward M1/M2/M3 spend requirements

---

## Summary: Endpoints Needed

**Note:** Card linking status and transaction history are already available in the existing Appsmith Linked Card Search Tool, so we only need HSBC campaign-specific data.

### Priority Breakdown:
- **P0 (Required for launch)**: Endpoints 1, 2
- **P1 (Nice to have)**: Endpoints 3, 4 (can rely on existing Appsmith tool initially, add campaign-specific logic later)

1. **User Lookup** - `GET /api/v1/hsbc/users/search?email={email}`
  - **Use cases:**
    - Issue #1: Find user who claims they applied but no miles
    - Search by email that user used for HSBC application
  - **Must return:**
    - User ID (if found)
    - Basic info to confirm it's the right person

2. **User Campaign Details** - `GET /api/v1/hsbc/users/{user_id}`
  - **Use cases:**
    - Issue #1: Check approval status, batch info, mile transaction status
    - Issue #3: See tranche dates, confirmation dates, auto-cancel dates
    - Issue #4: See cancellation reasons, HSBC rejection status
  - **Must return:**
    - HSBC approval status: accepted/approved/rejected, when status changed
    - All 3 tranche details:
      - Window dates (start/end)
      - Spend progress (current/required)
      - Reward status (pending/approved/cancelled)
      - Auto-confirmation date (60 days from tranche end)
      - Auto-cancel date (90 days from M1 end, for M1 only)
    - Mile transaction history with cancellation reasons
    - Batch info: when data was received from HSBC
    - For M2/M3 rejections: Show chargeback/reversal amounts and final posted spend

3. **Transaction Exclusion Details** (P1) - `GET /api/v1/hsbc/users/{user_id}/transactions/exclusions`
  - **Use cases:**
    - Issue #2: See which transactions are excluded and why
  - **Must return:**
    - Excluded transactions with:
      - Date, merchant, amount
      - Exclusion reason (e.g., "MCC 6011: Cash Advance")
      - Which tranche it would have counted towards
    - Summary: total spend vs qualified spend per tranche
  - **Note:** Basic transaction list already exists in Appsmith tool, this endpoint only needs to expose exclusion logic

4. **Clawback Status** (P1) - `GET /api/v1/hsbc/users/{user_id}/clawback-status`
  - **Use cases:**
    - Issue #4: Check if user is under clawback freeze
  - **Must return:**
    - Clawback reason
    - Timeline for resolution (2-week period)
    - Days remaining in dispute period
    - Redemption status (redeemed/unredeemed)