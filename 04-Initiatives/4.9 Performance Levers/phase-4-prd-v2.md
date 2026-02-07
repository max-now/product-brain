# Phase 4: Monetisation Lever — Paid Ads (CPI / CPC)

> **Overview PRD:** [prd-v2.md](./prd-v2.md)

---

## Problem

After Phases 1-3, we understand the economics of merchant performance:
- Which placements drive conversions (Phase 1)
- Which users convert for which merchants (Phase 2)
- Which incentives improve CVR and at what cost (Phase 3)

But we lack a **pricing layer** to monetise this understanding. Merchants who want guaranteed exposure beyond organic ranking have no mechanism to pay for it.

**Core question:** Can we create a paid visibility product that generates revenue without degrading the organic experience we've built in Phases 1-3?

---

## Prerequisites

This phase **cannot launch** without:
- Phase 1-3 data — CTR/CVR economics per placement, per merchant type
- [prd.md](./../4.6%20Impression%20Infrastructure/prd.md) — impression tracking, delivery pacing, attribution separation

**Pricing principle (from CTO):**
> Show Merchant A in deals page = 0.5 cents expected revenue. Show Merchant B = 0.2 cents expected revenue. Only if Merchant B pays 0.3+ cents do we display their deal instead.

Paid ads must be priced above the **opportunity cost** of displacing an organic merchant.

---

## What we need to answer first

| Question | Why it matters |
| --- | --- |
| What is the expected revenue per impression per placement? | Sets the pricing floor — paid ads must exceed this |
| How much organic inventory can we allocate to paid without degrading CVR? | Defines supply — too much paid inventory hurts user experience |
| Are merchants willing to pay at or above the opportunity cost? | Validates demand — if merchants won't pay the floor, model doesn't work |
| Does "Sponsored" labeling reduce CTR vs organic placements? | Determines the discount factor for paid inventory |

---

## What we need to build (if prerequisites met)

| Capability | Why |
| --- | --- |
| CPI campaigns | Merchant pays per impression — guaranteed visibility |
| CPC campaigns | Merchant pays per click — performance-based |
| Pricing calculator | Recommended CPI/CPC per placement based on Phase 1-3 economics |
| Delivery pacing | Daily impression/click caps to prevent over-delivery |
| Organic/paid separation | Paid placements occupy designated slots; organic ranking unaffected |
| "Sponsored" labeling | Users clearly know when a placement is paid |
| Post-campaign reporting | Impressions, clicks, conversions, ROI for merchant |
| Quality thresholds | Low-quality merchants can't buy visibility (min CTR/CVR required) |

---

## Pricing model

**CPI (Cost Per Impression):**
- Merchant pays for guaranteed impressions
- Priced above opportunity cost of organic merchant in that slot
- Daily pacing to spread impressions evenly

**CPC (Cost Per Click):**
- Merchant pays for clicks only
- Campaign pauses when click cap reached
- Better for merchants wanting performance accountability

**Pricing inputs (from Phases 1-3):**
- Expected organic revenue per impression per placement
- Opportunity cost of displacing organic merchant
- Merchant willingness to pay (pilot data)

---

## Success metrics

**Primary:**
- Revenue from paid placement ($X/month)
- Fill rate (% of paid inventory sold) — target: 60%+
- Merchant ROI positive (merchants renew campaigns)

**Guardrails:**
- Organic CTR/CVR not regressed (A/B test: users with paid ads vs without)
- Paid slots limited to 20-30% of placement inventory
- Quality thresholds enforced (no low-quality merchants buying visibility)
- Clear organic/paid attribution separation

---

## Who this serves

- **Merchants** — purchase guaranteed exposure to supplement organic ranking
- **BD** — sell performance packages (visibility + incentive + paid placement)
- **Finance** — new revenue stream
- **End users** — see relevant paid placements, clearly labeled

---

## What we're NOT doing

- Self-serve merchant ad platform (BD-managed only)
- User-segment targeting for paid ads (target placements, not users)
- Dynamic pricing (static CPI/CPC rates; explore dynamic later)
- Real-time bidding / auction model

---

## Exit criteria

Phase 4 is complete when:
- We have a validated CPI/CPC pricing model based on real economics
- Paid placement generates measurable revenue without organic CVR regression
- Merchants see positive ROI and renew campaigns
- Organic and paid attribution are cleanly separated

---

## Dependencies

- **Impression Infrastructure (4.6)** — impression tracking, placement definitions, delivery pacing, attribution separation. **Hard blocker.**
- **Phase 1-3 in production** — CTR/CVR economics needed for pricing
- **Legal** — terms & conditions for paid placement
