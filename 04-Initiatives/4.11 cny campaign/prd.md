# Max Miles Boost (CNY Edition)

**Linear Project:** https://linear.app/heymax/project/cny-campaign-5d722acf33d0

---

## Problem / Objective

Chinese New Year is a high-spending period in Singapore, with consumers actively shopping for gifts, home items, and festive preparations. However, HeyMax users may not be aware of the earning potential during this period, and we're competing with other rewards platforms offering seasonal promotions.

**Hypothesis**: Offering a flat-rate bonus (200 MM per transaction) with a clear cap will drive higher transaction volume than percentage-based bonuses, as users can easily calculate their potential earnings.

**Objective**: Drive user engagement and transaction volume during the CNY period (Feb 14-16, 2025) by offering bonus Max Miles on qualifying purchases, while reinforcing HeyMax as the go-to platform for maximizing rewards during key shopping periods.

---
## What success looks like

- **Primary**: 
  - 10% uplift in revenue vs similar period baseline
  - 67% uplift in avg spend amount during campaign period ($120 to >$200)
  - 10% MoM uplift in average transaction volume per user
  - 10% MoM uplift in total weekly transaction volume
- **Secondary**: 
  - 50% retention rate of participating users for shopping every 2nd week of month
  - increase in users making purchases through affiliate merchants during campaign period

---

## Supporting signals

- Average monthly shop spend per transaction in the past 3 months is S$120
  - top 20 merchant breakdown with % of monthly transactions >$200
| merchant_name | avg_merchant_monthly_spend | avg_monthly_spend | avg_monthly_txn_count | pct_txns_over_200 |
| --- | --- | --- | --- | --- |
| Trip.com | 7118.009474 | 48411955.1 | 6817 | 45.06 |
| Shopee | 43.03065252 | 1470271.335 | 34176.66667 | 3.46 |
| Booking.com | 4106.093971 | 1270151.735 | 309.3333333 | 69.4 |
| Agoda APAC | 299.5512498 | 406391.1956 | 1610 | 35.67 |
| Singapore Airlines | 1091.89237 | 356684.8408 | 326.6666667 | 70 |
| Lazada | 83.78746396 | 342942.09 | 4095.666667 | 9.02 |
| Klook | 95.24806166 | 298094.6836 | 3172 | 13.06 |
| Amazon | 57.21904959 | 120007.42 | 2097.666667 | 6.02 |
| iHerb | 178.1781629 | 96334.9934 | 541.3333333 | 37.07 |
| Expedia (SG) - CPS | 2758.247353 | 93780.41 | 34 | 88.24 |
| Accor South Asia - CPS | 381.2036554 | 93140.7598 | 244.3333333 | 60.03 |
| Traveloka | 454.0568598 | 85968.09879 | 189.3333333 | 55.11 |
| Emirates Airlines | 2039.828997 | 57115.21191 | 28 | 94.05 |
| Uniqlo | 86.67534604 | 28805.10667 | 332.6666667 | 5.51 |
| FoodPanda | 29.35656235 | 25158.57393 | 857 | 0.16 |
| Qatar Airways | 1599.177143 | 22388.48 | 14 | 90.48 |
| Apple Singapore | 654.1901961 | 22242.46667 | 34 | 54.9 |
| Pelago by Singapore Airlines | 96.37812866 | 21974.21333 | 229.3333333 | 13.81 |
| GetYourGuide | 244.5139925 | 21191.21268 | 86.66666667 | 43.46 |
| Taobao | 30.79162817 | 21051.20979 | 684 | 2.34 |

---

## Who is this for

### User personas

**Primary**: Active Miles Maximizers
- Already using HeyMax regularly for online shopping
- Highly motivated by bonus earning opportunities
- Typically spend S$200+ per transaction on key purchases

**Secondary**: Seasonal Shoppers
- Use HeyMax occasionally
- More active during festive/promotional periods
- Need clear incentive to choose HeyMax over direct merchant checkout

---

