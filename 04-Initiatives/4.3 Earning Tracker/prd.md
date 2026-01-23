# Personal Miles Performance Tracker PRD

## Feature Name
Personal Miles Performance Tracker
---
## Problem / Objective
**Current State Problems:**
1. Users lack visibility into their earning performance, leading to passive earning behaviour and low merchant discoverability
2. Once users complete initial transactions, there's no ongoing reason to return and explore new earning opportunities
3. "Shop online" category serves as an overly broad catch-all, lumping together disparate merchant types (investments, offline spend, etc.), creating confusion and poor findability

**Objective:** Create a sustainable engagement loop through personal performance tracking that motivates users to set earning goals, monitor progress, and continuously explore high-value earning opportunities.
---
## Hypothesis
We believe that showing users their earning progress toward a personal goal will increase sustained engagement and platform usage because the performance tracker creates clear visibility into earning performance and provides motivation to continuously explore earning opportunities.
---
## What Success Looks Like

**Primary Success Metrics:**

- **Category exploration from carousel:** [target]% of users tap on category boxes
- Merchant Page views
- more sessions per user + more clicks

**Secondary Metrics:**

- **Goal completion rate**: [target]% of users reach their monthly miles goal
- **Sustained engagement**: [target]% of users view tracker widget 3+ times per month
- Transaction frequency: Increase in avg transactions per user per month
- New Category transaction: [target]% of users tapped into category boxes and converted

**Success Definition:**

- Experiment is successful if primary metrics show statistically significant improvement (p < 0.05) with sustained engagement (measured at 30, 60, 90 days post-launch).
---
## Supporting Signals

### User Behaviour Data
- Users currently lack visibility into overall earning performance
- No existing mechanism to motivate ongoing platform engagement
- Need for clear targets and achievement feedback loops
- Current intent categories lack intuitive organization, making merchant discovery difficult
---
## Who Is This For
### User Personas
| Persona | Jobs to be Done |
| --- | --- |
| **New Users** | • When I join the platform, I want to set an earning goal, so I have a clear target to work toward\n• When I set a goal, I want to see my progress, so I stay motivated\n• When I view my performance, I want to understand where I can earn more, so I can reach my goal |
| **Existing Users** | • When I make purchases, I want to track progress toward my goal, so I stay motivated\n• When I'm behind on my goal, I want to see where I can earn more, so I can catch up\n• When I achieve my goal, I want recognition and ability to set stretch goals, so I continue engaging |
---
## Product Requirements
| # | User Story | Acceptance Criteria |
| --- | --- | --- |
| 1 | As a first-time user, I want to set a monthly miles goal so that I have a clear target to work toward | • User is prompted to set goal on first home page visit after feature launch\n• Goal setting modal shows 4 preset tiers (400/1,000/2,000/5,000) with annual redemption examples\n• Each tier shows: "X/month = Y annual miles = [Redemption destination]"\n• User can skip and set later, but sees prompt on subsequent visits\n• Goal is saved to user profile and persists month-to-month |
| 2 | As a user with a goal, I want to see my progress on the home page so that I'm continuously aware of my earning status | • Home page displays persistent tracker widge\n• Widget shows: progress bar, current miles, goal, percentage complete\n• Widget shows scrollable carousel of ALL 11 category boxes\n• Each category box shows: title, icon, miles earned\n• Categories with earnings have green background highlight\n• Categories with $0 earned have grey/default background\n• Widget updates in real-time when user earns miles |
| 3 | As a user, I want to see which categories I've earned from so that I can understand my earning patterns | • Category carousel shows all 11 categories in scrollable horizontal layout\n• Green highlight on categories where user made transactions\n• Miles amount displayed at bottom of each box\n• Categories sorted by highest earning first, then $0 categories\n• Categories are tappable and link to category pages |
| 4 | As a user, I want to edit my monthly goal so that I can adjust targets based on my spending patterns or redemption plans | • Widget includes "Edit goal" button in goal progress section\n• Tapping opens goal editing modal with current goal pre-filled\n• Modal shows 4 preset tiers + custom input option\n• Modal shows annual calculation and redemption example for selected tier\n• New goal saves immediately and updates all progress calculations |
| 5 | As a user at the start of a new month, I want my goal to persist but progress to reset so that I have a fresh start each month | • On 1st of each month, miles earned resets to $0\n• Monthly goal amount persists automatically (no re-entry needed)\n• Category averages update with new month's data\n• User sees "New month, new goal! You earned X miles in [previous month]" |
---

