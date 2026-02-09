---
planStatus:
  planId: plan-exp0-cbd-lunch-pilot
  title: "Experiment 0: CBD Lunch Pilot - Offline VOP"
  status: draft
  planType: initiative
  priority: high
  owner: davidwang
  stakeholders:
    - BD
    - Engineering
    - Finance
  tags:
    - offline-vop
    - experiment
    - cbd
    - lunch
  created: "2026-02-09"
  updated: "2026-02-09T00:00:00.000Z"
  progress: 0
---
# Experiment 0: CBD Lunch Pilot

**Goal:** Prove that card-linked offers drive measurable incremental visits to participating restaurants.

**Scope:** Self-funded by HeyMax. 2-3 restaurants in CBD area (lat 1.28, lng 103.84). Lunch daypart focus.

---

## 1. Why Lunch, Why CBD

**Lunch is the clear starting point:**
- 40% of all dining transactions happen 10am-2pm (largest daypart)
- CBD has 2,134 target users with $792/mo avg dining spend
- All 36 restaurants in our CBD dataset are lunch-dominant
- Office worker behaviour is predictable and habitual (same area, same time, weekdays)

**CBD is the clear starting area:**
- Highest user density (2,134 users in ~2km radius)
- Highest monthly spend ($1.69M/month)
- Office worker concentration = repeatable daily lunch decisions

---

## 2. Prior Experiments: What We Already Know

We've previously run CLO campaigns and restaurant voucher sales. These inform our experiment design and set benchmark expectations.

### CLO Campaigns (10 MPD)

We ran card-linked offers at 10 MPD for three restaurants between Sep 2024 - Jan 2025:
| Merchant | Txns | Total Spend | Avg Spend/Txn | Miles Awarded | Duration | Txns/Week |
| --- | --- | --- | --- | --- | --- | --- |
| **SKOSH** | 127 | $3,579 | $28.19 | 35,797 | 9 weeks | ~14 |
| **8 Korean BBQ** | 66 | $11,037 | $167.23 | 76,024 | 16 weeks | ~4 |
| **Fi Woodfire Thai** | 31 | $3,821 | $123.24 | 38,222 | 7 weeks | ~4 |
| **Total** | **224** | **$18,437** | **$82.31** | **150,043** |  |  |
### CLO Campaigns (5 MPD)

We ran japan rail cafe at 5 MPD from Sep 2025 - Dec 2025
| Merchant | Txns | Total Spend | Avg Spend/Txn | Miles Awarded | Duration | Txns/Week |
| --- | --- | --- | --- | --- | --- | --- |
| Japanese Rail Cafe & Club | 315 | $17,500 | $55.16 | 61,500 | 5 months | ~14 |
### Restaurant Voucher Sales (10 MPD) — Frying Fish Club

Sold $20 and $100 vouchers at 10 MPD:
| Metric | $20 Vouchers | $100 Vouchers | Total |
| --- | --- | --- | --- |
| Gross vouchers sold | 81 | 431 | 512 |
| Gross value | $1,600 | $43,100 | $44,700 |
| Refunds | 17 vouchers ($340) | 10 vouchers ($1,000) | 27 ($1,340) |
| **Net vouchers** | **64** | **421** | **485** |
| **Net value** | **$1,260** | **$42,100** | **$43,360** |

Refund rate: 5.3% (27/512) — healthy.

### Key Takeaways for This Experiment

| Learning | Implication |
| --- | --- |
| **SKOSH had highest volume (14 txns/week)** at lower avg spend ($28) | Lower-ticket, everyday restaurants drive more frequent engagement |
| **8 Korean BBQ had highest GMV** but only ~4 txns/week | Higher-ticket restaurants = fewer but larger transactions |
| **Fi Woodfire Thai tapered off after 7 weeks** | Novelty wears off — need to test sustained engagement beyond 4 weeks |
| **Japanese Rail Cafe (5 MPD) saw uptick** but limited repeat | Niche/occasion restaurants won't drive habitual behaviour |
| **HeyMax CLO cost = \~20% of GMV** at 10 MPD | At 6 MPD, cost drops to ~15% of GMV — more sustainable |
| **Voucher refund rate was 5.3%** | Low refund signals genuine demand, not just "free miles" hunting |

