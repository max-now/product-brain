# Phase 2: Relevancy Lever — Personalisation & Intent-Based Exposure

> **Overview PRD:** [prd-v2.md](./prd-v2.md) | **Experiment:** [phase-2-experiment.md](./phase-2-experiment.md)

---

## Problem

Phase 1 gives us control over **where** merchants appear. But we still show the same ranking to every user regardless of their behaviour, preferences, or session intent.

This means:
- A user who only shops travel sees the same merchants as a user who only shops retail
- A user in "search mode" (high intent) sees the same ranking as a user casually browsing
- We waste exposure by showing irrelevant merchants to users unlikely to convert

**Core question:** Is the conversion bottleneck relevancy — are we showing the wrong merchants to the wrong users?

---

## Hypothesis being tested

| Hypothesis | Test | Success looks like |
| --- | --- | --- |
| H3: Relevancy > raw exposure | Personalised ranking (based on user transaction history) outperforms popularity sort | >10% CTR uplift AND >5% CVR uplift vs control |

**Prerequisite:** Phase 1 data shows exposure lever has been optimised — remaining gap is relevancy.

---

## What we need to answer first

Before building, the [phase-2-experiment.md](./phase-2-experiment.md) must validate:
- Does personalised ranking meaningfully outperform static ranking?
- For which user segments is the effect strongest?
- Does personalisation reduce merchant diversity (filter bubble risk)?
- Does the effect hold for new vs returning users?

---

## What we need to build (if experiment validates)

### 2A: Personalisation

| Capability | Why |
| --- | --- |
| User-merchant affinity scoring | Rank merchants based on user's transaction history and behaviour |
| Personalised ranking logic | Extend Phase 1 ranking to include `user_id` — adjust non-committed slots |
| Diversity controls | Prevent filter bubbles — 30-40% of slots must be outside user's typical categories |

**Personalisation signals:**
- Transaction history (which merchants, recency, frequency)
- Category preferences (travel, dining, retail)
- Browsing and search patterns

**Key constraint:** Phase 1 campaigns (committed visibility) always take priority. Personalisation adjusts remaining slots only.

### 2B: Intent-Based Exposure

| Capability | Why |
| --- | --- |
| Intent detection | Detect session intent from entry point and behaviour (search = high intent, browse = discovery) |
| Intent-specific ranking strategies | Different placements serve different intents — rank accordingly |
| Placement-intent mapping | Tag each placement with primary intent category |

**Intent categories:**
- **Search** (entry via search bar) → high intent → prioritise high-CVR merchants
- **Browse** (entry via earn home) → discovery → balanced popular + new merchants
- **Deals** (entry via deals calendar) → urgency → time-sensitive offers first
- **Redeem** (entry via redeem flow) → immediate → fast checkout, high-value

---

## Success metrics

**Primary:**
- CTR uplift vs popularity sort (personalised placements)
- CVR uplift vs popularity sort
- Merchant diversity per session (not degraded)

**Guardrails:**
- No negative impact on overall platform CVR
- Phase 1 merchant visibility commitments still honoured
- Cold-start users (no history) perform no worse than control

---

## Who this serves

- **End users** — more relevant merchant recommendations
- **Merchants** — exposure to users more likely to convert (quality over quantity)
- **BD** — better performance conversations (targeted visibility vs broad)
- **Product** — user-merchant affinity data for future features

---

## What we're NOT doing

- Merchant-funded targeting (Phase 3/4)
- Real-time behavioural targeting (start with batch-computed affinity scores)
- Self-serve personalisation controls for merchants

---

## Exit criteria

Phase 2 is complete when:
- We know whether personalisation meaningfully outperforms static ranking
- We know for which user/merchant segments the effect is strongest
- We have intent detection accuracy >90% for high-confidence signals
- Data informs Phase 3: for merchants with good relevancy but low CVR, is incentive the missing lever?

---

## Dependencies

- **Phase 1 in production** — placement-specific ranking + baseline metrics
- **Transaction history pipeline** — user-merchant affinity scoring input
- **Phase 1 ranking query extensibility** — `user_id` and `intent_category` parameters
