# User Location & Daypart Segments Analysis

## Overview

Analysis of users who frequently dine (≥3 transactions in 90 days) at specific geographic locations, segmented by lunch (10am-2pm SGT) and dinner (5pm-10pm SGT) dayparts.

**Data Period:** Last 90 days
**Timezone:** SGT (UTC+8)
**Location Granularity:** ~1km grid (lat/lng rounded to 2 decimals)

---

## Summary Statistics

| Daypart | Unique Users | Total Segments | Locations | Avg Spend | Avg Visits/Month |
| --- | --- | --- | --- | --- | --- |
| Lunch | 9,377 | 13,865 | 134 | $26.82 | 2.4 |
| Dinner | 7,588 | 10,713 | 140 | $36.35 | 2.3 |

**Key Insight:** Dinner has 35% higher average spend than lunch ($36.35 vs $26.82), despite fewer unique users.

---

## Top 20 Locations by Unique Users

### Lunch Hotspots

| Rank | Location | Area (approx) | Users | Avg Spend | Visits/Mo | Est. Monthly Revenue |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 1.45,103.81 | Woodlands | 2,238 | $6.41 | 3.3 | $44,413 |
| 2 | 1.28,103.84 | Tanjong Pagar/CBD | 2,163 | $77.22 | 2.2 | $472,891 |
| 3 | 1.40,103.90 | Pasir Ris/Tampines | 1,300 | $16.21 | 2.3 | $47,592 |
| 4 | 1.28,103.85 | Marina Bay/CBD | 1,282 | $18.20 | 2.3 | $48,879 |
| 5 | 1.33,103.87 | Paya Lebar | 753 | $5.81 | 2.3 | $9,802 |
| 6 | 1.29,103.85 | Raffles Place | 632 | $22.20 | 2.4 | $30,050 |
| 7 | 1.33,103.74 | Jurong East | 416 | $11.19 | 2.3 | $9,495 |
| 8 | 1.28,103.83 | Chinatown | 365 | $13.72 | 1.8 | $11,205 |
| 9 | 1.32,103.84 | Novena | 331 | $13.15 | 2.3 | $9,520 |
| 10 | 1.35,103.95 | Bedok | 271 | $21.97 | 2.5 | $13,326 |

### Dinner Hotspots

| Rank | Location | Area (approx) | Users | Avg Spend | Visits/Mo | Est. Monthly Revenue |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 1.28,103.84 | Tanjong Pagar/CBD | 2,051 | $79.94 | 2.2 | $411,690 |
| 2 | 1.45,103.81 | Woodlands | 1,343 | $7.70 | 3.0 | $29,762 |
| 3 | 1.40,103.90 | Pasir Ris/Tampines | 1,085 | $22.08 | 2.3 | $58,815 |
| 4 | 1.28,103.85 | Marina Bay/CBD | 714 | $30.88 | 2.2 | $42,810 |
| 5 | 1.28,103.83 | Chinatown | 431 | $11.72 | 1.9 | $10,249 |
| 6 | 1.29,103.83 | Clarke Quay | 429 | $39.89 | 2.0 | $30,551 |
| 7 | 1.31,103.86 | Kallang | 399 | $22.56 | 2.0 | $17,138 |
| 8 | 1.35,103.95 | Bedok | 364 | $29.04 | 2.4 | $23,817 |
| 9 | 1.32,103.84 | Novena | 315 | $17.55 | 2.2 | $11,533 |
| 10 | 1.29,103.85 | Raffles Place | 214 | $50.69 | 2.4 | $27,222 |

---

## Strategic Insights for Merchant Targeting

### High-Value Locations (Revenue Focus)
1. **Tanjong Pagar/CBD (1.28,103.84)** - $885K combined monthly revenue, 4,214 unique users
2. **Marina Bay/CBD (1.28,103.85)** - $91K combined revenue, high-value dinner ($31 avg)
3. **Raffles Place (1.29,103.85)** - $57K combined revenue, premium dinner crowd ($51 avg)

### High-Frequency Locations (Volume Focus)
1. **Woodlands (1.45,103.81)** - 3,581 users, highest visit frequency (3.0-3.3x/month)
2. **Tampines/Pasir Ris (1.40,103.90)** - 2,385 users, good dinner spend ($22)

### Daypart Recommendations by Location
| Location | Lunch Deal? | Dinner Deal? | Rationale |
| --- | --- | --- | --- |
| CBD/Tanjong Pagar | ✅ Strong | ✅ Strong | Massive user base, premium spend both dayparts |
| Woodlands | ✅ Strong | ⚠️ Moderate | High frequency but low ticket size |
| Tampines | ✅ Good | ✅ Good | Balanced profile, good suburban reach |
| Bedok | ⚠️ Moderate | ✅ Strong | Dinner 32% higher spend than lunch |
| Chinatown | ⚠️ Moderate | ⚠️ Moderate | Lower frequency, lunch-heavy |

---

## SQL Query for Full CSV Export

Run this query in BigQuery Console to export the complete user-level segment data:

```sql
WITH user_transactions AS (
  SELECT
    user_id,
    ROUND(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64), 2) AS lat,
    ROUND(CAST(JSON_VALUE(merchant, '$.longitude') AS FLOAT64), 2) AS lng,
    EXTRACT(HOUR FROM TIMESTAMP_ADD(created_at, INTERVAL 8 HOUR)) AS hour_sgt,
    CAST(base_currency_amount AS FLOAT64) AS amount_sgd,
    DATE_TRUNC(DATE(TIMESTAMP_ADD(created_at, INTERVAL 8 HOUR)), MONTH) AS txn_month
  FROM `max-sg.pg_public.spend_transactions`
  WHERE status = 'SETTLED'
    AND created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
    AND JSON_VALUE(merchant, '$.mcc.l2_category') IN ('Fast Food Restaurants', 'Restaurants (excluding Bars)')
    AND JSON_VALUE(merchant, '$.latitude') IS NOT NULL
    AND JSON_VALUE(merchant, '$.latitude') != ''
    AND JSON_VALUE(merchant, '$.latitude') != '0'
    AND JSON_VALUE(merchant, '$.longitude') IS NOT NULL
    AND JSON_VALUE(merchant, '$.longitude') != ''
    AND JSON_VALUE(merchant, '$.longitude') != '0'
),
user_daypart_location AS (
  SELECT
    user_id,
    CONCAT(CAST(lat AS STRING), ',', CAST(lng AS STRING)) AS location,
    CASE
      WHEN hour_sgt BETWEEN 10 AND 14 THEN 'lunch'
      WHEN hour_sgt BETWEEN 17 AND 22 THEN 'dinner'
    END AS daypart,
    amount_sgd,
    txn_month
  FROM user_transactions
  WHERE hour_sgt BETWEEN 10 AND 14 OR hour_sgt BETWEEN 17 AND 22
)
SELECT
  user_id,
  location,
  daypart,
  ROUND(AVG(amount_sgd), 2) AS avg_spend,
  ROUND(COUNT(*) / COUNT(DISTINCT txn_month), 1) AS avg_visits_per_month
FROM user_daypart_location
WHERE daypart IS NOT NULL
GROUP BY user_id, location, daypart
HAVING COUNT(*) >= 3
ORDER BY location, daypart, avg_visits_per_month DESC
```

**Expected Output:** 24,578 rows with columns: `user_id | location | daypart | avg_spend | avg_visits_per_month`

---

*Analysis generated: 2026-02-06*
*Data source: max-sg.pg\_public.spend\_transactions*
*Timezone: All timestamps converted from UTC to SGT (UTC+8)*
