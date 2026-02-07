# Offline VOP: Experiment Plan

## Objective

Validate the "card-linked offers and merchant intelligence" model for F&B merchants before building full product. Prove offers drive behaviour change, merchants will pay for targeted acquisition, and personalisation improves efficiency.

---

## Positioning

**What we're building:** "Card-linked offers and merchant intelligence for offline merchants"

**Core insight:** The customer's card IS their CRM ID. No QR signups, no loyalty app downloads, no enrolment friction.

**Differentiation vs competitors:**

| Us (Heymax VOP) | Upside | Oddle CRM |
| --- | --- | --- |
| Card-rail attribution (VOP) | Receipt/check-in based | QR/NFC enrolment |
| No consumer friction | App + offer activation | Merchant-branded flows |
| Cross-merchant intelligence | Single merchant view | Single merchant view |
| Performance pricing (CPA) | Performance pricing | SaaS subscription |

---

## Experiment 0: Prove User Behaviour Change

**Duration:** 3-4 weeks

**Hypothesis:** Card-linked offers will drive measurable incremental visits to participating merchants.

**Why first:** Before pitching merchants, we need proof that offers actually change user behavior. HeyMax self-funds this test.

### Setup (Minimal Engineering)

1. **Select test restaurants:**
  - 2-3 restaurants in CBD/Central Singapore (highest user density from cohort data)
  - Mix of cuisine types (Japanese, Western, Local)

2. **Offer structure (FLAT RATE - keep it simple):**
  - 6 MPD for all users
  - No segmentation (new vs repeat) yet
  - HeyMax funds the MPD rewards (not merchant-funded)

3. **Targeting:**
  - Static cohort: Users who dine frequently in CBD area
  - No real-time geo-proximity yet

4. **Measurement:**
  - **Control group:** Similar users who don't see offer
  - **Exposed group:** Users who see offer
  - Track: Redemption rate, visit rate, transaction value, repeat visits within 30 days

### Success Criteria

| Metric | Target | What It Proves |
| --- | --- | --- |
| Offer redemption rate | >5% | Users engage with offers |
| Incremental lift vs control | >10% | Offers drive new visits |
| Repeat visit rate (30 days) | >20% | Users return after first redemption |

### What We Learn

- **If yes:** Proceed to Experiment 1 with proven data
- **If no:** Iterate on offer amount, targeting, or merchant selection

---

## Experiment 1: Prove Merchants Will Fund Offers

**Duration:** 2-3 weeks

**Hypothesis:** F&B merchants will commit to fund performance-based offers when shown specific cohort data and proven redemption rates from Experiment 0.

### Setup (Zero Engineering)

1. **Use Experiment 0 results + cohort data:**
  - Proven redemption rates and incremental lift from self-funded test
  - Cohort data from BigQuery: 24,156 active diners, $10.1M monthly spend
  - Top locations: CBD (2,134 users), Orchard (624 users), Marina Bay (588 users)

2. **Create merchant pitch deck (PDF):**
  - "We have X cardholders within 1km who spend $Y/month on dining but have never visited you"
  - Show Experiment 0 results: redemption rate, lift, repeat visit rate
  - **Flat rate offer:** 6 MPD (same as Experiment 0)
  - Performance-based pricing: "You only pay when they transact"

3. **BD outreach to 10 F&B merchants:**
  - Target: Independent/small chains in CBD, Orchard, or Marina Bay
  - Pitch: PDF report + verbal walkthrough
  - Ask: LOI or verbal commitment to fund offers

### Success Criteria

| Metric | Target | What It Proves |
| --- | --- | --- |
| Merchants pitched | 10 | Outreach capacity |
| LOIs / commitments | 3+ | Demand exists |
| Avg offer budget committed | >$500/merchant | Willingness to pay |
| Common objections | Documented | What to solve next |

### What We Learn

- **If yes:** Proceed to Experiment 2 (merchant-funded offers)
- **If no:** Revise value prop, pricing, or targeting

---

