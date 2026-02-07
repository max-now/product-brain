# Placement Prioritization for Impression Infrastructure

## Strategic Context

Impression tracking unlocks the Performance Levers initiative:
- **Phase 1 (Exposure):** Requires baseline CTR/CVR per placement to validate H1/H2
- **Phase 2 (Relevancy):** Requires intent-category mapping for personalisation

> Core equation: **Exposure × Relevancy × Incentive = Conversion**
> We can't optimize what we don't measure.

---

## Prioritisation Framework

### Scoring Criteria
| Criterion | Weight | Description |
| --- | --- | --- |
| **Volume** | 30% | Expected impressions/day (proxy for data velocity) |
| **Conversion Signal** | 30% | Strength of intent signal for CTR/CVR measurement |
| **Phase 1 Value** | 25% | Directly tests H1/H2 (exposure → CTR) |
| **Phase 2 Value** | 15% | Enables intent-based or personalised ranking |

### Value Unlock Matrix

```
                    Phase 1 Value (Exposure)
                    Low         High
Phase 2 Value  ┌──────────┬──────────┐
(Relevancy)    │          │          │
    High       │  Tier 2  │  Tier 1  │ ← Prioritize
               │          │          │
               ├──────────┼──────────┤
    Low        │  Tier 4  │  Tier 3  │
               │          │          │
               └──────────┴──────────┘
```

---

## Tier 1: Critical Path (Weeks 1-2)
> High volume + Strong conversion signal + Unlocks both Phase 1 & 2

These placements are **required for baseline measurement** and directly inform ranking experiments.

| Placement | Volume | Why Critical | Phase 1 Value | Phase 2 Value |
| --- | --- | --- | --- | --- |
| **Explore Intent Category Tabs** (16 placements) | High | Primary discovery surface; 16 intent categories = Phase 2 segmentation | Baseline CTR per category | Intent-based ranking test bed |
| **Search Results** | High | Highest intent signal | Search → CTR correlation | Intent = "search" (high CVR) |
| **Merchant Detail Page** | High | Last-mile conversion | CTR → CVR funnel | Personalised recommendations |
| **Home Top Banner Carousel** | High | High visibility promo placement | Banner CTR baseline | Campaign effectiveness |
| **Deals Calendar** | High | Time-sensitive intent | Deal CTR by urgency | Intent = "deals" |

**What this unlocks:**
- ✅ Baseline CTR/CVR per placement
- ✅ Validates whether rank position affects CTR (H1/H2)
- ✅ Intent category mapping for Phase 2B
- ✅ 60-70% of expected impression volume

### Implementation Priority Within Tier 1

```
Week 1:
1. explore_shop          ← Highest volume intent category
2. explore_deals         ← Deal-focused users (urgency)
3. earn_browse_all       ← Primary merchant discovery
4. search_merchants      ← Highest intent signal

Week 2:
5. merchant_detail_*     ← Conversion funnel completion
6. explore_food          ← High engagement category
7. explore_travel        ← High-value transactions
8. explore_groceries     ← Frequent usage category
```

---

## Tier 2: Phase 2 Enablers (Weeks 3-4)
> Moderate volume + Strong Phase 2 value (intent/personalisation signals)

| Placement | Volume | Why Important | Phase 1 Value | Phase 2 Value |
| --- | --- | --- | --- | --- |
| **Transaction History** (Miles + Cards) | High | Repeat visit surface; retention signal | CTR on return visits | Transaction-based affinity |
| **Voucher Sections** | High | Purchase intent signal | Voucher CTR → purchase | High-intent segment |
| **Bookmarks** | Medium | Explicit user intent signal | Saved → convert rate | User preference signal |
| **Earn Tab Browse All** | Very High | Main earning CTA; high intent surface | Core exposure metric | User affinity signals |

**What this unlocks:**
- ✅ User affinity scoring inputs (transaction history)
- ✅ Intent detection signals (bookmarks = consideration stage)
- ✅ Time-sensitive exposure effectiveness
- ✅ Phase 2 personalisation training data

---

## Tier 3: Conversion Depth (Weeks 5-6)
> Lower volume but strong conversion signal for specific use cases

| Placement | Volume | Why Important | Phase 1 Value | Phase 2 Value |
| --- | --- | --- | --- | --- |
| **Card Reward Recommendations** | Medium | Card-linked spending | Card-specific CTR | Card-based personalization |
| **Product Browsing** (Affiliate) | Medium | Shopping intent, \nshopee \nlazada \ntaobao specific | Product → merchant CTR | Shopping behavior signal |
| **Campaign Pages** (JRE, Yuu, etc.) | Low-Medium | Campaign-specific attribution | Campaign ROI measurement | N/A |

**What this unlocks:**
- ✅ Deep funnel conversion metrics
- ✅ Campaign effectiveness baseline (for Phase 4 monetisation)
- ✅ Card-linked behavior for personalization

---

## Tier 4: Long Tail (Post-Launch)
> Lower priority due to volume or niche use case

| Placement | Volume | Rationale for Deferral |
| --- | --- | --- |
| **Activation Flow** | Low | New users only; low volume |
| **Restaurant Listings** | Low | Niche dining vertical |
| **Articles** | Very Low | Educational, low conversion intent |
| **Web Marketing Pages** | Low | Logged-out users; acquisition, not conversion |

---

## Phase 1 Dependencies: Which Placements Unlock What

```
Placement Instrumented → Data Available → Phase 1 Capability Unlocked
─────────────────────────────────────────────────────────────────────
explore_* (16 tabs)     → CTR by category  → H1: Exposure distribution analysis
                                           → H2: Placement-specific ranking test

earn_browse_all         → Browse CTR       → Baseline for ranking experiments

search_merchants        → Search CTR/CVR   → High-intent conversion benchmark

merchant_detail_*       → Detail → Click   → Full funnel measurement
                                           → CVR optimization baseline
```

