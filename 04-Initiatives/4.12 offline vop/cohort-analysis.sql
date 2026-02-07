-- ============================================================
-- OFFLINE VOP: COHORT ANALYSIS QUERIES
-- Purpose: Analyse user spend behaviour to build targetable
--          cohorts for merchant pitch decks (Pre-Work phase)
-- ============================================================
-- Table name: max-sg.pg_public.spend_transactions
-- Run each section independently to explore the data
--
-- IMPORTANT FIXES APPLIED:
-- - status = 'SETTLED' (uppercase, not lowercase)
-- - Use TIMESTAMP_SUB(CURRENT_TIMESTAMP(), ...) instead of DATE_SUB(CURRENT_DATE(), ...)
-- - mcc.l1_category = 'Lifestyle & Retail Stores' (not 'Food')
-- - mcc.l2_category IN ('Fast Food Restaurants', 'Restaurants (excluding Bars)')
-- ============================================================

-- Sample merchant json array
-- {'address': '', 'background_color': None, 'bd_ranking': 999999, 'best_strategy': None, 'business_legal_names': [], 'categories': [], 'chope_restaurant_id': None, 'country_code': 'US', 'dba_names': [], 'earning_types': [], 'enterprise': '', 'icon': None, 'icon_url': None, 'id': 'PpRy12HV3Y3pBLB7Ce1g', 'intent_categories': [], 'latitude': '', 'longitude': '', 'mcc': {'l1_category': 'Business & Miscellaneous Services', 'l2_category': 'Contracted Services', 'l2_category_desc': None, 'mcc_code': '1731', 'mcc_desc': 'Electrical Contractors'}, 'mcc_code': '5812', 'mcc_codes': ['1731'], 'mcc_v2': [{'l1_category': 'Business & Miscellaneous Services', 'l2_category': 'Contracted Services', 'l2_category_desc': None, 'mcc_code': '1731', 'mcc_desc': 'Electrical Contractors'}], 'merchant': '', 'merchant_icon': None, 'name': 'Hitachi America LTD', 'offline_merchant_profile_id': None, 'payment_acceptance_method': [], 'phone_numbers': [], 'popularity_ranking': 999999, 'slug': 'hitachi-america-ltd', 'source': 'db', 'store': '', 'tags': ['contactless'], 'terminal_type': [], 'url': None}

-- spend transactions db schema

-- idVARCHAR
-- user_idVARCHAR
-- card_idVARCHAR
-- card_last_fourVARCHAR
-- card_schemeVARCHAR
-- original_currencyVARCHAR
-- original_currency_amountVARCHAR
-- base_currencyVARCHAR
-- base_currency_amountVARCHAR
-- merchantNULL
-- merchant_nameVARCHAR
-- mcc_descVARCHAR
-- mcc_codeVARCHAR
-- statusVARCHAR
-- vop_raw_transaction_idVARCHAR
-- deleted_atTIMESTAMP
-- created_atTIMESTAMP
-- updated_atTIMESTAMP
-- payment_tagVARCHAR
-- scheme_transaction_idVARCHAR
-- settled_atTIMESTAMP
-- datastream_metadataSTRUCT<uuid STRING, source_timestamp INT64>
-- datastream_metadata.uuidVARCHAR
-- datastream_metadata.source_timestampINTEGER
-- eligible_campaignsNULL
-- merchant_card_acceptor_idVARCHAR
-- terminal_idVARCHAR

-- ============================================================
-- 0. DATA QUALITY & COVERAGE CHECK
-- Run these first to understand what you're working with
-- ============================================================

-- 0a. Total transaction volume and date range
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT user_id) AS unique_users,
    COUNT(DISTINCT JSON_VALUE(merchant, '$.id')) AS unique_merchants,
    MIN(created_at) AS earliest_date,
    MAX(created_at) AS latest_date
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED'  -- or whatever indicates completed transactions
  AND deleted_at IS NULL;

