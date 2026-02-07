---
planStatus:
  planId: plan-offline-vop-cpo-critique
  title: CPO Critique - Offline VOP Initiative
  status: draft
  planType: research
  priority: high
  owner: davidwang
  stakeholders: []
  tags:
    - critique
    - strategy
    - offline-vop
  created: "2026-02-06"
  updated: "2026-02-06T00:00:00.000Z"
  progress: 0
---
# CPO Critique: Card-Linked Acquisition & Retention Intelligence

**Perspective:** Chief Product Officer with consumer ad-tech background
**Documents Reviewed:** PRD, Experiment Plan, Cohort Insights

---

## Executive Assessment

**Overall Verdict: This initiative has legs, but with significant caveats.**

The core insight is sound: card-rail attribution is genuinely differentiated, and the "zero-friction" value prop is compelling. However, there are critical gaps in the economic model, competitive positioning, and scalability assumptions that need addressing before this becomes a viable business line.

**Strength Score: 7/10** — Solid foundation, needs refinement on economics and defensibility.

---

## 1. What's Strong

### 1.1 Genuine Differentiation
The VOP card-rail attribution is a real moat. Unlike Upside (receipt scanning) or Oddle (QR enrollment), you have:
- Definitive transaction proof
- Zero consumer friction
- Cross-merchant intelligence

**CPO Take:** This is your wedge. Don't dilute it with feature creep.

### 1.2 Smart Experiment Sequencing
The phased approach (Exp 0 → 1 → 2 → 3) is well-structured:
- Self-fund first to prove behavior change
- Then pitch merchants with proven data
- Personalization comes last (correctly)

**CPO Take:** The "prove before building" discipline is right. Many teams would jump to building dashboards first.

### 1.3 Rich Cohort Data
24,156 users, $10.1M monthly spend, geographic density data — this is a strong foundation for merchant pitches.

**CPO Take:** This data is your sales weapon. The pitch templates in cohort-insights are well-crafted.

---

## 2. Critical Gaps & Concerns

### 2.1 The Revenue Math Doesn't Scale

**The Problem:**
At 2.5 cents/mile, the revenue per transaction is tiny:
- $30 transaction × 6 MPD = 180 miles × $0.025 = **$4.50**
- At 5% redemption rate with 24K users, that's ~1,200 redemptions/month
- Monthly revenue: **$5,400**

Even at "Scale" (50K users, 25% adoption, 2 redemptions/user/month = 25,000 redemptions):
- $4.50 × 25,000 = **$112,500/month**

**The Question:** Is this worth the BD, Eng, and PM resources for ~$1.3M annual revenue at scale? What's the resource cost to get there?

**Response:**
- **Breakage economics:** 2.5c/mile is top-line revenue. Actual cost is lower because users don't redeem 100% of miles at face value. HeyMax's profit model relies on breakage (users redeeming miles for lower-cost rewards). This makes the margin better than it appears.
- **Better than current partners:** 2.5c/mile from merchants is favorable compared to what we currently receive from most affiliate partners.
- **Not the end state:** The $112K/month "scale" scenario is Singapore-only with current user base. The real opportunity is building a merchant network that enables future monetization and global expansion to millions of users.
- **Network as the asset:** The merchant network itself has value beyond per-transaction revenue — it's a wedge for additional B2B products.

**Suggested Improvement:**
- Add breakage assumptions to P&L model
- Frame revenue projections as "Phase 1" not "Scale"
- Articulate future monetization paths once merchant network is established

### 2.2 Visa-Only Visibility is a Bigger Problem Than Acknowledged

**The Problem:**
You only see Visa transactions on linked cards. The cohort data shows 24K users — but what % of their total wallet do you see?

If you're showing a merchant "247 users spend $300+/mo on Japanese food nearby" but you're only seeing 30% of their actual dining spend, the targeting is less precise than claimed.

**Stakeholder Question to Expect:**
> "You're telling me you can target high spenders, but you only see their Visa transactions? What about Mastercard, Amex, cash?"

**Response:**
- This is a known limitation. We should be upfront with merchants and frame our data as **intent signals** rather than claiming complete wallet visibility.
- The pitch becomes: "We can show you high-intent diners based on their Visa spending patterns" — not "we know everything about these users."

**Suggested Improvement:**
- Update merchant pitch templates to acknowledge partial visibility
- Frame as "intent signal" rather than "complete picture"
- Prepare BD talking points for when merchants ask about other card networks

