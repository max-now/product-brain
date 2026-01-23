# Technical Design Document: Brand Exposure Dashboard

**Related PRD:** [prd.md](./prd.md)

## Overview
This document provides technical implementation details for the Brand Exposure Dashboard MVP, structured across three phases as defined in the PRD.
---

## Phase 1: Foundation – "Can we see it?"
*See PRD Phase 1 for business objectives and success criteria*

### 1.1 Exposure Event Logging

#### Brand Exposure Event Schema
```
exposure_events {
  event_id: UUID (primary key)
  merchant_id: UUID (foreign key)
  exposure_unit_id: UUID (foreign key)
  exposure_type: ENUM (banner, logo, merchant_page, card, etc.)
  placement_id: UUID (foreign key)
  user_id: UUID (anonymized, foreign key)
  timestamp: TIMESTAMP
  rank_position: INTEGER (nullable)
  session_id: UUID
  is_clickable: BOOLEAN
  algorithm_version: STRING
  created_at: TIMESTAMP
}
```

#### Batch Upload Service
- **Architecture:** Event queue → Batch processor → Database
- **Implementation:**
  - Client-side event collection buffer (max 50 events or 5 seconds)
  - POST to `/api/exposure/batch` endpoint
  - Queue: Redis or RabbitMQ
  - Batch processor: Process every 5 seconds, max 1000 events per batch
  - Async write to database with retry logic (max 3 attempts)

#### Data Quality Checks
- **Validation Rules:**
  - merchant_id must exist in merchant_dim
  - placement_id must exist in placement_dim
  - timestamp within last 10 minutes (reject stale events)
  - user_id format validation
  - rank_position >= 0 if not null

- **Monitoring:**
  - Event validation failure rate
  - Event processing lag time
  - DLQ size alerts (threshold: >100 events)

---

### 1.2 Basic Placement Inventory Dashboard

#### View 1: Placement Overview
**Sample Query:**
```sql
-- Total impressions per placement (7d, 30d)
SELECT
  placement_id,
  COUNT(*) as total_impressions,
  COUNT(DISTINCT user_id) as unique_users,
  COUNT(DISTINCT merchant_id) as unique_merchants
FROM exposure_events
WHERE timestamp >= NOW() - INTERVAL '7 days'
GROUP BY placement_id;

-- Average slots filled vs available
SELECT
  placement_id,
  AVG(merchants_shown) as avg_merchants_shown,
  MAX(merchants_shown) as max_merchants_shown
FROM (
  SELECT
    placement_id,
    session_id,
    COUNT(DISTINCT merchant_id) as merchants_shown
  FROM exposure_events
  WHERE timestamp >= NOW() - INTERVAL '7 days'
  GROUP BY placement_id, session_id
) subquery
GROUP BY placement_id;
```

**UI Components:**
- DataTable: placement_name, total_impressions, unique_merchants, saturation_rate
- Date range selector: 7d, 30d, custom
- Export to CSV functionality

---

#### View 2: Merchant Exposure Summary
**Sample Query:**
```sql
-- Merchant exposure across all placements
SELECT
  p.placement_name,
  COUNT(*) as impressions,
  COUNT(DISTINCT e.user_id) as unique_users,
  AVG(e.rank_position) as avg_rank
FROM exposure_events e
JOIN placement_dim p ON e.placement_id = p.placement_id
WHERE e.merchant_id = :merchant_id
  AND e.timestamp >= :start_date
GROUP BY p.placement_id, p.placement_name
ORDER BY impressions DESC;

-- Funnel: Impressions → Clicks → Conversions
SELECT
  COUNT(DISTINCT e.event_id) as impressions,
  COUNT(DISTINCT c.click_id) as clicks,
  COUNT(DISTINCT cv.conversion_id) as conversions
FROM exposure_events e
LEFT JOIN click_events c ON e.session_id = c.session_id
  AND e.merchant_id = c.merchant_id
LEFT JOIN conversion_events cv ON c.user_id = cv.user_id
  AND c.merchant_id = cv.merchant_id
  AND cv.timestamp BETWEEN e.timestamp AND e.timestamp + INTERVAL '7 days'
WHERE e.merchant_id = :merchant_id
  AND e.timestamp >= :start_date;
```

