# Old Prd

## Problem Statement
When merchants approach us saying "performance is not good, how can we improve it?", we lack:
1. **Systematic understanding** of our delivery capacity (impression → conversion rates per placement)
2. **Levers we can pull** to improve merchant performance in a scalable way
3. **Operational tooling** to execute improvements consistently across 100+ merchant requests

### Current State
- Ranking defaults to popularity sort + manual BD override (global, not placement-specific)
- No visibility into which placements drive conversions for which merchant types
- Manual processes without SOPs lead to inconsistent delivery
- No systematic response when merchants ask "why is my performance bad?"

### Objective
Build a **systematic merchant performance improvement capability** that:
1. **Measures** conversion capacity per placement/session type
  1. first via Statsig/Sundial
  2. subsequently via merchant portal
2. **Enables levers** to improve CTR and CVR at scale
3. **Delivers consistently** through operational tooling and clear ownership

---
## Levers to Improve Merchant Performance (CTR + CVR)
| Lever Category | Specific Levers | Impact Area | Phase | Notes |
| --- | --- | --- | --- | --- |
| **Exposure & Placement** | Merchant ranking allocation on more placements | CTR | 1 |  |
|  | Placement-specific ranking control | CTR | 1 |  |
|  | Time-bound visibility campaigns | CTR | 1 |  |
| **Personalisation** | Personalised merchant recommendations | CTR + CVR | 2 | Based on user behaviour/transaction history |
| **Intent-Based Exposure** | Show merchants based on session intent (search, browse, redeem) | CTR | 2 | Requires intent surface mapping |
| **Incentive** | Miles booster campaigns | CVR | 3 | Requires targeted approach; uncertain ROI |
| **Paid Ads** | CPI/CPC impression packages | CTR | 4 | Dependent on Impression Infrastructure (4.6) |
| **Education** | How-to-earn guides per merchant | CVR | Future | Cross-team dependency (Marketing) |

**Not in scope (no current capability):**
- User reviews / social proof (not built in-app)

**This PRD focuses on Phase 1: Exposure & Placement** — the foundation for systematic merchant performance improvement.

---

## Goals
- Understand conversion capacity per placement (which surfaces drive conversions?)
- Enable placement-specific ranking control (not just global)
- Deliver merchant visibility campaigns with clear ownership and SOPs
- Build foundation for additional levers (incentive, education, etc.)
- Create systematic response to "how do I improve performance?" at scale

---

## Who Is This For
- **Merchants / Partners**
  - Get actionable levers to improve performance, not just "wait and see"
- **BD team**
  - Can systematically respond to merchant performance inquiries
  - Has visibility and control over placement allocations
- **Ops team**
  - Clear SOPs for executing ranking changes
  - Time-bound campaigns that auto-expire
- **Product & Data teams**
  - Foundation data to decide: is this a ranking, upfunnel, or personalisation problem?

---

## Phasing Overview

| Phase | Focus | Levers Enabled | Outcome |
| --- | --- | --- | --- |
| **Phase 1** | Exposure & Placement | Placement-specific ranking, time-bound campaigns | Systematic delivery for merchant performance |
| **Phase 2** | Personalisation + Intent | User-based recommendations + intent-aware exposure | Targeted exposure based on user behaviour and session intent |
| **Phase 3** | Incentive | Miles boosters (targeted approach) | CVR lever for specific merchant segments |
| **Phase 4** | Paid Ads | CPI/CPC impression packages | Monetisation on understood economics |

**Dependencies:**
- Phase 4 depends on prd.md for exposure measurement and delivery pacing

---

## Phase 1 — Exposure & Placement Control

### Goal
Enable **systematic merchant performance improvement** through placement control, with clear measurement of what works.

### What This Enables
- "Merchant A performance is low → increase visibility on Earn Home + Deals for 14 days → measure CTR/CVR impact"
- Ops executes with clear SOPs, auto-expiring campaigns
- Product gets visibility into which placements drive conversions for which merchant types
- BD can respond to merchant inquiries with a consistent playbook

### User Stories & Acceptance Criteria (Phase 1)
| # | User story | Acceptance Criteria |
| --- | --- | --- |
| 1 | As an Ops team member, I want to upsize a merchants ranking in a specific section for a fixed time period. | Ops can select:\n- Merchant\n- Section(s)\n- Start date\n- End date\n\n- Ranking upsize automatically expires at end time\n- No engineering intervention required |
| 2 | As a Business team member, I want confidence that a sold deal maps clearly to in-app visibility. | Each deal references:\n— Sections included\n— Duration\n\n- Ops can verify active placements in-app\n- No ambiguity on where the merchant appears |
| 3 | As a Product team member, I want ranking logic to remain CPA-safe. | Ranking changes do not depend on exposure data\n\nCPA metrics (CTR, CVR) remain primary success signals\n\nNo paid placement logic influences conversion attribution |
---

