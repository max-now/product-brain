# Phase 1: Placement-Aware Merchant Ranking

Project: https://linear.app/heymax/project/performance-lever-placement-aware-merchant-ranking-403ff2dde2ea/
---
## Problem / Objective

When merchants ask "why is my performance bad, how can I improve it?", we lack systematic levers to help them. Our current ranking system is global (not placement-specific), manual, and inconsistent — making it impossible to deliver merchant performance improvements at scale.

**Core problem**: BD/Ops cannot systematically respond to 100+ merchant performance inquiries with data-driven actions.

**Objective**: Build placement-specific ranking control with clear measurement, enabling systematic merchant performance improvement through exposure management.

---
**What This Enables:**
- "Merchant A performance is low → increase visibility on Earn Home + Deals for 14 days → measure CTR/CVR impact"
- Ops executes with clear SOPs, auto-expiring campaigns
- Product gets visibility into which placements drive conversions for which merchant types
- BD can respond to merchant inquiries with a consistent playbook
---
## What success looks like

**Primary metrics**:
- **CTR uplift per placement**: Measure CTR impact of placement-specific ranking changes (target: establish baseline for future phases)
- **Operational excellence**: 100% of merchant visibility campaigns auto-expire (no manual cleanup)
- **Scale**: BD can respond to merchant inquiries with a consistent playbook (not ad-hoc)

**Secondary metrics**:
- **CVR measurement**: Track CVR per placement to understand which placements drive conversions
- Reduction in ops support requests for ranking changes
- Clear attribution: which placements drive conversions for which merchant types

