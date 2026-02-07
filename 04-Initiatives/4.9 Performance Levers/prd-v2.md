# Performance Levers

## Strategic Context

This initiative builds **systematic capability to improve merchant performance** through operational and commercial levers.

**Foundation dependency:**
- Phase 0-3 require [Impression Infrastructure Phase 1] for placement measurement
- Phase 4 requires [Impression Infrastructure Phase 2 & 3] for commercial delivery

```
┌─────────────────────────────────────┐
│ 4.6 Phase 1: Observability          │
│ - Placement definitions              │
│ - Exposure tracking                  │
│ - Baseline metrics                   │
└─────────────────────────────────────┘
           │ ENABLES ↓
┌─────────────────────────────────────┐
│ 4.9 Phase 0-3: Operational Levers   │
│ - Ranking controls                   │
│ - Personalization                    │
│ - Incentives                         │
└─────────────────────────────────────┘
           │ Requires ↓
┌─────────────────────────────────────┐
│ 4.6 Phase 2-3: Commercial Ready     │
│ - Packages + delivery pacing         │
│ - Reporting infrastructure           │
└─────────────────────────────────────┘
           │ ENABLES ↓
┌─────────────────────────────────────┐
│ 4.9 Phase 4: CPI/CPC Paid Ads       │
└─────────────────────────────────────┘
```

---

## 1. Business Context

Revenue growth = earning from consumers + earning from merchants.

Consumer earning grows via:
- **More spend** on existing channels (this initiative)
- **More channels** to earn on (not in scope)

Core assumption:

> **Exposure × Relevancy × Monetary Incentive = Conversion**

We lack systematic understanding of which lever is underperforming, by how much, or what the ceiling is.

### Levers to test across phases
| Lever Category | Specific Levers | Impact Area | Phase | Notes |
| --- | --- | --- | --- | --- |
| **Exposure & Placement** | Placement-specific ranking control | CTR | 1 | Tests H1, H2 |
|  | Time-bound visibility campaigns | CTR | 1 | Auto-expiring, no manual cleanup |
| **Personalisation** | User-based merchant recommendations | CTR + CVR | 2 | Based on transaction history |
| **Intent-Based Exposure** | Merchants shown based on session intent | CTR | 2 | Search vs browse vs deals vs redeem |
| **Incentive** | Miles booster campaigns | CVR | 3 | Tests H4; ROI uncertain |
| **Paid Ads** | CPM/CPC impression packages | Revenue | 4 | Depends on Impression Infrastructure |
**Not in scope:**
- User reviews / social proof (not built in-app)
- How-to-earn guides per merchant (cross-team dependency)

---

## 2. Problem Decomposition

```
Revenue Growth
├── More users (acquisition) — not in scope
├── More earning channels (supply) — not in scope
└── Higher conversion on existing channels ← THIS INITIATIVE
    ├── Exposure: enough impressions? right placements? right rank?
    ├── Relevancy: right merchant to right user? intent-aware?
    └── Incentive: compelling miles rate? urgency to act?
```

### Current state
- Ranking = popularity sort + manual BD override (global, not per-placement)
- No impression distribution visibility
- No personalisation or intent-based targeting
- No targeted incentive mechanisms

### What we know so far
- Merchants approach BD asking "why is my performance bad?" — no systematic response
- Manual ranking overrides via Appsmith — no time-bound campaigns, no auto-expiry
- Placement-specific data is missing — cannot correlate placement → conversion
- No baseline CTR/CVR metrics per placement to establish improvement ceiling
- [Phase 0 in progress] Impression tracking infrastructure being built ([prd.md](./../4.6%20Impression%20Infrastructure/prd.md))
- [Phase 0 in progress] Ranking experiment testing H1/H2 ([phase-1-experiment.md](./phase-1-experiment.md))

**Concrete examples (to be populated with Phase 0 data):**
- Merchant CTR by placement: [TBD from Phase 0 baseline]
- High-performing vs underperforming merchant impression distribution: [TBD from Phase 0 baseline]

*Note: These data points will populate as Phase 0 measurement infrastructure comes online.*

### Key unknowns (to test)
| # | Question | Validation approach |
| --- | --- | --- |
| 1 | Do underperforming merchants lack exposure, or is exposure wasted? | Impression vs CTR distribution; compare top vs bottom merchants on same placements |
| 2 | Does rank boosting improve CTR? By how much? | A/B test: boost under performing merchants to top 3, measure CTR delta |
| 3 | What is CTR ceiling per placement? | CTR distribution: top decile vs median vs bottom decile |
| 4 | Is affiliation the right channel for all merchants? | CTR/CVR by merchant category on same placements |
| 5 | High CTR + low CVR — incentive problem or UX? | CVR comparison across merchants with similar CTR; drop-off analysis |
| 6 | Does personalisation beat static ranking? | Cohort test: personalised vs popularity sort, measure CTR + CVR |

---