**UI Components:**
- Merchant dropdown selector (searchable)
- Bar chart: Impressions by placement
- Funnel visualisation: Impressions → Clicks → Conversions
- Table: Detailed breakdown per placement

---

#### View 3: Placement Deep Dive
**Sample Query:**
```sql
-- Top 10 merchants by impression share
SELECT
  m.merchant_name,
  COUNT(*) as impressions,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) as impression_share_pct
FROM exposure_events e
JOIN merchant_dim m ON e.merchant_id = m.merchant_id
WHERE e.placement_id = :placement_id
  AND e.timestamp >= :start_date
GROUP BY m.merchant_id, m.merchant_name
ORDER BY impressions DESC
LIMIT 10;

-- Impression concentration
WITH merchant_impressions AS (
  SELECT
    merchant_id,
    COUNT(*) as impressions,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) as rank
  FROM exposure_events
  WHERE placement_id = :placement_id
    AND timestamp >= :start_date
  GROUP BY merchant_id
)
SELECT
  SUM(CASE WHEN rank <= 3 THEN impressions ELSE 0 END) as top_3_impressions,
  SUM(CASE WHEN rank <= 5 THEN impressions ELSE 0 END) as top_5_impressions,
  SUM(impressions) as total_impressions
FROM merchant_impressions;

-- Hour-by-hour impression patterns
SELECT
  EXTRACT(HOUR FROM timestamp) as hour_of_day,
  COUNT(*) as impressions
FROM exposure_events
WHERE placement_id = :placement_id
  AND timestamp >= :start_date
GROUP BY hour_of_day
ORDER BY hour_of_day;
```

**UI Components:**
- Placement dropdown selector
- Pie chart: Top 10 merchant impression share
- KPI cards: Top 3 concentration %, Top 5 concentration %
- Line chart: Hourly impression patterns (24-hour view)

---

### HeyMax Data Points (Phase 1)
*See PRD for business definitions. Technical calculations:*

| Metric | SQL Implementation |
| --- | --- |
| **Total Impressions** | `COUNT(event_id)` |
| **Unique Impressions** | `COUNT(DISTINCT user_id)` per merchant |
| **Impression Share** | `COUNT(*) / SUM(COUNT(*)) OVER () * 100` |
| **Average Rank Position** | `AVG(rank_position) WHERE rank_position IS NOT NULL` |
| **Frequency Distribution** | `COUNT(DISTINCT user_id) GROUP BY impression_count_bucket` |
| **Placement Saturation** | `COUNT(DISTINCT merchant_id) / :max_slots * 100` |

---

## Phase 2: Intelligence – "What's working?"
*See PRD Phase 2 for business objectives and success criteria*

### 2.1 Performance Attribution Layer

#### Data Model Extensions
```sql
-- Link exposure to clicks
CREATE INDEX idx_exposure_session_merchant
ON exposure_events(session_id, merchant_id, timestamp);

CREATE INDEX idx_clicks_session_merchant
ON click_events(session_id, merchant_id, timestamp);

-- Link clicks to conversions (7-day attribution window)
CREATE INDEX idx_conversions_user_merchant_time
ON conversion_events(user_id, merchant_id, timestamp);

-- Multi-placement exposure tracking (materialized view)
CREATE MATERIALIZED VIEW user_exposure_paths AS
SELECT
  user_id,
  merchant_id,
  ARRAY_AGG(placement_id ORDER BY timestamp) as placement_sequence,
  MIN(timestamp) as first_exposure,
  MAX(timestamp) as last_exposure,
  COUNT(*) as total_exposures
FROM exposure_events
WHERE timestamp >= NOW() - INTERVAL '30 days'
GROUP BY user_id, merchant_id;

-- Refresh every hour
REFRESH MATERIALIZED VIEW CONCURRENTLY user_exposure_paths;
```

---

### 2.2 Performance Analytics Dashboard

