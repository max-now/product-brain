# Phase 2: Personalisation & Intent-Based Exposure

## Problem / Objective

With Phase 1's placement-specific ranking in place, we still show the same merchant ranking to all users regardless of their behavior, preferences, or session intent. This "one size fits all" approach misses conversion opportunities by not matching merchants to user context.

**Core problem**: Users see irrelevant merchants because ranking doesn't account for individual preferences or session intent.

**Objective**: Enable user-based merchant recommendations and intent-aware exposure to improve relevance and conversion through personalisation and context-aware ranking.

---
## What This Enables
- "User frequently transacts with travel merchants → surface travel merchants higher"
- "User in 'search' session → show different merchants vs 'browse deals' session"
- "User has never seen Merchant B but matches profile → recommend proactively"
- Move from "same ranking for everyone" to "relevant ranking per user and session intent"

---
## What success looks like

**Primary metrics:**
- **CTR uplift**: +10-15% in personalised placements vs baseline
- **CVR uplift**: +5-10% for personalised recommendations vs non-personalised (secondary CVR benefit)
- **Relevance**: 60%+ of users see at least one merchant they've transacted with before in top 5 positions

**Secondary metrics**:
- Diversity of merchant impressions (not just popular merchants)
- New merchant discovery rate (users clicking merchants outside their typical categories)
- Intent-based CTR variance (search intent vs browse intent performance)

**Guardrails**:
- No negative impact on overall platform CVR
- Merchant visibility commitments from Phase 1 still honored
- Personalisation respects user privacy (no PII in ranking logic)

---

## Supporting signals

**User behavior data available**:
- Transaction history (which merchants, how often, recency)
- Search history (which merchants searched, keywords)
- Browse patterns (which categories viewed, time spent)
- Session context (entry point, previous actions)

**Intent signals**:
- Search bar usage → high intent (user knows what they want)
- Browse earn home → discovery intent (exploring options)
- Deals calendar → time-bound intent (looking for limited offers)
- Redeem flow → immediate intent (ready to transact)

**Business rationale**:
- Phase 1 showed which placements convert, now optimize WHO sees WHAT
- Merchant partners want exposure to relevant users, not just volume
- Foundation for Phase 3 incentives (target right users for boosters)

---

## Data

**User affinity scoring inputs**:
- Transaction frequency per merchant (recency-weighted)
- Category preferences (travel, dining, retail, services)
- Average transaction value per category
- Time since last interaction with merchant

**Intent detection signals**:
- Session entry point (search, browse, deals, redeem)
- Previous page in session flow
- Time of day / day of week patterns
- Search keywords (if applicable)

**Placement-intent mapping** (from Phase 1 learnings):
- earn home → popular merchants = discovery intent
- earn home → limited time deals = urgency intent
- search bar = targeted intent
- deals calendar = time-bound intent

---

## Who is this for

### User personas

**Primary**:
- **End users**: Get more relevant merchant recommendations based on their behavior and session intent
- **Power users**: Discover new merchants in categories they already transact in

**Secondary**:
- **Merchants**: Exposure to users more likely to convert (not just impressions)
- **BD team**: Better performance conversations with merchants (targeted visibility vs broad visibility)
- **Product team**: Data on user-merchant affinity for future features

### SG vs AU users

Personalisation logic is market-agnostic, but:
- **SG market**: More merchant density → personalisation has higher impact (more choices to filter)
- **AU market**: Sparser inventory → personalisation complements (not replaces) general ranking

---

## Product requirements

### 2A. Personalisation

| # | User story | Acceptance criteria |
| --- | --- | --- |
| 1 | As an end user, I want to see merchants I've transacted with before ranked higher | - Users who transacted with Merchant A in last 90 days see it ranked higher<br>- Recency weighted (30d > 90d transactions)<br>- Frequency weighted (multiple transactions > one-off) |
| 2 | As an end user, I want to discover new merchants in categories I care about | - Users who transact in "Travel" see more travel merchants in discovery placements<br>- Category affinity calculated from transaction history<br>- Balance between familiar and new merchants (not 100% familiar) |
| 3 | As a Product team member, I want to measure personalisation impact per placement | - A/B test: personalised ranking vs baseline<br>- Track CTR, CVR, diversity metrics<br>- Can isolate personalisation effect from Phase 1 placement control |
| 4 | As an Ops team member, I want merchant visibility commitments to override personalisation | - Phase 1 campaigns (time-bound visibility) still apply<br>- Personalisation adjusts remaining slots, not committed slots<br>- Dashboard shows: committed vs personalised rankings |

