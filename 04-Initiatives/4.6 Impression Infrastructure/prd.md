# Impression Infrastructure

**Status**: In Progress
**Priority**: High
**Owner**: David Wang
**Start Date**: 2026-01-14
**Last Updated**: 2026-02-03
https://linear.app/heymax/project/impression-infrastructure-94d6ac0b43d5/overviewhttps://linear.app/heymax/project/impression-infrastructure-94d6ac0b43d5/overview

---

## Background & Context
HeyMax lists merchants and earns commission on successful conversions (CPA).

Today, merchant exposure across the app is largely unmanaged and opaque:
- We do not consistently know **where merchants are seen**
- We cannot quantify **which exposures drive conversions**
- We lack system-level guardrails to introduce CPC or CPM pricing safely

As HeyMax scales, we need a unified system that:
- Optimises merchant exposure to help merchants reach their goals
- Enables CPC and CPM pricing without cannibalising CPA performance

---
## Problem Statement
### Merchant Problems
- Merchants lack visibility into *where* and *how* they are exposed
- High-performing merchants can be crowded out unintentionally
- Awareness-oriented merchants have no structured way to invest

### Business Problems
- No foundation to price impressions or clicks credibly
- Risk of ad-hoc deals degrading overall performance

---
## Goals & Non-Goals

**Phase 1 Goals:**
- Establish **single source of truth** for merchant brand exposure
- Support CPA, CPC, and CPM merchant objectives
- Enable placement-level performance measurement (impressions, CTR, CVR)

**Phase 2 Goals:**
- Prevent cannibalisation between CPA merchants and CPM packages
- Enable placement-aware merchant ranking
- Guarantee CPM delivery only when explicitly sold

**Phase 3 Goals:**
- Launch merchant reporting with exposure analytics
- Enable data-driven pricing models

**Non-Goals:**
- Real-time bidding or auctions
- External ad network integrations
- Multi-touch attribution (Phase 1-2)

---
## Success Metrics by Phase

### Phase 1 – Observability
**Expected Outcomes:**
- 100% of core placements have impression tracking enabled
- Baseline metrics established for 5-7 key placements
- Impression → conversion attribution coverage reaches 80%+
- Overall platform CVR maintained (no regression)

**Key Metrics:**
- Placement-level impressions tracked
- Placement-level CTR measured
- Placement-level CVR measured
- Attribution coverage (% of conversions with exposure data)

### Phase 2 – Commercial Readiness
**Expected Outcomes:**
- CPM delivery accuracy within ±10% of target
- Merchant Package framework handles 3+ package types
- No cannibalisation between CPA and test CPM packages

**Key Metrics:**
- CPM delivery accuracy (actual vs promised impressions)
- Package delivery completion rate
- CPA merchant CVR (no regression vs baseline)
- Placement slot utilization by package type

### Phase 3 – Reporting & Packaging
**Expected Outcomes:**
- Launch 2-3 CPM/CPC packages with merchant reporting
- Merchant retention rate improves for packages with transparency
- New revenue from CPM/CPC pricing models

**Key Metrics:**
- Merchant adoption rate of new packages (CPM/CPC)
- Merchant retention & upsell rate
- Average revenue per merchant (by package type)
- Merchant satisfaction with exposure reporting (NPS/survey)
- Overall platform CVR maintained across all package types

---
## Core Principles
1. **Merchant-goal first**
  1. Exposure is a means to help merchants succeed, not the product by default.
2. **Performance-gated visibility**
  1. No merchant receives guaranteed dominance; relevance and outcomes always matter.
3. **Explicit guarantees only**
  1. Exposure volume is guaranteed *only* under CPM packages and within defined constraints.
4. **Placement-aware optimisation**
  1. Different surfaces have different intents and rules