### What's Different This Time

| Before | Now (Experiment 0) |
| --- | --- |
| 10 MPD (expensive) | 6 MPD (more sustainable, still meaningful) |
| No geographic focus | CBD lunch cluster specifically (highest density) |
| No time-of-day targeting | Full lunch window (11am-2pm) with time data captured for future off-peak experiment |
| No control group | Proper A/B with matched control |
| No opt-in requirement | In-app claim button for clean attribution |
| Mixed restaurant types | Everyday lunch restaurants only (median $10-30) |
| No repeat measurement | 4-week duration specifically to measure repeat rate |

### Benchmark Targets (Based on Prior Data)

Using SKOSH as the closest comparable (lower ticket, higher frequency):

| Metric | SKOSH Actual | Exp 0 Target | Notes |
| --- | --- | --- | --- |
| Txns/week per restaurant | ~14 | 10-15 | Conservative; SKOSH had 10 MPD vs our 6 MPD\n\nAwarding off-peak hours but given geo-location of restaurants selected, should not drop off too much |
| Avg spend per txn | $28.19 | $20-30 | CBD lunch range |
| HeyMax cost per txn | $7.05 (at 10 MPD) | $3.00-4.50 (at 6 MPD) | 36-57% cheaper per redemption |
| Weekly HeyMax cost | ~$99 | $60-90 | Lower MPD + daily cap |

---

## 3. Restaurant Selection

### Why <200 Transactions (Independent Restaurants)

We're deliberately targeting **small independent restaurants** (<200 transactions in 90 days), not chains or popular spots:

| Independent (<200 txns) | Bigger Brands (500+ txns) |
| --- | --- |
| Need help filling seats across all hours | Already full at peak — only need off-peak help |
| Owner-operators decide in one meeting | Chains need HQ/marketing approval |
| 10-15 extra covers/week is meaningful | Need hundreds of extra covers to care |
| Full lunch window (11am-2pm) works | Off-peak only (11-12, 2-3) makes sense |
| Simpler value prop: "more customers" | Complex value prop: "shift demand to off-peak" |

**The off-peak hypothesis (bigger brands)** is a separate experiment — see PRD Experiment 4. We need Exp 0 baseline data first to prove offers work at all, before adding time-window constraints.

### Selection Criteria

Pick 2-3 restaurants from [restaurants-below200txns-cbd.csv](./../04-Initiatives/4.12%20offline%20vop/restaurants-below200txns-cbd.csv) that meet ALL of these:

| Criteria | Why | Filter |
| --- | --- | --- |
| **<200 transactions in 90 days** | Independent/small — needs our help, decides fast | number_of_transactions column |
| **Median spend $10-$50** | Captures everyday lunch; not too cheap (hawker), not fine dining ($200+) | Median spend column |
| **Category = Restaurant** | Not bars/cafes (different user intent and meal occasion) | category column |
| **Independent or small chain** | Owner-operators who can say yes in one call | Manual check |
| **Lunch-dominant** | Aligns with our CBD office worker thesis | lunch_or_dinner column |

### Recommended Shortlist

From the <200 txns CBD restaurant data, filtering for median spend $10-$80 (everyday lunch range):