## Phase 2 Dependencies: Intent & Personalisation Signals

```
Placement               → Signal Type      → Phase 2 Use Case
─────────────────────────────────────────────────────────────────────
explore_* intent tabs   → Intent category  → Intent-based ranking (2B)

transaction_history     → Past purchases   → User-merchant affinity (2A)

bookmarks               → Saved merchants  → Explicit preference signal (2A)

search_*                → Search queries   → Intent detection (2B)

deals_calendar          → Deal browsing    → Urgency intent (2B)
```

---

## Recommended Implementation Order

### Sprint 1: Core Discovery (Week 1-2)
**Goal:** Establish baseline for ranking experiments

| # | Placement ID | Priority | Effort | Dependency |
| --- | --- | --- | --- | --- |
| 1 | `explore_shop` | P0 | Low | None |
| 2 | `explore_deals` | P0 | Low | None |
| 3 | `earn_browse_all` | P0 | Low | None |
| 4 | `search_merchants` | P0 | Low | None |
| 5 | `merchant_detail_header` | P0 | Medium | None |
| 6 | `merchant_detail_info` | P0 | Medium | None |

**Exit criteria:** Can measure CTR by placement for top 4 surfaces

### Sprint 2: Intent Categories (Week 2-3)
**Goal:** Complete explore tab coverage for Phase 2B

| # | Placement ID | Priority | Effort |
| --- | --- | --- | --- |
| 7 | `explore_food` | P1 | Low |
| 8 | `explore_travel` | P1 | Low |
| 9 | `explore_groceries` | P1 | Low |
| 10 | `explore_hotels` | P1 | Low |
| 11 | `explore_flights` | P1 | Low |
| 12 | Remaining explore_* tabs | P1 | Low |

**Exit criteria:** All 16 intent categories instrumented

### Sprint 3: Funnel Completion (Week 3-4)
**Goal:** Full conversion funnel + personalisation signals

| # | Placement ID | Priority | Effort |
| --- | --- | --- | --- |
| 13 | `miles_transaction_list` | P1 | Medium |
| 14 | `bookmark_merchant_grid` | P1 | Low |
| 15 | `home_top_banner_carousel` | P1 | Medium |
| 16 | `deals_calendar_*` | P1 | Low |

**Exit criteria:** User affinity signals available for Phase 2A

### Sprint 4+: Depth & Campaigns (Week 5+)
**Goal:** Campaign attribution + deep funnel

- Voucher placements
- Card reward placements
- Campaign pages (JRE, Yuu, Atome, TakeMe)
- Product browsing
- Activation flow

---

## Data Schema Considerations

For Phase 1 and 2 compatibility, each impression event should include:

```typescript
interface MerchantImpression {
  // Core identification
  placement_id: string;           // e.g., "explore_shop"
  merchant_id: string;
  merchant_slug: string;

  // Phase 1: Position tracking
  position_in_list: number;       // 0-indexed; critical for ranking experiments
  total_items_in_list: number;    // For impression share calculation

  // Phase 2: Intent signals
  intent_category?: string;       // For explore tabs
  entry_point?: string;           // "search" | "browse" | "deals" | "direct"

  // Phase 2: Personalisation context
  user_id?: string;
  session_id: string;

  // Metadata
  timestamp: string;
  platform: "expo" | "nextjs";

  // Campaign context (Tier 3)
  campaign_id?: string;
  campaign_slug?: string;
}
```

---

## Success Metrics by Tier

| Tier | Metric | Target |
| --- | --- | --- |
| Tier 1 | Data coverage | >80% of impressions tracked |
| Tier 1 | Data latency | <5 min from impression to warehouse |
| Tier 2 | User coverage | >70% of active users have affinity signals |
| Tier 3 | Campaign attribution | 100% of campaigns trackable |

---

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |
| Low impression volume on some placements | Medium | Slow experiment velocity | Prioritize high-volume placements first |
| Schema changes needed later | Low | Rework cost | Include Phase 2 fields from Day 1 |
| Performance impact from tracking | Low | User experience | Batch impressions, async processing |
| Inconsistent placement_id naming | Medium | Data quality | Enforce naming convention in code review |

---

## Appendix: Full Placement Inventory by Tier

<details>
<summary>Tier 1 Placements (16 total)</summary>

**Explore Tabs (16):**
- explore_deals
- explore_shop
- explore_food
- explore_groceries
- explore_dine
- explore_travel
- explore_flights
- explore_hotels
- explore_ride
- explore_shop_offline
- explore_apply_card
- explore_fx_n_biz
- explore_insurance
- explore_invest
- explore_vouchers
- explore_card

**Core Discovery:**
- earn_browse_all
- search_merchants
- merchant_detail_header
- merchant_detail_info
</details>

<details>
<summary>Tier 2 Placements (8 total)</summary>

- miles_transaction_list
- cards_transaction_detail
- bookmark_merchant_grid
- home_top_banner_carousel
- deals_calendar_current
- deals_calendar_upcoming
- home_limited_time_deals
- home_featured
</details>

<details>
<summary>Tier 3 Placements (12 total)</summary>

- my_vouchers_available
- my_vouchers_redeemed
- voucher_purchase_recommendations
- cards_reward_cycles
- merchant_products_best_deals
- merchant_products_hot_items
- campaign_jre_*
- campaign_yuu
- campaign_atome
- campaign_takeme_japan
- web_merchant_recommendations
</details>

<details>
<summary>Tier 4 Placements (deferred)</summary>

- activation_*
- web_dine_out_*
- web_articles_*
- web_marketing_*
- redeem_*
</details>
