# Phase 3: Incentive Levers

## Problem / Objective

With Phase 1 (placement control) and Phase 2 (personalisation) in place, we can surface the right merchants to the right users. However, some merchants have good visibility but low CVR due to:
- Lower perceived value vs competitors
- Less compelling offers
- Category-specific friction (e.g., redemption complexity)

**Core problem**: Visibility and relevance alone are insufficient to drive conversions for certain merchant segments.

**Objective**: Enable targeted incentive mechanisms (miles boosters, promotional rates) to improve CVR for specific merchant segments where exposure and personalisation have been optimized but conversion remains low.

---
## What This Enables
- "Merchant A has good visibility but low CVR → test miles booster for high-intent users"
- Stack levers: placement + personalisation + incentive

---
## What success looks like

**Primary metrics:**
- **CVR uplift**: +15-25% for merchants with active booster campaigns vs baseline
- **ROI positive**: Revenue from incremental transactions > cost of miles boosters (or merchant-funded)
- **Targeted activation**: 80%+ of boosters applied to users with demonstrated intent (Phase 2 affinity or intent signals)

**Secondary metrics**:
- Merchant satisfaction: partners willing to fund boosters for performance improvement
- User perception: boosters seen as "bonus" not expectation (avoid conditioning)
- Incremental transactions (not cannibalizing organic conversions)

**Guardrails**:
- No margin erosion: boosters must be ROI-positive (HeyMax-sponsored) or merchant-funded
- No user conditioning: boosters are time-bound, not permanent
- No platform CVR regression: boosters don't distract from higher-value merchants

---

## Supporting signals

**Phase 1-2 learnings inform targeting**:
- Which merchants have high visibility but low CVR? (Phases 1-2 data)
- Which user segments have high intent but don't convert? (Phase 2 affinity data)
- Which placements benefit most from incentives? (Phase 1 placement performance)

**Incentive types available**:
1. **Miles boosters**: Temporary bonus miles on top of base earn rate (e.g., "Earn 2x miles at Merchant A this week")
2. **Discounted miles rate**: Merchant pays reduced rate per mile for promotional period (commercial model TBD)
3. **Threshold bonuses**: Bonus miles for spending above threshold (e.g., "Spend $50, get 500 bonus miles")

**Commercial models**:
- **HeyMax-sponsored**: HeyMax funds boosters for strategic partners (CAC investment)
- **Merchant-funded**: Merchant pays for boosters to drive volume (co-marketing)
- **Hybrid**: Shared cost between HeyMax and merchant

---

## Data

**Targeting criteria** (from Phase 2 affinity data):
- User has transacted in merchant's category but not with this specific merchant (conquest)
- User has transacted with merchant before but not recently (re-engagement)
- User has high search/browse intent in category but low conversion (intent-to-CVR gap)

**Booster effectiveness signals** (post-launch):
- CVR uplift by merchant category (which categories respond to incentives?)
- CVR uplift by user segment (which users respond to incentives?)
- Incrementality (did booster drive new transactions or just subsidize organic?)

**Economic model inputs**:
- Base earn rate per merchant (existing miles cost)
- Booster multiplier (e.g., 2x = +100% miles cost)
- Average transaction value (ATV) per merchant
- Margin per transaction (revenue - miles cost - booster cost)

---

## Who is this for

### User personas

**Primary**:
- **End users**: Get bonus miles incentive to try new merchants or re-engage with past merchants
- **Merchant partners**: Performance lever to improve CVR when visibility and relevance are already optimized

**Secondary**:
- **BD team**: Commercial lever to offer performance packages (visibility + incentive)
- **Finance team**: Needs ROI-positive incentives or clear cost-sharing model with merchants
- **Product team**: Data on incentive effectiveness to optimize future campaigns

### SG vs AU users

Incentive effectiveness may vary by market:
- **SG market**: Higher merchant density → incentives differentiate similar offers
- **AU market**: Sparser inventory → incentives may drive larger CVR uplift (less choice)

---

## Product requirements