| Restaurant | Txns (90d) | Median Spend | Avg Spend | Why |
| --- | --- | --- | --- | --- |
| **Sawadee Thai Cuisine** | 161 | $37.95 | $67.34 | Thai, highest volume in range, everyday lunch |
| **Ryan's Kitchen** | 153 | $43.12 | $68.47 | Western, good volume, solid price point |
| **Bulgogi Syo (Vivocity)** | 157 | $45.32 | $56.86 | Korean BBQ, good volume |
| **abV@Southbridge** | 106 | $63.00 | $81.47 | Wine bar/restaurant, decent volume |
| **Kiwami (Suntec City)** | 172 | $38.13 | $55.14 | Japanese, highest txn count |
| **Bornga (VivoCity)** | 97 | $72.03 | $88.40 | Korean, lower volume but good ticket |
| **Cherry Garden** | 136 | $66.00 | $133.95 | Chinese, well-known, solid volume |
| **Peperoni Pizzeria** | 166 | $94.80 | $110.65 | Italian, high volume but higher ticket |
**Recommendation:** Start with **2-3 restaurants** across different cuisines. Best candidates are **Sawadee Thai**, **Ryan's Kitchen**, and **Kiwami (Suntec City)** — all have 150+ txns, median spend $38-$43, and are everyday lunch spots.

### How to Decide

1. **Filter the CSV** to median spend $10-$80, <200 transactions, category = Restaurant
2. **Shortlist 5-6** that are independent/small chain with clear lunch identity
3. **BD contacts owners** — first 2-3 who agree to participate join the pilot
4. **Diversity check** — try for 2-3 different cuisines if possible

---

## 4. Offer Structure

### Keep It Simple: Flat 6 MPD

| Parameter | Value | Rationale |
| --- | --- | --- |
| **MPD Rate** | 6 MPD | Matches PRD baseline; meaningful but not excessive |
| **Minimum Spend** | $10 | Above median for fast food, captures most restaurant txns |
| **Cap** | 1 redemption per user per day | Prevents gaming; controls budget |
| **Max MPD per redemption** | 180 miles (= $30 spend cap for earning) | Caps cost at $4.50/redemption |
| **Funding** | HeyMax self-funded | Proves model before asking merchants to pay |

### Example User Experience

> User spends $25 at Boon Tong Kee during lunch.
> Earns: 25 × 6 = 150 Max Miles (worth ~$3.75 to HeyMax in cost)
> User sees miles credited in app.
> Total HeyMax cost: 150 × $0.025 = **$3.75**

---

## 5. Timing: Full Lunch Window (11am-2pm)

### Why Full Lunch, Not Off-Peak

We originally considered restricting to off-peak only (11-12, 2-3). **We're not doing that for Exp 0.** Here's why:

| Off-Peak Only | Full Lunch (11am-2pm) |
| --- | --- |
| Tests two hypotheses at once (do offers work? + can we shift demand?) | Tests one hypothesis cleanly: do offers drive visits? |
| If redemptions are low, unclear if offer failed or time window was too restrictive | If redemptions are low, we know the offer itself didn't work |
| Makes sense for big brands who are already full at peak | Our <200 txn restaurants need customers at ALL hours |
| More complex communication & messaging (time-windowed attribution) | Simpler: any transaction 11am-2pm qualifies |

**Off-peak demand shifting is a separate experiment** — reserved for bigger brands (PS Cafe, popular chains) who have a clear peak/off-peak problem. See PRD Experiment 4.

### Offer Timing Structure

| Time Window | MPD Rate | Purpose |
| --- | --- | --- |
| **11:00am - 2:00pm** | 6 MPD | Full lunch window |
| All other times | No offer | Focus on lunch hypothesis |

### What Users Need to Know

**Key user communication:**
- "Earn 6 MPD at [Restaurant] — pay with your linked card between 11am and 2pm"
- "Transaction must be **completed** during the eligible window" (not when you sit down, when you **pay**)
- Practical tip: "Arrive by 1:30pm to ensure you pay before 2pm"

**Important detail for restaurants:** Payment time = attribution time. Users must **complete payment** within the window, not just arrive. This needs to be clear in the offer T&Cs.

**Data we'll collect for future off-peak experiment:** We'll still track the exact transaction time for every redemption. This gives us a natural distribution baseline (what % happen 11-12, 12-1, 1-2) that informs the off-peak experiment design later.

---

## 6. Campaign Page & Opt-In