#### View 1: Placement Performance Scorecard
**Sample Query:**
```sql
-- CTR by placement
SELECT
  p.placement_name,
  COUNT(DISTINCT e.event_id) as impressions,
  COUNT(DISTINCT c.click_id) as clicks,
  ROUND(100.0 * COUNT(DISTINCT c.click_id) / NULLIF(COUNT(DISTINCT e.event_id), 0), 2) as ctr_pct
FROM exposure_events e
JOIN placement_dim p ON e.placement_id = p.placement_id
LEFT JOIN click_events c ON e.session_id = c.session_id
  AND e.merchant_id = c.merchant_id
  AND c.timestamp BETWEEN e.timestamp AND e.timestamp + INTERVAL '1 hour'
WHERE e.timestamp >= :start_date
GROUP BY p.placement_id, p.placement_name;

-- CVR by placement (impression → conversion)
SELECT
  p.placement_name,
  COUNT(DISTINCT e.event_id) as impressions,
  COUNT(DISTINCT cv.conversion_id) as conversions,
  ROUND(100.0 * COUNT(DISTINCT cv.conversion_id) / NULLIF(COUNT(DISTINCT e.event_id), 0), 2) as cvr_pct
FROM exposure_events e
JOIN placement_dim p ON e.placement_id = p.placement_id
LEFT JOIN conversion_events cv ON e.user_id = cv.user_id
  AND e.merchant_id = cv.merchant_id
  AND cv.timestamp BETWEEN e.timestamp AND e.timestamp + INTERVAL '7 days'
WHERE e.timestamp >= :start_date
GROUP BY p.placement_id, p.placement_name;

-- Revenue per 1000 impressions (RPM proxy)
SELECT
  p.placement_name,
  COUNT(DISTINCT e.event_id) as impressions,
  SUM(cv.commission_amount) as total_revenue,
  ROUND(SUM(cv.commission_amount) / NULLIF(COUNT(DISTINCT e.event_id), 0) * 1000, 2) as rpm
FROM exposure_events e
JOIN placement_dim p ON e.placement_id = p.placement_id
LEFT JOIN conversion_events cv ON e.user_id = cv.user_id
  AND e.merchant_id = cv.merchant_id
  AND cv.timestamp BETWEEN e.timestamp AND e.timestamp + INTERVAL '7 days'
WHERE e.timestamp >= :start_date
GROUP BY p.placement_id, p.placement_name;
```

**UI Components:**
- Table: placement_name, impressions, clicks, conversions, CTR%, CVR%, RPM
- Sort by any column
- Colour-coded performance indicators (green/yellow/red thresholds)

---

#### View 2: Merchant Performance Benchmarking
**Sample Query:**
```sql
-- Which placements drive highest CVR for this merchant
SELECT
  p.placement_name,
  COUNT(DISTINCT e.event_id) as impressions,
  COUNT(DISTINCT cv.conversion_id) as conversions,
  ROUND(100.0 * COUNT(DISTINCT cv.conversion_id) / NULLIF(COUNT(DISTINCT e.event_id), 0), 2) as cvr_pct,
  -- Categorize placement intent
  CASE
    WHEN cvr_pct >= 5.0 THEN 'CPA Priority'
    WHEN ctr_pct >= 2.0 AND cvr_pct < 2.0 THEN 'CPC Candidate'
    ELSE 'CPI Candidate'
  END as recommended_package
FROM exposure_events e
JOIN placement_dim p ON e.placement_id = p.placement_id
LEFT JOIN conversion_events cv ON e.user_id = cv.user_id
  AND e.merchant_id = cv.merchant_id
  AND cv.timestamp BETWEEN e.timestamp AND e.timestamp + INTERVAL '7 days'
WHERE e.merchant_id = :merchant_id
  AND e.timestamp >= :start_date
GROUP BY p.placement_id, p.placement_name
ORDER BY cvr_pct DESC;
```

**UI Components:**
- Merchant selector
- Bar chart: CVR by placement
- Scatter plot: CTR vs CVR (quadrant chart)
- Placement recommendations table

---