| # | User story | Acceptance criteria |
| --- | --- | --- |
| 1 | As a BD team member, I want to create a time-bound miles booster campaign for a specific merchant | - Can select: Merchant, Booster multiplier (e.g., 2x), Start date, End date, Funding source (HeyMax/Merchant)<br>- Campaign automatically expires at end time<br>- Booster visible to users in-app (badge, messaging) |
| 2 | As an end user, I want to see which merchants have active boosters | - Merchants with active boosters display badge (e.g., "2x miles")<br>- Badge visible in: search results, earn home, deals calendar<br>- Booster details shown on merchant detail page |
| 3 | As a Finance team member, I want to ensure boosters are ROI-positive or merchant-funded | - Dashboard shows: Booster cost, Incremental revenue, ROI<br>- Can filter by funding source (HeyMax vs merchant-funded)<br>- Alerts if campaign ROI < 0 (HeyMax-funded only) |
| 4 | As a Product team member, I want to target boosters to high-intent users only | - Booster eligibility based on Phase 2 affinity data (e.g., "transacted in category but not this merchant")<br>- Can define targeting criteria per campaign<br>- Non-eligible users don't see booster (no false expectations) |
| 5 | As an Ops team member, I want to track active booster campaigns and avoid conflicts | - Dashboard shows: Active boosters, Scheduled boosters, Expired boosters<br>- Can filter by merchant, date range, funding source<br>- Warns if multiple boosters overlap (same merchant) |
| 6 | As a merchant partner, I want to fund a booster campaign to improve my CVR | - Merchant can request booster via BD team<br>- Cost estimate provided upfront (estimated impressions × booster cost per transaction)<br>- Post-campaign report: impressions, clicks, conversions, total cost |

---

## Events tracking

| Event name | Event attributes | Description |
| --- | --- | --- |
| booster_campaign_created | campaign_id, merchant_id, booster_multiplier, start_date, end_date, funding_source, created_by | BD creates booster campaign |
| booster_campaign_started | campaign_id, merchant_id, booster_multiplier | Campaign goes live |
| booster_campaign_expired | campaign_id, merchant_id, total_cost, total_transactions, roi | Campaign auto-expires |
| booster_impression | user_id, merchant_id, placement_id, booster_multiplier, eligible | User sees merchant with booster badge |
| booster_click | user_id, merchant_id, placement_id, booster_multiplier | User clicks merchant with booster |
| booster_transaction | user_id, merchant_id, transaction_value, base_miles, bonus_miles, funding_source | User completes transaction with booster applied |

**Note**: `booster_transaction` event enables ROI calculation (incremental revenue vs booster cost).

---

## FAQs

**Q: How do boosters interact with Phase 1 placement campaigns?**
A: Independent. Phase 1 controls WHERE merchants appear. Phase 3 controls INCENTIVE on top of placement. Both can run simultaneously.

**Q: What if a merchant has both a Phase 1 visibility campaign and a Phase 3 booster?**
A: Ideal scenario. Visibility + incentive = maximum CVR impact. Dashboard shows combined campaigns.

**Q: How do we prevent user conditioning (expecting boosters always)?**
A: (1) Time-bound campaigns (2-4 weeks max), (2) Rotate merchants (not same merchant always boosted), (3) Messaging: "Limited time bonus" vs "Standard rate".

**Q: Who decides if a booster is HeyMax-funded or merchant-funded?**
A: BD team based on: (1) Strategic importance of merchant, (2) Merchant's willingness to fund, (3) Expected ROI. HeyMax-funded requires CFO approval for large campaigns.

**Q: Can users stack multiple boosters (e.g., 2x miles + threshold bonus)?**
A: Not in Phase 3. One active booster per merchant per user. Phase 3+ may explore stacking with complexity tradeoffs.