### 2B. Intent-Based Exposure

| # | User story | Acceptance criteria |
| --- | --- | --- |
| 5 | As an end user in a "search" session, I want high-CVR merchants surfaced | - Search intent detected (entry via search bar)<br>- Ranking prioritizes merchants with high CVR in search context<br>- Different ranking than browse/discovery intent |
| 6 | As an end user browsing deals, I want time-sensitive offers surfaced | - Browse deals intent detected (entry via deals calendar)<br>- Ranking prioritizes merchants with ending-soon deals<br>- Urgency signals (e.g., "Ends in 2 days") displayed |
| 7 | As a Product team member, I want to define intent categories and map placements | - Intent categories defined: search, browse, deals, redeem<br>- Each placement tagged with primary intent<br>- Intent-specific ranking logic documented |
| 8 | As a Data team member, I want to measure intent signal accuracy | - Track: detected intent vs actual user behavior<br>- Validate: search intent users have higher CVR than browse intent<br>- False positive rate for intent detection < 10% |

---

## Events tracking

| Event name | Event attributes | Description |
| --- | --- | --- |
| merchant_personalised_ranking_applied | user_id, merchant_id, placement_id, affinity_score, ranking_shift | User saw personalised ranking (vs baseline) |
| intent_detected | user_id, session_id, detected_intent, confidence_score, entry_point | System detected user session intent |
| merchant_affinity_calculated | user_id, merchant_id, category, affinity_score, last_transaction_date | User-merchant affinity score computed |
| intent_based_ranking_applied | user_id, placement_id, detected_intent, merchant_ids[], timestamp | Ranking adjusted based on detected intent |

**Note**: These events extend Phase 1's `merchant_impression` and `merchant_click` events to measure personalisation and intent impact.

---

## FAQs

**Q: How does personalisation interact with Phase 1 placement campaigns?**
A: Phase 1 campaigns (committed merchant visibility) take priority. Personalisation adjusts the remaining non-committed ranking slots.

**Q: What if a user has no transaction history (new user)?**
A: Fall back to baseline ranking (Phase 1 placement-specific logic). Personalisation applies progressively as users transact.

**Q: How do we avoid "filter bubbles" (users only see same merchants)?**
A: Diversity quota: 30-40% of recommendations must be outside user's typical categories. Balances relevance with discovery.

**Q: How accurate is intent detection?**
A: Phase 2 starts with simple heuristics (entry point, previous page). Phase 2B refines with session behavior patterns. Target: 90%+ accuracy.

**Q: Can merchants opt into "personalisation-friendly" campaigns?**
A: Not in Phase 2. Personalisation is system-wide. Phase 3 (incentives) may allow merchant-specific targeting.

---

## Workstream Breakdown

### 2A. Personalisation (can start after Phase 1)

**Dependencies**: Phase 1 placement-specific ranking in production

**Workstreams**:
1. **User affinity scoring**:
  - Transaction history ingestion (recency, frequency, category)
  - Affinity score calculation per merchant
  - Scoring refresh cadence (daily batch job)

2. **Personalised ranking logic**:
  - Extend Phase 1 ranking query to include user_id parameter
  - Ranking adjustment formula (baseline + affinity_score)
  - A/B test framework for measuring impact

3. **Measurement & iteration**:
  - Statsig experiment: personalised vs non-personalised ranking
  - CTR/CVR uplift tracking per placement
  - User feedback (optional: "Why am I seeing this?")

### 2B. Intent-Based Exposure (requires upfront mapping)

**Dependencies**: Phase 2A personalisation foundation, intent category definitions

**Workstreams**:
1. **Intent taxonomy & mapping**:
  - Define intent categories (search, browse, deals, redeem, quick action, cross-sell)
  - Map existing placements to intent categories
  - Intent-specific ranking strategies per category

2. **Intent detection logic**:
  - Session entry point detection (search bar, earn home, deals calendar)
  - Behavioral signals (time on page, previous actions)
  - Intent confidence scoring (high/medium/low confidence)

3. **Intent-aware ranking**:
  - Extend ranking logic to include intent_category parameter
  - Intent-specific merchant pools (e.g., high-CVR for search, discovery for browse)
  - A/B test: intent-aware vs intent-agnostic ranking