### 2.3 No Competitor Response Plan

**The Problem:**
The PRD mentions Upside and Oddle but doesn't address:
- What if Visa/Mastercard launches competing programs?
- What if Grab or Deliveroo adds card-linked offers to their platforms?
- What if a well-funded competitor enters Singapore?

**Stakeholder Question to Expect:**
> "What happens when Grab copies this? They have more merchants and users."

**Response:**
- Not a priority to address now. We're in validation phase — need to prove the model works before worrying about competitive response.
- If the model proves out, we can develop defensibility through merchant relationships and data network effects.

**Status:** Acknowledged risk, not addressing in current phase.

### 2.4 User Acquisition Story is Weak

**The Problem:**
The initiative is positioned to address "declining weekly transacting users" but it's primarily an engagement play for existing users. The "Merchant-Funded Acquisition" section is marked as "Not MVP" — so how does this solve the WAU decline problem?

**Stakeholder Question to Expect:**
> "You said our WAU is declining. How does giving existing users more deals fix that?"

**Response:**
The positioning should be dual:
1. **Revenue diversification:** New B2B channel that's better than current affiliate partnerships
2. **Converting active → transacting users:** Offline deals are easier to adopt than online affiliates. Users who browse but don't transact now have a lower-friction path to earning.

The framing shifts from "solving WAU decline" to "increasing transaction rate among existing active users while diversifying revenue."

**Suggested Improvement:**
- Update PRD "Why Now" section to reflect this dual positioning
- Clarify that this turns more active users into transacting users (not acquiring new users in MVP)

### 2.5 Merchant Unit Economics Not Validated

**The Problem:**
You're assuming merchants will pay 6-10 MPD (2.5 cents/mile = $0.15-0.25 per $1 spent). But:
- Is this better than their current CAC on Instagram/Google?
- What's their typical marketing budget per new customer?
- At $7.50 per $30 transaction, that's 25% cost-to-revenue — is this sustainable?

**Stakeholder Question to Expect:**
> "Why would a merchant pay $7.50 to acquire a customer who spends $30? That's a 25% marketing cost."

**Response:**
- This is genuinely unknown — we don't yet know what merchants are willing to fund.
- **Subsidization option:** HeyMax can absorb some of the cost during experiments. Offer limited-time deals where merchants pay less than full rate.
- **Scarcity lever:** Make deals limited quantity so users claim quickly, creating urgency and perceived value.
- Experiment 1 will validate willingness to pay; we can adjust pricing based on merchant feedback.

**Suggested Improvement:**
- Include pricing sensitivity testing in Experiment 1 (test different MPD rates)
- Be prepared to subsidize during validation phase
- Document merchant objections to inform pricing strategy

---

## 3. Assumption Risks

| Assumption | Risk Level | Validation Method | Status |
| --- | --- | --- | --- |
| Users will engage with offers | Medium | Experiment 0 | ✅ Addressed |
| Merchants will fund offers | High | Experiment 1 | ✅ Will validate + can subsidize |
| Offers drive behavior change | High | Experiment 0 | ✅ Addressed |
| Personalization improves efficiency | Medium | Experiment 3 | ✅ Addressed |
| 2.5 cents/mile is profitable for HeyMax | Low | Breakage economics | ✅ Better than current partners |
| Visa-only data is sufficient | Medium | Experiment 1 feedback | ✅ Frame as intent signal |
| Scale economics work | Medium | Phase 2 validation | ⚠️ Not immediate priority |

---

## 4. Likely Stakeholder Questions

### From CEO
1. "What's the path to $1M ARR? $5M? $10M?" — Revenue projections are vague at scale
2. "How does this help our WAU problem?" — Engagement ≠ Acquisition
3. "What's the opportunity cost?" — Resources could go elsewhere

### From CFO
1. "What's the margin at scale?" — Revenue per transaction is clear, but costs aren't
2. "What's the break-even timeline?" — Experiment 0 is HeyMax-funded, when do we recoup?
3. "How does this affect miles liability?" — Merchant-funded miles have different accounting treatment

### From CTO
1. "What eng resources do you need for each phase?" — Timeline has PM + Eng but no scope
2. "What's the VOP integration cost?" — Is this incremental or new build?
3. "How do we handle merchant disputes?" — Attribution edge cases