## Experiment 2: Prove Merchant-Funded Offers Work

**Duration:** 4-6 weeks

**Hypothesis:** Merchant-funded offers will achieve similar performance to HeyMax-funded offers (Experiment 0).

### Setup (Same as Experiment 0)

1. **Onboard 3-5 committed merchants** from Experiment 1

2. **Offer mechanics:**
  - User sees offer in Heymax app (no geo-targeting yet)
  - User pays with linked Visa card at merchant
  - VOP confirms transaction → user gets reward
  - **Flat rate offer:** 6 MPD (same as Experiment 0)
  - **Merchant funded** (this is the key difference)

3. **Targeting (v0):**
  - Static cohort: Users who dine frequently in merchant's area
  - No real-time geo-proximity (build later if this works)

4. **Measurement:**
  - Control group: Similar users who don't see offer
  - Exposed group: Users who see offer
  - Compare: Redemption rate, visit rate, incremental lift

### Success Criteria

| Metric | Target | What It Proves |
| --- | --- | --- |
| Offer redemption rate | >5% | Performance holds with merchant funding |
| Incremental lift vs control | >10% | Offers still drive behaviour change |
| Merchant satisfaction | >60% want to continue | Sustainable economics |
| Avg transaction at merchant | ≥ segment avg | Quality conversions |

### What We Learn

- **If yes:** Proceed to Experiment 3 (test Personalisation)
- **If no:** Merchants unhappy with ROI → iterate pricing or targeting

---

## Experiment 3: Prove Personalisation Works

**Duration:** 4-5 weeks

**Hypothesis:** Tiered rewards based on customer type (new/repeat/lapsed/churned) will be more cost-efficient than flat rewards.

### Setup

1. **Use existing merchants from Experiment 2**

1. Segment users by behaviour:
  - **New to merchant:** Never transacted at this merchant
  - **Repeat visitor:** 1+ transactions in last 90 days
  - **Lapsed:** Last transaction 90-180 days ago
  - **Churned:** Last transaction 180+ days ago

2. **A/B test:**
  - **Control:** Flat 6 MPD for everyone
  - **Test:** Tiered rewards by segment:
    - New: 10 MPD (acquisition)
    - Repeat: 4 MPD (retention)
    - Lapsed: 8 MPD (win-back)
    - Churned: 10 MPD (re-acquisition)

3. **Measurement:**
  - Compare total MPD spend (control vs test)
  - Compare redemption rates by segment
  - Calculate acquisition cost per new customer

### Success Criteria

| Metric | Target | What It Proves |
| --- | --- | --- |
| New customer acquisition cost | 20% lower than flat | Tiered is more efficient |
| Total MPD spend | Same or lower vs flat | Better economics for merchants |
| Redemption rates maintained | Within 10% of flat | Users still engage with lower rewards |
| Merchant satisfaction | >60% prefer tiered | Merchants see value in Personalisation |

---

## What Data Merchants Actually Want

Based on competitive research, merchants care about **actionable** data, not dashboards.

### Tier 1: Must-Have for V1

| Insight | Example | Why They Care |
| --- | --- | --- |
| High-spend non-customers nearby | "247 users within 1km spend $300+/mo on dining but haven't visited you" | Acquisition |
| Lapsed customers | "38 users used to visit but haven't in 90 days" | Win-back |
| Campaign performance | "X claimed, Y transacted, Z revenue, $A cost" | ROI proof |

### Tier 2: Nice-to-Have for V2

| Insight | Example | Why They Care |
| --- | --- | --- |
| Category benchmarks | "Your customers spend $180/mo on dining. Area avg is $260" | Upsell opportunity |
| Daypart performance | "Your lunch share is low vs dinner" | Promotional timing |
| Cross-merchant affinity | "Your Japanese diners also spend $150+/mo on fitness" | Partnership opportunities |

### Delivery Format (Phased)