-- 0b. Check MCC L1/L2 category coverage — how granular is the data?
SELECT
    FORMAT_TIMESTAMP('%Y-%m', created_at) AS month,
    JSON_VALUE(merchant, '$.mcc.l1_category') AS l1_category,
    JSON_VALUE(merchant, '$.mcc.l2_category') AS l2_category,
    JSON_VALUE(merchant, '$.mcc.l2_category_desc') AS l2_description,
    SUM(CAST(base_currency_amount AS FLOAT64)) AS spend_amount,
    COUNT(*) AS txn_count,
    COUNT(DISTINCT user_id) AS unique_users

FROM pg_public.spend_transactions
WHERE deleted_at IS NULL
GROUP BY 1, 2, 3, 4
ORDER BY txn_count DESC

-- 0c. Check what "tags" contain — might have cuisine/category info
SELECT
    JSON_VALUE(merchant, '$.tags') AS tags,
    COUNT(*) AS txn_count
FROM `max-sg.pg_public.spend_transactions`
WHERE JSON_VALUE(merchant, '$.tags') IS NOT NULL
  AND JSON_VALUE(merchant, '$.tags') != ''
  AND status = 'SETTLED'
  AND deleted_at IS NULL
GROUP BY 1
ORDER BY txn_count DESC
LIMIT 50;

-- 0d. Check payment_acceptance_method — distinguish offline vs online
SELECT
    JSON_VALUE(merchant, '$.payment_acceptance_method') AS payment_acceptance_method,
    JSON_VALUE(merchant, '$.terminal_type') AS terminal_type,
    payment_tag,
    COUNT(*) AS txn_count,
    COUNT(DISTINCT user_id) AS unique_users
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED'
  AND deleted_at IS NULL
GROUP BY 1, 2, 3
ORDER BY txn_count DESC;

-- 0e. Geo coverage — how many transactions have lat/long?
SELECT
    JSON_VALUE(merchant, '$.mcc.l2_category') AS l2_category,
    COUNT(*) AS total_records,
    COUNTIF(JSON_VALUE(merchant, '$.latitude') IS NOT NULL 
        AND JSON_VALUE(merchant, '$.latitude') != '') AS has_lat_long,
    COUNTIF(JSON_VALUE(merchant, '$.latitude') IS NULL 
        OR JSON_VALUE(merchant, '$.latitude') = '') AS missing_lat_long,
    ROUND(COUNTIF(JSON_VALUE(merchant, '$.latitude') IS NOT NULL 
        AND JSON_VALUE(merchant, '$.latitude') != '') * 100.0 / COUNT(*), 2) AS pct_with_lat_long
FROM `max-sg.pg_public.spend_transactions`
WHERE deleted_at IS NULL
  AND JSON_VALUE(merchant, '$.mcc.l2_category') IN ('Fast Food Restaurants', 'Restaurants (excluding Bars)')
GROUP BY 1
ORDER BY total_records DESC;


-- ============================================================
-- 1. RESTAURANT DINER SEGMENTATION (MCC-BASED)
-- Goal: Build restaurant diner cohorts using MCC filtering
-- Starting case: MCC is enough. Cuisine-level granularity later.
-- ============================================================

-- 1a. Restaurant diner universe — MCC-based
-- This is your V1 cohort. "High-spend restaurant diners near you."
-- Adjust mcc_l1_category value based on what 0b returns.
SELECT
    JSON_VALUE(merchant, '$.mcc.l1_category') AS l1,
    JSON_VALUE(merchant, '$.mcc.l2_category') AS l2,
    JSON_VALUE(merchant, '$.mcc.l2_category_desc') AS l2_desc,
    COUNT(*) AS txn_count,
    COUNT(DISTINCT user_id) AS unique_users,
    ROUND(AVG(CAST(base_currency_amount AS FLOAT64)), 2) AS avg_txn_amount,
    ROUND(SUM(CAST(base_currency_amount AS FLOAT64)), 2) AS total_spend
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED'
  AND deleted_at IS NULL
  AND JSON_VALUE(merchant, '$.mcc.l2_category') IN ('Fast Food Restaurants', 'Restaurants (excluding Bars)')  -- L2 is more accurate than L1
