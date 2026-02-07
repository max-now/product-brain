# Phase 1 Experiment: Ranking Position Impact Test

Ticket: https://linear.app/heymax/issue/ENG-2732/hypothesis-setup

## Experiment Overview
**Objective:** Isolate and measure the causal impact of ranking position on merchant performance metrics (CTR, CVR).

**Placement:** Explore page
**Test Merchant Category Group:**
- Group 1 [Shop Online]
  - SHEIN, Apple, Nike
  - Amazon, Samsung, PUMA

why we need 2 merchant groups:
- to prevent control from having a merchant in the merchant group being in the same spot as the experiment.
optional
- Group 2 [Book Travel]
  - Klook, Agoda, Income Travel Insurance
  - Pelago, Booking.com, FWD Travel Insurance
**Duration:** 9th Feb - 30 Feb
**Sample Size:** [TBD based on power analysis]

---
## Hypothesis
**IF** we change a group of merchant's ranking position on the Explore page
**THEN** we will observe a measurable change in impressions, CTR, and CVR
**BECAUSE** ranking position directly affects visibility and perceived merchant credibility
---
## Known Limitations
1. **Merchant group test:** Results may not generalise to merchant of all types
2. **Single placement:** Explore page behaviour may differ from Search or Deals pages of varying number of merchant
3. **Uncontrolled factors:** User intent, seasonality, external merchant marketing still influence results
4. **Short-term test:** Cannot measure long-term habituation or saturation effects
---
## Experiment Design
### Test Groups
| Group | Group Position | Sample Split |
| --- | --- | --- |
| **Variant A** | Row 1 | 50% |
| **Variant B** | Row 8 | 50% |
---
## Controlled Variables (Must Keep Constant)
To ensure a fair test, these factors **SHOULD NOT CHANGE** during the experiment period:

1. **Merchant attributes:**
- Miles earning rate (same across all variants)
- Deal presence (no new deals launched mid-test)
- Visual presentation (no logo/badge changes)
- Merchant category/vertical
2. **Placement context:**
- Only test on Explore page
  - if not possible, then all available surfaces.
- Same sorting algorithm for all other merchants
- No featured tags or promotional badges on merchant group
3. **User experience:**
- Same page layout and design
- No A/B tests running on Explore page UI
- No marketing campaigns specifically promoting Nike
4. **Timing:**
- Avoid seasonal peaks (holidays, major sales events)
- No external Nike campaigns/events during test period

---
## Primary Metrics
| Metric | Definition | Success Threshold |
| --- | --- | --- |
| **Impressions** | no. of times users has viewed page | Directional validation (higher position = more impressions) |
| **CTR** | clicks into merchants in the merchant group | >10% lift for Variant A vs Control |
| **CVR** | clicks into swm of merchants in the merchant group | No degradation vs Control |
| **Position Elasticity** | % change in CTR per position change | Measurable negative correlation |
---
## Secondary Metrics (Guardrails)
- **Overall Explore page CTR:** Should not decrease (ensures we're not cannibalising other merchants)
- **Merchant Group CVR:** Should remain stable (validates that clicks are quality traffic)
---
## Success Criteria
### Experiment validates hypothesis if:
1. ✅ Variant A (row 1) shows statistically significant CTR uplift vs Control
2. ✅ Variant B (row 8) shows statistically significant CTR decrease vs Control
3. ✅ Position elasticity coefficient is negative and significant
4. ✅ CVR remains stable across all variants (±5% tolerance)
5. ✅ Overall Explore page metrics remain neutral or improve

### Experiment fails to validate if:
1. ❌ No statistically significant difference in CTR between variants
2. ❌ CTR increases but CVR drops significantly (quality of traffic issue)
3. ❌ Results are inconsistent across user segments (confounding factors)