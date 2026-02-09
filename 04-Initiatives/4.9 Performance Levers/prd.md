# Performance Levers

## Business Context

**The opportunity:** Merchant revenue is constrained by our inability to systematically diagnose and improve performance. When merchants ask "why is my performance bad?", we have no data-backed answer and no levers to address it at scale.

**Root cause:** We lack instrumentation to measure which factor drives conversion:
> **Exposure × Relevancy × Monetary Incentive = Conversion**

Without measurement, we can't diagnose problems, test interventions systematically, or optimise at scale.

**This initiative builds measurement + intervention capability** to transform merchant performance from reactive guesswork to systematic optimisation - unlocking operational improvement (Phase 0-3) and commercial CPM monetisation (Phase 4).

**Foundation dependency:**
- Levers Phase 0 - 3 require [Impression Infrastructure Phase 1] for placement measurement
- Levers Phase 4 requires [Impression Infrastructure Phase 2 & 3] for commercial delivery

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
    ├── EXPOSURE: enough impressions? right placements? right rank?
    ├── RELEVANCY: right merchant to right user? intent-aware?
    └── INCENTIVE: compelling miles rate? urgency to act?
```

### Today: Flying blind

**What we have:**
- Simple ranking = popularity sort + manual BD override (global, not placement-specific)
- Manual campaign management via Appsmith (no auto-expiry, requires cleanup)
- No merchant performance diagnostics

**What's missing (the instrumentation gap):**
- ❌ No impression distribution visibility → can't diagnose exposure problems
- ❌ No placement-specific metrics → can't correlate placement → conversion
- ❌ No baseline CTR/CVR per placement → can't measure improvement
- ❌ No personalisation or intent-based targeting → can't test relevancy
- ❌ No targeted incentive mechanisms → can't test monetary motivation

**Symptoms in the field:**
- Merchants: "Why is my performance bad?" → BD has no data-backed answer
- BD: Manual ranking overrides with no success metrics or auto-expiry
- Product: Can't validate if exposure, relevancy, or incentive is the bottleneck

### What we're learning (Phase 0 in progress)

**Instrumentation being built:**
- [prd.md](./../4.6%20Impression%20Infrastructure/prd.md) — tracking impressions, CTR, CVR per merchant per placement
- [phase-1-experiment.md](./phase-1-experiment.md) — testing H1/H2: does rank position causally affect CTR?

**Data we'll have soon (Phase 0 baselines):**
- Merchant CTR by placement: [TBD]
- Impression distribution: high-performers vs under-performers on same placements [TBD]
- Rank position vs CTR correlation: [TBD]

*Note: These baselines will inform which levers to prioritize in Phase 1-3.*

---

## 3. Hypotheses to Test

Each phase tests one lever in the conversion equation: **Exposure × Relevancy × Incentive = Conversion**
| Hypothesis | Test | Success = | Phase |
| --- | --- | --- | --- |
| **H1: Exposure is the bottleneck** | Impression distribution analysis | Underperformers have significantly fewer impressions than top performers | 0 |
| **H2: Rank position drives CTR** | A/B test: boost underperformers to top 3 | >5% CTR uplift | 0 - 1 |
| **H3: Relevancy > raw exposure** | Personalized vs popularity ranking | >30% CTR + >15% CVR uplift | 2 |
| **H4: Incentives drive incremental CVR** | Miles booster campaigns vs control | >15% CVR uplift with positive ROI | 3 |
**Testing approach:**
- Phase 0 validates H1/H2 before building exposure levers (Phase 1). 
- Phases 2-3 test relevancy and incentive to measure relative contribution. 
- Results determine optimal lever weightage and production rollout.

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


### Critical questions that lead to our hypotheses

These questions frame what we need to learn to build the right levers:

| # | Question | Why it matters | How we'll answer |
| --- | --- | --- | --- |
| **Q1** | Do underperforming merchants lack exposure, or is exposure wasted? | Determines if we need **distribution** or **relevancy** fixes | Impression vs CTR distribution; compare top vs bottom merchants on same placements |
| **Q2** | Does rank position causally affect CTR? By how much? | Validates if **placement-specific ranking** is worth building | A/B test: boost under-performers to top 3, measure CTR delta |
| **Q3** | What is the CTR ceiling per placement? | Sets **realistic improvement targets** per lever | CTR distribution: top decile vs median vs bottom decile |
| **Q4** | Does personalization beat static ranking? | Tests if **relevancy > raw exposure** | Cohort test: personalized vs popularity sort, measure CTR + CVR |
| **Q5** | High CTR + low CVR = incentive problem or UX? | Distinguishes **monetary motivation** from **experience issues** | CVR comparison across merchants with similar CTR; drop-off analysis |
| **Q6** | Do miles boosters drive incremental CVR? At what cost? | Validates **incentive lever ROI** before scaling | Boosted campaigns vs control, measure CVR uplift and cost per conversion |

**From questions to hypotheses:**
These questions translate directly into testable hypotheses (Section 3) that each phase validates before building production levers.