GROUP BY 1, 2, 3
ORDER BY unique_users DESC;

-- 1b. Top restaurant merchants by user volume
-- Use this to see which restaurants your users already visit
-- and to eyeball whether name-matching for cuisine is needed later
SELECT
    JSON_VALUE(merchant, '$.name') AS merchant_name,
    merchant_name AS merchant_name_col,
    JSON_VALUE(merchant, '$.mcc.l2_category_desc') AS subcategory,
    JSON_VALUE(merchant, '$.tags') AS tags,
    COUNT(*) AS txn_count,
    COUNT(DISTINCT user_id) AS unique_users,
    ROUND(AVG(CAST(base_currency_amount AS FLOAT64)), 2) AS avg_txn_amount,
    ROUND(SUM(CAST(base_currency_amount AS FLOAT64)), 2) AS total_spend
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED'
  AND deleted_at IS NULL
  AND JSON_VALUE(merchant, '$.mcc.l2_category') IN ('Fast Food Restaurants', 'Restaurants (excluding Bars)')  -- L2 is more accurate than L1
GROUP BY 1, 2, 3, 4
ORDER BY unique_users DESC
LIMIT 100;

-- 1c. (OPTIONAL — V2) Cuisine-level identification via merchant name
-- Only run this if merchants specifically ask for cuisine-level targeting
-- or if you want to refine the pitch from "diners" to "Japanese diners"

-- Japanese restaurants
SELECT
    COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name) AS merchant_name,
    COUNT(DISTINCT user_id) AS users
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED' AND deleted_at IS NULL
  AND (LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%sushi%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%ramen%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%izakaya%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%yakiniku%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%tempura%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%udon%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%teppanyaki%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%omakase%')
GROUP BY 1 ORDER BY users DESC LIMIT 50;

-- Korean restaurants
SELECT
    COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name) AS merchant_name,
    COUNT(DISTINCT user_id) AS users
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED' AND deleted_at IS NULL
  AND (LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%korean%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%bibimbap%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%bulgogi%'
    OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%samgyeopsal%')
GROUP BY 1 ORDER BY users DESC LIMIT 50;


-- ============================================================
-- 2. GEO SEGMENTATION
-- Goal: Understand where users transact, build district-level cohorts
-- ============================================================

-- 2a. Transaction heatmap by district
-- NOTE: You'll need to map lat/long to district names.
-- Quick approach: round to ~neighbourhood level and eyeball on a map.
-- Better approach: create a district lookup table.
SELECT
    ROUND(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64), 2) AS lat_rounded,
    ROUND(CAST(JSON_VALUE(merchant, '$.longitude') AS FLOAT64), 2) AS lng_rounded,
    COUNT(*) AS txn_count,
    COUNT(DISTINCT user_id) AS unique_users,
    ROUND(SUM(CAST(base_currency_amount AS FLOAT64)), 2) AS total_spend
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED'
  AND deleted_at IS NULL
  AND JSON_VALUE(merchant, '$.latitude') IS NOT NULL
  AND JSON_VALUE(merchant, '$.latitude') != ''
  -- Country filter removed - data shows Singapore (SG) market
GROUP BY 1, 2
ORDER BY unique_users DESC
LIMIT 50;

