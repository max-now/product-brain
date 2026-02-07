---
planStatus:
  planId: plan-merchant-content-experiment
  title: Merchant Page Content Marketing Experiment
  status: draft
  planType: research
  priority: high
  owner: davidwang
  stakeholders: []
  tags:
    - experiment
    - content-marketing
    - conversion
    - merchant-page
  created: "2026-02-06"
  updated: "2026-02-06T00:00:00.000Z"
  progress: 0
---
# Merchant Page Content Marketing Experiment

## Experiment Overview

**Objective:** Measure the causal impact of visual content and user testimonials on merchant page engagement (intent) and conversion.

**Placement:** Merchant Detail Page (mobile and web)

**Target Merchant Categories:**
- **Primary:** Restaurants (Dine category)
- **Secondary:** Hotels (Hotels category)
- **Control comparison:** General retail merchants

**Duration:** [TBD - recommend 3-4 weeks minimum]

**Sample Size:** [TBD based on power analysis]

---

## Hypothesis

**IF** we add visual content (photos/videos) and user testimonials to merchant detail pages
**THEN** we will observe increased time on page and higher click-through to earning actions
**BECAUSE** rich visual content and social proof reduce decision friction and increase user confidence in the merchant

### Sub-hypotheses

1. **Restaurant & Hotel Amplification:** The effect will be stronger for restaurants and hotels because these categories are experience-based and benefit more from visual preview and social proof than transactional retail.

2. **Visual Content Effect:** Photos/videos create emotional connection and help users envision the experience, driving higher engagement.

3. **Social Proof Effect:** User testimonials reduce perceived risk and validate earning potential, increasing conversion intent.

---

## Known Limitations

1. **Content availability:** Not all merchants may have quality visual content or testimonials available
2. **Content quality variance:** Inconsistent content quality across merchants may confound results
3. **Vertical bias:** Restaurant/hotel merchants may have inherently more visual content available, biasing the category comparison
4. **Selection bias:** Users who reach merchant pages may already have high intent
5. **Short-term test:** Cannot measure long-term brand perception or repeat visit effects
6. **Platform differences:** Mobile vs web engagement patterns may differ

---

## Experiment Design

### Test Groups

| Group | Content Treatment | Sample Split |
| --- | --- | --- |
| **Control** | Current merchant page (no content additions) | 50% |
| **Variant A** | Merchant page + visual content gallery + user testimonials | 50% |

### Optional Extended Design (Category Segmentation)

| Category | Control | Variant A | Notes |
| --- | --- | --- | --- |
| **Restaurants** | 50% | 50% | Primary hypothesis validation |
| **Hotels** | 50% | 50% | Primary hypothesis validation |
| **General Retail** | 50% | 50% | Baseline comparison |

---

## Content Specification

### Visual Content Gallery
- **Position:** Below merchant header, above earning strategy section
- **Format:** Horizontal scrollable carousel
- **Content:** 3-6 high-quality photos or 1 video + photos
- **Source:** [TBD - merchant-provided, scraped, or curated]

### User Testimonials Section
- **Position:** Below earning strategy, above card rewards
- **Format:** 2-3 testimonial cards
- **Content:** User quotes about earning/redemption experience
- **Elements per testimonial:**
  - User avatar (anonymized or initials)
  - Quote text (40-80 words)
  - Miles earned or benefit received
  - Date of experience
- **Source:** [TBD - real user data, synthesized for test, or curated]

---

## Controlled Variables (Must Keep Constant)

1. **Merchant attributes:**
  - Miles earning rate (same across all variants)
  - Active promotions/campaigns
  - Merchant ranking position on other surfaces

2. **Page structure:**
  - Same header, earning strategy, and card rewards sections
  - Same CTA buttons and placements
  - No other A/B tests running on merchant pages

3. **User experience:**
  - Same navigation and page load performance
  - No marketing campaigns promoting specific test merchants

4. **Timing:**
  - Avoid major holidays or seasonal peaks
  - No merchant-specific external campaigns

---

## Primary Metrics