+++ ## User Experience Details Draft

+++ ### Home Page Widget Draft

#### Phase 1: Basic Progress Tracker

**Phase 1 Hypothesis Test:** Does progress tracking alone drive engagement, or do visual earning indicators (color + miles) provide significant additional value?

**Widget Layout:**
```javascript
┌───────────────────────────────────────────────────┐
│ 🎯 Your Miles This Month      [Edit goal]         │
│                                                   │
│ ████████████░░░░░░░░ 2,450 / 4,000                │
│ 61% of your goal                                  │
│                                                   │
│ ◄ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌────── ► │
│   │ Order   │ │  Book   │ │  Shop   │ │ Apply   │
│   │  food   │ │ travel  │ │ offline │ │for card │
│   │         │ │         │ │         │ │         │
│   │   🍔    │ │   🏨    │ │   🛍️    │ │   💳    │
│   │         │ │         │ │         │ │         │
│   └─────────┘ └─────────┘ └─────────┘ └─────────┘
└───────────────────────────────────────────────────┘
```
**Category Display Logic:**
- Scrollable horizontal carousel showing ALL 11 categories
- Each box displays: Category title (top), icon (middle)
- Sort order: Default category order (no earning-based sorting)
- All boxes are tappable and link to category detail pages
- Smooth horizontal scroll with swipe gesture

---

#### Phase 2: Enhanced Visual Feedback

**Phase 2 Hypothesis Test:** Does adding visual earning feedback (color coding + miles display) increase category exploration and merchant discovery compared to Phase 1?

**Widget Layout:**
```javascript
┌───────────────────────────────────────────────────┐
│ 🎯 Your Miles This Month      [Edit goal]         │
│                                                   │
│ ████████████░░░░░░░░ 2,450 / 4,000                │
│ 61% of your goal                                  │
│                                                   │
│ ◄ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌────── ► │
│   │ Order   │ │  Book   │ │  Shop   │ │ Apply   │
│   │  food   │ │ travel  │ │ offline │ │for card │
│   │         │ │         │ │         │ │         │
│   │   🍔    │ │   🏨    │ │   🛍️    │ │   💳    │
│   │         │ │         │ │         │ │         │
│   │ 200 mi  │ │1,200 mi │ │ 850 mi  │ │  0 mi   │
│   └─────────┘ └─────────┘ └─────────┘ └─────────┘
│   [green bg]  [green bg]  [green bg]  [grey bg]  │
└───────────────────────────────────────────────────┘
```
**Additional Category Display Logic:**
- Each box displays: Category title (top), icon (middle), miles earned (bottom)
- **Green background** for categories with earnings (user made transaction)
- **Grey/default background** for categories with $0 earned

+++

---

+++ ### Goal Setting Experience Draft
**Initial Goal Setting Modal:**
```javascript
┌─────────────────────────────────────────┐
│         Set Your Miles Goal 🎯          │
│                                         │
│ How many miles do you want to earn      │
│ each month?                             │
│                                         │
│   ○ 400 miles/month                     │
│      = 4,800/year                       │
│      = One-way to Kuala Lumpur          │
│                                         │
│   ○ 1,000 miles/month                   │
│      = 12,000/year                      │
│      = Round-trip to Bangkok            │
│                                         │
│   ● 2,000 miles/month              ✓    │
│      = 24,000/year                      │
│      = Round-trip to Tokyo              │
│                                         │
│   ○ 5,000 miles/month                   │
│      = 60,000/year                      │
│      = Round-trip to London             │
│                                         │
│   ○ Custom: [____] miles                │
│                                         │
│ You can change this anytime             │
│                                         │
│          [Set Goal & Continue]          │
│              [Skip for now]             │
└─────────────────────────────────────────┘
```

