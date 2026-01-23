# Merchant Search Improvements

**Project:** https://linear.app/heymax/project/merchant-search-improvements-ee4e2b902196/

---

## Problem / Objective

Users are not engaging with search recommendations effectively, leading to low CTR and missed opportunities for merchant discovery.

**Objective**: Increase CTR and CVR on search recommendations and discovery features to drive more engagement and merchant visits.

---

## What success looks like
| Metric | Target |
| --- | --- |
| CTR on recommendations | Increase by X% |
| CVR on popular searches | Increase by X% |
| CTR on recent searches | Increase by X% |

---

## Supporting signals
- Analytics showing CTR on "For you" recommendations being high mainly because people are using it as a bookmark section
- Low engagement with current "Handpicked for you" section

---

## Product requirements

| # | User story | Acceptance criteria |
| --- | --- | --- |
| 1 | As a user, I want my recent searches on the search page to show merchants I've searched instead of raw search text | Recent searches display merchant names instead of raw search text |
| 2 | As a user, I want to see popular searches instead of "handpicked for you" | Replace "Handpicked for you" with "Popular searches" section\n\n[Figma](https://www.figma.com/design/kSCAqiLzY1p2B6IwE46Q4B/-HeyMax--Search?node-id=202-2700&t=iy8owN6MQUmIHjkH-1) |
---

## Hypotheses to validate
| Hypothesis | Validation method |
| --- | --- |
| Showing recent merchants (vs search text) increases re-engagement | A/B test with CTR on recent searches |
| Popular searches will yield higher CTR than "Handpicked for you" | A/B test comparing CTR between variants |
## Events tracking

### Updates Required to `omni_search_item` Event

**Current event:** `omni_search_item` with attributes: `source`, `query`, `useVisaApi`, `country`, `paymentTags`, `userCountry`, `merchant`, `type`, `isProductSearch`, `searchStatus`

**Changes needed:**

1. **For Recent Searches (Hypothesis 1)**
  - When `source` = `recent_search`, ensure the `merchant` attribute is populated with the merchant name (not raw search text)
  - This allows us to track CTR on merchant-based recent searches vs text-based recent searches in A/B test

2. **For Popular Searches (Hypothesis 2)**
  - Ensure `source` = `popular_search` fires when users tap on popular search items
  - Track which popular searches are being clicked to compare CTR against "Handpicked for you" recommendations

**No new events needed** - existing `omni_search_item` event structure supports both hypotheses with proper attribute population.

---

## Launch checklist

- [ ] Experiment plan defined for hypotheses
- [ ] Tracking events implemented
- [ ] A/B test setup for recent merchants vs search text
- [ ] A/B test setup for popular searches vs handpicked