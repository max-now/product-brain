# Card-Linked CRM & Offers Platform

## Vision

Position HeyMax as the **"card-rail native CRM and offer engine"** for offline merchants — combining a performance-based acquisition model with retention intelligence, powered by Visa Offers Platform (VOP) data.

**One-liner:** The customer's card is their CRM ID. No QR, no app, no enrolment friction.

---

**If we allow users to opt in to sharing anonymised purchase history data,**
**then we can build targeting cohorts (e.g., "spends $300+/mo on Japanese dining") that offline merchants will pay to access via funded MPD offers**

---

### Competitive Moats to Build

**Full analysis:** See [cohort-insights-final.md](./cohort-insights-final.md) and [user-location-daypart-segments.md](./user-location-daypart-segments.md)
1. **Card-rail native attribution:** VOP proves conversions definitively. No receipt scanning, no check-ins.
2. **Cross-merchant benchmarking:** "Your customers spend $180/mo on dining. Area average is $260." Single-merchant CRMs can't do this.
3. **Meta-loyalty stacking:** Users earn bank points + Max Miles + merchant-funded offers in one transaction. Hard to replicate.
4. **Instant activation:** Merchant goes live in one call — no POS integration, no hardware, no consumer app.

---

## Hypothesis

**If** we offer F&B merchants card-linked offers with proven attribution and cohort intelligence,

**Then** they will fund performance-based rewards (CPA model),

**Because** they value high-intent, high-spend customer acquisition more than broad untargeted advertising — and they can't get this attribution anywhere else.

### Key Assumptions to Validate

| # | Assumption | Risk | Validation |
| --- | --- | --- | --- |
| 1 | Users will engage with offline offers | Low | Poll: 82% persuadable |
| 2 | Merchants will fund offers based on cohort data | **High** | Experiment 1 |
| 3 | Offers drive measurable behaviour change | **High** | Experiment 2 |
| 4 | Personalised offers outperform flat offers | Medium | Experiment 3 |
| 5 | Partial wallet data (Visa only) is sufficient | Medium | Merchant feedback |

---

## Target Market

### Primary: F&B Merchants (Singapore)

**Why \****F&B first**\*\*:**
- High visit frequency = fast feedback loops
- Rewards-sensitive customers (Eatigo, OpenRice, credit card promos)
- Thin margins → need proven ROI, not brand awareness
- Fast decision-makers (owner-operators)

**Segment priority:**

| Priority | Segment | Why |
| --- | --- | --- |
| 1 | Independent restaurants | Fast decisions, reward-sensitive |
| 2 | Small chains (3-10 outlets) | Scalable, but still agile |
| 3 | F&B in malls/office clusters | High foot traffic, competitive |

### Secondary (Future): Personal Services

Gyms, salons, clinics — high LTV, membership-based, underserved by digital marketing.

---

## Value Proposition

### For Merchants

**Core pitch:**
> "We have X cardholders within 1km who spend $Y/month on dining but have never visited you. We'll put your offer in front of them. You fund the reward, you only pay when they transact."

**Why this works:**
- **Specificity:** Not "food lovers" but "$300+/mo Japanese diners within 1km"
- **Performance-aligned:** Pay when they transact, not for impressions
- **Zero effort:** No app, no POS integration, no loyalty setup
- **Proven attribution:** VOP closes the loop definitively

### For Users

**Core value:**
- Earn MPD at offline merchants (new earning pathway)
- Stacks with existing card rewards (meta-loyalty)
- No extra steps — pay with linked card, earn automatically

---

## What We're Building

### Phase 0: Prove Demand (Weeks 1-3)

**Goal:** Validate merchants will fund offers.

**Approach:**
- BD pitches 10 F&B merchants using existing cohort data
- PDF reports showing cohort size, location, spend patterns
- Ask for LOIs or verbal commitments

**Success:** 3+ merchant commitments

**Detailed plan:** See [experiment-plan.md](./experiment-plan.md)

### Phase 1: Prove Behaviour Change (Weeks 4-9)

**Goal:** Validate offers drive incremental transactions.

**Approach:**
- Launch card-linked offers with committed merchants
- Control vs exposed group measurement
- Test lunch vs dinner daypart targeting

