# Phase 1 Experiment: Ranking Position Impact Test

Ticket: https://linear.app/heymax/issue/ENG-2732/hypothesis-setup

## Experiment Overview
**Objective:** Isolate and measure the causal impact of ranking position on merchant performance metrics (CTR, CVR).

**Test Merchant:** Nike
**Placement:** Explore page
**Duration:** [TBD]
**Sample Size:** [TBD based on power analysis]

---

## Hypothesis
**IF** we change Nike's ranking position on the Explore page
**THEN** we will observe a measurable change in impressions, CTR, and CVR
**BECAUSE** ranking position directly affects visibility and perceived merchant credibility

---

## Experiment Design

### Test Groups
| Group | Nike Position | Sample Split | Notes |
| --- | --- | --- | --- |
| **Control** | Current position (baseline) | 33% | No changes to existing ranking algorithm |
| **Variant A** | Position 5 | 33% | High visibility placement |
| **Variant B** | Position 25 | 33% | Lower visibility placement |

### Randomisation
- User-level randomisation (consistent experience per user)
- Stratified by [user segment/activity level if needed]
- Equal traffic split across all three groups

---

## Controlled Variables (Must Keep Constant)

To ensure a fair test, these factors **MUST NOT CHANGE** during the experiment period:

1. **Merchant attributes:**
  - Miles earning rate (same across all variants)
  - Deal presence (no new deals launched mid-test)
  - Visual presentation (no logo/badge changes)
  - Merchant category/vertical

2. **Placement context:**
  - Only test on Explore page (not deals, search, or other placements)
  - Same sorting algorithm for all other merchants
  - No featured tags or promotional badges on Nike

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
| **Impressions** | no. of times Nike appears in user viewport | Directional validation (higher position = more impressions) |
| **CTR** | (Clicks / Impressions) × 100% | >10% lift for Variant A vs Control |
| **CVR** | (Transactions / Clicks) × 100% | No degradation vs Control |
| **Position Elasticity** | % change in CTR per position change | Measurable negative correlation |

---

## Secondary Metrics (Guardrails)

- **Overall Explore page CTR:** Should not decrease (ensures we're not cannibalising other merchants)
- **Nike CVR:** Should remain stable (validates that clicks are quality traffic)
- **User engagement:** Time on page, scroll depth (detect negative UX impact)

---

## Statistical Requirements

- **Minimum Detectable Effect (MDE):** [TBD - typically 5-10% CTR change]
- **Statistical Power:** 80%
- **Significance Level:** α = 0.05 (two-tailed test)
- **Test Duration:** Run until statistical significance achieved OR 2 weeks minimum

---

## Analysis Plan

### 1. Primary Analysis
- Compare CTR between Control, Variant A, and Variant B
- Calculate position elasticity: log(CTR) vs log(Position)
- Test statistical significance using [t-test / chi-square / appropriate method]

### 2. Segmentation Analysis
- By user activity level (new vs returning users)
- By device type (mobile vs desktop)
- By time of day / day of week

### 3. Validation Checks
- **Simpson's Paradox check:** Ensure direction of effect is consistent across segments
- **Novelty effect:** Compare Week 1 vs Week 2 CTR to detect decay
- **Cannibalisation:** Measure if other merchants' CTR dropped

---

## Success Criteria

### Experiment validates hypothesis if:
1. ✅ Variant A (position 5) shows statistically significant CTR uplift vs Control
2. ✅ Variant B (position 25) shows statistically significant CTR decrease vs Control
3. ✅ Position elasticity coefficient is negative and significant
4. ✅ CVR remains stable across all variants (±5% tolerance)
5. ✅ Overall Explore page metrics remain neutral or improve

### Experiment fails to validate if:
1. ❌ No statistically significant difference in CTR between variants
2. ❌ CTR increases but CVR drops significantly (quality of traffic issue)
3. ❌ Results are inconsistent across user segments (confounding factors)

---

## Implementation Checklist

**Pre-Launch:**
- [ ] Confirm Nike has no scheduled deals/promotions during test period
- [ ] Verify no other Explore page experiments running concurrently
- [ ] Set up tracking for impression-level data (not just click-level)
- [ ] Configure user bucketing logic (ensure consistent assignment)
- [ ] Define exclusion criteria (bots, internal users, etc.)

**During Test:**
- [ ] Daily monitoring of traffic split (should remain ~33/33/33)
- [ ] Check for data quality issues (missing impressions, tracking errors)
- [ ] Monitor for external factors (Nike PR events, competitor activity)

**Post-Test:**
- [ ] Run statistical significance tests
- [ ] Document confounding factors observed
- [ ] Prepare recommendation for Phase 2 (personalization layer)

---

## Known Limitations

1. **Single merchant test:** Results may not generalise to all merchant types (Nike is a popular brand)
2. **Single placement:** Explore page behaviour may differ from Search or Deals pages
3. **Uncontrolled factors:** User intent, seasonality, external Nike marketing still influence results
4. **Short-term test:** Cannot measure long-term habituation or saturation effects

**Mitigation:** Phase 2 should test multiple merchants across different categories and placements.