| Phase | Format | Effort |
| --- | --- | --- |
| V1 | PDF report via BD | Zero eng |
| V2 | Simple dashboard (read-only) | Medium |
| V3 | Self-serve + campaign management | High |

**Rule:** Only build V2 when >50% of merchants ask for it.

---

## Scaling Path (After Experiments Succeed)

### If Experiments 1-3 Pass:

**Phase 1: Expand Coverage (Months 2-3)**
- Scale to 15-20 merchants per priority area
- Add 2-3 new geographic clusters
- Automate reporting (basic dashboard)

**Phase 2: Add Geo-Proximity (Months 3-4)**
- Real-time location-based offer triggering
- "Within 500m" targeting
- Push notifications near merchant

**Phase 3: Merchant Self-Serve (Months 4-6)**
- Portal: Set offer rules, view performance
- Pricing tiers:
  - Starter (Performance-only): CPA on incremental transactions
  - Growth (Performance + Insights): Dashboards + segmentation
  - Pro (SaaS + Performance): APIs for larger chains

### Pricing Model Evolution

| Phase | Model | Rationale |
| --- | --- | --- |
| Experiment | Free / sponsored | Prove value |
| V1 | CPA only (% of transaction) | Low risk for merchants |
| V2 | CPA + small platform fee | Capture more value |
| V3 | Subscription + CPA | Recurring revenue |

---

## Key Risks & Mitigations

| Risk | Mitigation |
| --- | --- |
| Merchant cohort sizes too small | Start with highest-density areas (CBD, Tampines) |
| Low offer redemption | Test different reward levels, daypart targeting |
| Attribution disputes | VOP provides definitive transaction proof |
| Partial wallet visibility (Visa only) | Frame as "best-available personalisation on known spend" |
| Merchants want full CRM, not just offers | Position offers as entry point, upsell to CRM later |

---

## Decision Points

### After Experiment 0:
- **Go:** >5% redemption + >10% lift → Proceed to Experiment 1
- **Iterate:** Low redemption → Test different MPD amount or merchant selection
- **Kill:** Offers don't move behavior → Abandon initiative

### After Experiment 1:
- **Go:** 3+ merchant commitments → Proceed to Experiment 2
- **Pivot:** <3 commitments → Revise value prop, try different segments
- **Kill:** Zero interest → Abandon offline merchant model

### After Experiment 2:
- **Go:** >5% redemption + >10% lift + >60% merchant satisfaction → Proceed to Experiment 3
- **Iterate:** Low merchant satisfaction → Adjust pricing or targeting
- **Kill:** Performance drops significantly vs Experiment 0 → Revisit model

### After Experiment 3:
- **Go:** Personalisation is 20%+ more efficient → Build tiered rewards into platform
- **Stay simple:** No significant difference → Keep flat 6 MPD offers (simpler for merchants)
- **Scale either way:** Both models work, choose based on merchant preference

---

## Optional: Experiment 4 — Daypart Targeting (Demand Shifting)

**When to run:** Only if merchants specifically request it during Experiments 1-3. This is a response to merchant feedback, not a core hypothesis to validate.

**Duration:** 3-4 weeks

**Hypothesis:** Merchants will use higher MPD rates during off-peak hours to shift demand away from peak times.

### The Merchant Problem

Restaurants have capacity constraints:
- **Peak hours (12-1pm lunch, 7-8pm dinner):** Overbooked, turn away customers
- **Off-peak hours (2-5pm, 9-10pm):** Empty tables, under-utilised capacity

**Merchant ask:** "Can I offer 10 MPD from 2-5pm to fill empty tables, but only 4 MPD during peak lunch rush?"

### Setup

1. **Select 2-3 merchants with clear peak/off-peak patterns**
  - Preferably sit-down restaurants (not fast casual)
  - Must have POS data showing peak vs off-peak volume

2. **Offer structure:**
  - **Off-peak hours:** 10 MPD (e.g., 2-5pm, 9-10pm)
  - **Peak hours:** 4 MPD (e.g., 12-1pm, 7-8pm)
  - **Standard hours:** 6 MPD (e.g., 5-7pm)

