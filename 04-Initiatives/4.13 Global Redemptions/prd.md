# Global Redemptions

**Linear Project:** https://linear.app/heymax/project/global-redemptions-d22afe808b4f/overview

---

## Problem / Objective

Companies with existing loyalty currencies (points, rewards) want to offer a travel offering such as airline/hotel miles redemption to their users but face significant barriers:
- Building and maintaining relationships with airline loyalty programs is resource-intensive
- Managing fulfilment infrastructure and support across multiple countries is complex
- Existing solutions (e.g., Ascenda) are country-locked, enterprise-focused, and require volume
- Companies don't want to deprecate their own loyalty currency but want a redemption layer

### The Opportunity
Enable a B2B2C redemption-as-a-service model where companies can offer their users access to HeyMax's airline redemption network while maintaining their own loyalty currency and brand relationship.

**Objective**:
1. Extend our redemption infrastructure to allow partners to access a hosted redemption portal to convert their loyalty currency → Max Miles → Airline/Hotel Miles
2. Acquire new HeyMax users in core (HK/SG) and expanding markets (AU/TW/JP) through partner channels
3. Generate new B2B revenue streams while expanding distribution

---

## What success looks like

### Success Metrics
- **User Acquisition**: New HeyMax account sign-ups
- **Revenue**: Miles purchase volume commitment from partners
---

## Supporting signals

### Active Partner Pipeline
| Partner | Type | User Base | Key Markets | Status |
| --- | --- | --- | --- | --- |
| **PEXX** | Stablecoin card | 70K KYC'd users | Bangladesh, Indonesia, Asia | Active discussions |
| **Animoca Brands** | Web3/Gaming | Large (60% Korean) | South Korea, Global | Active discussions |
| **Rytbank** | Digital bank | TBD | Malaysia | Active discussions |
| **Rapidz** | Payment platform | TBD | TBD | Early talks |
| **DCS (Diners)** | Credit card network | TBD | TBD | Early talks |
| **Atome** | BNPL platform | TBD | SEA | Early talks |
| **Rewa** | Rewards platform | TBD | TBD | Early talks |
| **CYS** | Payment platform | TBD | TBD | Early talks |
| **KAST** | Stablecoin card | TBD | TBD | Early talks |

### Common Partner Needs
- **Don't want to deprecate existing loyalty currency**: Need a conversion layer, not a replacement
- **Want scalable, easy-to-use partner**: Previous solutions (Ascenda) too enterprise-heavy and country-locked
- **Need broad redemption network**: Access to multiple airline partners without individual integrations
- **Support for diverse markets**: From Bangladesh/Indonesia to Korea to Malaysia
- **White-label/co-branded experience**: Maintain their brand relationship with users

### Why This Matters Now
- Multiple inbound requests from different partner types (fintech, web3, BNPL, traditional cards)
- Each partner has established user base and distribution
- Partners want to add travel as value-add without building infrastructure
- Opportunity to scale HeyMax reach into non-traditional channels

---

## Who is this for

### User personas

**Primary: Partner's Rewards User**
- Has earned Partner's Points through card spend, campaigns, and incentives
- Interested in travel and wants to convert points to airline miles
- Comfortable with digital financial services
- Located in Asia (Bangladesh, Indonesia) or other regions

**Secondary: Partner's - HeyMax Product User**
- Partner's user who logs into HeyMax directly
- Wants to access flight/hotel search capabilities before transferring miles

---

## User Flows

> **Key Design Principle**: Due to contractual obligations with airline partners, the relationship is between Max Miles ↔ Airline Partners. Therefore, Max Miles branding must be visible throughout the redemption experience.

### Flow 1: First-Time Redemption (with Account Linking Upfront)

