# Earning Categories PRD

## Feature Name
Earning Categories Redesign with Earning Visibility
---
## Problem / Objective
**Current State Problems:**
1. Traffic to existing application intent categories is significantly low, indicating poor engagement with the discovery feature
2. User behaviour analysis shows users primarily search for known merchants rather than browsing or discovering new earning opportunities through categories
3. Current intent categories design lacks visibility into earning potential, providing no motivation for users to explore merchants in intent categories
**Objective:** Increase category engagement and merchant discovery by making earning potential transparent, reorganizing categories into intuitive segments, and providing continuous reasons to re-engage through new merchant visibility.
---
## Hypothesis
We believe that showing earning opportunities grouped on a category-level with potential miles earning visibility will increase category engagement and merchant discovery because users will understand the tangible value available in each category and be motivated to explore high-earning opportunities they weren't previously aware of.
---
## What Success Looks Like
**Primary Success Metrics:**
- **Category CTR**: Increase from [baseline]% to [target]% (+[X]% lift)
- **Discovery-driven transactions**: Increase transactions from category browsing by [X]%
- **Category exploration rate**: Increase avg # of categories explored per user from [baseline] to [target]
**Secondary Metrics:**
- **Time spent in categories**: Increase by [X] seconds per session
- **New merchant discovery**: [target]% increase in transactions with merchants discovered via categories
- **Return visit rate**: [target]% of users return to category pages within 7 days
- **New merchant engagement**: [target]% CTR on categories with "NEW" badges vs. without
**Success Definition:** Experiment is successful if primary metrics show statistically significant improvement (p < 0.05) with sustained category engagement over 30 days.
---
## Supporting Signals
### User Behavior Data
- Current user behavior: Predominantly search-driven, minimal category browsing
- "Shop online" category conflates unrelated merchant types, reducing relevance
- Low traffic to existing intent categories suggests lack of motivation to explore
- Users don't know earning potential of different merchant categories
---
## Who Is This For
### User Personas
| Persona | Jobs to be Done |
| --- | --- |
| **New Users** | • When I join the platform, I want to understand where I can earn miles, so I can start maximizing my rewards<br>• When I browse categories, I want to see what other users earn, so I can prioritize high-value opportunities<br>• When I see a category, I want to know if it's relevant to my spending, so I don't waste time |
| **Existing Users** | • When I browse categories, I want to see what other users earn, so I can prioritize high-value opportunities<br>• When I return to the platform, I want to see what's new, so I can discover fresh earning opportunities<br>• When I explore a category, I want to find merchants that match my intent, so I can complete transactions quickly |
---
## Intent Category Performance Data
Data to be displayed on category cards showing earning potential:
| Category | Avg Miles/User/Month | Unique Users | Total Miles Issued |
| --- | --- | --- | --- |
| Book travel | 3,243 | 5,809 | 18,841,349 |
| Shop offline | 422 | 17,468 | 7,368,059 |
| Shop online | 787 | 8,448 | 6,651,350 |
| Apply for card | 11,053 | 66 | 729,500 |
| FX & Business Spend | 17,091 | 35 | 598,169 |
| Order food | 239 | 2,387 | 569,302 |
| Book a ride | 282 | 1,746 | 492,783 |
| Dine out | 275 | 1,783 | 489,982 |
| Buy insurance | 447 | 347 | 155,160 |
| Buy groceries | 327 | 462 | 151,231 |
| Invest | 4,582 | 22 | 100,800 |
*This data will be displayed to users to show earning potential per category*
---
## Product Requirements
| # | User Story | Acceptance Criteria |
| --- | --- | --- |
| 1 | As a user landing on the home page, I want to see intent categories with earnings data so that I can understand the value of exploring each category | • Display category cards showing category name, icon, and "Avg X miles/month" earned by platform users<br>• Show all 11 refined categories in priority order<br>• Cards are tappable and lead to category detail pages<br>• Earnings data updates monthly based on platform performance |
| 2 | As a user, I want to see categories that match my actual spending intent so that I don't waste time browsing irrelevant merchants | • Remove broad "Shop online" catch-all category<br>• Create distinct categories: Book travel, Shop offline, Shop online (refined), Apply for card, FX & Business Spend, Order food, Book a ride, Dine out, Buy insurance, Buy groceries, Invest<br>• Each category contains only relevant merchants matching the intent<br>• Category names clearly indicate their purpose |
| 3 | As a user viewing categories, I want to see which ones have new merchants so that I have a reason to revisit familiar categories | • Categories with new merchants (added in last 30 days) show "🆕 X new" badge<br>• Badge appears on category card on home page<br>• Individual merchant pages show "NEW" tag on recently added merchants<br>• Badge persists for 30 days after merchant addition<br>• Badge shows count of new merchants (e.g., "🆕 5 new") |
| 4 | As a user exploring a category, I want to see merchant details and earning potential so that I can make informed decisions | • Category detail pages show list of merchants in category<br>• Each merchant shows earning rate/cashback percentage<br>• "NEW" tag displayed on recently added merchants<br>• Merchants sortable by earning potential, popularity, alphabetical |
---
## User Experience Details
### Home Page Category Cards
**Category Card Layout:**
```javascript
┌─────────────────────────────────┐
│  🏨                             │
│  Book travel                    │
│  Avg 3,243 miles/month    🆕 3  │
└─────────────────────────────────┘
```
**Card Elements:**
- **Category icon**: Visual identifier for quick recognition
- **Category name**: Clear, action-oriented label
- **Earning data**: "Avg X miles/month" showing platform average
- **New merchant badge** (conditional): "🆕 X new" if merchants added in last 30 days
**Visual Hierarchy:**
- Earning data displayed prominently to emphasize value
- New merchant badge positioned for visibility without overwhelming
- Tappable area covers entire card
---
### Category Prioritization & Display Order
Recommended display order on home page (balancing volume, earnings, and strategic value):
1. **Book travel** - High volume (5,809 users), high earnings (3,243 avg) - flagship category
2. **Shop offline** - Highest volume (17,468 users), everyday category (422 avg)
3. **FX & Business Spend** - Highest per-user value (17,091 avg) - premium positioning
4. **Apply for card** - Second highest per-user value (11,053 avg) - high-value acquisition
5. **Shop online** - High volume (8,448 users), refined category (787 avg)
6. **Invest** - High per-user value (4,582 avg), emerging category
7. **Buy insurance** - Moderate earnings (447 avg), periodic need
8. **Order food** - Moderate volume (2,387 users), habitual category (239 avg)
9. **Buy groceries** - Everyday essential (327 avg)
10. **Book a ride** - Habitual category (282 avg)
11. **Dine out** - Lifestyle category (275 avg)
---
### Category Detail Page
**Page Structure:**
```javascript
Book travel
Avg 3,243 miles/month • 5,809 users

[Sort: Earning potential ▼]

─────────────────────────────────
🆕 Airline A                    →
    Earn 5 miles per $1

🆕 Hotel B                      →
    Earn 10 miles per $1

Travel Agency C                 →
    Earn 3 miles per $1
─────────────────────────────────
```
**Features:**
- Category header with earning data and user count
- Sort/filter options (earning potential, popularity, alphabetical)
- Merchant list with earning rates
- NEW tags on recently added merchants
- Tap through to merchant detail/booking page
---
### New Merchant Badge Logic
**When badge appears:**
- Merchant added to category within last 30 days
- Badge shows count: "🆕 5 new" (if 5 merchants added)
- Badge shows on home page category card
- "NEW" tag shows on individual merchants in category detail page
**Badge duration:**
- Persists for 30 days from merchant addition date
- Automatically removed after 30 days
- Count updates as new merchants added or badges expire
---
## Events Tracking Table
| Event Name | Event Attributes | Description |
| --- | --- | --- |
| category_card_viewed | • category_name: string<br>• avg_miles_shown: integer<br>• experiment_variant: string<br>• card_position: integer<br>• new_merchant_count: integer | Fires when a category card enters viewport on home page |
| category_card_clicked | • category_name: string<br>• avg_miles_shown: integer<br>• experiment_variant: string<br>• card_position: integer<br>• has_new_badge: boolean<br>• new_merchant_count: integer | Fires when user taps on a category card; primary engagement metric |
| category_page_viewed | • category_name: string<br>• source: string (home/search/direct)<br>• experiment_variant: string<br>• merchant_count: integer<br>• new_merchant_count: integer | Fires when category detail page loads |
| new_merchant_clicked | • merchant_name: string<br>• category_name: string<br>• days_since_added: integer<br>• avg_miles_shown: integer | Fires when user taps on a merchant with "NEW" tag |
| merchant_selected_from_category | • category_name: string<br>• merchant_name: string<br>• experiment_variant: string<br>• merchant_earning_rate: string<br>• is_new_merchant: boolean | Fires when user selects a merchant from category page |
| experiment_exposure | • experiment_name: string<br>• variant: string<br>• user_id: string | Fires on first home page load during experiment |
---
## Experiment Design
### Variant A (Control)
- Current intent categories layout
- No earnings data displayed
- Existing "Shop online" catch-all category remains
- No new merchant badges
- Standard category cards with icons and names only
### Variant B (Treatment - Earning Categories)
- Intent categories with earnings data: "Avg X miles/month"
- Refined 11 categories with "Shop online" segmented
- New merchant badges: "🆕 X new"
- Enhanced category cards with earning visibility
- Updated category detail pages with earning rates per merchant
### Experiment Parameters
- **Traffic Split:** 50/50 randomized assignment
- **Duration:** 30 days minimum (can extend to 60 days for long-term engagement)
- **Primary Decision Metrics:**
  - Category card CTR
  - Discovery-driven transactions (transactions from category browsing)
  - Category exploration rate