3. **Measurement:**
  - Compare redemption distribution vs baseline (Experiment 2 flat rate)
  - Track: % of redemptions during off-peak vs peak
  - Merchant feedback: "Did this help fill empty tables?"

### Success Criteria

| Metric | Target | What It Proves |
| --- | --- | --- |
| Off-peak redemption shift | >15% increase vs baseline | Users respond to higher MPD in off-peak |
| Peak hour redemptions | Decrease or stay flat | Not cannibalising peak demand |
| Merchant satisfaction | >70% find it valuable | Worth the added complexity |
| Total redemptions | Maintained or increased | Doesn't reduce overall engagement |

### What We Learn

- **If yes:** Build daypart targeting into platform (merchants control MPD by time window)
- **If no:** Keep simple flat rates or Personalisation only (don't add time-based complexity)

**Key insight:** This is a **merchant-driven feature**, not a core product assumption. Only build if merchants ask for it.

---

## Decision Points

### After Experiment 0:
- **Go:** >5% redemption + >10% lift → Proceed to Experiment 1
- **Iterate:** Low redemption → Test different MPD amount or merchant selection
- **Kill:** Offers don't move behavior → Abandon initiative

### After Experiment 1:
- **Go:** 3+ merchant commitments → Proceed to Experiment 2
- **Pivot:** <3 commitments → Revise value prop, try different segments
- **Kill:** Zero interest → Abandon offline merchant model

### After Experiment 2:
- **Go:** >5% redemption + >10% lift + >60% merchant satisfaction → Proceed to Experiment 3
- **Iterate:** Low merchant satisfaction → Adjust pricing or targeting
- **Kill:** Performance drops significantly vs Experiment 0 → Revisit model
- **Optional:** If 2+ merchants ask about off-peak pricing → Run Experiment 4

### After Experiment 3:
- **Go:** Personalisation is 20%+ more efficient → Build tiered rewards into platform
- **Stay simple:** No significant difference → Keep flat 6 MPD offers (simpler for merchants)
- **Scale either way:** Both models work, choose based on merchant preference

### After Experiment 4 (if run):
- **Go:** Merchants find it valuable → Add daypart controls to platform
- **Skip:** Not worth the complexity → Keep time-agnostic offers

---

## Timeline

| Week | Activity | Owner |
| --- | --- | --- |
| 1-4 | Experiment 0: Self-funded user behavior test | PM + Eng |
| 5 | Analyze Exp 0, prepare merchant pitch | PM + BD |
| 5-7 | Experiment 1: Merchant outreach | BD |
| 8 | Onboard committed merchants | PM + BD |
| 8-12 | Experiment 2: Merchant-funded offers | PM + Eng |
| 13-17 | Experiment 3: Personalisation A/B test | PM + Data |
| 18 | Decision point: Scale or pivot | Leadership |
| *18-22* | *(Optional) Experiment 4: Daypart targeting* | *PM + Eng* |
| *23* | *(Optional) Final decision on features to build* | *Leadership* |

---

## Appendix: Data We Have

### User Segments (from BigQuery analysis)

| Daypart | Unique Users | Locations | Avg Spend |
| --- | --- | --- | --- |
| Lunch | 9,377 | 134 | $26.82 |
| Dinner | 7,588 | 140 | $36.35 |

### Top Locations

| Location | Area | Lunch Users | Dinner Users | Combined Revenue |
| --- | --- | --- | --- | --- |
| 1.28,103.84 | CBD | 2,163 | 2,051 | $885K/month |
| 1.45,103.81 | Woodlands | 2,238 | 1,343 | $74K/month |
| 1.40,103.90 | Tampines | 1,300 | 1,085 | $106K/month |

### Key Insight

Dinner transactions are 35% higher value than lunch ($36.35 vs $26.82). Both dayparts matter — combined = 77% of all dining transactions.

---

*Document version: 1.0*
*Last updated: 2026-02-06*