```
Partner's App → "Redeem to Miles" → Redirected to HeyMax Self-Hosted Page
    ↓
┌─────────────────────────────────────────────────────────────┐
│ HeyMax Redemption Portal (Co-branded: Partner's + Max Miles)│
├─────────────────────────────────────────────────────────────┤
│ Step 1: Account Linking & T&C (if first time)               │
│   - Accept Terms & Conditions                               │
│   - Consent: Partner's will share with HeyMax:              │
│     • Email                                                 │
│     • Phone number                                          │
│     • User country                                          │
│     • First and last name                                   │
│   - HeyMax account created automatically via Partner's API  │
│   - 1:1 binding: Partner's user ID → HeyMax user ID         │
└─────────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 2: Redemption Dashboard                                │
│   Header:                                                   │
│   - Partner's Points Available: Y points                    │
│   - Max Miles Balance: 0 miles                              │
│                                                             │
│   Available Airline Partners (configured by Partner's):     │
│   [Singapore Airlines] [Qantas] [Emirates] [...]           	│
│                                                             │
│   Transfer History:                                         │ <-- need to check with Partner's if they need to display this information on their
│   - Partner's → Max Miles deposits                          │ <-- transaction history
│   - Max Miles → Airline redemptions                         │
└─────────────────────────────────────────────────────────────┘
    ↓
User selects airline partner
    ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 3: Enter Airline Account (if not already linked)       │
│   To transfer to Singapore Airlines, link your account:     │
│   - Enter loyalty number: [___]                             │
│   [Continue]                                                │
└─────────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 4: Transfer Confirmation                               │
│   You are transferring to: [Singapore Airlines]             │
│   Linked account: SQ123456789                               │
│                                                             │
│   Transfer amount:                                          │
│   - Partner Miles to transfer: [___] (input)                │
│   - Partner's Points required: Y points (calculated)        │
│                                                             │
│   Two-step transfer:                                        │ <-- will only need this if Partner's can't do an escrow hold on the funds
│   1. Partner's Points (Y) → Max Miles (X)                   │ <-- if not, they will have to convert to Max Miles
│   2. Max Miles (X) → Singapore Airlines                     │
│                                                             │
│   [ Confirm Transfer ]                                      │
└─────────────────────────────────────────────────────────────┘
    ↓
Processing:
1. Partner's deducts Y Partner's Points via API
2. HeyMax credits X Max Miles to user account
3. HeyMax initiates transfer to airline partner
    ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 5: Confirmation & Tracking                             │
│   Transfer ID: TXN123456                                    │ <--- transfer id should be provided by heymax
│   Status: Processing → Completed                            │
│   Estimated completion: 1 minute		                        │
│                                                             │
│   Your Max Miles balance: Updated                           │
│   Transaction history: Updated with both transfers          │
└─────────────────────────────────────────────────────────────┘
```

### Flow 2: Returning User Redemption

```
Partner's App → "Redeem to Miles" → HeyMax Self-Hosted Page
    ↓
┌─────────────────────────────────────────────────────────────┐
│ Redemption Dashboard (User already authenticated)           │
│   Partner's Points Available: Y points                           │
│   Max Miles Balance: X miles                                │
│                                                             │
│   Available Airline Partners (configured by Partner's):          │
│   [Singapore Airlines] [Qantas] [Emirates] [...]           	│
│                                                             │
│   Transfer History: [Recent transactions]                   │
└─────────────────────────────────────────────────────────────┘
    ↓
Select airline → Link account if needed → Enter miles amount → Confirm
    ↓
(Same transfer flow as Flow 1, Step 3-5)
```

### Flow 3: Partner Support Portal (Partner's Staff) (option: give them API instead)

```
Partner's Support Portal → Lookup User/Transaction
    ↓
Enter Partner's User ID or Transaction ID
    ↓
View Transaction Details:
    - Redemption status
    - Miles transfer status
    - Fulfillment timeline
    - User's HeyMax account status
    ↓
For complex issues: Escalate to HeyMax (English)
```

---

## Product requirements