-- 2b. AREA-LEVEL: Lunch vs Dinner traffic by geo
-- Shows which areas have lunch crowd vs dinner crowd for targeting
SELECT
    ROUND(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64), 2) AS lat_rounded,
    ROUND(CAST(JSON_VALUE(merchant, '$.longitude') AS FLOAT64), 2) AS lng_rounded,
    COUNT(CASE WHEN EXTRACT(HOUR FROM created_at) BETWEEN 10 AND 14 THEN 1 END) AS lunch_txns,
    COUNT(CASE WHEN EXTRACT(HOUR FROM created_at) BETWEEN 17 AND 22 THEN 1 END) AS dinner_txns,
    COUNT(DISTINCT CASE WHEN EXTRACT(HOUR FROM created_at) BETWEEN 10 AND 14 THEN user_id END) AS lunch_users,
    COUNT(DISTINCT CASE WHEN EXTRACT(HOUR FROM created_at) BETWEEN 17 AND 22 THEN user_id END) AS dinner_users,
    ROUND(AVG(CASE WHEN EXTRACT(HOUR FROM created_at) BETWEEN 10 AND 14
              THEN CAST(base_currency_amount AS FLOAT64) END), 2) AS avg_lunch_spend,
    ROUND(AVG(CASE WHEN EXTRACT(HOUR FROM created_at) BETWEEN 17 AND 22
              THEN CAST(base_currency_amount AS FLOAT64) END), 2) AS avg_dinner_spend
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED'
  AND deleted_at IS NULL
  AND JSON_VALUE(merchant, '$.latitude') IS NOT NULL
  AND JSON_VALUE(merchant, '$.latitude') != ''
  -- Country filter removed - data shows Singapore (SG) market
  AND JSON_VALUE(merchant, '$.mcc.l2_category') IN ('Fast Food Restaurants', 'Restaurants (excluding Bars)')
  AND created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
GROUP BY 1, 2
HAVING lunch_txns + dinner_txns >= 50  -- minimum activity threshold
ORDER BY (lunch_users + dinner_users) DESC
LIMIT 50;

-- 2c. Infer user "home area" — where they transact most on weekends/evenings
-- (Proxy for residential neighbourhood)
SELECT
    user_id,
    ROUND(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64), 2) AS lat_rounded,
    ROUND(CAST(JSON_VALUE(merchant, '$.longitude') AS FLOAT64), 2) AS lng_rounded,
    COUNT(*) AS weekend_evening_txns
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED'
  AND deleted_at IS NULL
  AND JSON_VALUE(merchant, '$.latitude') IS NOT NULL
  AND JSON_VALUE(merchant, '$.latitude') != ''
  AND (
    EXTRACT(DAYOFWEEK FROM created_at) IN (1, 7)  -- Sunday=1, Saturday=7
    OR (EXTRACT(DAYOFWEEK FROM created_at) BETWEEN 2 AND 6 AND EXTRACT(HOUR FROM created_at) >= 18)  -- weekday evenings
  )
  AND created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
GROUP BY 1, 2, 3
QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY weekend_evening_txns DESC) = 1;

-- 2d. Infer user "work area" — where they transact most on weekday lunchtimes
SELECT
    user_id,
    ROUND(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64), 2) AS lat_rounded,
    ROUND(CAST(JSON_VALUE(merchant, '$.longitude') AS FLOAT64), 2) AS lng_rounded,
    COUNT(*) AS weekday_lunch_txns
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED'
  AND deleted_at IS NULL
  AND JSON_VALUE(merchant, '$.latitude') IS NOT NULL
  AND JSON_VALUE(merchant, '$.latitude') != ''
  AND EXTRACT(DAYOFWEEK FROM created_at) BETWEEN 2 AND 6  -- Monday to Friday
  AND EXTRACT(HOUR FROM created_at) BETWEEN 10 AND 14  -- lunch hours
  AND created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
GROUP BY 1, 2, 3
QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY weekday_lunch_txns DESC) = 1;