### Do We Need a Campaign Page?

**Yes, we need opt-in.** Here's why:

| Without Opt-In | With Opt-In |
| --- | --- |
| Users who already eat there get rewarded for doing nothing | Only rewards users who actively engaged with the offer |
| No attribution — can't prove the offer drove the visit | Clear attribution — user saw offer → claimed → transacted |
| No control group possible | Can measure claimed vs unclaimed vs control |
| Looks like free money, not a behaviour change tool | Proves intent-driven behaviour change |

### Minimal Opt-In Flow

**Keep it lightweight — no separate campaign page needed.**

1. **In-app offer card** — User sees "Earn 6 MPD at [Restaurant] for lunch (11am-12pm or 2pm-3pm)" in the HeyMax app deals section
2. **"Claim" button** — User taps to opt in (one tap, no form)
3. **Confirmation** — "You're in! Pay with your linked card at [Restaurant] during the eligible window to earn miles."
4. **Post-transaction** — VOP detects transaction → miles credited → notification sent

**What this gives us:**
- **Exposed + Claimed** = users who saw AND opted in (active intent)
- **Exposed + Not Claimed** = users who saw but didn't opt in (awareness but no action)
- **Control** = similar users who never saw the offer (baseline)

### No Email Blast Needed

- Surface offers **only in-app** (deals section, maybe home feed)
- Optional: push notification to target cohort ("New lunch deal near your office")
- No email campaign, no external marketing spend
- This tests **organic discovery + light nudge**, not marketing-driven conversion

---

## 7. Budget

### Cost Model

| Item | Calculation | Cost |
| --- | --- | --- |
| **Max cost per redemption** | 180 miles × $0.025 | $4.50 |
| **Avg expected cost per redemption** | ~$20 avg spend × 6 MPD × $0.025 | $3.00 |
| **Daily cap per user** | 1 redemption/day | $3-4.50/user/day |

### Budget Scenarios

| Scenario | Redemptions/Day | Daily Cost | 4-Week Cost | Notes |
| --- | --- | --- | --- | --- |
| **Conservative** | 10/day | $30-45 | **$840-$1,260** | ~1% of exposed cohort |
| **Moderate** | 30/day | $90-135 | **$2,520-$3,780** | ~3% of exposed cohort |
| **Optimistic** | 50/day | $150-225 | **$4,200-$6,300** | ~5% of exposed cohort |

**Recommended budget:** **$3,000-$5,000 total** for a 4-week experiment across 2-3 restaurants.

If we hit the optimistic scenario early, that's a good problem — it means offers are working.

### Budget Controls

- **Hard cap:** Set total experiment budget (e.g., $5,000)
- **Daily monitoring:** Track daily redemptions and cost
- **Kill switch:** If daily cost exceeds $250/day for 3 consecutive days, pause and evaluate

---

## 8. Experiment Duration

### 4 Weeks (20 Weekdays)

| Week | Focus | What We're Watching |
| --- | --- | --- |
| **Week 1** | Soft launch, debug | Are offers surfacing correctly? VOP attribution working? Any bugs? |
| **Week 2** | Ramp up | Start measuring redemption rates, daily patterns |
| **Week 3** | Steady state | Core measurement week — redemption rate, incremental lift |
| **Week 4** | Repeat behaviour | Do week 2-3 redeemers come back? Measure repeat rate |

**Why 4 weeks:**
- Need 2+ weeks of steady-state data (week 1 is always noisy)
- Need to measure **repeat visits** (can a user who redeems in week 2 come back in week 3-4?)
- Weekday-only behaviour (lunch) means we need 20 working days minimum

**Weekends:** Offer stays live but don't expect high volume (office area). Weekend data is bonus.

---

## 9. Measurement & Control Groups

### Group Design

| Group | Size | Treatment |
| --- | --- | --- |
| **Exposed (Treatment)** | ~500 users | See offer in app, can claim |
| **Control** | ~500 users | Don't see offer, same user profile |
| **Holdout** | Everyone else | No treatment, baseline |