### P0 - Must Have
| # | User story | Acceptance criteria |
| --- | --- | --- |
| 1 | As a Partner's user, I need to accept T&C for account linking | User accepts T&C consenting to share email, phone, country, name with HeyMax; account created automatically via API |
| 2 | As a Partner's user, I want to see my app's balance and Max Miles balance | Dashboard shows current Max Miles balance (contractual requirement to show Max Miles brand) |
| 3 | As a Partner's user, I want to see available airline partners | Self-hosted HeyMax page displays airline partners configured for partners |
| 4 | As a Partner's user, I want to transfer my points to the airline partner miles without having to think too much about the max miles concept. | Two-step transfer clearly shown: (1) Partner's Points → Max Miles, (2) Max Miles → Airline |
| 5 | As a Partner's user, I want to see my transfer history | HeyMax Self Hosted page shows both funding transactions (Partner's → Max Miles) and redemption transactions (Max Miles → Airlines)\n\nUser can view deposit and redemption transactions in HeyMax account as well |
| 6 | As a Partner's user, I want to track my redemption status after i made the redemption | User can see transaction ID, status, and estimated fulfilment time |
| 7 | As Partner's support, I need to lookup user redemptions to investigate potential issues | Support portal allows lookup by Partner's user ID or transaction ID |
| 8 | As HeyMax, we want co-branded experience so that users know that their redemptions is fulfilled by HeyMax | "Powered by HeyMax" branding visible on redemption page |
| 9 | As a partner, we need webhook notifications for fulfilment status to display to give users better feedback post completing an action. | API webhook sends status updates for each redemption stage |
P1 - Second Phase
| 10 | As Partner/HeyMax, we need to control which redemption partners users can see | Config system allows Partner's to control available airline partners by country/user segment |

P2 - Future
| # | User story | Acceptance criteria |
| --- | --- | --- |
| 11 | As a Partner's user, I want to see the HeyMax redemption page in the language that I speak/read | Build tokens for words for translation in various languages |
---
## Technical Requirements

### Integration Method
- **Primary**: HeyMax-hosted page embedded as iframe in Partner's mobile application

### Required Builds
| Component | Status | Priority | Notes |
| --- | --- | --- | --- |
| Self-hosted redemption dashboard | New build | P0 | **Must display Max Miles branding** (contractual); shows balance, airline partners, transfer history |
| Partner account linking + T&C flow | New build | P0 | Required when user is redirected from PEXX application to HeyMax page. account is automatically created for the use.\n\nT&C acceptance + consent to share user data (email, phone, country, name); automatic account creation via API |
| Two-step transfer system | New build | P0 | (1) Partner Points → Max Miles, (2) Max Miles → Airline\n\nHeyMax to send a request to partner to hold points in escrow before initiating credit to airline partner.\nUnder the hood to transfer to miles to partner's user account and initiate redemption on behalf of user. |
| Partner config system | New build | P0 | Control airline visibility by country/partner |
| Redemption API | Exists | P0 | Extend to support partner context + two-step transfer |
| Partner support portal | New build | P1 | User/transaction lookup |
| Webhook API for fulfilment tracking | New build | P1 | Expose existing internal system |

---

## Events tracking
| Event name | Event attributes | Description |
| --- | --- | --- |
| `Partner's_redemption_page_viewed` | `Partner's_user_id`, `max_miles_balance` | User lands on HeyMax redemption dashboard |
| `heymax_account_created` | `Partner's_user_id`, `heymax_user_id` | HeyMax account created for Partner's user |
| `airline_partner_selected` | `heymax_user_id`, `airline_program` | User selects airline to transfer to |
| `airline_account_linking_started` | `heymax_user_id`, `airline_program` | User starts linking airline account |
| `airline_account_linked` | `heymax_user_id`, `airline_program`, `success` | Airline loyalty account linked successfully |
| `redemption_initiated` | `transaction_id`, `Partner's_user_id`, `Partner's_points`, `max_miles`, `airline_program` | User initiates transfer |
| `redemption_confirmed` | `transaction_id`, `Partner's_user_id`, `airline_program`, `miles` | User confirmed miles transfer |
| `fulfillment_completed` | `transaction_id`, `fulfillment_time` | Miles successfully transferred to airline |
| `support_lookup` | `Partner's_support_user_id`, `lookup_type` | Partner's support looked up user/transaction |