### From BD Lead
1. "What's my quota?" — 10 merchants pitched, 3+ LOIs — is this realistic?
2. "What objections should I expect?" — Need playbook for common pushback
3. "How do I explain Visa-only limitation?" — Need clear talking points

---

## 5. Suggested Improvements

### 5.1 Add Revenue Model Sensitivity Analysis

Current projections assume fixed variables. Add:
- What if adoption is 3% instead of 25%?
- What if merchants only commit $200/month instead of $500?
- What's the minimum viable scale for profitability?

### 5.2 Clarify Resource Requirements

Each experiment phase should include:
- Eng effort (sprints or FTE weeks)
- BD effort (hours per merchant)
- PM effort (% of time)
- Total cost to run the experiment

### 5.3 Add Kill Criteria at Each Phase

Current "Decision Points" have Go/Iterate/Kill but the kill thresholds are vague. Make them concrete:
- Kill if <1% redemption rate
- Kill if 0 merchants commit after 10 pitches
- Kill if revenue per resource hour < $X

### 5.4 Strengthen the "Why Now" Narrative

Current framing is weak:
- WAU is declining (but this is engagement, not acquisition)
- VOP data is untapped (but why now vs. 6 months ago?)

Add:
- What's changed in the market?
- Is there a competitor threat?
- Is there a regulatory window?

### 5.5 Model Merchant Economics Explicitly

Add a section that shows:
- Typical restaurant CAC via Instagram/Google ($X)
- Our effective CAC ($Y)
- Merchant payback period (Z months)
- Why this is better than alternatives

---

## 6. Missing Sections

| Section | Why It Matters | Suggested Content |
| --- | --- | --- |
| **Resource Requirements** | Leadership needs to allocate | Eng sprints, BD headcount, PM time per phase |
| **P&L Model** | CFO will ask | Revenue, COGS (miles), opex, margin by phase |
| **Competitive Response** | Board will ask | What if Grab/Visa enters? |
| **Exit Criteria** | Good governance | When do we kill vs. iterate? |
| **Legal/Compliance** | Data privacy risk | VOP data usage rights, PDPA considerations |
| **Merchant Churn Model** | Scale planning | What % renew? What's LTV of a merchant? |

---

## 7. Bottom Line

### Does This Initiative Have Legs?

**Yes.** The core value prop (card-rail attribution, zero friction, cross-merchant intelligence) is differentiated. The experiment design is sound. The cohort data is rich.

**Addressed concerns:**
1. ✅ Revenue math — Breakage economics make margin better than top-line suggests; merchant network is the real asset
2. ✅ Visa-only limitation — Frame as intent signal, be upfront with merchants
3. ✅ Competitive response — Not a priority in validation phase
4. ✅ Positioning — Dual frame: revenue diversification + converting active → transacting users
5. ✅ Merchant economics — Will validate in Experiment 1, can subsidize if needed

**Remaining items:**
1. Resource requirements need explicit modeling
2. Update PRD "Why Now" to reflect dual positioning

### Recommended Next Steps

1. **Update PRD positioning** — Frame as revenue diversification + active → transacting user conversion
2. **Add breakage economics to P&L** — Show actual margin, not just top-line revenue
3. **Prepare BD for Visa-only questions** — Clear talking points about intent signals
4. **Include pricing sensitivity in Experiment 1** — Test what merchants are actually willing to pay
5. **Clarify resource ask** — What's the actual headcount/sprint cost per phase?

---

## Appendix: Red Team Questions

Use these to stress-test the initiative in stakeholder meetings:

1. "If this is such a good idea, why hasn't Visa built it directly?"
2. "What happens when you can't show enough users near a specific merchant?"
3. "How do you prevent merchants from gaming the system (e.g., giving offers to existing customers)?"
4. "What's the worst-case scenario if Experiment 0 fails?"
5. "Why would a user choose HeyMax deals over credit card dining promos?"
6. "What's preventing a competitor from licensing VOP and doing the same thing?"
7. "How do you handle multi-tenant merchants (e.g., food courts)?"
8. "What's the user experience for discovering and redeeming offers?"
9. "How do you prove incrementality vs. cannibalization of existing visits?"
10. "What's the merchant support cost at 50 merchants? 500?"

---

*Critique prepared: 2026-02-06*
*Reviewer: CPO perspective (ad-tech background)*