#### View 3: Conversion Path Analysis
**Sample Query:**
```sql
-- For converted users: which placements did they see?
WITH conversions AS (
  SELECT DISTINCT user_id, merchant_id, timestamp as conversion_time
  FROM conversion_events
  WHERE timestamp >= :start_date
),
exposure_before_conversion AS (
  SELECT
    e.user_id,
    e.merchant_id,
    p.placement_name,
    e.timestamp,
    c.conversion_time,
    ROW_NUMBER() OVER (PARTITION BY e.user_id, e.merchant_id ORDER BY e.timestamp) as exposure_sequence,
    ROW_NUMBER() OVER (PARTITION BY e.user_id, e.merchant_id ORDER BY e.timestamp DESC) as reverse_sequence
  FROM exposure_events e
  JOIN conversions c ON e.user_id = c.user_id
    AND e.merchant_id = c.merchant_id
    AND e.timestamp < c.conversion_time
  JOIN placement_dim p ON e.placement_id = p.placement_id
)
SELECT
  placement_name,
  COUNT(*) as times_in_path,
  SUM(CASE WHEN exposure_sequence = 1 THEN 1 ELSE 0 END) as first_touch_count,
  SUM(CASE WHEN reverse_sequence = 1 THEN 1 ELSE 0 END) as last_touch_count,
  AVG(EXTRACT(EPOCH FROM (conversion_time - timestamp)) / 3600) as avg_hours_to_conversion
FROM exposure_before_conversion
GROUP BY placement_name
ORDER BY times_in_path DESC;
```

**UI Components:**
- Sankey diagram: Exposure sequence flow
- Table: First touch vs last touch attribution
- Histogram: Time to conversion distribution

---

### 2.3 Commercial Package Simulator
**Sample Query:**
```sql
-- Simulate CPI delivery feasibility
WITH placement_capacity AS (
  SELECT
    placement_id,
    AVG(daily_impressions) as avg_daily_impressions,
    AVG(daily_cvr_pct) as avg_cvr_pct,
    AVG(daily_revenue) as avg_daily_revenue
  FROM (
    SELECT
      placement_id,
      DATE(timestamp) as date,
      COUNT(*) as daily_impressions,
      COUNT(DISTINCT cv.conversion_id) * 100.0 / NULLIF(COUNT(*), 0) as daily_cvr_pct,
      SUM(cv.commission_amount) as daily_revenue
    FROM exposure_events e
    LEFT JOIN conversion_events cv ON e.user_id = cv.user_id
      AND e.merchant_id = cv.merchant_id
      AND cv.timestamp BETWEEN e.timestamp AND e.timestamp + INTERVAL '7 days'
    WHERE e.timestamp >= NOW() - INTERVAL '30 days'
    GROUP BY placement_id, DATE(timestamp)
  ) daily_stats
  GROUP BY placement_id
)
SELECT
  p.placement_name,
  pc.avg_daily_impressions * 30 as monthly_impression_capacity,
  :requested_impressions as requested_impressions,
  CASE
    WHEN pc.avg_daily_impressions * 30 * 0.3 >= :requested_impressions THEN 'Feasible (30% allocation)'
    WHEN pc.avg_daily_impressions * 30 * 0.5 >= :requested_impressions THEN 'Feasible (50% allocation - HIGH RISK)'
    ELSE 'Not Feasible'
  END as delivery_feasibility,
  pc.avg_daily_revenue * 30 as monthly_cpa_revenue,
  pc.avg_daily_revenue * 30 * 0.3 as revenue_at_risk_30pct
FROM placement_capacity pc
JOIN placement_dim p ON pc.placement_id = p.placement_id
ORDER BY monthly_impression_capacity DESC;
```

**UI Components:**
- Input: CPI budget, requested impressions
- Table: Placement recommendations with risk scores
- Visual: Revenue at risk meter
- Warning indicators for high-risk allocations

---

### HeyMax Data Points (Phase 2)
*See PRD for business definitions. Technical calculations defined in queries above.*

---

## Phase 3: Commercialisation – "Sell with confidence"
*See PRD Phase 3 for business objectives and success criteria*

### 3.1 Merchant-Facing Exposure Portal