-- 2e. USER-LEVEL: Spending pattern segmentation
-- Classify users by their dining behavior patterns
WITH user_spend_patterns AS (
    SELECT
        user_id,
        COUNT(*) AS total_txns,
        ROUND(SUM(CAST(base_currency_amount AS FLOAT64)), 2) AS total_spend_90d,
        ROUND(SUM(CAST(base_currency_amount AS FLOAT64)) / 3, 2) AS avg_monthly_spend,
        ROUND(AVG(CAST(base_currency_amount AS FLOAT64)), 2) AS avg_txn_value,
        COUNT(DISTINCT DATE(created_at)) AS active_days,
        -- Time of day patterns
        COUNT(CASE WHEN EXTRACT(HOUR FROM created_at) BETWEEN 10 AND 14 THEN 1 END) AS lunch_txns,
        COUNT(CASE WHEN EXTRACT(HOUR FROM created_at) BETWEEN 17 AND 22 THEN 1 END) AS dinner_txns,
        -- Day of week patterns
        COUNT(CASE WHEN EXTRACT(DAYOFWEEK FROM created_at) IN (1, 7) THEN 1 END) AS weekend_txns,
        COUNT(CASE WHEN EXTRACT(DAYOFWEEK FROM created_at) BETWEEN 2 AND 6 THEN 1 END) AS weekday_txns,
        -- Geographic spread
        COUNT(DISTINCT ROUND(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64), 2)) AS unique_areas
    FROM `max-sg.pg_public.spend_transactions`
    WHERE status = 'SETTLED'
      AND deleted_at IS NULL
      AND JSON_VALUE(merchant, '$.mcc.l2_category') IN ('Fast Food Restaurants', 'Restaurants (excluding Bars)')
      AND created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
    GROUP BY 1
    HAVING COUNT(*) >= 3  -- minimum 3 transactions to classify
)

SELECT
    user_id,
    total_txns,
    avg_monthly_spend,
    avg_txn_value,
    -- Spend tier
    CASE
        WHEN avg_monthly_spend >= 500 THEN 'Heavy Spender ($500+/mo)'
        WHEN avg_monthly_spend >= 200 THEN 'Regular Spender ($200-500/mo)'
        WHEN avg_monthly_spend >= 50  THEN 'Light Spender ($50-200/mo)'
        ELSE 'Occasional (<$50/mo)'
    END AS spend_tier,
    -- Frequency pattern
    CASE
        WHEN total_txns >= 30 THEN 'Very Frequent (30+/90d)'
        WHEN total_txns >= 15 THEN 'Frequent (15-30/90d)'
        WHEN total_txns >= 5  THEN 'Regular (5-15/90d)'
        ELSE 'Occasional (<5/90d)'
    END AS frequency_pattern,
    -- Time preference
    CASE
        WHEN lunch_txns > dinner_txns * 2 THEN 'Lunch-Heavy'
        WHEN dinner_txns > lunch_txns * 2 THEN 'Dinner-Heavy'
        WHEN lunch_txns > 0 AND dinner_txns > 0 THEN 'Mixed (Lunch+Dinner)'
        ELSE 'Off-Peak'
    END AS time_preference,
    -- Day preference
    CASE
        WHEN weekend_txns > weekday_txns THEN 'Weekend Diner'
        WHEN weekday_txns > weekend_txns * 2 THEN 'Weekday-Only'
        ELSE 'Mixed (Weekday+Weekend)'
    END AS day_preference,
    -- Mobility pattern
    CASE
        WHEN unique_areas = 1 THEN 'Single Location'
        WHEN unique_areas <= 3 THEN 'Low Mobility (2-3 areas)'
        ELSE 'High Mobility (4+ areas)'
    END AS mobility_pattern,
    -- Composite persona (example — customize as needed)
    CASE
        WHEN avg_monthly_spend >= 300 AND lunch_txns > dinner_txns
             THEN 'High-Value Lunch Regular'
        WHEN avg_monthly_spend >= 300 AND dinner_txns > lunch_txns
             THEN 'High-Value Dinner Regular'
        WHEN weekday_txns > weekend_txns * 2 AND lunch_txns > 10
             THEN 'Office Worker (Lunch-Focused)'
        WHEN weekend_txns > weekday_txns AND dinner_txns > 5
             THEN 'Weekend Social Diner'
        WHEN avg_txn_value >= 150
             THEN 'Premium Diner'
        WHEN total_txns >= 20 AND avg_txn_value < 100
             THEN 'Frequent Budget Diner'
        ELSE 'Casual Diner'
    END AS user_persona
FROM user_spend_patterns
ORDER BY avg_monthly_spend DESC;


