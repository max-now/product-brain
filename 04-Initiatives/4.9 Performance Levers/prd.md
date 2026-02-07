# Performance Levers
*Merchant Performance & Delivery Capacity*

---

## Strategic Context


**Foundation dependency:**
- Phase 0-3 require [prd.md](./../4.6%20Impression%20Infrastructure/prd.md) for placement measurement
- Phase 4 requires [prd.md](./../4.6%20Impression%20Infrastructure/prd.md) for commercial delivery

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
  2. subsequently via business analytics portal
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

---

## Goals

1. **Measures** conversion capacity per placement/session type
2. **Enables levers** to improve CTR and CVR at scale
3. **Delivers consistently** through operational tooling and clear ownership
4. Creates systematic response to "how do I improve performance?" at scale

---

## Who Is This For

| Stakeholder | What They Get |
| --- | --- |
| **Merchants / Partners** | Actionable levers to improve performance, not just "wait and see" |
| **BD team** | Systematic response to merchant performance inquiries with data-driven actions |
| **Ops team** | Clear SOPs for executing ranking changes; time-bound campaigns that auto-expire |
| **Product & Data teams** | Foundation data to decide: is this a ranking, upfunnel, or personalisation problem? |

---

## Phasing Overview

This initiative builds **systematic capability to improve merchant performance** through operational and commercial levers.
| Phase | Focus | Levers Enabled | Dependency |
| --- | --- | --- | --- |
| **Phase 0** | **Instrumentation** | Placement metrics, baseline CTR/CVR | [prd.md](./../4.6%20Impression%20Infrastructure/prd.md) |
| **Phase 1** | Exposure & Placement | Placement-specific ranking, time-bound campaigns | 4.6 Phase 1 ✓ |
| **Phase 2** | Personalisation + Intent | User-based recommendations + intent-aware exposure | 4.6 Phase 1 ✓ |
| **Phase 3** | Incentive | Miles boosters (targeted approach) | 4.6 Phase 1 ✓ |
| **Phase 4** | Paid Ads | CPI/CPC impression packages | [prd.md](./../4.6%20Impression%20Infrastructure/prd.md) |

**Phase PRDs:**
- [phase-1-prd.md](./phase-1-prd.md)
- [phase-2-prd.md](./phase-2-prd.md)
- [phase-3-prd.md](./phase-3-prd.md)
- [phase-4-prd.md](./phase-4-prd.md)

---

## Phase Summaries

### Phase 0 — Instrumentation & Measurement Foundation
> **Delivered by:** [prd.md](./04-Initiatives/4.6 Impression Infrastructure/prd.md) 

Before we can systematically improve merchant performance, we need:
- ✅ Placement definitions (where merchants appear)
- ✅ Exposure tracking (when merchants are seen)
- ✅ Baseline metrics (CTR, CVR by placement)

**What this enables:** Attribution of which placements drive conversions, data foundation for ranking decisions

**Status:** In Progress (4.6 Phase 1)
**Blocks:** Phase 1 launch

---

## Phase 1 — Exposure & Placement Control
> **Detailed PRD:** [phase-1-prd.md](./phase-1-prd.md)

Enable **systematic merchant performance improvement** through placement control. Ops gets time-bound campaigns with auto-expiry; BD gets a consistent playbook for merchant inquiries.

**Hypothesis to test:** Placement-specific ranking control will improve merchant CTR by 15-25% by surfacing merchants in high-converting placements where they currently have low visibility.

| Lever | Description | Success Metric |
| --- | --- | --- |
| Placement-specific ranking | Control merchant rank per placement (not global) | CTR uplift per placement |
| Time-bound campaigns | Auto-expiring visibility campaigns | 100% campaigns auto-expire |
| Campaign dashboard | View active/scheduled/expired campaigns | Ops efficiency |

## Phase 2 — Personalisation & Intent-Based Exposure
> **Detailed PRD:** [phase-2-prd.md](./phase-2-prd.md)

Enable **user-based merchant recommendations and intent-aware exposure**. Move from "same ranking for everyone" to "relevant ranking per user and session intent."

**Hypothesis to test:** Personalised merchant ranking based on user transaction history and session intent will improve CTR by 20-30% and CVR by 10-15% by showing users merchants they are more likely to engage with.

| Lever | Description | Success Metric |
| --- | --- | --- |
| Personalised recommendations | Merchant suggestions based on user transaction history | CTR + CVR uplift |
| Affinity-based ranking | Adjust ranking based on user-merchant affinity signals | CTR uplift |
| Intent-based exposure | Show different merchants based on session intent (search, browse, redeem) | CTR uplift |

## Phase 3 — Incentive Levers
> **Detailed PRD:** [phase-3-prd.md](./phase-3-prd.md)

Enable **targeted incentive mechanisms** (miles boosters) to improve CVR for specific merchant segments. Stack levers: placement + personalisation + incentive.

**Hypothesis to test:** Miles booster campaigns will increase CVR by 25-40% for targeted merchant segments by creating additional purchase motivation, with ROI positive when merchant contribution margin exceeds booster cost.

| Lever | Description | Success Metric |
| --- | --- | --- |
| Miles booster campaigns | Temporary bonus miles for specific merchants | CVR uplift |
| Discounted miles rate | Sell miles to merchant at reduced rate for boosting | CVR uplift |

## Phase 4 — Paid Ads (CPI / CPC)
> **Detailed PRD:** [phase-4-prd.md](./04-Initiatives/4.9 Performance Levers/phase-4-prd.md) 

Introduce **paid visibility as a pricing layer** on top of understood economics.

**Dependency:** Requires 4.6 Phase 2-3 for:
- Commercial package framework
- Delivery pacing & guarantees
- Merchant reporting infrastructure

**Hypothesis to test:** Merchants will pay $0.10-0.30 per click (CPC) or $2-5 per 1000 impressions (CPI) for guaranteed visibility in high-converting placements, creating a new revenue stream without degrading organic merchant performance.

| Lever | Description | Success Metric |
| --- | --- | --- |
| CPI impression packages | Pay per impression for guaranteed visibility | Revenue per impression |
| CPC click packages | Pay per click for performance-based visibility | Revenue per click |
---

## Cross-Phase Considerations

### What Applies Across All Phases
- CPA metrics (CTR, CVR) remain primary success signals
- No paid placement logic influences conversion attribution until Phase 4
- All levers should be measurable and attributable

### Guardrails
- No regression in overall platform CVR
- Clear separation between organic and paid ranking (when Phase 4 launches)
- Systematic approach over ad-hoc solutions