## 3. Hypotheses
| # | Hypothesis | Evidence needed | Invalidated if |
| --- | --- | --- | --- |
| H1 | Exposure is a bottleneck for under performing merchants | Impression analysis: underperformers have significantly fewer impressions than top performers in same category | Comparable impressions but lower CTR → problem is relevancy, not exposure |
| H2 | Placement-specific ranking improves CTR | A/B test: placement-context ranking vs global popularity | <5% CTR uplift |
| H3 | Relevancy > raw exposure | Personalised ranking outperforms popularity sort on CTR + CVR | Popularity sort performs comparably |
| H4 | Miles boosters drive incremental CVR | CVR uplift in boosted campaigns vs control, positive ROI | Uplift doesn't justify cost, or cannibalisation |

---

## 4. Why This Matters / Projected Success Criteria

**Current Opportunity sizing:**
- Average monthly shop revenue (p180d): 17M MM
- Average monthly merchant page views (p90d): 690k
- Average monthly merchant page SWM clicks CTR (p90d): 14.5% (100k)
- Average monthly merchant page -> SWM user CTR (p90d): 53%
- Average monthly merchant page -> SWM user CVR (p90d): 40%

**Levers Impact model (conservative estimate):**
- H1/H2 (Exposure): >15% CTR uplift
- H3 (Relevancy): >30% CTR + >15% CVR uplift
- H4 (Incentive): >15% CVR uplift

**Competitive context:**
- Our advantage: Integrated platform with card spend data

If combined levers impact is lower, this signals either:
- Wrong levers (real bottleneck is elsewhere: UX, merchant quality, platform value prop)
- Levers don't combine multiplicatively (interactions between levers neutralize effects)

**Re-evaluation trigger:** If Phase 1-2 combined show <10% uplift for either CTR and CVR, pause Phase 3 and investigate root cause.
---

## 5. Phased Approach

Each phase tests a hypothesis about lever magnitude. Infrastructure for all levers (exposure, relevancy, incentive) must exist to measure their relative contribution to conversion. Experiments determine optimal weightage and production rollout timing.

| Phase | Lever | Hypothesis | What we build | What we learn | Dependency |
| --- | --- | --- | --- | --- | --- |
| **0** | Measurement + Validation | — | Impression tracking infra + ranking experiment | Baseline data; does rank position causally affect CTR? | [prd.md](./../4.6%20Impression%20Infrastructure/prd.md) |
| **1** | Exposure | H1, H2 | Placement-specific ranking, time-bound campaigns | Does better exposure improve CTR? By how much? | 4.6 Phase 1 ✓ |
| **2** | Relevancy | H3 | Personalised ranking, intent-based exposure | Does relevancy outperform raw exposure? | 4.6 Phase 1 ✓ |
| **3** | Incentive | H4 | Miles booster campaigns | Does incentive drive incremental CVR? At what ROI? | 4.6 Phase 1 ✓ |
| **4** | Monetisation | — | CPI/CPC paid visibility | Can we monetise validated levers? | [prd.md](./../4.6%20Impression%20Infrastructure/prd.md) |

### Phase 0 — Instrumentation & Measurement Foundation
> **Delivered by:** [Impression Infrastructure Phase 1] 

**Status:** In Progress

Two workstreams already underway:
- **Impression tracking infrastructure** ([prd.md](./../4.6%20Impression%20Infrastructure/prd.md))
  - Instrumentation layer to measure impressions, CTR, CVR per merchant per placement
  - [Impression Infrastructure Phase 1] Required for Phase 1-3 operational levers 
  - [Impression Infrastructure Phase 2 & 3] Required for Phase 4 commercialisation
- **Ranking position experiment** ([phase-1-experiment.md](./phase-1-experiment.md))
  - Tests H1/H2 by measuring if rank position causally affects CTR
  - Results determine whether Phase 1 is worth building

**What this enables:**
- ✅ Placement definitions (where merchants appear)
- ✅ Exposure tracking (when merchants are seen)
- ✅ Baseline metrics (CTR, CVR by placement)
- ✅ Attribution of which placements drive conversions
- ✅ Data foundation for ranking decisions

**Exit criteria:** Baseline impression/CTR/CVR data per placement + statsig results on whether rank boosting improves CTR

**Blocks:** Phase 1 launch

**Note on phasing:** While experiments validate magnitude and ROI before production rollout, Phase 2-3 infrastructure (personalisation, incentives) should be built in parallel. We need all three levers instrumented to measure relative contribution to the conversion equation: `Exposure × Relevancy × Incentive = Conversion`. Experiments determine optimal weightage, not whether to build.

---

## 6. Stakeholders

- **Merchants / Partners** — data-backed performance explanation + actionable levers
- **BD team** — systematic response to "how do I improve performance?"
- **Ops team** — SOPs for ranking changes; auto-expiring campaigns
- **Product & Data** — data to answer: exposure, relevancy, or incentive problem?
- **Engineering** — clear problem definition and validation criteria before building

---

## 7. Guardrails

- No regression in overall platform CVR
- Evidence required before progressing phases
- All interventions measurable and attributable
- Organic vs paid ranking separated (Phase 4)