**Selection criteria for treatment + control:**
- Users who have transacted at restaurants in the CBD area in last 90 days
- Matched on: spend tier, frequency tier, recency of last CBD restaurant transaction
- Random assignment within matched pairs

### Success Metrics

| Metric | Target | How We Measure |
| --- | --- | --- |
| **Offer claim rate** | >15% | Claimed / Exposed |
| **Redemption rate** | >5% | Transacted at merchant / Claimed |
| **Incremental visit lift** | >10% | Treatment visit rate - Control visit rate |
| **Repeat visit rate** | >20% | Users who transact 2+ times at same merchant within 30 days |
| **Avg transaction value** | >= area avg ($20-50) | Not gaming with minimum spend |
| **Txn time distribution** | Recorded for all redemptions | Baseline data for future off-peak experiment |

### Go / No-Go Decision

| Result | Decision |
| --- | --- |
| Redemption >5% AND lift >10% | **Go** → Proceed to Experiment 1 (merchant pitch) |
| Redemption 2-5% OR lift 5-10% | **Iterate** → Test different MPD rate, restaurant, or time window |
| Redemption <2% AND lift <5% | **Kill** → Offers don't change behaviour, revisit initiative |

---

## 10. What We Need to Build / Configure

### Engineering Requirements (Minimal)

| Item | Effort | Priority |
| --- | --- | --- |
| In-app offer card with "Claim" CTA | Small | P0 |
| Claim tracking (user × offer → claimed_at) | Small | P0 |
| VOP transaction matching (merchant + time window + claimed user) | Medium | P0 |
| Miles crediting on match | Small | P0 |
| Control group assignment | Small | P0 |
| Daily redemption dashboard/query | Small | P1 |
| Push notification to cohort (optional) | Small | P2 |

### Content Needed

| Item | Owner |
| --- | --- |
| Offer card copy + design | PM + Design |
| Restaurant photos/logos | BD (from restaurant) |
| T&Cs for offer (payment timing, daily cap) | PM + Legal |
| Cohort selection query | Data/PM |

---

## 11. Summary: The Experiment at a Glance

| Dimension | Decision |
| --- | --- |
| **Where** | CBD area, lat 1.28 lng 103.84 |
| **When** | 11am-2pm (full lunch window) |
| **Which restaurants** | 2-3 independents from shortlist, <200 txns, median spend $10-80 |
| **Offer** | 6 MPD, $10 min spend, capped at 1/day/user, max 180 miles/redemption |
| **Funding** | HeyMax self-funded, $3-5K total budget |
| **Duration** | 4 weeks |
| **Opt-in** | Yes — in-app claim button (no email blast) |
| **Marketing** | None — in-app only, optional push notification |
| **Control group** | Yes — 50/50 matched split |
| **Success** | >5% redemption, >10% incremental lift, >20% repeat rate |

---

## 12. Open Questions

- [ ] Do we need restaurant owner's explicit permission to run a HeyMax-funded pilot at their location?
- [ ] Should we include the Vivo City cluster (Aburi-EN, Una Una) even though it's slightly outside core CBD?

---

*Related documents:*
- [prd.md](./../04-Initiatives/4.12%20offline%20vop/prd.md)
- [experiment-plan.md](./../04-Initiatives/4.12%20offline%20vop/experiment-plan.md)
- [restaurants-below30dollar.csv](./../04-Initiatives/4.12%20offline%20vop/restaurants-below30dollar.csv)
- [restaurants-below200txns-cbd.csv](./../04-Initiatives/4.12%20offline%20vop/restaurants-below200txns-cbd.csv)
- [cohort-insights-final.md](./../04-Initiatives/4.12%20offline%20vop/cohort-insights-final.md)
- https://console.statsig.com/3lQdicUjsoYYdZG5M4H2YC/
- https://superset.heymax.ai/superset/dashboard/cf4575c5-1d0f-4aab-8a41-e38e10bca60c/