- **Statistical Significance Threshold:** p < 0.05
- **Success Criteria:** Treatment must show statistically significant improvement in category engagement
---
## Merchant Recategorization Plan
### "Shop Online" Segmentation
**Merchants to move out of "Shop online":**
- **To "Invest"**: Investment platforms, brokerage apps, robo-advisors
- **To "Shop offline"**: Offline retailers with online presence, department stores
- **To "Buy insurance"**: Insurance comparison sites, policy platforms
- **To other specific categories**: Based on primary merchant intent
**Remaining in "Shop online" (refined):**
- Pure e-commerce platforms (Amazon, Lazada, Shopee, etc.)
- Online retail marketplaces
- Direct-to-consumer online brands
### Implementation Requirements
- Merchant mapping document detailing reclassification
- Data migration to update merchant-category associations
- QA testing to ensure merchants appear in correct categories
- Support documentation for user questions about category changes
---
## FAQs
**Q: Why show average miles per user instead of total miles issued?**
- A: Average miles per user is more relatable and actionable. It answers "What could I earn?" rather than showing aggregate platform metrics. Users can directly compare their potential earnings.
**Q: How do we handle categories with very low participation (like Invest with 22 users)?**
- A: Still display the category with earning data. High per-user value (4,582 miles) is compelling even with low volume. The earning potential motivates exploration regardless of current participation levels.
**Q: What happens to existing "Shop online" merchants when we segment the category?**
- A: Merchants are reclassified into appropriate new categories (e.g., investment platforms → Invest, offline retailers → Shop offline). Remaining "Shop online" focuses on core e-commerce. A detailed merchant mapping document will guide the transition.
**Q: Will showing earnings data on all categories make high-value niche categories (like "Apply for card") too prominent?**
- A: No. Category order balances multiple factors: volume, earnings, and strategic value. High-value niches are positioned prominently but not overwhelmingly. Users self-select based on relevance.
**Q: Could the new merchant badge lose effectiveness over time as users become familiar with it?**
- A: Badge effectiveness depends on actual new merchant additions. As long as we continuously onboard new merchants (which we should for platform growth), the badge remains valuable. We'll monitor badge CTR over time.
**Q: How often will earnings data update?**
- A: Monthly, based on previous month's performance data. This provides stable, meaningful averages while remaining current enough to reflect actual earning potential.
**Q: What if users only focus on highest-earning categories and ignore others?**
- A: That's acceptable and even desirable. We want users to discover and use the highest-value opportunities for their needs. Lower-earning categories still serve users with those specific intents (e.g., "Order food" for meal delivery).
---
## Launch Checklist
- [ ] Experiment plan defined - Traffic split, duration, decision metrics documented
- [ ] Tracking events defined - All events in tracking table implemented
- [ ] Design mockups completed - Treatment variant finalized for all screen sizes
- [ ] Merchant recategorization complete - All merchants reassigned from "Shop online"
- [ ] Merchant mapping document - Detailed transition plan documented
- [ ] Success metrics baseline established - Current CTR, engagement rate documented
- [ ] Stakeholder sign-off received - Product, design, data science approval
- [ ] QA test plan created - Test cases for both variants, merchant placement accuracy
- [ ] Experiment randomization tested - User assignment logic validated for 50/50 split
- [ ] Documentation updated - Category definitions and merchant mappings
- [ ] Support team briefed - FAQs and talking points for user questions
- [ ] Data dashboard created - Real-time experiment monitoring with key metrics
- [ ] Rollback plan defined - Criteria and process for stopping experiment early
---
## Additional Notes
**Dependencies:**
- Monthly earnings calculation pipeline must be established and refresh monthly
- Merchant recategorization requires coordination with operations team
- Experiment platform must support persistent user assignment across sessions
- Merchant onboarding process must capture "date_added" for new badge logic
**Constraints:**
- Mobile screen real estate limits number of visible categories without scrolling
- Earnings data has processing lag; must communicate "previous month" timeframe
- Cannot guarantee specific redemption values (earnings examples are illustrative)
**Future Considerations (V2):**
- Personalized category recommendations based on user behavior
- Dynamic category ordering based on user preferences
- Seasonal category highlighting (e.g., "Book travel" during holiday booking season)
- Category-specific promotional campaigns
- User reviews and ratings for merchants within categories
- Advanced filtering and search within categories
**Risk Mitigation:**
- Monitor for unintended consequences (e.g., all traffic to top category)
- Track cross-category behavior to understand substitution effects
- Have rollback plan if treatment negatively impacts any key metric
- Collect qualitative feedback on category organization and earning visibility
---
**Document Owner:** [Name]
**Last Updated:** January 7, 2026
**Status:** Draft - Pending Review