## Phase 2 — Personalisation & Intent-Based Exposure

### Goal
Enable **user-based merchant recommendations and intent-aware exposure** to improve relevance and conversion.

### What This Enables
- "User frequently transacts with travel merchants → surface travel merchants higher"
- "User in 'search' session → show different merchants vs 'browse deals' session"
- "User has never seen Merchant B but matches profile → recommend proactively"
- Move from "same ranking for everyone" to "relevant ranking per user and session intent"

### Levers in Scope
| Lever | Description | Success Metric | Status |
| --- | --- | --- | --- |
| Personalised recommendations | Merchant suggestions based on user transaction history and behaviour | CTR + CVR uplift | Data exists |
| Affinity-based ranking | Adjust ranking based on user-merchant affinity signals | CTR uplift | Data exists |
| Intent-based exposure surfaces | Show different merchants based on session intent (search, browse, redeem) | CTR uplift | Requires mapping |
++ quick action + cross sell recommendation


### Phase 2 Workstreams

**2A. Personalisation** (can start immediately after Phase 1):
- User transaction history → merchant affinity scoring
- Personalised ranking adjustments per user

**2B. Intent-Based Exposure** (requires upfront work):
- **Map intent categories**: Define what "search intent" vs "browse intent" vs "redeem intent" means
- **Tag existing placements**: Which surfaces serve which intents?
- **Define intent-specific ranking logic**: e.g. high CVR merchants for search, discovery merchants for browse
- **Measure intent signals**: How do we detect user intent in session?

### Open Questions
- What user signals are available today? (transaction history, search, browse)
- How do we balance personalisation vs merchant commitments (e.g. promised visibility)?
- **Intent surfaces**: Which app surfaces map to which intents? (requires discovery work)
- **Intent detection**: How do we infer user intent from session behaviour?

---

## Phase 3 — Incentive Levers

### Goal
Enable **targeted incentive mechanisms** to improve CVR for specific merchant segments.

### What This Enables
- "Merchant A has good visibility but low CVR → test miles booster for high-intent users"
- Stack levers: placement + personalisation + incentive

### Levers in Scope
| Lever | Description | Success Metric | Notes |
| --- | --- | --- | --- |
| Miles booster campaigns | Temporary bonus miles for specific merchants | CVR uplift | May be HeyMax-sponsored or merchant-funded |
| Discounted miles rate | Sell miles to merchant at reduced rate for boosting | CVR uplift | Commercial model TBD |

### Why Phase 3 (not earlier)?
- Incentives require understanding which merchants/users to target (from Phase 1-2 learnings)
- Uncertain ROI — need data to prescribe right solution
- Commercial model (who pays?) needs clarity

---

## Phase 4 — Paid Ads (CPI / CPC)

### Goal
Introduce **paid visibility as a pricing layer** on top of understood economics.

### Key Principle
Paid ads = a factor to change placement logic based on expected revenue.
> Example: Show Merchant A in deals page = 0.5 cents expected revenue. Show Merchant B = 0.2 cents expected revenue. Only if Merchant B pays 0.3+ cents do we display their deal instead.

### Dependency
This phase depends on prd.md:
- Exposure measurement (impressions by placement)
- Delivery pacing and caps
- CPI/CPC commercial readiness
---
### Prerequisites
- Understand expected conversion value per placement (from Phase 1-3 learnings)
- Impression Infrastructure in production (exposure logging, placement definitions)
- Clear separation between organic and paid ranking
- Budget/cap guardrails to prevent over-delivery
---
## What We Are Explicitly *Not* Doing in Phase 1
- No personalised ranking (Phase 2)
- No incentive levers like miles boosters (Phase 3)
- No paid ads / CPI / CPC (Phase 4)
- No real-time bidding
- No advertiser self-serve
---
## Phase 1 Launch Checklist
- Placement list finalised with owners (see table below)
- Ops SOP documented for ranking changes
- Measurement setup in Statsig/Sundial for CTR/CVR per placement
- Time-bound campaign functionality tested
- BD playbook for "how to improve merchant performance" documented
- Internal training completed