4. **Measurement & validation**:
  - Intent detection accuracy tracking
  - CTR/CVR by detected intent category
  - False positive analysis (misclassified intent)

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Personalisation creates "filter bubbles" (users only see same merchants) | M | Diversity quota (30-40% unfamiliar merchants). Monitor discovery rate. |
| Affinity scoring complexity delays launch | H | Start with simple recency-weighted transaction count. Iterate post-launch. |
| Intent detection inaccuracy hurts CVR | H | Phase 2B starts with high-confidence signals only (e.g., search bar = search intent). Low-confidence → fallback to baseline. |
| Merchant visibility commitments conflict with personalisation | M | Phase 1 campaigns override personalisation. Clear prioritization rules in ranking logic. |
| Cold start problem (new users have no history) | L | Graceful degradation: no history → Phase 1 baseline ranking. No negative impact. |
| Performance overhead (real-time affinity calculation) | M | Pre-compute affinity scores daily (batch job). Cache per user. Lazy load if needed. |

---

## Launch checklist

### Phase 2A (Personalisation)
- [ ] Transaction history data pipeline validated
- [ ] Affinity scoring logic implemented and tested
- [ ] Personalised ranking query extends Phase 1 logic
- [ ] A/B test framework ready (personalised vs baseline)
- [ ] Statsig experiment configured for CTR/CVR tracking
- [ ] Diversity quota logic implemented (avoid filter bubbles)
- [ ] Ops dashboard shows: committed vs personalised rankings
- [ ] Pilot with 10-20% users, expand post-validation
- [ ] Rollback plan documented

### Phase 2B (Intent-Based Exposure)
- [ ] Intent taxonomy defined and documented
- [ ] Placement-to-intent mapping completed
- [ ] Intent detection logic implemented (entry point + session signals)
- [ ] Intent-aware ranking strategies defined per category
- [ ] Intent confidence scoring validated (>90% accuracy target)
- [ ] A/B test: intent-aware vs intent-agnostic ranking
- [ ] False positive monitoring dashboard ready
- [ ] Pilot with high-confidence intents only (search, deals)
- [ ] Expand to medium-confidence intents post-validation

---

## Appendix

### User Affinity Scoring Formula (Initial)

```python
affinity_score = (
    recency_weight * recency_score +      # Last transaction date (30d=1.0, 90d=0.5, 180d=0.2)
    frequency_weight * frequency_score +  # Transaction count (log scale)
    category_weight * category_score      # Category match to placement context
)

# Example:
# - User transacted with Merchant A 15 days ago (recency=0.8)
# - User transacted 3 times in 90 days (frequency=0.6)
# - Merchant A is in user's top category (category=1.0)
# → affinity_score = 0.4*0.8 + 0.3*0.6 + 0.3*1.0 = 0.8
```

**Weights tunable via Statsig** for experimentation.

### Intent Detection Logic (Initial)

| Intent Category | Detection Signal | Confidence | Ranking Strategy |
| --- | --- | --- | --- |
| Search | Entry via search bar | High | Prioritize high-CVR merchants, exact match > category match |
| Browse | Entry via earn home (not search) | Medium | Balanced discovery + popular merchants |
| Deals | Entry via deals calendar | High | Time-sensitive deals, urgency signals |
| Redeem | Entry via redeem flow | High | Fast checkout, high-value offers |
| Quick Action | Cross-sell trigger (post-transaction) | Medium | Related merchants, complementary categories |

**Fallback**: Low confidence or ambiguous intent → Phase 1 baseline ranking.

### Technical Architecture Notes

**Affinity Score Storage**:
- Redis cache: `user:{user_id}:affinity:{merchant_id}` → score (TTL: 24h)
- Daily batch job recalculates from transaction history
- Fallback to DB if cache miss (cold users)

**Ranking Query Extension**:
```python
# Phase 1 (placement-specific)
query = query.order_by(
    placement_ranking,           # Phase 1: placement campaigns
    bd_ranking,                  # BD override
    popularity_ranking           # Popularity fallback
)

# Phase 2A (personalisation)
query = query.order_by(
    placement_ranking,           # Phase 1: placement campaigns (highest priority)
    affinity_adjusted_ranking,   # Phase 2A: personalised ranking (bd_ranking + affinity_score)
    popularity_ranking           # Popularity fallback
)

# Phase 2B (intent-aware)
query = query.order_by(
    placement_ranking,           # Phase 1: placement campaigns
    intent_adjusted_ranking,     # Phase 2B: intent-specific ranking (affinity + intent strategy)
    popularity_ranking           # Popularity fallback
)
```

**Intent Context Propagation**:
- Detected intent stored in session context (Redis)
- Passed as parameter to ranking query: `get_merchants(user_id, placement_id, intent_category)`
