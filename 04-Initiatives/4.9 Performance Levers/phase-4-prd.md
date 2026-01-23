# Phase 4: Paid Ads (CPI / CPC)

## Problem / Objective

With Phases 1-3 in place, we understand:
- Which placements drive conversions (Phase 1)
- Which users convert for which merchants (Phase 2)
- Which incentives improve CVR (Phase 3)

However, we still lack a **pricing layer** to monetize this understanding. Merchants who want guaranteed exposure beyond organic ranking currently have no mechanism to pay for it.

**Core problem**: We have optimized organic ranking and incentives, but have no paid placement product to monetize merchant demand for visibility.

**Objective**: Introduce paid visibility as a pricing layer on top of understood economics, enabling merchants to purchase guaranteed impressions or clicks at transparent, value-based pricing.

---

## What success looks like

**Primary metrics:**
- **Revenue**: $X/month from paid placement (target TBD based on pilot)
- **Fill rate**: 60%+ of paid inventory sold (supply-demand balance)
- **ROI for merchants**: Paid placement drives positive ROI vs organic (merchants renew campaigns)

**Secondary metrics**:
- **Organic CVR protection**: No regression in organic merchant performance (protects Phase 1-3 CTR/CVR gains)
- **User experience**: Paid placements clearly labeled, relevant (not spammy)
- **Pricing accuracy**: CPI/CPC rates reflect true value based on Phase 1-3 CTR/CVR data (no under/over-pricing)

**Guardrails**:
- **Organic-paid separation**: Paid placements don't influence organic ranking or conversion attribution
- **Quality threshold**: Paid merchants must meet minimum quality bar (CTR, CVR, user ratings)
- **Budget caps**: Merchants can't over-spend (delivery pacing, daily budget limits)

---

## Supporting signals

**Foundation from Phases 1-3**:
- **Phase 1**: Placement-specific CTR/CVR data (which surfaces are valuable?)
- **Phase 2**: User-merchant affinity (which users to target for paid ads?)
- **Phase 3**: Incentive effectiveness (should paid ads include boosters?)

**CTO principle (from main PRD)**:
> "Paid ads = a factor to change placement logic based on expected revenue."
>
> **Example**: Show Merchant A in deals page = 0.5 cents expected revenue. Show Merchant B = 0.2 cents expected revenue. Only if Merchant B pays 0.3+ cents do we display their deal instead.

**Commercial models**:
1. **CPI (Cost Per Impression)**: Merchant pays for guaranteed impressions (e.g., 10,000 impressions at $0.01 each = $100)
2. **CPC (Cost Per Click)**: Merchant pays for clicks only (e.g., 100 clicks at $1 each = $100)
3. **Hybrid (CPI + performance bonus)**: Base CPI + bonus if CVR exceeds threshold

---

## Data

**Pricing inputs** (from Phase 1-3 learnings):
- **Expected revenue per placement**: Baseline CVR × ATV × margin per transaction
- **Opportunity cost**: What we forgo by showing Merchant B instead of Merchant A
- **Merchant willingness to pay**: Survey data, pilot campaign feedback

**Example calculation** (from CTO principle):
- Placement: Deals page
- Organic Merchant A: CVR 4%, ATV $100, margin 2% = **$0.08 expected revenue per impression**
- Paid Merchant B: CVR 2%, ATV $80, margin 2% = **$0.032 expected revenue per impression**
- **CPI floor for Merchant B**: $0.048 (to break even vs showing Merchant A)
- **Recommended CPI**: $0.06-0.08 (20-60% markup for paid inventory)

**Inventory availability** (from Phase 1):
- Which placements can accommodate paid ads without degrading organic experience?
- How many impressions per placement are available daily?
- Peak vs off-peak inventory pricing (dynamic pricing)

---

## Dependency: Impression Infrastructure (Initiative 4.6)

**Phase 4 CANNOT launch without \*\***[prd.md](./../4.6%20Impression%20Infrastructure/prd.md) in production.**

Required capabilities from 4.6:
1. **Impression tracking**: Log every merchant impression by placement, user, timestamp
2. **Placement definitions**: Standardized placement IDs (e.g., `earn_home_popular`, `deals_calendar_current`)
3. **Delivery pacing**: Cap impressions per day/week to avoid over-delivery
4. **Attribution separation**: Clear separation between organic and paid impression data

