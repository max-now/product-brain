# HeyMax Merchant Exposure & Pricing Model PRD

## Background & Context
HeyMax lists merchants and earns commission on successful conversions (CPA).

Today, merchant exposure across the app is largely unmanaged and opaque:
- We do not consistently know **where merchants are seen**
- We cannot quantify **which exposures drive conversions**
- We lack system-level guardrails to introduce CPC or CPI pricing safely

As HeyMax scales, we need a unified system that:
- Optimises merchant exposure to help merchants reach their goals
- Enables CPC and CPI pricing without cannibalising CPA performance
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
| phase | Goals | Non-Goals |
| --- | --- | --- |
| 1 | Establish a **single source of truth** for merchant brand exposure | Real-time bidding or auctions |
| 1 | Allow merchants to pursue different goals:\n— Conversions (CPA)\n— Traffic (CPC)\n— Awareness (CPI) | External ad network integrations |
| 1 |  | Multi-touch attribution |
| 2 | Prevent cannibalisation between merchants and packages |  |
| 2 | Enable **placement-aware merchant ranking** |  |
| 2 | Guarantee CPI delivery **only when explicitly sold** |  |
| 2 | Multi-touch attribution |  |
The proposed system enables:
- Impressions by placement & exposure type
- CVR by placement
- CTR by placement
- Rank position impact analysis
- Exposure mix attribution to conversions

These insights guide:
- Pricing
- Package design
- Product optimisation
---
## Success Metrics
- Overall platform CVR (no regression)
- Merchant conversion lift
- Impression → conversion attribution coverage
- CPI delivery accuracy
- Merchant retention & upsell rate

---
## Core Principles
1. **Merchant-goal first**
  1. Exposure is a means to help merchants succeed, not the product by default.
2. **Performance-gated visibility**
  1. No merchant receives guaranteed dominance; relevance and outcomes always matter.
3. **Explicit guarantees only**
  1. Exposure volume is guaranteed *only* under CPI packages and within defined constraints.
4. **Placement-aware optimisation**
  1. Different surfaces have different intents and rules
---
## Key Concepts & Building Blocks
| Block | Description | Examples |
| --- | --- | --- |
| Exposure Unit\n(What the user sees) | A unified abstraction for all brand exposure in HeyMax.\n\nEach exposure unit is tagged to a:\n• Merchant\n• Exposure type\n• Placement (where it appears)\n• Clickability | Exposure Type Examples:\n• Banner creative\n• Dedicated merchant page\n• Merchant logo on home earning page\n• Merchant logo on transaction confirmation |
| Placement\n(Where exposure happens) | A stable, enumerable surface in the app.\n\nPlacements define:\n- Number of slots\n- User intent level\n- Ranking strategy\n- Eligibility for packages e.g. CPA / CPI / CPC\n\nv2\n• % of slots reserved for paid packages\n• % reserved for organic ranking | Examples:\n• Home – Earn carousel\n• Search results\n• Merchant page entry point\n• Post-transaction screen\n\nv2 Example:\n• Home Earn carousel slots: 30% paid / 70% organic |
| Brand Exposure\n(What gets measured) | Every time an exposure unit is rendered to a user, we log a **BrandExposure** event.\n\nCaptured fields:\n- Merchant\n- Exposure unit\n- Placement\n- User\n- Rank position (if applicable)\n- Algorithm version\n- Timestamp\n\nThis is the **single source of truth** for:\n- Impressions\n- Reach\n- Frequency\n- Performance attribution |  |
---
## Commercial Layer: Merchant Packages
| Block | Description | Examples |
| --- | --- | --- |
| Merchant Package | A Merchant Package defines **optimisation preferences**, not ranking, not entitlement.\n\nAttributes:\n- Package type: CPA / CPC / CPI\n- Merchant objective\n- Active period\n- Priority tier\n- Optional budget or delivery cap | Examples:\n- CPA Boost\n- CPC Traffic\n- CPI Brand Awareness |
| Package Exposure Scope | Each package explicitly defines:\n- Eligible exposure types\n- Eligible placements\n- Frequency or impression limits\n\nThis ensures:\n• No silent surface takeover\n• Clear merchant expectations\n• No cannibalisation of other deals |  |
---
## Enabling New Pricing Models
### Phase 1 – Observability
- [ ] Define placements & exposure types
- [ ] Start logging Exposure events
  - [ ] need to batch upload to prevent impact on performance
- [ ] Baseline monitoring dashboard for placements (impressions, CTR, CVR)

### Phase 1.5 – Merchant Ranking Observability
- [Merchant / Partner Ranking Logic Documentation](https://www.notion.so/Merchant-Partner-Ranking-Logic-Documentation-2cc1638079d7806181d1fd4224aecc24?pvs=21)

### Phase 2 – Commercial Readiness
- [ ] Merchant Packages + Exposure pools setup
- [ ] Delivery pacing
- [ ] Merchant Reach & frequency metrics

### Phase 3 – Reporting & Packaging
- [ ] CPA / CPC / CPI offerings
- [ ] Partner reporting infrastructure
- [ ] Pricing & guarantees
---
## Key Risks & Mitigations
**Risk:** CPI cannibalises CPA 
**Mitigation:** Placement slot caps + intent-based pools

**Risk:** Merchant distrust in impression quality
**Mitigation:** Transparent exposure definitions & reporting

**Risk:** Over-complexity early
**Mitigation:** Strict phasing and defaults
---
## Next Steps
1. Calculate impressions, CTR, CVR by placement
![image.png](assets/70d1e87dfe16bce3e95df8b388cdad997c98a35cc4bae1da9d3f234946bd19b2.png){475x264}
  1. use user conversions as proxy for now
1. Identify and lock 5–7 core placements
  1. Classify placements into CPA-dominant vs CPI-eligible
2. Define 1–2 exposure pools (intent-based)
3. Set up Exposure Unit events
4. Backfill & validate impression data (1–2 weeks)
5. Simulate CPI delivery (e.g. 50k impressions)
6. Simulate CPC outcomes where intent exists
7. Define packages from constraints
8. Pilot, learn, then scale