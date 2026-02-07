# Phase 2 Experiment: Relevancy / Personalisation Impact Test

Ticket: [TBD]

## Experiment Overview
**Objective:** Measure whether personalised merchant ranking (based on user behaviour) outperforms static popularity-based ranking on CTR and CVR.

**Placement:** Explore page
**Duration:** [TBD]
**Sample Size:** [TBD based on power analysis]

---
## Hypothesis
**IF** we rank merchants based on a user's past transaction history and browsing behaviour
**THEN** we will observe higher CTR and CVR compared to the default popularity sort
**BECAUSE** users are more likely to engage with merchants that match their existing spending patterns and interests

---
## Known Limitations
1. **Cold start:** New users without transaction history cannot be personalised — must fall back to default ranking
2. **Single placement:** Explore page behaviour may differ from other surfaces
3. **Attribution window:** Users may have been exposed to merchants via other channels (marketing, BD outreach)
4. **Data recency:** Personalisation based on stale transaction data may not reflect current intent
5. **Category bias:** Users with narrow spending history may get overly narrow recommendations

---
## Experiment Design
### Test Groups
| Group | Ranking Logic | Sample Split |
| --- | --- | --- |
| **Control** | Default popularity sort (current behaviour) | 50% |
| **Variant** | Personalised ranking based on user transaction history + browsing signals | 50% |

### Personalisation Signals (Variant)
- Past transaction categories (e.g., user frequently shops online → rank e-commerce higher)
- Past merchant interactions (clicked/converted merchants ranked higher)
- Recency weighting (recent behaviour weighted more than older)
- [TBD: additional signals based on available data]

---
## Controlled Variables (Must Keep Constant)
1. **Merchant attributes:**
  - Miles earning rates unchanged during test
  - No new deals launched mid-test for test merchants
  - Same visual presentation across groups
2. **Placement context:**
  - Only test on Explore page
  - Same merchant pool available to both groups
  - No featured tags or promotional badges differing between groups
3. **User experience:**
  - Same page layout and design
  - No other A/B tests running on Explore page
4. **Timing:**
  - Avoid seasonal peaks
  - No major marketing campaigns during test

---
## Primary Metrics
| Metric | Definition | Success Threshold |
| --- | --- | --- |
| **CTR** | Clicks on merchants / impressions | >10% lift for Variant vs Control |
| **CVR** | Conversions / clicks | >5% lift for Variant vs Control |
| **Diversity** | Unique merchants clicked per user session | No significant decrease vs Control |

---
## Secondary Metrics (Guardrails)
- **Overall Explore page CTR:** Should not decrease
- **Long-tail merchant exposure:** Personalisation should not exclusively favour top merchants
- **New user experience:** Cold-start users in Variant should perform no worse than Control

---
## Success Criteria
### Experiment validates hypothesis if:
1. Variant shows statistically significant CTR uplift vs Control
2. Variant shows statistically significant CVR uplift vs Control
3. Merchant diversity per session remains stable (±10% tolerance)
4. Overall Explore page metrics remain neutral or improve
5. Effect holds across user segments (new vs returning, high vs low activity)

### Experiment fails to validate if:
1. No statistically significant difference in CTR or CVR
2. CTR improves but CVR drops (personalisation attracts curiosity clicks, not purchase intent)
3. Only works for high-activity users — no effect on majority of user base
4. Merchant diversity drops significantly (filter bubble effect)
