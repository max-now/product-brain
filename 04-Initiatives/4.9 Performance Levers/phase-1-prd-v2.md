# Phase 1: Exposure Lever — Placement-Specific Ranking

---

## Problem

We believe **exposure** is the primary bottleneck for underperforming merchants (H1, H2 from overview PRD).

Current state:
- Ranking is **global** — same `bd_ranking` applies across all placements
- No placement-level control — can't target specific surfaces
- No time-bound campaigns — rankings stay until manually changed
- No visibility into which placements drive conversions for which merchant types

What we need to answer:
- Does rank position causally affect CTR? (tested in [phase-1-experiment.md](./phase-1-experiment.md))
- Which placements drive conversions for which merchant types?
- What is the CTR ceiling per placement?

---

## Hypotheses being tested
| Hypothesis | Test | Success looks like |
| --- | --- | --- |
| H1: Underperforming merchants lack exposure, not relevancy | Compare impression distribution: top vs bottom merchants on same placements | Under performing merchants have significantly fewer impressions |
| H2: Placement-specific ranking improves CTR | A/B: placement-context ranking vs global popularity | >5% CTR uplift |

---

## What we need to build
| Capability | Why |
| --- | --- |
| Placement-specific ranking control | Enable per-surface merchant rank (not global) |
| Time-bound campaigns with auto-expiry | Prevent stale rankings; enable controlled experiments |
| Campaign management dashboard | Ops needs visibility into active/scheduled/expired campaigns |
| CTR/CVR measurement per placement | Understand which placements convert for which merchants |

---

## Success metrics

**Primary:**
- CTR uplift per placement (vs baseline) — target: establish measurable improvement
- 100% campaign auto-expiry rate (no manual cleanup)
- BD can respond to merchant inquiries with consistent playbook

**Guardrails:**
- No regression in overall platform CVR
- CPA metrics remain primary success signals

---

## Who this serves

- **Ops** — time-bound campaigns with SOPs, replacing ad-hoc Appsmith overrides
- **BD** — systematic response to "how do I improve performance?" with placement-specific actions
- **Product/Data** — baseline CTR/CVR data per placement to inform Phase 2+

---

## What we're NOT doing

- Personalised ranking (Phase 2)
- Incentive levers / miles boosters (Phase 3)
- Paid ads / CPI / CPC (Phase 4)
- Impression guarantees
- Advertiser self-serve

---

## Exit criteria

Phase 1 is complete when:
- We have statsig data on whether rank boosting improves CTR and by how much
- We know which placements drive conversions for which merchant types
- Ops is executing campaigns through the dashboard (not Appsmith)

This data determines **how much** exposure matters as a lever and informs Phase 2 investment.

---

## Dependencies

- **Impression Infrastructure (4.6):** Not required for Phase 1 launch, but Phase 1 events (`merchant_impression`) will feed into 4.6
- **Statsig/Sundial:** Required for measurement
- **Appsmith deprecation:** Phase 1 replaces manual ranking in Appsmith

---

## Phase 2 readiness

Phase 1 infrastructure must support Phase 2 without major refactoring:
- Ranking query should accept optional `user_id` (Phase 2A: personalisation) and `intent_category` (Phase 2B: intent-based)
- Campaign priority field needed — Phase 1 campaigns override personalisation
- Placement inventory should include `intent_category` mapping for Phase 2B