**Q: How do we measure incrementality (did booster drive NEW transactions)?**
A: A/B test: eligible users with booster vs eligible users without booster (control group). Compare CVR delta.

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Boosters erode margin (not ROI-positive) | H | Finance approval required for HeyMax-funded campaigns. ROI monitoring dashboard with alerts. Pilot with small budget first. |
| User conditioning (expect boosters always) | M | Time-bound campaigns (2-4 weeks max). Rotate merchants. Messaging: "Limited time bonus". Monitor organic CVR post-booster. |
| Boosters cannibalize organic conversions (not incremental) | H | A/B test for incrementality measurement. If incrementality < 50%, pause campaign. Require Phase 1-2 optimization first (visibility + relevance). |
| Merchant unwilling to fund boosters | M | Start with HeyMax-funded pilots to prove ROI. Offer co-funding (50/50 split) as middle ground. Provide post-campaign ROI report to merchants. |
| Booster complexity confuses users | L | Simple messaging: "2x miles" or "Bonus 500 miles". Badge + tooltip on merchant card. Avoid fine print unless necessary. |
| Targeting too narrow (boosters shown to too few users) | M | Phase 2 affinity data provides targeting pool. Start with broad criteria (e.g., "transacted in category"). Narrow post-pilot if needed. |

---

## Launch checklist

- [ ] Commercial model finalized (HeyMax-funded vs merchant-funded criteria)
- [ ] Finance approval process documented for HeyMax-funded campaigns
- [ ] Booster campaign creation UI built (BD dashboard)
- [ ] Targeting logic implemented (Phase 2 affinity integration)
- [ ] Booster badge UI implemented (search, earn home, deals calendar, merchant detail)
- [ ] Events tracking implemented and validated
- [ ] ROI monitoring dashboard built (cost, revenue, incrementality)
- [ ] A/B test framework for incrementality measurement
- [ ] Merchant post-campaign report template ready
- [ ] Internal training completed (BD, Ops, Finance)
- [ ] Pilot with 3-5 merchants (mix of HeyMax-funded and merchant-funded)
- [ ] Incrementality validation: >50% of conversions are incremental (vs organic)
- [ ] Rollback plan documented

---

## Appendix

### Booster Types & Use Cases

| Booster Type | Description | Best For | Example |
| --- | --- | --- | --- |
| Miles multiplier | 2x, 3x base earn rate | Re-engagement, conquest | "Earn 2x miles at Merchant A this week" |
| Flat bonus | Fixed miles on top of base rate | High ATV merchants | "Earn 500 bonus miles on your next purchase" |
| Threshold bonus | Bonus for spending above threshold | Driving higher basket size | "Spend $50, get 1000 bonus miles" |
| Category booster | Booster applies to all merchants in category | Category-level campaigns | "Earn 2x miles at all Travel merchants this month" |

**Phase 3 focuses on Miles Multiplier (simplest, easiest to communicate).**

### Economic Model (Example)

**Scenario**: Merchant A has good visibility (Phase 1) and relevance (Phase 2) but CVR is 2% (target: 4%).

**Baseline (no booster)**:
- Impressions: 10,000
- Clicks (CTR 5%): 500
- Transactions (CVR 2%): 10
- ATV: $100
- Revenue: $1,000
- Miles cost (base rate 2%): $20
- Margin: $980

**With 2x booster (HeyMax-funded)**:
- Impressions: 10,000
- Clicks (CTR 6%, +1% from badge): 600
- Transactions (CVR 4%, +2% from incentive): 24
- ATV: $100
- Revenue: $2,400
- Miles cost (base rate 2%): $48
- **Booster cost (additional 2% miles)**: $48
- Total cost: $96
- Margin: $2,304

**ROI**: ($2,304 - $980) / $48 = **+2,758% ROI** on booster spend.
**Incremental margin**: $1,324 (from 14 incremental transactions).

**Decision**: HeyMax-funded booster is ROI-positive. Proceed.

---

**With 2x booster (Merchant-funded)**:
- Same economics as above
- Merchant pays: $48 booster cost
- Merchant net benefit: +14 transactions at $100 ATV = $1,400 revenue - $48 cost = **+$1,352 incremental revenue**