**Integration points**:
- Paid campaigns reference placement IDs from 4.6
- Impression delivery uses 4.6 pacing logic
- Billing uses 4.6 impression logs (CPI) or click events (CPC)

---

## Who is this for

### User personas

**Primary**:
- **Merchant partners**: Want to purchase guaranteed exposure to supplement organic ranking
- **BD team**: Can sell performance packages (visibility + incentive + paid placement)
- **Finance team**: New revenue stream from paid placement

**Secondary**:
- **End users**: See relevant paid placements (clearly labeled as "Sponsored")
- **Product team**: Monetization layer on top of optimized organic ranking
- **Data team**: Pricing model to optimize (dynamic CPI/CPC based on performance)

### SG vs AU users

Paid placement value varies by market:
- **SG market**: Higher merchant density → paid ads differentiate in crowded placements
- **AU market**: Sparser inventory → paid ads may cannibalize organic (need careful balance)

---

## Product requirements

### 4A. Paid Placement Infrastructure

| # | User story | Acceptance criteria |
| --- | --- | --- |
| 1 | As a BD team member, I want to sell a CPI campaign to a merchant | - Can create campaign: Merchant, Placement(s), Total impressions, CPI rate, Start/End date<br>- Budget calculated automatically (impressions × CPI)<br>- Campaign pacing: daily impression cap (total / campaign days)<br>- No manual intervention to start/stop campaign |
| 2 | As a BD team member, I want to sell a CPC campaign to a merchant | - Can create campaign: Merchant, Placement(s), Max clicks, CPC rate, Start/End date<br>- Budget cap (max clicks × CPC)<br>- Campaign pauses when max clicks reached<br>- Click attribution logged separately from organic clicks |
| 3 | As a Finance team member, I want to track paid campaign revenue | - Dashboard shows: Total revenue, Revenue by merchant, Revenue by placement<br>- Billing report: Actual impressions/clicks delivered × rate<br>- Compare to budget (under/over-delivery) |
| 4 | As an end user, I want to know when I'm seeing a paid placement | - Paid placements clearly labeled: "Sponsored" badge<br>- Tooltip: "This merchant is paying for visibility"<br>- Paid placements visually distinct (border, background color) but not intrusive |
| 5 | As a Product team member, I want to ensure paid placements don't hurt organic CVR | - A/B test: users with paid ads vs users without paid ads<br>- Track: Organic CTR, Organic CVR, Overall CVR<br>- Alert if organic CVR drops >5% |

### 4B. Pricing & Optimization

| # | User story | Acceptance criteria |
| --- | --- | --- |
| 6 | As a BD team member, I want recommended CPI/CPC rates per placement | - Pricing calculator: Input placement → Output recommended CPI/CPC<br>- Based on: Expected revenue per impression (from Phase 1 data), Opportunity cost, Market rate<br>- Can override recommended rate (with justification) |
| 7 | As a Data team member, I want to optimize CPI/CPC pricing over time | - Track: Merchant willingness to pay, Fill rate (% inventory sold), Merchant ROI<br>- Suggest price adjustments: Increase if fill rate >80%, Decrease if fill rate <40%<br>- A/B test pricing tiers to find optimal rates |
| 8 | As a merchant partner, I want to see ROI from my paid campaign | - Post-campaign report: Impressions delivered, Clicks received, Conversions driven, Total spend, ROI (revenue vs spend)<br>- Compare to organic performance (baseline)<br>- Renewal recommendation based on ROI |

### 4C. Quality & Guardrails

| # | User story | Acceptance criteria |
| --- | --- | --- |
| 9 | As a Product team member, I want to enforce quality thresholds for paid merchants | - Merchant must meet: Min CVR (e.g., 1%), Min user rating (if available), No fraud flags<br>- Low-quality merchants can't purchase paid placement (auto-reject)<br>- Alert BD if merchant quality drops mid-campaign |
| 10 | As an Ops team member, I want to prevent over-delivery (budget overruns) | - Campaign auto-pauses when: Impression cap reached (CPI), Click cap reached (CPC), Budget depleted<br>- Daily pacing: evenly distribute impressions across campaign days<br>- Alert if delivery pace >120% of target |
| 11 | As a Product team member, I want to separate organic and paid attribution | - Paid impressions/clicks tagged separately in events<br>- Organic ranking logic NEVER uses paid impression data<br>- CPA metrics (for organic) exclude paid placements<br>- Clear separation in analytics dashboards |

