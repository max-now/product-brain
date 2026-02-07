---
planStatus:
  planId: plan-offline-vop-prd-revision
  title: Offline VOP PRD Revision for Stakeholder Alignment
  status: completed
  planType: improvement
  priority: high
  owner: davidwang
  stakeholders: []
  tags: [prd, offline-vop, stakeholder-alignment]
  created: "2026-02-06"
  updated: "2026-02-06T00:00:00.000Z"
  progress: 0
---

# Plan: Revise Offline VOP PRD for Stakeholder Alignment

## Objective

Transform the existing PRD into a clear, concise stakeholder alignment document that:
1. Establishes the "Why Now" urgency (declining weekly transacting users)
2. Frames the broader vision (card-linked CRM for any brand, starting with F&B)
3. Shows the flywheel economics for merchant acquisition → CRM → revenue
4. Provides clear revenue projections from MVP → Phase 1

## Key Changes to Make

### 1. Restructure for Executive Alignment

**Current structure:** Technical/tactical (problem, hypothesis, phases, risks)
**New structure:** Strategic/narrative (Why Now → Vision → Flywheel → Impact → Roadmap)

### 2. Add "Why Now" Section

Lead with the urgency signal:
- Weekly transacting users are declining
- Card transaction data is an undermonetized asset
- F&B merchants are desperate for attribution (Grab/Deliveroo taking 30% commissions)
- Competitive window: No card-linked CRM player in SG market yet

### 3. Reframe the Vision

**Current:** "Card-linked CRM for offline merchants"
**New framing:** "We help brands acquire and retain the right customers using card transaction intelligence. Starting with restaurants (high frequency), expanding to any offline brand."

Make explicit:
- Long-term vision: Any brand can use our card intelligence for acquisition/CRM
- Why start with F&B: Highest weekly transaction frequency = fastest learning cycles

### 4. Add Flywheel Diagram

```
Merchant Signs Up (funded offer)
    ↓
Users Redeem at Merchant
    ↓
Transaction Data Enriches Cohorts
    ↓
Better Targeting → Higher Conversion
    ↓
Merchant Sees ROI → Increases Budget/Adds CRM
    ↓
More Revenue for HeyMax
    ↓
Attract More Merchants (network effects)
```

### 5. Add Revenue Impact Projections

Based on cohort data:
- 24,156 active diners, $10.1M/month spend
- MVP (3-5 merchants): Conservative revenue estimate
- Phase 1 (15-20 merchants): Scaled revenue estimate
- Include CPA fee assumptions

### 6. Streamline Content

**Remove:**
- Detailed experiment methodology (belongs in experiment-plan.md)
- SQL references and technical data notes
- Granular success metrics tables

**Keep:**
- Core value proposition
- Key data proof points
- Risk/mitigation summary (shortened)

## Proposed New PRD Structure

```markdown
# Card-Linked Acquisition & CRM Platform (Offline VOP)

## Why Now
- Leading indicator: Weekly transacting users declining
- Untapped asset: Card transaction intelligence
- Market timing: No card-linked CRM player in SG

## Vision
One sentence + expanded vision

## The Opportunity
- Market size (from cohort data)
- Why F&B first

## How It Works (Flywheel)
Visual + explanation of value loop

## Revenue Model & Projections
- MVP → Phase 1 → Scale economics
- Fee structure

## What We're Building
- Simplified phase overview (not tactical details)

## Key Risks & Mitigations
- Shortened table

## Appendix: Data Foundation
- Link to detailed analysis docs
```

## Implementation Steps

1. [ ] Read current PRD structure
2. [ ] Draft new "Why Now" section with declining WAU framing
3. [ ] Write expanded vision section (F&B as wedge, any brand as destination)
4. [ ] Create flywheel explanation (text-based for markdown)
5. [ ] Calculate revenue projections from cohort data
6. [ ] Restructure remaining content
7. [ ] Remove tactical details (move to linked docs if needed)
8. [ ] Final edit for concision and stakeholder clarity

## Open Questions

1. **What is the actual weekly transacting user decline rate?** (Need specific numbers to make "Why Now" compelling)
2. **What CPA % does HeyMax take?** (Needed for revenue projections)
3. **What's the target merchant count for MVP vs Phase 1?** (Current doc says 3-5 MVP, 15-20 Phase 1)