#### Authentication & Access Control
```typescript
// API Routes
POST /api/merchant/auth/login
  - Input: merchant_id, api_key
  - Output: JWT token (24h expiry)
  - Rate limit: 10 requests/minute

GET /api/merchant/exposure/summary
  - Auth: Bearer token
  - Query params: start_date, end_date
  - Returns: Exposure summary across all placements

GET /api/merchant/exposure/performance
  - Auth: Bearer token
  - Returns: CTR, CVR, conversions by placement

GET /api/merchant/exposure/audience
  - Auth: Bearer token
  - Returns: Unique users, frequency distribution
```

#### UI Implementation (React/Next.js)
```
/merchant-portal
  /dashboard
    - ExposureSummaryTab
    - PerformanceTab
    - AudienceReachTab
    - CompetitiveContextTab
  /components
    - DateRangePicker
    - PlacementBreakdownChart
    - FrequencyHistogram
    - CTRTrendLine
```

---

### 3.2 Package Delivery Monitoring

#### Real-Time Pacing Algorithm
```python
# Run every 15 minutes for active CPI packages
def check_delivery_pacing(package_id):
    package = get_active_package(package_id)

    # Calculate expected delivery by now
    days_elapsed = (today - package.start_date).days
    total_days = (package.end_date - package.start_date).days
    expected_impressions = package.guaranteed_impressions * (days_elapsed / total_days)

    # Get actual delivery
    actual_impressions = get_impressions_delivered(package_id)

    # Calculate pacing
    pacing_pct = (actual_impressions / expected_impressions) * 100

    if pacing_pct < 80:
        alert_status = "UNDER_DELIVERING"
        # Increase allocation in eligible placements
        adjust_slot_allocation(package_id, increase=True)
    elif pacing_pct > 120:
        alert_status = "OVER_DELIVERING"
        # Reduce allocation to preserve budget
        adjust_slot_allocation(package_id, increase=False)
    else:
        alert_status = "ON_TRACK"

    log_pacing_check(package_id, pacing_pct, alert_status)
    return alert_status
```

#### Slot Allocation Monitor
```sql
-- Monitor organic vs paid slot mix per placement
CREATE MATERIALIZED VIEW placement_slot_mix AS
SELECT
  e.placement_id,
  p.placement_name,
  DATE(e.timestamp) as date,
  COUNT(CASE WHEN mp.package_type IS NULL THEN 1 END) as organic_impressions,
  COUNT(CASE WHEN mp.package_type = 'CPI' THEN 1 END) as cpi_impressions,
  COUNT(CASE WHEN mp.package_type = 'CPC' THEN 1 END) as cpc_impressions,
  COUNT(CASE WHEN mp.package_type = 'CPA' THEN 1 END) as cpa_impressions,
  COUNT(*) as total_impressions,
  ROUND(100.0 * COUNT(CASE WHEN mp.package_type IS NOT NULL THEN 1 END) / COUNT(*), 2) as paid_pct
FROM exposure_events e
JOIN placement_dim p ON e.placement_id = p.placement_id
LEFT JOIN merchant_packages mp ON e.merchant_id = mp.merchant_id
  AND e.timestamp BETWEEN mp.start_date AND mp.end_date
WHERE e.timestamp >= NOW() - INTERVAL '7 days'
GROUP BY e.placement_id, p.placement_name, DATE(e.timestamp);

-- Alert if paid_pct exceeds 40% threshold
SELECT * FROM placement_slot_mix WHERE paid_pct > 40;
```

---

### 3.3 Commercial Pricing Calculator

#### Pricing Model
```python
# Base pricing calculation
def calculate_package_pricing(merchant_objective, budget):
    if merchant_objective == "awareness":
        # CPI Pricing
        base_cpm = 8.50  # £8.50 per 1000 impressions
        impressions = (budget / base_cpm) * 1000

        # Adjust for placement mix
        high_value_placements = ['home_earn_carousel', 'search_results']
        standard_placements = ['merchant_page', 'category_browse']

        allocation = {
            "high_value": impressions * 0.4,  # 40% at 1.3x premium
            "standard": impressions * 0.6     # 60% at base rate
        }

        return {
            "package_type": "CPI",
            "guaranteed_impressions": int(impressions),
            "estimated_reach": int(impressions * 0.7),  # 70% unique users
            "placement_allocation": allocation,
            "base_cpm": base_cpm
        }

    elif merchant_objective == "traffic":
        # CPC Pricing
        base_cpc = 0.35  # £0.35 per click
        clicks = int(budget / base_cpc)
        estimated_impressions = clicks / 0.025  # Assume 2.5% CTR

        return {
            "package_type": "CPC",
            "guaranteed_clicks": clicks,
            "estimated_impressions": int(estimated_impressions),
            "base_cpc": base_cpc,
            "estimated_cvr": "1.5-3.0%"
        }

    elif merchant_objective == "conversions":
        # CPA Boost (commission-based)
        return {
            "package_type": "CPA",
            "commission_structure": "Performance-based",
            "estimated_impressions": "Variable (optimised for CVR)",
            "note": "No upfront cost - commission on conversions only"
        }
```

