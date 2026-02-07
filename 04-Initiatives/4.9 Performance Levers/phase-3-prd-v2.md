# Phase 3: Incentive Lever — Miles Boosters

> **Overview PRD:** [prd-v2.md](./prd-v2.md) | **Experiment:** [phase-3-experiment.md](./phase-3-experiment.md)

---

## Problem

After Phase 1 (exposure) and Phase 2 (relevancy), some merchants will still have:
- Good visibility (they appear in the right placements)
- Good relevancy (they're shown to the right users)
- Low CVR (users click but don't convert)

**Core question:** For merchants where exposure and relevancy are optimised but CVR remains low, is the missing lever monetary incentive?

Possible reasons users click but don't convert:
- Miles earn rate isn't compelling enough vs alternatives
- No urgency or time-bound reason to act now
- Perceived value gap (merchant offer isn't differentiated)

---

## Hypothesis being tested

| Hypothesis | Test | Success looks like |
| --- | --- | --- |
| H4: Miles boosters drive incremental CVR | A/B: boosted merchants (2x, 3x miles) vs control (1x) for high-CTR/low-CVR merchants | >15% CVR uplift AND ROI > 1.0 |

**Prerequisite:** Phase 1-2 data confirms these merchants don't have an exposure or relevancy problem — the gap is incentive.

---

## What we need to answer first

Before scaling, the [phase-3-experiment.md](./phase-3-experiment.md) must validate:
- Does a miles booster increase CVR? By how much?
- Is the uplift incremental or cannibalised from other merchants?
- Does CVR return to baseline after the booster ends (no dependency creation)?
- What booster tier (2x vs 3x) gives best ROI?
- Is the uplift worth the cost?

---

## What we need to build (if experiment validates)

| Capability | Why |
| --- | --- |
| Booster campaign creation | BD/Ops can create time-bound miles booster for specific merchants |
| User-facing booster badge | Users see "2x miles" on eligible merchants (search, earn home, deals) |
| Targeting logic | Booster shown to high-intent users only (Phase 2 affinity data) |
| ROI monitoring dashboard | Track: booster cost, incremental revenue, ROI per campaign |
| Incrementality measurement | A/B test: eligible users with booster vs without — isolate true uplift |

**Targeting criteria (from Phase 2):**
- **Conquest:** User transacts in category but not this merchant
- **Re-engagement:** User transacted with merchant but not recently (90+ days)
- **Intent gap:** User searches/browses category frequently but doesn't convert

---

## Commercial models

| Model | Who pays | When to use |
| --- | --- | --- |
| HeyMax-funded | HeyMax (CAC investment) | Strategic partners, proving the model |
| Merchant-funded | Merchant | Merchant wants to drive volume, willing to pay for performance |
| Hybrid | Shared cost | Co-marketing, testing new merchants |

---

## Success metrics

**Primary:**
- CVR uplift vs control (boosted merchants)
- Incrementality rate (% of conversions that wouldn't have happened without booster)
- ROI > 1.0 (incremental revenue exceeds booster cost)

**Guardrails:**
- Non-boosted merchant CVR stable (no cannibalisation)
- Post-campaign CVR doesn't drop below pre-campaign baseline (no dependency)
- Platform CVR not regressed
- Boosters are time-bound (2-4 weeks max)

---

## Who this serves

- **End users** — bonus miles incentive to try/re-engage with merchants
- **Merchants** — performance lever when visibility and relevance are already optimised
- **BD** — commercial lever: sell performance packages (visibility + incentive)
- **Finance** — ROI-positive incentives or clear merchant cost-sharing

---

## What we're NOT doing

- Stacking multiple boosters per merchant per user
- Permanent/always-on boosters (time-bound only)
- Self-serve booster creation for merchants
- Threshold bonuses or complex incentive types (start with simple multiplier)

---

## Exit criteria

Phase 3 is complete when:
- We know the CVR uplift from incentives and for which merchant segments
- We have a validated ROI threshold for sustainable booster campaigns
- We know whether merchant-funded boosters are commercially viable
- Data informs Phase 4: can we monetise these levers via paid placement?

---

## Dependencies

- **Phase 1-2 in production** — exposure + relevancy optimised; identifies merchants where incentive is the remaining gap
- **Phase 2 affinity data** — targeting criteria for booster eligibility
- **Finance approval process** — for HeyMax-funded campaigns

---

## Why Phase 3 and not earlier?

- Incentives without exposure/relevancy = wasted spend (wrong users see the booster)
- Phase 1-2 data identifies which merchants actually need incentives vs better placement/targeting
- ROI depends on knowing baseline conversion to measure true incremental lift