**Guardrails**:
- No regression in overall platform CVR
- CPA metrics (CTR, CVR) remain primary success signals (ranking changes don't depend on exposure data)

---
## Supporting signals

**Operational friction**:
- Ops doesn't know which merchants are ranked where at any time → double counting
- Manual process without SOP → rankings stay forever until someone remembers to update
- No placement-level control → can't target specific surfaces

**Business need**:
- Need to tie merchant exposure to performance for partnership conversations
- Growing merchant inventory requires scalable ranking logic
- Increasing surface complexity (search, earn, deals, redeem) with different intents

**Foundation for future**:
- Phase 2 (Personalisation) and Phase 3 (Incentives) require understanding placement impact first
- Phase 4 (Paid Ads) requires clear separation of organic vs paid ranking

---
## Data

**Current ranking system**:
- 2 fields: `bd_ranking` (manual, global) and `popularity_ranking` (automated, 30-day transaction volume)
- Default rank: 999999 (lower number = higher rank)
- No time-bound campaigns
- No placement-specific control

**Key surfaces** (see Appendix for full inventory):
- earn home page → popular merchants (popularity sort)
- earn home page → limited time deals (manual, Appsmith)
- deals calendar → current tab (deal end date ASC)
- search bar → default (similar merchants based on history)

---

## Who is this for

### User personas

**Primary**:
- **Ops team**: Needs to execute merchant visibility campaigns with clear SOPs and auto-expiring rules
- **BD team**: Needs to respond to merchant performance inquiries systematically with placement-specific actions

**Secondary**:
- **Product team**: Needs data on which placements drive conversions for which merchant types
- **Merchants/Partners**: Get actionable levers to improve performance (not "wait and see")

---

### Standard Operating Procedure (Draft)

**Use Cases for ranking campaigns**:
- New merchant onboarding: General visibility boost for first 14 days (free tier - no specific rank guarantee, just improved placement within ranking algorithm)
- Merchant performance inquiry: "Why is my performance low?"
- Partner agreement: Contractual visibility commitment
- Seasonal promotions: Boost travel merchants during holiday season

**How to choose placements**:
| Use case | Recommended placements | Duration |
| --- | --- | --- |
| General visibility boost | earn home → popular + deals | 14 days |
| Deal-specific boost | earn home → deals + deals calendar | 7-14 days (aligned with deal expiry) |
| New merchant onboarding | earn home → popular | 14 days |
| Partner agreement | All placements (negotiated) | Contract duration |

**Duration guidelines**:
- **7 days**: Short-term test (new merchant, seasonal)
- **14 days**: Standard visibility boost (most common)
- **30 days**: Partner agreement (contractual)
- **90+ days**: Avoid (manual cleanup risk) — use Phase 3 incentives instead

**Conflict resolution**:
- If two campaigns overlap (same merchant, same placement, overlapping dates):
  - **Rule**: Latest start_date wins
  - **Example**: Campaign A (Jan 1-15), Campaign B (Jan 10-20) → Jan 1-9: A active, Jan 10-20: B active
- Dashboard will warn before creating conflicting campaigns
- Ops can override by confirming conflict modal

**Merchant communication template** (if BD sells visibility):
```
"We're boosting your visibility on [placements] from [start date] to [end date].
You'll appear higher in [section names] during this period.
We'll measure CTR/CVR impact and share results after the campaign ends."
```

---

## Core Hypothesis

This phase hinges on the hypothesis that **increasing a merchant's ranking within the application increases visibility, which subsequently increases CTR (Click-Through Rate) and CVR (Conversion Rate)**.

More details about experiment listed in the ticket.

**Phase 1 measurement focus:**
- Establish baseline CTR/CVR per placement (pre-campaign)
- Track CTR/CVR uplift during ranking campaigns (treatment vs control)
- Identify which placements have strongest visibility → conversion correlation
- Document which merchant types benefit most from ranking boosts (informs Phase 2 personalisation)

---

## Product requirements
| # | User story | Acceptance criteria |
| --- | --- | --- |
| 1 | As an Ops team member, I want to upsize a merchant's ranking in specific sections for a fixed time period | Ops can select: Merchant, Section(s), Start date, End date\n- Ranking upsize automatically expires at end time\n- No engineering intervention required\n- Changes visible in ops dashboard |
| 2 | As a BD team member, I want confidence that a sold deal maps clearly to in-app visibility | Each deal references: Sections included, Duration\n- Ops can verify active placements in-app\n- No ambiguity on where the merchant appears\n- Merchant sees consistent exposure per agreement |
| 3 | As a Product team member, I want ranking logic to remain CPA-safe | Ranking changes do not depend on exposure data\n- CPA metrics (CTR, CVR) remain primary success signals\n- No paid placement logic influences conversion attribution |
| 4 | As an Ops team member, I want to see all active and scheduled ranking campaigns | Dashboard shows: Active campaigns, Scheduled campaigns, Expired campaigns\n- Can filter by merchant, section, date range\n- Can edit or cancel scheduled campaigns |
| 5 | As a Product team member, I want to measure CTR/CVR impact per placement for ranking changes | Statsig/Sundial tracks CTR/CVR by placement\n- Can compare before/after metrics for ranking changes\n- Data feeds into "which placements work for which merchants" insights |

---
## Audit tracking
| Event name | Event attributes | Description |
| --- | --- | --- |
| merchant_ranking_campaign_created | merchant_id, \nplacement_ids[], \nstart_date, \nend_date, \ncreated_by | Ops creates a time-bound ranking campaign |
| merchant_ranking_campaign_started | merchant_id, \nplacement_ids[], \ncampaign_id | Campaign goes live |
| merchant_ranking_campaign_expired | merchant_id, \nplacement_ids[], \ncampaign_id | Campaign auto-expires |
| merchant_impression \n(to sync with cpi enablement project) | merchant_id, \nplacement_id, \nrank_position, \nuser_id, \ntimestamp | Merchant shown to user at specific placement and rank |
| merchant_click\n(to sync with cpi enablement project) | merchant_id, \nplacement_id, \nrank_position, \nuser_id, \ntimestamp | User clicks merchant from specific placement |

**Note**: `merchant_impression` and `merchant_click` events enable CTR/CVR measurement per placement.

---

## Measurement Plan

### Baseline Capture (Pre-Launch)
**Timeline**: 2-4 weeks before Phase 1 launch

**Metrics to capture**:
- CTR per placement (baseline)
- CVR per placement (baseline)
- Merchant rank distribution (how many merchants at rank 1-10, 11-50, 51+)
- Ops team time spent on manual ranking changes (survey)

**Tools**:
- Statsig: Create experiment groups (control vs treatment)
- Sundial: CTR/CVR dashboard per placement
- Ops survey: Manual effort baseline (hours per week on ranking changes)

---

### Reporting Cadence

**Weekly** (during pilot and first month):
- Active campaign count
- Auto-expiry success rate (target: 100%)
- CTR/CVR by placement (treatment vs control)

**Monthly** (post-launch):
- Placement performance report (which placements drive CVR)
- Merchant type analysis (which merchant categories benefit most from ranking boosts)
- Ops efficiency gain (time saved vs baseline)
- Conflict rate (how often campaigns overlap)

**Quarterly**:
- ROI analysis: BD conversions from merchant performance playbook
- Learnings for Phase 2 (which placements to prioritize for personalisation)

---

### Alert Thresholds

**Immediate rollback triggers**:
- Platform CVR drops >5% (compared to 7-day baseline)
- Placement CVR drops >10% for any pilot placement
- Auto-expiry failure rate >5% (campaigns not expiring on time)

**Warning alerts** (investigate, don't rollback):
- CTR variance >15% week-over-week (could indicate ranking issues)
- Ops creating >20 campaigns/week (may indicate tooling friction)
- Conflict rate >10% (campaigns overlapping frequently)

**Who gets alerted**:
- Immediate rollback: Product lead, Engineering on-call, Ops lead
- Warning alerts: Product lead, Data analyst

**Alert delivery**:
- Statsig alerts (configured thresholds)
-  channel: `#performance````````````-levers-monitoring`
- PagerDuty for rollback triggers (if outside business hours)

---

## User Flows

### Flow 1: Ops Creates Campaign (Happy Path)

```
1. Ops receives merchant inquiry from BD: "Merchant A wants higher visibility"
2. Ops opens Campaign Management Dashboard
3. Clicks "Create Campaign"
4. Searches for Merchant A (dropdown autocomplete)
5. Selects placements:
   ☑ earn home → popular merchants
   ☑ earn home → limited time deals
6. Sets dates: Jan 20 - Feb 3 (14 days)
7. Reviews preview panel:
   - Current rank: earn home popular = 8, deals = 12
   - Projected rank: earn home popular = 2, deals = 3
   - No conflicts detected ✓
8. Clicks "Create Campaign"
9. Success message: "Campaign created. Merchant A will be boosted on 2 placements from Jan 20-Feb 3."
10. Campaign appears in "Scheduled" tab
11. Jan 20 arrives → Campaign auto-starts (status: Active)
12. Feb 3 arrives → Campaign auto-expires (status: Expired)
13. Ops confirms auto-expiry in dashboard
```

---

### Flow 2: Ops Creates Campaign (Conflict Resolution)

```
1. Ops opens "Create Campaign" form
2. Selects Merchant B
3. Selects placement: earn home → popular merchants
4. Sets dates: Jan 25 - Feb 8
5. Preview panel shows warning:
   ⚠️ "Merchant B already has campaign on earn home → popular from Jan 20 - Feb 5"
6. Conflict modal appears:
   "Overlapping campaign detected:
    - Existing: Jan 20 - Feb 5
    - New: Jan 25 - Feb 8

    Resolution: Latest campaign (Jan 25 start) will override from Jan 25 onward.
    Jan 20-24: Existing campaign active
    Jan 25-Feb 8: New campaign active

    [Cancel] [Override and Create]"
7. Ops clicks "Override and Create"
8. Campaign created with warning badge in dashboard
9. Jan 25 arrives → New campaign takes over (existing campaign still shows in history)
```

---

### Flow 3: BD Responds to Merchant Inquiry

```
1. Merchant emails BD: "Why is my CTR low? How can I improve?"
2. BD opens internal playbook (Phase 1 SOP)
3. BD checks merchant's current ranking:
   - Opens Merchant Ranking Visibility Dashboard
   - Searches for merchant
   - Sees: earn home popular = rank 15, deals = rank 20
4. BD assesses placement recommendation:
   - Merchant is in "travel" category
   - Recommendations: earn home popular + deals (14-day boost)
5. BD drafts response to merchant:
   "We'll boost your visibility on Earn Home and Deals for 14 days.
    You'll rank higher during this period. We'll measure CTR/CVR impact and share results."
6. BD forwards request to Ops with details:
   - Merchant: [Name]
   - Placements: earn home popular, earn home deals
   - Duration: Jan 20 - Feb 3
   - Reason: Performance improvement campaign
7. Ops creates campaign (Flow 1)
8. After campaign ends, Product shares CTR/CVR results with BD
9. BD follows up with merchant: "Your CTR increased 12% during the boost. Here's the data."
```

---

### Flow 4: Product Reviews Placement Performance

```
1. Product opens Statsig experiment: "Phase 1 Placement Ranking"
2. Reviews CTR/CVR by placement (treatment vs control):
   - earn home → popular: CTR +8%, CVR +3%
   - earn home → deals: CTR +15%, CVR +5%
   - deals calendar: CTR +5%, CVR +1%
3. Insight: "Deals placement drives highest conversion uplift"
4. Product documents findings for Phase 2:
   - Prioritize "earn home → deals" for personalisation (Phase 2A)
   - "Deals calendar" may benefit from intent-based ranking (Phase 2B)
5. Product shares learnings in weekly sync with Ops/BD
6. Ops adjusts SOP: "For deal-heavy merchants, prioritize deals placements"
```

---

## FAQs

**Q: How does this differ from the current manual ranking?**
A: Current ranking is global (applies everywhere), manual (Appsmith field), and permanent (until someone remembers to change it). Phase 1 adds placement-specific control, time-bound campaigns, and auto-expiry.

**Q: What happens if two campaigns conflict (same merchant, same placement)?**
A: Latest start_date wins. Ops dashboard will warn about conflicts when scheduling.

**Q: Can merchants see this dashboard?**
A: No, this is internal tooling for Ops/BD. Merchants see results (improved visibility) but not the controls.

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Ops overwhelmed with campaign management complexity | H | Clear SOP, simple UI, auto-expiry default. Training before launch. |
| Ranking changes hurt overall CVR | H | Statsig monitoring per placement. Guardrail alerts if platform CVR drops. Phase 1 stays CPA-safe (no exposure-dependent logic). |
| Merchants demand guaranteed impressions we can't deliver | M | Clear communication: Phase 1 = ranking control, not impression guarantees. Impression packages come in Phase 4 (with 4.6). |
| Engineering effort underestimated | M | Start with 2-3 pilot placements (earn home, deals). Expand after validation. |
| Conflicts between campaigns (same merchant, same placement) | M | Dashboard warns on conflicts. Clear conflict resolution rule (latest start_date wins). |
| Merchant deleted/deactivated during active campaign | L | Campaign auto-cancels if merchant deactivated. Ops notified via dashboard alert. |
| Placement logic changes (e.g., popularity sort algorithm updated) | M | Ranking campaigns use absolute rank position (not algorithm-dependent). If placement logic changes, campaigns continue with adjusted baseline. |
| Merchant has no deals live during campaign period | L | Campaign still applies (ranking boost). Ops can check deal status in preview panel before creating campaign. |
| BD schedules campaigns directly (bypassing Ops) | M | Phase 1: Only Ops has dashboard access. Phase 2 may add BD read-only view. Prevents unauthorized changes. |

---

## What We Are Explicitly *Not* Doing in Phase 1

- No personalised ranking (Phase 2)
- No incentive levers like miles boosters (Phase 3)
- No paid ads / CPI / CPC (Phase 4)
- No real-time bidding
- No advertiser self-serve
- No impression guarantees (comes with Phase 4 + Impression Infrastructure)

---

## Phase 2 Readiness: Infrastructure Considerations

**Critical**: Phase 1 infrastructure must support Phase 2's personalisation and intent-based ranking without major refactoring.

### Phase 2A: Personalisation Requirements

**What Phase 1 must enable**:
1. **Ranking query extensibility**:
  - Phase 1: `get_merchants(placement_id)` → returns ranked list
  - Phase 2A needs: `get_merchants(placement_id, user_id)` → personalised ranked list
  - **Action**: Design ranking query to accept optional `user_id` parameter (default: None)

2. **Campaign priority preservation**:
  - Phase 2A: "Phase 1 campaigns (committed visibility) take priority. Personalisation adjusts remaining slots."
  - **Action**: `merchant_ranking_campaigns` table must have `priority` field (default: 1000 = highest)
  - Ranking logic: `ORDER BY campaign_priority DESC, affinity_score DESC, bd_ranking, popularity_ranking`

3. **User-merchant affinity scoring**:
  - Phase 2A needs to build a merchant affinity score based on user's transaction history, subsequently creating user cohorts based on a bundle of interested intent categories / merchants and shuffling exposure to user and capturing the CTR and CVR uplift.
    - see previously ran HPFY experiment for potential tests for this

---

### Phase 2B: Intent-Based Exposure Requirements

**What Phase 1 must enable**:
1. **Intent parameter in ranking query**:
  - Phase 2B needs: `get_merchants(placement_id, user_id, intent_category)`
  - **Action**: Ranking query should accept optional `intent_category` parameter (default: None)
  - Phase 1 ignores this param, Phase 2B uses it for intent-specific ranking strategies

2. **Placement-intent mapping**:
  - Phase 2B: "Each placement tagged with primary intent"
  - **Action**: Phase 1's `placement_inventory` (Appendix) should include `intent_category` column
  - Example: earn home popular = "browse", deals calendar = "deals"
  - This mapping informs Phase 2B's intent detection logic

3. **Session context tracking**:
  - Phase 2B: "Session entry point detection (search bar, earn home, deals calendar)"
  - **Action**: Phase 1 events should include `session_id` and `entry_point` (if not already tracked)
  - Enables Phase 2B to detect intent from session behavior

---

### Phase 1 Schema Additions for Phase 2 Compatibility

**`merchant_ranking_campaigns`**** table** (Phase 1):
```python
campaign_id: UUID (PK)
merchant_id: UUID (FK)
placement_ids: Array[UUID]  # Multi-placement support
start_date: DateTime
end_date: DateTime
created_by: UUID (ops user)
status: Enum (scheduled, active, expired)
priority: Integer (default: 1000)  # Phase 2: personalisation = 500, Phase 1 campaigns = 1000
campaign_type: Enum (manual, personalised, intent_based)  # Phase 1 = manual, Phase 2 adds others
boost_type: Enum (general_boost, top_n_placement, specific_rank)  # Ranking strategy: general_boost (free tier, relative improvement), top_n_placement (e.g., "top 20"), specific_rank (exact position - takes priority)
boost_value: Integer (nullable)  # For specific_rank (exact position) or top_n_placement (e.g., 20 for "top 20"). Null for general_boost
featured_tag_enabled: Boolean (default: false)  # Show "Featured" tag in UI if no upsize promotion
upsize_tag_enabled: Boolean (default: false)  # Show upsize tag in UI if merchant has upsize promotion
```

**`placement_inventory`**** table** (Phase 1):
```python
placement_id: UUID (PK)
placement_name: String  # e.g., "earn_home_popular"
display_name: String  # e.g., "Earn Home → Popular Merchants"
current_ranking_logic: String  # e.g., "bd_ranking, popularity_ranking"
owner: String  # Team responsible
intent_category: Enum (browse, deals, search, redeem, quick_action)  # Phase 2B uses this
is_pilot: Boolean  # Phase 1 pilots only a few placements
```

**Ranking query signature** (Phase 1, extensible for Phase 2):
```python
def get_merchants(
    placement_id: UUID,
    user_id: UUID = None,           # Phase 2A: personalisation
    intent_category: str = None,    # Phase 2B: intent-based
    experiment_group: str = None    # A/B testing
) -> List[Merchant]:
    # Phase 1: ignores user_id, intent_category
    # Phase 2A: includes user affinity scores
    # Phase 2B: applies intent-specific strategies
    pass
```

---

### Phase 2 Rollout Plan (Enabled by Phase 1)

**Phase 2A: Personalisation** (3-6 months after Phase 1 launch)
- Prerequisite: Phase 1 placement-specific ranking live, baseline metrics captured
- No schema changes needed (uses Phase 1's extensible query)
- Ops dashboard shows: "Campaign Priority: Manual (Phase 1) vs Personalised (Phase 2A)"

**Phase 2B: Intent-Based Exposure** (6-9 months after Phase 1 launch)
- Prerequisite: Phase 2A live, intent taxonomy defined
- Uses Phase 1's `placement_inventory.intent_category` mapping
- No breaking changes to Phase 1 campaigns (intent-based ranking applies to non-campaign slots)

---

## Launch Checklist

### Pre-Launch (4 weeks before)
- [ ] **Placement inventory finalised** with owners (see Appendix)
- [ ] **Baseline metrics captured** (2-4 weeks of CTR/CVR per placement)
- [ ] **Ops SOP documented** (when to use, placement selection, duration guidelines)
- [ ] **BD playbook documented** (merchant inquiry → placement recommendation → results sharing)
- [ ] **Schema changes deployed**:
  - [ ] `merchant_ranking_campaigns` table created
  - [ ] `placement_inventory` table created (with `intent_category` for Phase 2)
  - [ ] Ranking query refactored to accept `placement_id, user_id (optional), intent_category (optional)`

### Engineering Build (2-3 weeks)
- [ ] **Time-bound campaign functionality**:
  - [ ] Campaign creation API (POST `/campaigns`)
  - [ ] Auto-expiry cron job (runs every 5 mins, marks expired campaigns)
  - [ ] Campaign management API (GET/PUT/DELETE `/campaigns/:id`)
- [ ] **Frontend tooling**:
  - [ ] Campaign creation form (merchant search, placement multi-select, date pickers, preview panel)
  - [ ] Campaign management dashboard (Active/Scheduled/Expired tabs, filters, bulk actions)
  - [ ] Merchant ranking visibility dashboard (merchant-centric + placement-centric views)
  - [ ] Conflict detection warnings (real-time validation)
- [ ] **Events tracking**:
  - [ ] `merchant_ranking_campaign_created/started/expired` events (BigQuery/Segment)
  - [ ] `merchant_impression` and `merchant_click` events include `placement_id, rank_position, user_id, session_id`
- [ ] **Measurement setup**:
  - [ ] Statsig experiment configured (treatment: Phase 1 ranking, control: baseline)
  - [ ] Sundial dashboard for CTR/CVR per placement
  - [ ] Alert thresholds configured (CVR drop >5% = rollback trigger)

### Testing & Training (1 week before launch)
- [ ] **UAT with Ops team** (3-5 test campaigns created, verified auto-expiry)
- [ ] **Training completed**:
  - [ ] Ops: Dashboard walkthrough, SOP review, conflict resolution practice
  - [ ] BD: Playbook training, merchant communication templates
  - [ ] Product: How to read Statsig reports, alert escalation process
- [ ] **Rollback plan documented**:
  - [ ] Rollback trigger: CVR drop >5% or auto-expiry failure >5%
  - [ ] Rollback action: Disable Phase 1 ranking query, revert to baseline
  - [ ] Rollback owner: Engineering on-call + Product lead

### Pilot Phase (2 weeks)
- [ ] **Pilot merchants selected** (3-5 merchants):
  - [ ] Mix of categories (travel, dining, retail)
  - [ ] Mix of current ranking (high-performing + low-performing)
- [ ] **Pilot placements** (2-3 placements):
  - [ ] earn home → popular merchants
  - [ ] earn home → limited time deals
  - [ ] deals calendar → current tab (optional)
- [ ] **Pilot campaigns created**:
  - [ ] 3-5 campaigns scheduled (7-14 day duration)
  - [ ] Auto-expiry verified (campaigns end on time, no manual cleanup)
  - [ ] CTR/CVR uplift measured (comparison vs baseline)
- [ ] **Ops feedback collected** (survey: tooling usability, SOP clarity, conflict handling)

### Post-Pilot (Expand or Rollback)
- [ ] **Success criteria met**:
  - [ ] Auto-expiry success rate = 100%
  - [ ] Ops adoption rate >80% (using dashboard vs Appsmith)
  - [ ] No platform CVR regression (guardrail)
  - [ ] Positive Ops feedback (>4/5 satisfaction score)
- [ ] **If success → Expand**:
  - [ ] Roll out to all merchants (remove pilot restrictions)
  - [ ] Add more placements (search, redeem, etc.)
  - [ ] Document learnings for Phase 2
- [ ] **If failure → Rollback**:
  - [ ] Disable Phase 1 ranking query (revert to baseline)
  - [ ] Postmortem: What went wrong? (tooling bugs, SOP gaps, measurement issues)
  - [ ] Iterate and re-pilot

---

## Dependencies

### Internal
- **Impression Infrastructure (4.6)**: Not required for Phase 1, but Phase 1 events (`merchant_impression`) will feed into 4.6 when ready
- **CPI Enablement Project**: Phase 1 event schema should align (same `merchant_impression` and `merchant_click` events)
- **Statsig/Sundial setup**: Required for measurement (Owner: Data team)
- **Appsmith deprecation**: Phase 1 replaces manual ranking in Appsmith (Owner: Ops team)

### External
- **None** (Phase 1 is fully internal, no merchant-facing changes)

### Cross-Functional
- **Ops team**: UAT, training, pilot execution (Owner: Ops lead)
- **BD team**: Playbook adoption, merchant communication (Owner: BD lead)
- **Data team**: Statsig experiment, Sundial dashboard, alert setup (Owner: Data analyst)
- **Design**: Wireframes for dashboard UI (Owner: Product designer)

---

## Appendix

### Current Ranking System

The system uses a **multi-layered ranking** with two primary fields:

| Field | Type | Description | Default |
| --- | --- | --- | --- |
| `bd_ranking` | Manual | Set by BD/Ops team (highest priority) | 999999 |
| `popularity_ranking` | Automated | Calculated from transaction volume (30-day lookback) | 999999 |

**Ranking Priority Order:**
1. **BD Ranking** (manual, highest priority) — strategic partnerships
2. **Popularity Ranking** (transaction-based) — actual transaction volumes
3. **Best Ranking** (materialized view) — combining affiliate/voucher rankings

**Current Issues**:
- BD ranking is **global** — applies to all surfaces, no placement-level control
- No time-bound campaigns — manual cleanup required
- No visibility into which placements a merchant appears on
- No SOP — inconsistent execution across Ops team

### Placement Inventory

| App Page → Section | Current Ranking Logic | Controls | Owner |
| --- | --- | --- | --- |
| earn home page → popular merchants | popularity sort | TBD |  |
| earn home page → limited time deals | manual | Appsmith Merchant Record |  |
| deals calendar → current tab | deal end date ASC | N/A |  |
| deals calendar → upcoming tab | deal start date ASC (up to 7 days) | N/A |  |
| search bar - default | similar merchants based on past search history | N/A |  |
| earn home page → marketing banner | manual | [Statsig config](https://console.statsig.com/3lQdicUjsoYYdZG5M4H2YC/dynamic_configs/app_v2_earn_carousel) |  |

**Phase 1 pilot placements** (to be finalised):
- earn home page → popular merchants
- earn home page → limited time deals
- deals calendar → current tab

### Technical Notes

**Database fields** (existing):
```python
popularity_ranking: Mapped[int] = mapped_column(
    INTEGER, nullable=False, index=True, default=999999
)
bd_ranking: Mapped[int] = mapped_column(
    INTEGER, nullable=False, index=True, default=999999
)
```

**New schema needed**:

**`merchant_ranking_campaigns`**** table**:
```sql
CREATE TABLE merchant_ranking_campaigns (
    campaign_id UUID PRIMARY KEY,
    merchant_id UUID NOT NULL REFERENCES merchants(id),
    placement_ids UUID[] NOT NULL,  -- Array of placement IDs (multi-placement support)
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    status VARCHAR(20) NOT NULL DEFAULT 'scheduled',  -- scheduled, active, expired, cancelled
    priority INTEGER DEFAULT 1000,  -- Phase 1 = 1000, Phase 2A personalisation = 500
    campaign_type VARCHAR(20) DEFAULT 'manual',  -- manual, personalised, intent_based
    boost_type VARCHAR(20) NOT NULL DEFAULT 'general_boost',  -- general_boost (free tier), top_n_placement (e.g., "top 20"), specific_rank (exact position - takes priority over other types)
    boost_value INTEGER,  -- For specific_rank (exact position) or top_n_placement (e.g., 20 for "top 20"). Null for general_boost
    featured_tag_enabled BOOLEAN DEFAULT FALSE,  -- Show "Featured" tag in UI if no upsize promotion
    upsize_tag_enabled BOOLEAN DEFAULT FALSE,  -- Show upsize tag in UI if merchant has upsize promotion
    INDEX idx_merchant_placement (merchant_id, placement_ids),
    INDEX idx_status_dates (status, start_date, end_date)
);
```

**`placement_inventory`**** table** (for Phase 2 readiness):
```sql
CREATE TABLE placement_inventory (
    placement_id UUID PRIMARY KEY,
    placement_name VARCHAR(100) NOT NULL,  -- e.g., "earn_home_popular"
    display_name VARCHAR(200) NOT NULL,  -- e.g., "Earn Home → Popular Merchants"
    current_ranking_logic TEXT,  -- e.g., "bd_ranking, popularity_ranking"
    owner VARCHAR(100),  -- Team responsible
    intent_category VARCHAR(50),  -- browse, deals, search, redeem (Phase 2B uses this)
    is_pilot BOOLEAN DEFAULT FALSE,  -- Phase 1 pilots only a few placements
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

**Phase 1 approach**: Keep `bd_ranking` global (no breaking changes), but ranking query filters by `placement_id` and checks active campaigns in `merchant_ranking_campaigns` table. If merchant has active campaign for placement → apply boost based on `boost_type`:
- **specific\_rank**: Override to exact position specified in `boost_value` (highest priority)
- **top\_n\_placement**: Ensure merchant appears within top N (e.g., top 20) using relative boost
- **general\_boost**: Apply relative ranking improvement without guaranteeing specific position (free tier)

**Ranking query logic** (from `merchant_manager.py:642-647`):

**Current (baseline)**:
```python
query = query.order_by(
    RMerchant.bd_ranking,           # 1st priority: BD ranking (global)
    RMerchant.popularity_ranking,   # 2nd priority: Popularity ranking
    MerchantExploreData.best_ranking, # 3rd priority: Best ranking
)
```

**Phase 1 (placement-specific campaigns)**:
```python
def get_merchants(
    placement_id: UUID,
    user_id: UUID = None,           # Phase 2A: personalisation (ignored in Phase 1)
    intent_category: str = None,    # Phase 2B: intent-based (ignored in Phase 1)
    experiment_group: str = None    # A/B testing
) -> List[Merchant]:
    # Check for active campaigns at this placement
    active_campaigns = get_active_campaigns(placement_id, now())

    # Build ranking query with boost type logic
    query = query.order_by(
        CASE(
            # Specific rank takes highest priority (paid tier)
            WHEN merchant_id IN active_campaigns AND campaign.boost_type == 'specific_rank'
                THEN campaign.boost_value,
            # Top N placement: apply boost to ensure top N (e.g., top 20)
            WHEN merchant_id IN active_campaigns AND campaign.boost_type == 'top_n_placement'
                THEN calculate_top_n_boost(campaign.boost_value, RMerchant.bd_ranking),
            # General boost: relative improvement without specific position guarantee (free tier)
            WHEN merchant_id IN active_campaigns AND campaign.boost_type == 'general_boost'
                THEN RMerchant.bd_ranking * 0.5,  # Example: 50% improvement
            ELSE RMerchant.bd_ranking
        ),                          # 1st priority: Campaign ranking (placement-specific, boost_type-aware)
        RMerchant.bd_ranking,       # 2nd priority: BD ranking (global fallback)
        RMerchant.popularity_ranking, # 3rd priority: Popularity ranking
        MerchantExploreData.best_ranking # 4th priority: Best ranking
    )

    return query.all()

def get_active_campaigns(placement_id: UUID, current_time: datetime) -> Dict[UUID, Campaign]:
    """Returns {merchant_id: campaign} for active campaigns at placement"""
    campaigns = db.query(MerchantRankingCampaigns).filter(
        placement_id IN MerchantRankingCampaigns.placement_ids,
        MerchantRankingCampaigns.start_date <= current_time,
        MerchantRankingCampaigns.end_date >= current_time,
        MerchantRankingCampaigns.status == 'active'
    ).all()

    return {c.merchant_id: c for c in campaigns}

def calculate_top_n_boost(target_n: int, current_rank: int) -> int:
    """Calculate boost value to ensure merchant appears in top N"""
    # If already in top N, maintain position; otherwise boost to edge of top N
    return min(current_rank, target_n)
```

**Phase 2A extension (personalisation)**:
```python
# Same query, but includes user affinity scores
query = query.order_by(
    campaign_ranking,               # Phase 1: placement campaigns (highest priority)
    affinity_adjusted_ranking,      # Phase 2A: bd_ranking + affinity_score
    RMerchant.popularity_ranking
)
```

**Phase 2B extension (intent-based)**:
```python
# Same query, but applies intent-specific strategies
query = query.order_by(
    campaign_ranking,               # Phase 1: placement campaigns
    intent_adjusted_ranking,        # Phase 2B: affinity + intent strategy (e.g., high-CVR for search)
    RMerchant.popularity_ranking
)
```

---

## Frontend Requirements

### Campaign Scheduling UI

**Purpose**: Enable Ops to create, manage, and monitor time-bound merchant ranking campaigns across placements.

#### 1. Campaign Creation Form
**Required fields**:
- **Merchant selection**: Searchable dropdown (by name or ID)
- **Placement selection**: Multi-select checkboxes
  - earn home → popular merchants
  - earn home → limited time deals
  - deals calendar → current tab
  - (expandable to other placements post-pilot)
- **Boost type**: Radio buttons
  - General boost (free tier - relative improvement, no specific position guarantee)
  - Top N placement (e.g., "top 20" - ensures appearance in top N)
  - Specific rank (paid tier - exact position, takes priority)
- **Boost value**: Integer input (required for top_n_placement and specific_rank, disabled for general_boost)
- **Tag configuration**: Checkboxes
  - ☐ Show "Featured" tag (only if merchant has no upsize promotion)
  - ☐ Show upsize tag (only if merchant has upsize promotion)
- **Date range**: Start date/time, End date/time (datetime pickers)
- **Preview panel**:
  - Shows current rank for selected merchant at each placement
  - Shows projected rank during campaign period (based on boost_type)
  - Warning if merchant already has active/scheduled campaign at selected placement

**Conflict detection**:
- Real-time validation: if merchant + placement combination already has campaign during date range
- Warning modal: "Merchant A already has campaign on [placement] from [date range]. Latest campaign will override. Continue?"
- Conflict resolution rule: **Latest start\_date wins** (overlapping campaigns prioritize by start_date DESC)

**Actions**:
- Create campaign (saves to `merchant_ranking_campaigns` table)
- Preview before confirm
- Cancel

**Wireframe requirements** (to be created):
- Form layout (left: inputs, right: preview panel)
- Conflict warning modal
- Success confirmation state

---

#### 2. Campaign Management Dashboard

**Views**:
- **Active tab**: Campaigns currently live (start_date ≤ now ≤ end_date)
- **Scheduled tab**: Campaigns not yet started (start_date > now)
- **Expired tab**: Campaigns past end_date (auto-archived after 30 days)

**Table columns**:
| Column | Description | Sortable |
| --- | --- | --- |
| Merchant | Name + ID | Yes |
| Placements | Comma-separated list (with count badge) | No |
| Boost Type | General / Top N / Specific Rank (with badge color: gray/blue/gold) | Yes |
| Boost Value | N/A for general boost, number for top N/specific rank | No |
| Tags | Featured / Upsize badges if enabled | No |
| Start Date | YYYY-MM-DD HH:mm | Yes |
| End Date | YYYY-MM-DD HH:mm | Yes |
| Status | Active / Scheduled / Expired | Yes |
| Created By | Ops user who created campaign | Yes |
| Actions | Edit / Cancel / Duplicate | No |

**Filters**:
- Merchant (search by name/ID)
- Placement (multi-select)
- Date range (created date or active date)
- Created by (dropdown of Ops users)

**Actions**:
- **Edit**: Only for scheduled campaigns (not yet started)
- **Cancel**: Immediately ends active campaign or removes scheduled campaign
- **Duplicate**: Pre-fills form with campaign details (change dates)
- **Bulk cancel**: Select multiple campaigns → cancel all

**Wireframe requirements**:
- Dashboard table layout
- Filter panel (collapsible sidebar)
- Action dropdown menu per row

---

#### 3. Merchant Ranking Visibility Dashboard

**Purpose**: Show Ops where merchants currently rank at each placement (for informed scheduling decisions).

#### View 1: Merchant-Centric Report
**User flow**: "Where does Merchant X rank right now?"

**Inputs**:
- Search merchant by name or ID

**Output table**:
| Placement | Current Rank | Active Campaign | Next Scheduled Change | Historical Trend (30d) |
| --- | --- | --- | --- | --- |
| earn home → popular | 5 | Yes (ends Jan 25) | None | Sparkline chart |
| earn home → deals | 12 | No | Jan 30 (rank → 3) | Sparkline chart |
| deals calendar | 999999 | No | None | — |

**Additional features**:
- "Create Campaign" button (pre-fills merchant in creation form)
- Export to CSV
- Historical rank chart (line graph, last 30 days, per placement)

---

#### View 2: Placement-Centric Report
**User flow**: "Who's ranked where on [placement] right now?"

**Inputs**:
- Select placement (dropdown)
- Optional: Show only top N merchants (default 50)

**Output table**:
| Rank | Merchant | Active Campaign | Campaign Expiry | Actions |
| --- | --- | --- | --- | --- |
| 1 | Merchant A | Yes | Jan 25 | View details |
| 2 | Merchant B | No | — | Create campaign |
| 3 | Merchant C | Yes (scheduled) | Starts Jan 30 | View details |
| ... | ... | ... | ... | ... |

**Features**:
- Highlight merchants with active campaigns (badge or row color)
- "Simulate campaign" button:
  - Select merchant → input campaign dates → see projected rank change
  - Preview: "If Merchant D is boosted from Jan 20-30, rank will change from 15 → 5"

---

#### 4. Point-of-Scheduling Context Panel

**Embedded in Campaign Creation Form (right sidebar)**

**Real-time preview while Ops selects merchant + placements**:
```
┌─ Context Panel ─────────────────────────┐
│ Merchant: [Selected Merchant Name]     │
│                                          │
│ Current Rankings:                        │
│ • earn home → popular: Rank 8           │
│ • earn home → deals: Rank 12            │
│                                          │
│ Active Campaigns at Selected Placements: │
│ • earn home → popular:                   │
│   - Merchant E (Jan 15-25)              │
│   - Merchant F (Jan 20-30) ⚠️ Conflict  │
│                                          │
│ Projected Impact:                        │
│ • earn home → popular: Rank 8 → 2       │
│ • earn home → deals: Rank 12 → 3        │
└──────────────────────────────────────────┘
```

**Features**:
- Updates dynamically as Ops selects merchant/placements/dates
- Warning icon for conflicts
- Estimated rank change (based on current `bd_ranking` boost logic)