---

## Technical Considerations

### Data Architecture
```
exposure_events (fact table) - Primary storage
├─ Partitioned by date (monthly partitions)
├─ Indexed on: (merchant_id, timestamp), (placement_id, timestamp), (user_id, timestamp)
└─ Retention: 30 days raw, 2 years aggregated

merchant_dim - Merchant metadata
placement_dim - Placement definitions
user_dim - Anonymized user data
exposure_unit_dim - Exposure type taxonomy
session_dim - Session tracking

click_events - Click tracking
├─ Links via: (session_id, merchant_id)
└─ Retention: 30 days raw, 1 year aggregated

conversion_events - Transaction data
├─ Links via: (user_id, merchant_id, timestamp window)
└─ Retention: Indefinite (business requirement)
```

### Performance Optimizations

#### Phase 1
- **Batch Processing:** 5-second intervals, max 1000 events/batch
- **Database:** PostgreSQL with TimescaleDB extension for time-series optimization
- **Caching:** Redis for dashboard queries (5-minute TTL)
- **Async Writes:** Queue-based processing to avoid blocking client

#### Phase 2
- **Pre-Aggregation:** Hourly/daily rollups via cron jobs
- **Materialized Views:** Refresh every hour for conversion paths
- **Query Optimization:** Covering indexes on common join patterns
- **Dashboard Loading:** Lazy load charts, paginated tables

#### Phase 3
- **Real-Time Pacing:** 15-minute check intervals for active packages
- **API Rate Limiting:** 100 requests/minute per merchant
- **CDN:** Cache static portal assets
- **Database Connection Pooling:** Max 50 connections, 10-second timeout

### Privacy & Compliance

#### Data Handling
- **PII Protection:** user_id is SHA-256 hashed UUID, no email/name in exposure logs
- **GDPR Compliance:**
  - Raw event data: 30-day retention
  - Aggregated data: Indefinite (anonymized)
  - User deletion requests: Cascade delete all user_id records within 48 hours

#### Merchant Data Access
- **Access Control:** Merchants can only view their own data
- **Aggregated Reporting:** No individual user-level data exposed
- **Audit Logging:** All merchant API calls logged for 90 days

---

## Deployment Strategy

### Phase 1 Rollout
1. Deploy event logging to 10% of traffic (canary)
2. Monitor error rates, latency, data quality
3. Gradually increase to 100% over the week
4. Launch internal dashboard for HeyMax team

### Phase 2 Rollout
1. Backfill 30 days of historical data
2. Build and test attribution queries
3. Launch internal analytics dashboard
4. Run validation against existing conversion tracking (±5% accuracy)

### Phase 3 Rollout
1. Beta test merchant portal with 5 pilot merchants
2. Gather feedback, iterate on UX
3. Launch package delivery monitoring internally
4. Public launch to all merchants

---

## Monitoring & Alerting

### Key Metrics to Monitor
- Event processing lag (alert if >10 seconds)
- Event validation failure rate (alert if >2%)
- Dashboard query latency p95 (alert if >2 seconds)
- Package delivery pacing (alert if <80% or >120%)
- API error rate (alert if >1%)
- Database connection pool saturation (alert if >80%)

### Dashboards
- **Operational Dashboard:** Event throughput, error rates, system health
- **Business Dashboard:** Impressions, CTR, CVR by placement
- **Commercial Dashboard:** Package delivery, revenue metrics