---
## Key Concepts & Building Blocks
| Block | Description | Examples |
| --- | --- | --- |
| Exposure Unit\n(What the user sees) | A unified abstraction for all brand exposure in HeyMax.\n\nEach exposure unit is tagged to a:\n• Merchant\n• Exposure type\n• Placement (where it appears)\n• Clickability | Exposure Type Examples:\n• Banner creative\n• Dedicated merchant page\n• Merchant logo on home earning page\n• Merchant logo on transaction confirmation |
| Placement\n(Where exposure happens) | A stable, enumerable surface in the app.\n\nPlacements define:\n- Number of slots\n- User intent level\n- Ranking strategy\n- Eligibility for packages e.g. CPA / CPM / CPC\n\nv2\n• % of slots reserved for paid packages\n• % reserved for organic ranking | Examples:\n• Home – Earn carousel\n• Search results\n• Merchant page entry point\n• Post-transaction screen\n\nv2 Example:\n• Home Earn carousel slots: 30% paid / 70% organic |
| Brand Exposure\n(What gets measured) | Every time an exposure unit is rendered to a user, we log a **BrandExposure** event.\n\nCaptured fields:\n- Merchant\n- Exposure unit\n- Placement\n- User\n- Rank position (if applicable)\n- Algorithm version\n- Timestamp\n\nThis is the **single source of truth** for:\n- Impressions\n- Reach\n- Frequency\n- Performance attribution |  |
---
## Commercial Layer: Merchant Packages
| Block | Description | Examples |
| --- | --- | --- |
| Merchant Package | A Merchant Package defines **optimisation preferences**, not ranking, not entitlement.\n\nAttributes:\n- Package type: CPA / CPC / CPM\n- Merchant objective\n- Active period\n- Priority tier\n- Optional budget or delivery cap | Examples:\n- CPA Boost\n- CPC Traffic\n- CPM Brand Awareness |
| Package Exposure Scope | Each package explicitly defines:\n- Eligible exposure types\n- Eligible placements\n- Frequency or impression limits\n\nThis ensures:\n• No silent surface takeover\n• Clear merchant expectations\n• No cannibalisation of other deals |  |
---
## Implementation Phases

### Phase 1 – Observability
**Goal:** Single source of truth for merchant exposure
**Enables:** Performance Levers Phase 0-3

**Tasks:**
- [ ] Calculate impressions, CTR, CVR by placement (use user conversions as proxy initially)
- [ ] Identify and lock 5–7 core placements
  - [ ] Classify placements into CPA-dominant vs CPM-eligible
- [ ] Define placements & exposure types
- [ ] Set up Exposure Unit events (batch upload to prevent performance impact)
- [ ] Backfill & validate impression data (1–2 weeks)
- [ ] Build baseline monitoring dashboard (impressions, CTR, CVR by placement)

**Handoff:** Placement types & metrics available for merchant ranking algo & tooling

### Phase 2 – Commercial Readiness
**Goal:** Infrastructure for CPM/CPC packages
**Enables:** Performance Levers Phase 4

**Tasks:**
- [ ] Define 1–2 exposure pools (intent-based)
- [ ] Merchant Packages + Exposure pools setup
- [ ] Delivery pacing logic
- [ ] Merchant Reach & frequency metrics
- [ ] Simulate CPM delivery (e.g. 50k impressions)
- [ ] Simulate CPC outcomes where intent exists

**Handoff:** Commercial package framework ready for BD

### Phase 3 – Reporting & Packaging
**Goal:** Launch CPM/CPC offerings with merchant reporting

**Tasks:**
- [ ] Define packages from constraints
- [ ] Build CPA / CPC / CPM package offerings
- [ ] Partner reporting infrastructure
- [ ] Pricing & guarantees framework
- [ ] Pilot with 2-3 merchants, learn, then scale

---
## Key Risks & Mitigations
**Risk:** CPM cannibalises CPA 
**Mitigation:** Placement slot caps + intent-based pools

**Risk:** Merchant distrust in impression quality
**Mitigation:** Transparent exposure definitions & reporting

**Risk:** Over-complexity early
**Mitigation:** Strict phasing and defaults