---

## Partner Agreement - Non-Negotiables

### What HeyMax Requires
| Requirement | Why It Matters |
| --- | --- |
| **HeyMax account creation for every redeeming user** | Brand exposure, user acquisition funnel, enables flight/hotel search upsell |
| **1:1 user binding + data sharing (Partner's user → HeyMax account)** | Fraud prevention, clean data, audit trail; requires Partner's to share email, phone, country, name with user consent |
| **Co-branded redemption experience ("Powered by HeyMax")** | Brand visibility without requiring full white-label investment |
| **Partner's owns frontline user support** | Avoid multilingual global support burden; they handle their users |

---

## FAQs

**Q: What currency do users see?**
A: Users see both currencies clearly:
- **Max Miles balance** (displayed prominently - contractual requirement)
- **Partner's Points** (shown when calculating transfer amounts)
- Two-step transfer clearly indicated: Partner's Points → Max Miles → Airline Miles

**Q: Can Partner's claw back miles after transfer?**
A: If miles are still in HeyMax account, we can support freezing. Once transferred to airline partner, clawbacks are not possible.

**Q: When do users need to link their airline account?**
A: Account linking is only required when the user wants to transfer miles to a specific airline. It's not required upfront - users can browse available partners and see their Max Miles balance without linking. When they select an airline to transfer to, they'll be prompted to link their loyalty account if they haven't already.

**Q: What user data does Partner's share with HeyMax?**
A: With user consent via T&C acceptance, Partner's shares:
- Email address
- Phone number
- User country
- First and last name

This data is used to create the HeyMax account and maintain 1:1 user binding for fraud prevention and support.

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Partner's users resistant to HeyMax account creation | High | Position as value-add feature (flight search, transaction history); make process seamless |
| Fraud/abuse through partner channel | High | 1:1 user binding; rate limiting; account verification requirements |
| Support burden from non-English markets | Medium | Partner's owns frontline support; structured escalation process; clear SLA documentation |
| Fulfillment delays impact Partner's brand | High | Clear expectation setting on timelines; real-time status updates; robust fulfillment monitoring |
| Partner's wants full white-label (no HeyMax branding) | Medium | Stand firm on co-branding requirement; emphasize value of HeyMax features to users |
| Technical integration complexity | Medium | Offer both iframe and API options; provide comprehensive API documentation; dedicated integration support |

---

## Launch checklist

### Pre-Launch
- [ ] Partner agreement signed with non-negotiables confirmed
- [ ] Co-branded redemption page designed and developed
- [ ] Partner config system built (airline visibility controls)
- [ ] Redemption API extended for partner context
- [ ] Partner support portal built and tested
- [ ] Webhook API documented and tested
- [ ] Account creation flow adapted for partner context

### Launch
- [ ] Tracking events defined and implemented
- [ ] Internal monitoring dashboard set up
- [ ] Partner's support team trained on portal
- [ ] Escalation process documented and communicated
- [ ] Soft launch with limited user group
- [ ] Full launch to all Partner's users

### Post-Launch
- [ ] Monitor fulfillment metrics daily for first 2 weeks
- [ ] Weekly sync with Partner's on support issues
- [ ] User feedback collection and analysis
- [ ] Optimization roadmap based on learnings

---

## Appendix

### Discovery Call Notes
- **Date**: 02/02/26
- **Partner:** Partner's
- **Integration Method**: Partner's confirmed iframe embedding in mobile app is acceptable
- **Account Creation**: Partner's users comfortable with HeyMax account creation

To be confirmed
- **Display Format**: Show Max Miles with Partner's Points in parentheses
- **Reversals**: HeyMax proposed no reversals after airline transfer; Partner's accepted
- **Support Language**: English-only escalation to HeyMax confirmed acceptable
- **Transaction History**: Partner's interested in showing funding and redemption transactions