## Product requirements
| # | User story | Acceptance criteria |
| --- | --- | --- |
| 1 | As a user, I want to be automatically enrolled in the CNY campaign | User sees campaign banner on home screen without manual opt-in; no registration required |
| 2 | As a user, I want to understand how to earn the bonus | Campaign details page clearly explains: spend S$200+, earn 200 MM bonus, up to 1,000 MM cap during campaign period |
| 3 | As a user, I want to know which merchants qualify | Campaign page displays list of qualifying merchants; excluded merchants clearly marked |
| 4 | As a user shopping on Shopee/Taobao/Lazada, I want to understand the item-level requirement | Clear messaging that each item must be S$200+ (not cart total) for these specific merchants |
| 6 | As a user, I want to see my bonus miles | Bonus miles appear as "Pending" in transaction history immediately after qualifying transaction is tracked; labeled as "CNY Bonus" |
| 7 | As a user, I want to know when my bonus becomes usable | bonus miles's transaction time shows the same confirmation date as the original transaction; \n\nbonus miles confirmed automatically when merchant confirms |
| 8 | As a user, I want to receive notifications about my bonus | Push notification after qualifying purchase confirming bonus earned; |
Designs: https://www.figma.com/design/PL1BsvtJYQohVyaQYbbLUT/-HeyMax--Product-Campaigns?node-id=7535-121&t=3Gz86EnzfiTI3F13-1https://www.figma.com/design/PL1BsvtJYQohVyaQYbbLUT/-HeyMax--Product-Campaigns?node-id=7535-121&t=3Gz86EnzfiTI3F13-1

---

## Events tracking
| Event name | Event attributes | Description |
| --- | --- | --- |
| `campaign_viewed` | `campaign_id`, \n`user_id`, \n`source` (home_banner, push, email) | User views campaign details page |

---

## Technical requirements

### Campaign logic
- Campaign period: Feb 14, 2025 00:00 SGT → Feb 16, 2025 23:59 SGT
- Transaction postback must fall within period
- Bonus calculation: 
  - IF transaction_amount ≥ 200 AND merchant NOT IN excluded_list THEN bonus = 200 MM
- User cap enforcement: SUM(user_bonuses) ≤ 1,000 MM per user_id

### Excluded merchants (see Appendix A for full list)
- All insurance products
- Financial services (Syfe, Endowus, Webull, etc.)
- Utilities (MyRepublic, Circles Life)
- Gift cards and vouchers

### Bonus payout flow
1. Transaction completes → Issue bonus as "Pending" status
2. Merchant confirms (no returns) → Move to "Confirmed" status
3. Return/refund occurs → Reverse bonus, notify user


---

## Risks & Mitigations
| Risk | Impact | Mitigation |
| --- | --- | --- |
| Users game the system by splitting orders or creating multiple accounts | H | Miles earning cap of 1000MM; \nmiles cant be transferred |
| Merchant tracking delays cause user confusion | M | proactive comms on identified delays; \nsupport team escalation path |
| Users don't understand item-level requirement for Shopee/Taobao/Lazada | H | Prominent in-app messaging on these merchant pages; \nFAQ placement; pre-purchase warning |
| Low awareness of campaign among target users | M | Multi-channel launch (push, email, in-app banner); \npartner with high-traffic merchants for visibility |

---

## Launch checklist

- [ ] Campaign logic implemented and tested (incl. edge cases: timezone, item-level checking)
- [ ] Excluded merchant list loaded into system
- [ ] Tracking events instrumented and verified in staging
- [ ] Customer.io campaigns setup:
  - [ ] Pre-launch teaser (Feb 12)
  - [ ] Launch announcement (Feb 14)
  - [ ] Mid-campaign reminder (Feb 15)
  - [ ] Final hours reminder (Feb 16, 6pm)
  - [ ] Post-campaign recap (Feb 17)
- [ ] In-app campaign banner designed and scheduled
- [ ] Campaign landing page published
- [ ] Progress tracker UI implemented
- [ ] FAQ page updated
- [ ] Support team training completed
- [ ] Admin dashboard for monitoring ready
- [ ] Legal review of T&Cs completed
- [ ] Load testing completed (3x expected peak traffic)
- [ ] Rollback plan documented
- [ ] Post-campaign analysis template prepared

---

## Experiment plan

N/A - this is a full rollout to all SG users

**Future tests**:
- Test variable bonus tiers (S$200 = 200 MM, S$500 = 600 MM) vs. flat rate
- Test different cap levels (1,000 MM vs. 2,000 MM) on user behavior
- Test merchant-specific bonuses vs. campaign-wide approach

---

## Appendix

Max Miles Boost (CNY Edition) Terms & Conditions + Excluded Merchants (Full List)
https://docs.google.com/document/d/1L1JDjxQjCpuLBw5TI23-nzUpVGoqqZYZ3X8tTsPzZCs/edit?tab=t.0

Max Miles Boost (CNY Edition) Marketing Brief
https://docs.google.com/spreadsheets/d/14ogs316szW15ut20b4m4Y0U7RVXM2cHxbpGqZh79ylI/edit?gid=307825892#gid=307825892