**Goal Tier Definitions:**
| Monthly Goal | Annual Miles | Redemption Example |
| --- | --- | --- |
| 400 miles/month | 4,800/year | One-way flight to Kuala Lumpur, Malaysia |
| 1,000 miles/month | 12,000/year | Round-trip to Bangkok, Thailand |
| 2,000 miles/month | 24,000/year | Round-trip to Tokyo, Japan |
| 5,000 miles/month | 60,000/year | Round-trip to London, UK |
| Custom | Varies | User calculates based on specific redemption goal |
**Recommended Default:** 2,000 miles/month (moderate, achievable for most users)

+++

+++


---



## Events Tracking Table
| Event Name | Event Attributes | Description |
| --- | --- | --- |
| goal_set | • goal_amount: integer\n• goal_tier: string (400/1000/2000/5000/custom)\n• annual_miles: integer\n• redemption_example: string\n• is_first_time: boolean | Fires when user sets or updates their monthly miles goal |
| tracker_widget_viewed | • current_miles: integer\n• goal: integer\n• progress_pct: integer\n• active_categories_count: integer\n• session_timestamp: datetime | Fires when tracker widget enters viewport on home page |
| category_carousel_scrolled | • scroll_position: integer\n• categories_viewed: array\n• user_progress_pct: integer | Fires when user scrolls through category carousel |
| category_box_clicked | • category_name: string\n• category_position: integer\n• has_earnings: boolean\n• miles_earned: integer\n• user_progress_pct: integer | Fires when user taps on a category box from the carousel |
| goal_edited | • old_goal: integer\n• new_goal: integer\n• goal_change_pct: integer\n• current_progress_pct: integer | Fires when user changes their monthly goal |
| goal_achieved | • goal_amount: integer\n• days_to_achieve: integer\n• categories_used: integer | Fires when user's earned miles first exceeds or equals their goal |
---
## Experiment Design

### Variant A (Control)

- Current platform experience
- No performance tracker
- Users see standard interface

### Variant B (Treatment - Performance Tracker)

- Performance tracker widget on home page with goal progress bar
- Goal setting with 4 preset tiers + redemption examples
- Scrollable category carousel showing all 11 categories
- Category boxes display: title, icon, miles earned
- Green highlight for categories with earnings, grey for $0 categories
- Simplified single-page experience (no separate dashboard)

### Experiment Parameters

- **Traffic Split:** 50/50 randomised assignment
- **Duration:** 30 days minimum to measure sustained engagement
- **Success Criteria:** Treatment must show sustained engagement improvement (measured at 30, 60, 90 days)

## FAQs

**Q: How does this PRD address the "Shop online" catch-all issue?**

- A: The improved category organization with clearer labels and icons in the carousel helps users distinguish between "Shop online", "Shop offline", and "Invest" at a glance, reducing confusion about category purposes.

---

## Launch Checklist

- Tracking events defined - All events in tracking table implemented
- Design mockups completed - Treatment variant finalised for all screen sizes
- Success metrics baseline established - Current engagement metrics documented
- Stakeholder sign-off received - Product, design, data science approval
- QA test plan created - Test cases for both variants, data accuracy, tracking
- Experiment randomization tested - User assignment logic validated for 50/50 split
- Documentation updated - Feature documentation and user guides prepared
- Support team briefed - FAQs and talking points for user questions
- Data dashboard created - Real-time experiment monitoring with key metrics
- Rollback plan defined - Criteria and process for stopping experiment early

---

## **Future Considerations (V2):**

- Personalised earning projections based on spending patterns
- Historical performance charts (month-over-month trends)
- Push notifications for progress milestones
- Achievement badges and streaks
- Social features (compare with friends)
- Category-specific sub-goals