# Phase 3 Experiment: Monetary Incentive (Miles Booster) Impact Test

Ticket: [TBD]

## Experiment Overview
**Objective:** Measure whether bonus miles incentives drive incremental CVR for merchants where users click but don't convert, and whether the uplift justifies the booster cost.

**Placement:** Explore page
**Test Merchant Selection:** Merchants with above-average CTR but below-average CVR (high interest, low conversion)
**Duration:** [TBD]
**Sample Size:** [TBD based on power analysis]

---
## Hypothesis
**IF** we offer bonus miles (e.g., 2x or 3x earn rate) on selected merchants
**THEN** we will observe higher CVR without degrading baseline CVR post-campaign
**BECAUSE** users who click but don't convert lack sufficient monetary motivation to complete the transaction

---
## Known Limitations
1. **Cannibalisation risk:** Users may delay purchases to wait for boosters, or shift spend from non-boosted merchants
2. **Novelty effect:** Initial uplift may not sustain — users habituate to boosters
3. **Selection bias:** Merchants chosen for test may not represent all underperformers
4. **Attribution:** Difficult to isolate booster effect from other factors (merchant promotions, seasonality)
5. **Cost sensitivity:** ROI depends heavily on merchant contribution margin, which varies

---
## Experiment Design
### Test Groups
| Group | Incentive | Sample Split |
| --- | --- | --- |
| **Control** | Standard miles rate (1x) | 50% |
| **Variant A** | 2x miles rate | 25% |
| **Variant B** | 3x miles rate | 25% |

### Why two variant tiers:
- Measures dose-response: does a higher booster yield proportionally higher CVR?
- Helps determine optimal booster level for ROI

### Merchant Selection Criteria
- CTR above category median (users are interested)
- CVR below category median (users aren't converting)
- Sufficient click volume for statistical significance

---
## Controlled Variables (Must Keep Constant)
1. **Merchant attributes:**
  - No new deals or promotions launched mid-test
  - Same visual presentation (booster badge is the only difference)
  - Ranking position unchanged during test
2. **Placement context:**
  - Same placement and rank for test merchants across all groups
  - No other ranking experiments running simultaneously
3. **User experience:**
  - Same page layout and design
  - Booster clearly communicated (e.g., "Earn 2x miles") — no hidden incentive
4. **Timing:**
  - Avoid seasonal peaks and major sales events
  - Include post-campaign observation period (2 weeks after booster ends)

---
## Primary Metrics
| Metric | Definition | Success Threshold |
| --- | --- | --- |
| **CVR** | Conversions / clicks on boosted merchants | >15% lift for Variant A vs Control |
| **Incremental CVR** | CVR uplift attributable to booster (not cannibalised) | Positive after accounting for baseline trend |
| **ROI** | Incremental revenue / booster cost | >1.0 (revenue exceeds booster cost) |

---
## Secondary Metrics (Guardrails)
- **Non-boosted merchant CVR:** Should not decrease (cannibalisation check)
- **Post-campaign CVR:** Boosted merchant CVR after campaign ends — should not drop below pre-campaign baseline (no dependency creation)
- **CTR on boosted merchants:** Should remain stable (booster shouldn't inflate curiosity clicks)
- **Overall platform CVR:** No regression

---
## Success Criteria
### Experiment validates hypothesis if:
1. Variant A and/or B show statistically significant CVR uplift vs Control
2. Incremental CVR is positive (not cannibalised from other merchants)
3. ROI > 1.0 for at least one variant tier
4. Post-campaign CVR does not drop below pre-campaign baseline
5. Non-boosted merchant CVR remains stable

### Experiment fails to validate if:
1. No statistically significant CVR difference
2. CVR uplift exists but ROI < 1.0 (cost exceeds incremental revenue)
3. Non-boosted merchant CVR drops (cannibalisation)
4. Post-campaign CVR drops below baseline (users trained to wait for boosters)
5. Only works at 3x tier — unsustainable cost structure