-- ============================================================
-- 3. COHORT BUILDING — GEO × CATEGORY × SPEND
-- Goal: Build the actual targetable cohorts for merchant decks
-- ============================================================

-- 3a. Restaurant diner cohort — MCC-based, last 90 days
-- THIS IS YOUR V1 COHORT. Simple MCC filter, no name matching needed.
WITH restaurant_txns AS (
    SELECT
        user_id,
        ROUND(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64), 2) AS lat_rounded,
        ROUND(CAST(JSON_VALUE(merchant, '$.longitude') AS FLOAT64), 2) AS lng_rounded,
        CAST(base_currency_amount AS FLOAT64) AS amount,
        created_at
    FROM `max-sg.pg_public.spend_transactions`
    WHERE status = 'SETTLED'
      AND deleted_at IS NULL
      AND created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
      AND JSON_VALUE(merchant, '$.mcc.l2_category') IN ('Fast Food Restaurants', 'Restaurants (excluding Bars)')  -- L2 is more accurate than L1
      -- Optional: further filter by mcc.l2_category if L2 is granular enough
),

user_restaurant_spend AS (
    SELECT
        user_id,
        COUNT(*) AS txn_count_90d,
        ROUND(SUM(amount), 2) AS total_spend_90d,
        ROUND(SUM(amount) / 3, 2) AS avg_monthly_spend,
        COUNT(DISTINCT DATE_TRUNC(created_at, MONTH)) AS active_months
    FROM restaurant_txns
    GROUP BY 1
)

SELECT
    CASE
        WHEN avg_monthly_spend >= 500 THEN 'Heavy ($500+/mo)'
        WHEN avg_monthly_spend >= 200 THEN 'Regular ($200-500/mo)'
        WHEN avg_monthly_spend >= 50  THEN 'Light ($50-200/mo)'
        ELSE 'Occasional (<$50/mo)'
    END AS spend_tier,
    COUNT(DISTINCT user_id) AS users,
    ROUND(AVG(avg_monthly_spend), 2) AS avg_monthly_spend,
    ROUND(AVG(txn_count_90d), 1) AS avg_txns_90d
FROM user_restaurant_spend
GROUP BY 1
ORDER BY avg_monthly_spend DESC;


-- 3b. THE COHORT MAP — geo × spend level (MCC-based, restaurant diners)
-- This is what BD uses to decide where to pitch.
-- V1 = single category (restaurants), so no category dimension needed yet.
WITH restaurant_txns AS (
    SELECT
        user_id,
        ROUND(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64), 2) AS lat_rounded,
        ROUND(CAST(JSON_VALUE(merchant, '$.longitude') AS FLOAT64), 2) AS lng_rounded,
        CAST(base_currency_amount AS FLOAT64) AS amount
    FROM `max-sg.pg_public.spend_transactions`
    WHERE status = 'SETTLED'
      AND deleted_at IS NULL
      AND created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
      AND JSON_VALUE(merchant, '$.mcc.l2_category') IN ('Fast Food Restaurants', 'Restaurants (excluding Bars)')  -- L2 is more accurate than L1
),

user_geo_spend AS (
    SELECT
        user_id,
        lat_rounded,
        lng_rounded,
        COUNT(*) AS txn_count_90d,
        ROUND(SUM(amount) / 3, 2) AS avg_monthly_spend
    FROM restaurant_txns
    WHERE lat_rounded IS NOT NULL
    GROUP BY 1, 2, 3
)

SELECT
    lat_rounded,
    lng_rounded,
    CASE
        WHEN avg_monthly_spend >= 500 THEN 'Heavy ($500+/mo)'
        WHEN avg_monthly_spend >= 200 THEN 'Regular ($200-500/mo)'
        WHEN avg_monthly_spend >= 50  THEN 'Light ($50-200/mo)'
        ELSE 'Occasional (<$50/mo)'
    END AS spend_tier,
    COUNT(DISTINCT user_id) AS cohort_size,
    ROUND(AVG(avg_monthly_spend), 2) AS avg_spend_per_user,
    ROUND(SUM(avg_monthly_spend), 2) AS total_monthly_spend