**Success:** >5% redemption, >10% incremental lift

### Phase 2: Scale & Personalise (Months 3-6)

**Goal:** Expand coverage and add intelligence.

**Approach:**
- 15-20 merchants per priority area
- Add geo-proximity targeting
- Test personalised reward tiers (new vs lapsed vs loyal)

### Future: Merchant Self-Serve

- Portal for setting offers, viewing performance
- Subscription + CPA pricing model
- Full CRM capabilities (retention alerts, churn prediction)

---

## Data We Have (Validated)

From BigQuery analysis of last 90 days:

| Segment | Users | Locations | Avg Spend |
| --- | --- | --- | --- |
| Lunch diners (10am-2pm) | 9,377 | 134 | $26.82 |
| Dinner diners (5pm-10pm) | 7,588 | 140 | $36.35 |

**Top locations:**

| Area | Users | Monthly Revenue |
| --- | --- | --- |
| CBD/Tanjong Pagar | 4,214 | $885K |
| Woodlands | 3,581 | $74K |
| Tampines | 2,385 | $106K |

**Key insight:** Dinner transactions are 35% higher value than lunch. Both dayparts matter.


---

## Pricing Model

### V1: Performance-Only (CPA)

- Merchant funds reward amount
- Heymax takes % fee on confirmed transactions
- Merchant pays only when user transacts

**Why start here:** Lowest risk for merchants, proves ROI first.

### V2: Performance + Platform Fee

- Small monthly platform fee
- Lower CPA rate
- Access to basic dashboards and insights

### V3: Subscription + Performance

- Monthly subscription for CRM features
- Retention alerts, churn prediction, VIP segmentation
- Lower CPA for high-volume merchants

---

## What Merchants Get (Phased)

### V1: Campaign Reports (PDF)

- Impressions served
- Deals claimed
- Confirmed conversions (VOP)
- Cohort profile
- Effective CPA

**Delivery:** BD sends monthly or post-campaign

### V2: Simple Dashboard

- Real-time: Active campaigns, redemptions
- Monthly: Retention alerts, churn flags
- Segmentation views


### V3: Full Self-Serve

- Create/edit campaigns
- Set budgets and rules
- Manage exclusive rewards tiers

---

## Risks & Mitigations

| Risk | Mitigation |
| --- | --- |
| Cohort sizes too small | Start with highest-density areas |
| Low redemption rates | Test reward levels, daypart targeting |
| Partial wallet (Visa only) | Frame as "best-available" + show incrementality |
| Merchants want instant CRM | Position offers as entry point, upsell CRM later |
| Attribution disputes | VOP provides definitive proof |

---

## Success Metrics

### Experiment Phase

| Metric | Target |
| --- | --- |
| Merchant commitments | 3+ |
| Offer redemption rate | >5% |
| Incremental lift vs control | >10% |
| Merchant satisfaction | >60% want to continue |

### Scale Phase

| Metric | Target |
| --- | --- |
| Active merchants | 15-20 per area |
| Monthly redemptions | 1,000+ per area |
| Merchant retention | >70% renew |
| Revenue | TBD based on experiment results |

---

## Team Alignment

### What This Initiative IS

- A new B2B revenue channel leveraging VOP data
- Performance-based merchant acquisition (CPA model)
- A stepping stone to full merchant CRM
- Validation before building product

### What This Initiative IS NOT

- A dashboard-first product (prove value before building UI)
- A replacement for online merchant partnerships
- An enterprise sales motion (start small, stay nimble)
- Building full geo-proximity before proving offers work

### Key Decisions Made

1. **Prove demand before building product** — BD outreach with PDF reports first
2. **Start with F&B** — fastest feedback loops, reward-sensitive customers
3. **CPA pricing first** — lowest merchant risk, proves ROI
4. **No geo-targeting in v1** — test offer value before adding complexity

---

## Related Documents

- [experiment-plan.md](./experiment-plan.md) — Detailed test design and success criteria
- [cohort-insights-final.md](./cohort-insights-final.md) — Full data analysis and merchant pitch frameworks
- [user-location-daypart-segments.md](./user-location-daypart-segments.md) — Location × daypart breakdown

---

*Last updated: 2026-02-06*