| Metric | Definition | Success Threshold |
| --- | --- | --- |
| **Time on Page** | Avg seconds spent on merchant detail page | >15% increase vs Control |
| **Earning Action CTR** | Clicks on "Earn Now", affiliate links, or booking buttons | >10% lift vs Control |
| **Scroll Depth** | % of users who scroll past the content section | >20% increase vs Control |

---

## Secondary Metrics (Guardrails)

| Metric | Definition | Threshold |
| --- | --- | --- |
| **Bounce Rate** | Users who leave without any interaction | No increase vs Control |
| **Page Load Time** | Time to interactive (content may add latency) | <500ms increase |
| **CVR (Post-click)** | Actual conversions after earning action click | No degradation (±5%) |
| **Overall Merchant Page Traffic** | Total visits to merchant pages | Neutral or positive |

---

## Success Criteria

### Experiment validates hypothesis if:

1. ✅ Variant A shows statistically significant increase in Time on Page (>15%)
2. ✅ Variant A shows statistically significant increase in Earning Action CTR (>10%)
3. ✅ Effect size is larger for Restaurant and Hotel categories vs General Retail
4. ✅ Bounce rate remains stable or decreases
5. ✅ Post-click CVR is not degraded (quality traffic maintained)

### Experiment fails to validate if:

1. ❌ No statistically significant difference in primary metrics
2. ❌ Time on page increases but CTR decreases (engagement without action)
3. ❌ Bounce rate increases significantly (content drives users away)
4. ❌ Effect is equal or lower for Restaurants/Hotels vs General Retail
5. ❌ Page load time significantly increases, impacting UX

---

## Category-Specific Analysis

To validate the Restaurant/Hotel hunch, we will segment results by category:

| Category | Expected Effect Size | Rationale |
| --- | --- | --- |
| **Restaurants** | High (+15-25% CTR lift) | Dining is visual; food photos drive intent; reviews are decision-critical |
| **Hotels** | High (+15-25% CTR lift) | Travel is experience-based; photos set expectations; trust matters |
| **General Retail** | Moderate (+5-10% CTR lift) | Transactions are product-focused; less emotional decision-making |

### Restaurant-Specific Content Elements
- Food photography
- Ambiance/interior shots
- "I earned X miles on my dinner" testimonials

### Hotel-Specific Content Elements
- Room and amenity photos
- Location/view shots
- "I earned X miles on my stay" testimonials

---

## Implementation Requirements

### Content Sourcing

| Option | Pros | Cons | Recommendation |
| --- | --- | --- | --- |
| **Merchant-provided** | High quality, authentic | Requires merchant outreach, slow | Best for pilot |
| **Scraped/aggregated** | Fast, scalable | Legal/quality concerns | Avoid for now |
| **User-generated** | Authentic social proof | Quality variance | Combine with curated |
| **AI-generated** | Scalable for test | Authenticity concerns | Placeholder only |

### Technical Requirements

1. **Merchant page component:** New section for visual gallery
2. **Testimonial component:** Card layout with user info
3. **Impression tracking:** Track views of content sections
4. **Engagement tracking:** Track scroll depth, time on section, interactions
5. **A/B framework integration:** Feature flag for variant assignment

### Content Volume for Pilot

| Category | Merchants Needed | Content per Merchant |
| --- | --- | --- |
| Restaurants | 10-20 | 5 photos + 3 testimonials |
| Hotels | 10-20 | 5 photos + 3 testimonials |
| General Retail | 10-20 | 5 photos + 3 testimonials |

---

## Open Questions

1. **Content source:** Where will visual content and testimonials come from for the pilot?
2. **Merchant selection:** Which specific restaurants and hotels should be included?
3. **Sample size:** What is the current traffic to merchant pages to determine duration?
4. **Mobile vs Web:** Should we run on both platforms simultaneously or start with one?
5. **Testimonial authenticity:** Can we use real user data, or do we need to synthesize/curate?

---

## Next Steps

1. [ ] Define content sourcing strategy
2. [ ] Select pilot merchant list (restaurants, hotels, retail control)
3. [ ] Run power analysis to determine sample size and duration
4. [ ] Design visual mockups for content sections
5. [ ] Define technical implementation requirements
6. [ ] Create Linear tickets for engineering work