FROM user_geo_spend
GROUP BY 1, 2, 3
HAVING COUNT(DISTINCT user_id) >= 10  -- minimum viable cohort size
ORDER BY cohort_size DESC
LIMIT 50;


-- ============================================================
-- 4. MERCHANT-SPECIFIC INSIGHTS
-- Goal: For a specific merchant, show what we know about their customers
-- Useful for BD prep before pitching a specific restaurant
-- ============================================================

-- 4a. Customer profile for a specific merchant
-- Replace 'TARGET_MERCHANT_NAME' with the actual merchant
SELECT
    COUNT(DISTINCT user_id) AS total_customers,
    COUNT(*) AS total_transactions,
    ROUND(AVG(CAST(base_currency_amount AS FLOAT64)), 2) AS avg_txn_value,
    ROUND(SUM(CAST(base_currency_amount AS FLOAT64)), 2) AS total_revenue_via_our_cards,
    MIN(created_at) AS first_seen,
    MAX(created_at) AS last_seen
FROM `max-sg.pg_public.spend_transactions`
WHERE status = 'SETTLED'
  AND deleted_at IS NULL
  AND (LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%TARGET_MERCHANT_NAME%'
    OR LOWER(merchant_name) LIKE '%TARGET_MERCHANT_NAME%');

-- 4b. Lapsed customers — used to visit but haven't in 90+ days
WITH merchant_customers AS (
    SELECT
        user_id,
        MAX(created_at) AS last_visit,
        COUNT(*) AS total_visits,
        ROUND(AVG(CAST(base_currency_amount AS FLOAT64)), 2) AS avg_spend
    FROM `max-sg.pg_public.spend_transactions`
    WHERE status = 'SETTLED'
      AND deleted_at IS NULL
      AND (LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%TARGET_MERCHANT_NAME%'
        OR LOWER(merchant_name) LIKE '%TARGET_MERCHANT_NAME%')
    GROUP BY 1
)

SELECT
    COUNT(*) AS lapsed_customers,
    ROUND(AVG(total_visits), 1) AS avg_previous_visits,
    ROUND(AVG(avg_spend), 2) AS avg_spend_per_visit
FROM merchant_customers
WHERE last_visit < TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
  AND total_visits >= 2;  -- they were repeat customers, not one-timers

-- 4c. What else do this merchant's customers spend on?
-- Cross-category affinity (Tier 2 insight)
WITH target_customers AS (
    SELECT DISTINCT user_id
    FROM `max-sg.pg_public.spend_transactions`
    WHERE status = 'SETTLED'
      AND deleted_at IS NULL
      AND (LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%TARGET_MERCHANT_NAME%'
        OR LOWER(merchant_name) LIKE '%TARGET_MERCHANT_NAME%')
)

SELECT
    JSON_VALUE(t.merchant, '$.mcc.l1_category') AS mcc_l1_category,
    JSON_VALUE(t.merchant, '$.mcc.l2_category_desc') AS mcc_l2_category_desc,
    COUNT(*) AS txn_count,
    COUNT(DISTINCT t.user_id) AS unique_customers,
    ROUND(AVG(CAST(t.base_currency_amount AS FLOAT64)), 2) AS avg_txn_value
FROM `max-sg.pg_public.spend_transactions` t
INNER JOIN target_customers tc ON t.user_id = tc.user_id
WHERE t.status = 'settled'
  AND t.deleted_at IS NULL
  AND LOWER(COALESCE(JSON_VALUE(t.merchant, '$.name'), t.merchant_name)) NOT LIKE '%TARGET_MERCHANT_NAME%'  -- exclude target merchant
  AND LOWER(t.merchant_name) NOT LIKE '%TARGET_MERCHANT_NAME%'
GROUP BY 1, 2
ORDER BY unique_customers DESC
LIMIT 20;