---

## Events tracking

| Event name | Event attributes | Description |
| --- | --- | --- |
| paid_campaign_created | campaign_id, merchant_id, campaign_type (CPI/CPC), placement_ids[], total_budget, rate, start_date, end_date | BD creates paid campaign |
| paid_campaign_started | campaign_id, merchant_id, campaign_type | Campaign goes live |
| paid_campaign_paused | campaign_id, reason (budget_depleted, cap_reached, manual) | Campaign paused (auto or manual) |
| paid_campaign_expired | campaign_id, merchant_id, total_impressions, total_clicks, total_spend, roi | Campaign completed |
| paid_impression | user_id, merchant_id, placement_id, campaign_id, timestamp | User sees paid placement |
| paid_click | user_id, merchant_id, placement_id, campaign_id, timestamp | User clicks paid placement |
| paid_transaction | user_id, merchant_id, campaign_id, transaction_value, attributed_to_paid | User transacts after clicking paid placement |

**Note**: All paid events tagged with `campaign_id` and kept separate from organic events.

---

## FAQs

**Q: How do paid placements interact with Phase 1 organic ranking?**
A: Separate inventories. Paid placements occupy designated slots (e.g., top 2 positions = paid, positions 3+ = organic). Organic ranking unaffected.

**Q: Can a merchant run paid campaigns and Phase 1 organic campaigns simultaneously?**
A: Yes. Paid = guaranteed impressions in paid slots. Organic = ranking in non-paid slots. Both can run together.

**Q: What if a paid merchant also ranks high organically?**
A: Paid slot takes priority (merchant pays for guaranteed visibility). Organic slot shows next-best merchant. Merchant can't occupy both paid and organic slots simultaneously.

**Q: How do we prevent low-quality merchants from buying visibility?**
A: Quality thresholds: Min CVR, min user rating, no fraud flags. BD approves all campaigns manually before launch (no self-serve in Phase 4).

**Q: What if a paid campaign delivers poorly (low CTR/CVR)?**
A: Campaign runs to completion (merchant paid for impressions/clicks). Post-campaign report shows poor performance. BD recommends: (1) Improve offer, (2) Try different placement, (3) Pause future campaigns.

**Q: Can merchants target specific user segments (Phase 2 affinity)?**
A: Not in Phase 4. Paid campaigns target placements, not users. User targeting requires more complex pricing model (explore in Phase 4+).