**Decision**: Merchant benefits from booster. BD can pitch as performance package.

---

### Targeting Logic (Phase 2 Integration)

**Booster eligibility criteria** (configurable per campaign):

1. **Conquest targeting**: User transacted in merchant's category but NOT this merchant (last 90 days)
  - Example: User transacted with Travel merchants, but not Merchant A → eligible for Merchant A booster

2. **Re-engagement targeting**: User transacted with this merchant before but NOT recently (90+ days ago)
  - Example: User last transacted with Merchant A 120 days ago → eligible for re-engagement booster

3. **Intent-to-CVR gap targeting**: User has high browse/search intent in category but low conversion
  - Example: User searched for "hotels" 3 times in last 30 days but no transactions → eligible for Travel booster

4. **Broad targeting**: All users (no restrictions)
  - Example: Strategic merchant launch, maximize reach

**Targeting stored per campaign**:
```python
campaign = {
    "campaign_id": "boost_001",
    "merchant_id": "merchant_a",
    "booster_multiplier": 2.0,
    "start_date": "2026-02-01",
    "end_date": "2026-02-14",
    "funding_source": "heymax",
    "targeting_criteria": {
        "type": "conquest",
        "category": "travel",
        "exclude_past_transactions": True,
        "lookback_days": 90
    }
}
```

**Eligibility check at impression time**:
```python
def is_eligible_for_booster(user_id, campaign):
    if campaign["targeting_criteria"]["type"] == "conquest":
        # Check if user transacted in category but not this merchant
        user_category_transactions = get_user_transactions(user_id, category=campaign["targeting_criteria"]["category"])
        user_merchant_transactions = get_user_transactions(user_id, merchant_id=campaign["merchant_id"])
        return len(user_category_transactions) > 0 and len(user_merchant_transactions) == 0
    # ... other targeting types
```

---

### Booster Badge UI (Mockup Description)

**Merchant card with booster** (earn home, search results):
- Badge: "2x MILES" in top-right corner (gold background, white text)
- Tooltip on hover: "Limited time: Earn 2x miles at [Merchant] until [End Date]"

**Merchant detail page**:
- Banner below merchant logo: "🎉 Earn 2x miles on your next purchase — Limited time offer"
- Expiry countdown: "Ends in 3 days"

**Post-transaction confirmation**:
- "You earned 1,000 miles + 1,000 bonus miles (2x booster) = 2,000 total miles"

---

### Technical Architecture Notes

**Booster campaign storage**:
```sql
CREATE TABLE merchant_booster_campaigns (
    campaign_id UUID PRIMARY KEY,
    merchant_id UUID NOT NULL,
    booster_multiplier DECIMAL NOT NULL,  -- e.g., 2.0 for 2x
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    funding_source VARCHAR(50) NOT NULL,  -- 'heymax' or 'merchant'
    targeting_criteria JSONB,
    created_by UUID,
    created_at TIMESTAMP DEFAULT NOW(),
    status VARCHAR(50) DEFAULT 'scheduled'  -- scheduled, active, expired
);
```

**Eligibility cache** (Redis):
- Key: `user:{user_id}:eligible_boosters`
- Value: List of campaign_ids user is eligible for (TTL: 1 hour)
- Recomputed when: (1) User transacts, (2) Cache expires, (3) New campaign launched

**Booster application at transaction**:
```python
# At transaction time
base_miles = transaction_value * merchant.earn_rate
if user_has_active_booster(user_id, merchant_id):
    booster_campaign = get_active_booster(merchant_id)
    bonus_miles = base_miles * (booster_campaign.booster_multiplier - 1)
    total_miles = base_miles + bonus_miles
    log_booster_transaction(user_id, merchant_id, base_miles, bonus_miles, booster_campaign.funding_source)
else:
    total_miles = base_miles
```

## Why is it Phase 3 and not earlier?
- Incentives require understanding which merchants/users to target (from Phase 1-2 learnings)
- Uncertain ROI — need data to prescribe right solution
- Commercial model (who pays?) needs clarity