-- ============================================================
-- 5. PITCH DECK NUMBERS
-- Goal: Generate the exact numbers BD needs for merchant presentations
-- ============================================================

-- 5a. "Users near you who spend on [category] but have never been to your restaurant"
-- THE most important query — this is the acquisition pitch
-- Replace TARGET coordinates and category keywords
WITH target_area_spenders AS (
    -- Users who spend on Japanese dining near the target merchant
    SELECT DISTINCT user_id
    FROM `max-sg.pg_public.spend_transactions`
    WHERE status = 'SETTLED'
      AND deleted_at IS NULL
      AND created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
      AND JSON_VALUE(merchant, '$.latitude') IS NOT NULL
      AND JSON_VALUE(merchant, '$.latitude') != ''
      -- Within ~1km of target merchant (rough bounding box)
      -- Replace TARGET_LAT / TARGET_LNG with merchant coordinates
      AND ABS(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64) - TARGET_LAT) < 0.01
      AND ABS(CAST(JSON_VALUE(merchant, '$.longitude') AS FLOAT64) - TARGET_LNG) < 0.01
      AND (
        LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%sushi%'
        OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%ramen%'
        OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%izakaya%'
        OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%yakiniku%'
        -- add category keywords
      )
),

target_merchant_customers AS (
    -- Users who HAVE visited the target merchant
    SELECT DISTINCT user_id
    FROM `max-sg.pg_public.spend_transactions`
    WHERE status = 'SETTLED'
      AND deleted_at IS NULL
      AND (LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%TARGET_MERCHANT_NAME%'
        OR LOWER(merchant_name) LIKE '%TARGET_MERCHANT_NAME%')
)

-- Users who spend on the category nearby but have NEVER visited this merchant
SELECT
    COUNT(*) AS potential_new_customers,
    'These users spend on Japanese dining within 1km but have never visited your restaurant' AS pitch_line
FROM target_area_spenders
WHERE user_id NOT IN (SELECT user_id FROM target_merchant_customers);

-- 5b. Summary stats for the pitch deck
-- Monthly spend of the non-customer cohort (proves they have budget)
WITH target_area_spenders AS (
    SELECT
        user_id,
        CAST(base_currency_amount AS FLOAT64) AS amount,
        created_at
    FROM `max-sg.pg_public.spend_transactions`
    WHERE status = 'SETTLED'
      AND deleted_at IS NULL
      AND created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
      AND JSON_VALUE(merchant, '$.latitude') IS NOT NULL
      AND JSON_VALUE(merchant, '$.latitude') != ''
      AND ABS(CAST(JSON_VALUE(merchant, '$.latitude') AS FLOAT64) - TARGET_LAT) < 0.01
      AND ABS(CAST(JSON_VALUE(merchant, '$.longitude') AS FLOAT64) - TARGET_LNG) < 0.01
      AND (
        LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%sushi%'
        OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%ramen%'
        OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%izakaya%'
        OR LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%yakiniku%'
      )
),

target_merchant_customers AS (
    SELECT DISTINCT user_id
    FROM `max-sg.pg_public.spend_transactions`
    WHERE status = 'SETTLED'
      AND deleted_at IS NULL
      AND (LOWER(COALESCE(JSON_VALUE(merchant, '$.name'), merchant_name)) LIKE '%TARGET_MERCHANT_NAME%'
        OR LOWER(merchant_name) LIKE '%TARGET_MERCHANT_NAME%')
),

non_customers AS (
    SELECT
        s.user_id,
        s.amount,
        s.created_at
    FROM target_area_spenders s
    WHERE s.user_id NOT IN (SELECT user_id FROM target_merchant_customers)
)

SELECT
    COUNT(DISTINCT user_id) AS potential_customers,
    ROUND(SUM(amount) / 3, 2) AS cohort_monthly_spend,
    ROUND(SUM(amount) / 3 / COUNT(DISTINCT user_id), 2) AS avg_monthly_spend_per_user,
    ROUND(AVG(amount), 2) AS avg_transaction_value
FROM non_customers;