**Q: How do we price dynamic inventory (peak vs off-peak)?**
A: Phase 4 uses static pricing (same CPI/CPC all day). Phase 4+ can explore dynamic pricing (higher rates during peak hours).

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Paid placements degrade organic CVR (users avoid "Sponsored" ads) | H | A/B test impact. Clear labeling but not intrusive. Limit paid slots to 20-30% of inventory. Monitor organic CTR/CVR continuously. |
| Merchants over-spend (no budget caps) | M | Campaign auto-pauses when budget depleted. Daily pacing prevents burst spending. Alert BD if delivery pace >120%. |
| Pricing too high (merchants won't buy) | H | Pilot with 5-10 merchants at various price points. Survey willingness to pay. Start conservative, adjust post-pilot. |
| Pricing too low (undermonetize inventory) | M | Use Phase 1 expected revenue as floor. Markup 20-60% for paid inventory. Dynamic pricing post-pilot. |
| Attribution complexity (did paid ad cause transaction?) | M | Last-touch attribution: transaction within 7 days of paid click = attributed. Compare to organic conversion window. |
| Dependency on Impression Infrastructure (4.6) delays launch | H | Phase 4 CANNOT launch without 4.6. Align timelines. Build Phase 4 in parallel but don't release until 4.6 is live. |
| Merchants expect self-serve (not BD-managed campaigns) | L | Phase 4 is BD-managed only. Communicate: Self-serve requires more infra (explore in Phase 4+). |

---

## Launch checklist

### Prerequisites
- [ ] **Impression Infrastructure (4.6) in production**:
  - [ ] Impression tracking live
  - [ ] Placement definitions standardized
  - [ ] Delivery pacing functional
  - [ ] Attribution separation validated

### Phase 4 Build
- [ ] Paid campaign creation UI built (BD dashboard)
- [ ] CPI/CPC campaign types supported
- [ ] Budget cap and daily pacing logic implemented
- [ ] Paid placement slots defined per placement (e.g., top 2 = paid, 3+ = organic)
- [ ] "Sponsored" badge UI implemented (clear labeling)
- [ ] Events tracking implemented and validated
- [ ] Pricing calculator built (recommended CPI/CPC per placement)
- [ ] Post-campaign report template ready (impressions, clicks, conversions, ROI)

### Testing & Validation
- [ ] Quality threshold enforcement tested (low-quality merchants rejected)
- [ ] Over-delivery prevention tested (campaigns pause at cap)
- [ ] Attribution logic validated (paid vs organic separation)
- [ ] A/B test framework ready (measure organic CVR impact)

### Go-to-Market
- [ ] Pilot with 5-10 merchants (mix of CPI and CPC campaigns)
- [ ] Pricing validation: survey merchant willingness to pay
- [ ] BD training completed (how to sell paid campaigns)
- [ ] Merchant onboarding guide documented
- [ ] Legal review: Terms & Conditions for paid placement
- [ ] Rollback plan documented

---

## Appendix

### Paid vs Organic Slot Allocation (Example)

**Placement**: Earn Home → Popular Merchants

**Total slots**: 10 positions

**Allocation**:
- **Positions 1-2**: Paid slots (if campaigns active)
- **Positions 3-10**: Organic slots (Phase 1-2 ranking)

**Rendering logic**:
```python
def get_merchants_for_placement(placement_id, user_id):
    # 1. Fetch active paid campaigns for this placement
    paid_merchants = get_paid_campaigns(placement_id, active=True)
    paid_slots = paid_merchants[:2]  # Top 2 positions

    # 2. Fetch organic ranking (Phase 1-2 logic)
    organic_merchants = get_organic_ranking(placement_id, user_id, exclude=paid_merchants)
    organic_slots = organic_merchants[:8]  # Positions 3-10

    # 3. Merge: paid first, organic after
    return paid_slots + organic_slots
```

---

### Pricing Calculator (Example)

**Inputs**:
- Placement: `deals_calendar_current`
- Expected organic CTR: 5%
- Expected organic CVR: 3%
- Average transaction value (ATV): $100
- Margin per transaction: 2%

**Calculation**:
1. **Expected revenue per impression (organic)**:
  - CTR 5% × CVR 3% = 0.15% conversion rate per impression
  - 0.15% × $100 ATV × 2% margin = **$0.003 per impression**

2. **Opportunity cost** (if we show paid ad instead of organic):
  - Organic expected revenue = $0.003
  - Paid merchant expected revenue = $0.001 (assume lower CVR)
  - Opportunity cost = $0.003 - $0.001 = **$0.002**

3. **Recommended CPI**:
  - Floor: $0.002 (break-even)
  - Markup: 50-100% (paid inventory premium)
  - **Recommended CPI: $0.003 - $0.004**

4. **Recommended CPC** (if merchant prefers CPC):
  - Paid CTR: assume 4% (slightly lower than organic due to "Sponsored" label)
  - CPI $0.003 ÷ 4% CTR = **CPC $0.075 per click**

**BD dashboard shows**:
- Placement: Deals Calendar (Current)
- Recommended CPI: $0.003 - $0.004
- Recommended CPC: $0.07 - $0.08
- Expected impressions available: 50,000/day
- Expected clicks available: 2,000/day (at 4% CTR)

---

### Campaign Example: CPI

**Merchant**: Travel Co.
**Placement**: Earn Home → Popular Merchants
**Campaign type**: CPI
**Total impressions**: 100,000
**CPI rate**: $0.004
**Total budget**: $400
**Campaign duration**: 10 days
**Daily impression cap**: 10,000/day

**Delivery pacing**:
- Day 1: 10,000 impressions delivered
- Day 2: 10,000 impressions delivered
- ...
- Day 10: 10,000 impressions delivered
- **Total**: 100,000 impressions → Campaign complete

**Billing**:
- Actual impressions delivered: 100,000
- CPI rate: $0.004
- **Total charge**: $400

**Post-campaign metrics**:
- Impressions: 100,000
- Clicks: 4,000 (4% CTR)
- Conversions: 120 (3% CVR from clicks, 0.12% from impressions)
- Transaction value: $12,000 (120 × $100 ATV)
- Merchant revenue: $12,000
- Merchant cost: $400
- **Merchant ROI**: ($12,000 - $400) / $400 = **+2,900% ROI**

**Renewal**: High ROI → recommend renewal at same rate or slightly higher (demand-based pricing).

---

### Campaign Example: CPC

**Merchant**: Dining Co.
**Placement**: Deals Calendar → Current
**Campaign type**: CPC
**Max clicks**: 500
**CPC rate**: $0.08
**Total budget**: $40
**Campaign duration**: 7 days

**Delivery**:
- Day 1: 75 clicks
- Day 2: 80 clicks
- ...
- Day 6: 70 clicks
- **Total after 6 days**: 480 clicks
- Day 7: 20 clicks → Campaign pauses (max clicks reached)

**Billing**:
- Actual clicks delivered: 500
- CPC rate: $0.08
- **Total charge**: $40

**Post-campaign metrics**:
- Impressions: 12,500 (estimated, 4% CTR)
- Clicks: 500
- Conversions: 15 (3% CVR from clicks)
- Transaction value: $1,500 (15 × $100 ATV)
- Merchant revenue: $1,500
- Merchant cost: $40
- **Merchant ROI**: ($1,500 - $40) / $40 = **+3,550% ROI**

**Renewal**: High ROI → recommend renewal with higher click budget (e.g., 1,000 clicks).

---

### Technical Architecture Notes

**Paid campaign storage**:
```sql
CREATE TABLE merchant_paid_campaigns (
    campaign_id UUID PRIMARY KEY,
    merchant_id UUID NOT NULL,
    campaign_type VARCHAR(10) NOT NULL,  -- 'CPI' or 'CPC'
    placement_ids TEXT[] NOT NULL,
    total_budget DECIMAL NOT NULL,
    rate DECIMAL NOT NULL,  -- CPI or CPC rate
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    max_impressions INTEGER,  -- for CPI campaigns
    max_clicks INTEGER,       -- for CPC campaigns
    daily_impression_cap INTEGER,
    created_by UUID,
    created_at TIMESTAMP DEFAULT NOW(),
    status VARCHAR(50) DEFAULT 'scheduled'  -- scheduled, active, paused, expired
);
```

**Delivery tracking** (real-time counters in Redis):
- Key: `paid_campaign:{campaign_id}:impressions` → count
- Key: `paid_campaign:{campaign_id}:clicks` → count
- TTL: 30 days post-campaign

**Campaign pause logic**:
```python
def check_campaign_limits(campaign_id):
    campaign = get_campaign(campaign_id)
    impressions = redis.get(f"paid_campaign:{campaign_id}:impressions")
    clicks = redis.get(f"paid_campaign:{campaign_id}:clicks")

    # CPI campaign: pause if max impressions reached
    if campaign.campaign_type == "CPI" and impressions >= campaign.max_impressions:
        pause_campaign(campaign_id, reason="impression_cap_reached")

    # CPC campaign: pause if max clicks reached
    if campaign.campaign_type == "CPC" and clicks >= campaign.max_clicks:
        pause_campaign(campaign_id, reason="click_cap_reached")

    # Budget check
    if campaign.campaign_type == "CPI":
        spend = impressions * campaign.rate
    else:
        spend = clicks * campaign.rate

    if spend >= campaign.total_budget:
        pause_campaign(campaign_id, reason="budget_depleted")
```

**Paid placement rendering**:
```python
# At impression time
def log_paid_impression(user_id, merchant_id, placement_id, campaign_id):
    # Increment impression counter
    redis.incr(f"paid_campaign:{campaign_id}:impressions")

    # Log event for billing
    log_event("paid_impression", {
        "user_id": user_id,
        "merchant_id": merchant_id,
        "placement_id": placement_id,
        "campaign_id": campaign_id,
        "timestamp": now()
    })

    # Check if campaign limits reached
    check_campaign_limits(campaign_id)
```
