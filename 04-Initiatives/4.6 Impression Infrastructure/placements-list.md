# Placements List
## Placement Tracking Recommendations
### High-Priority Placements (Top Impressions Expected)
1. ✅ **Explore Intent Category Tabs** (16 placements) - Primary merchant discovery
2. ✅ **Earn Tab Browse All** - Main earning opportunities
3. ✅ **Home Top Banner Carousel** (Web) - High visibility promotional
4. ✅ **Search Results** - Active user intent
5. ✅ **Merchant Detail Page** - High-value impressions
6. ✅ **Transaction History** (Miles + Cards) - Frequent revisits
7. ✅ **Deals Calendar** (Current + Upcoming) - Deal-focused users
8. ✅ **Bookmarks** - Saved merchant revisits
### Medium-Priority Placements
9. ✅ **Campaign Pages** (JRE, Yuu, Atome, TakeMe Japan) - Targeted campaigns
10. ✅ **Voucher Sections** - Purchase intent
11. ✅ **Card Reward Recommendations** - Card-focused users
12. ✅ **Product Browsing** (Affiliate) - Shopping intent
### Low-Priority Placements
13. ✅ **Activation Flow** - New users only
14. ✅ **Restaurant Listings** - Niche use case
15. ✅ **Articles** - Educational content

## Summary Statistics
### Expo Mobile App
- **Total Placement Categories**: 13
- **Total Unique Placements**: 70+
### Next.js Web App
- **Total Placement Categories**: 9
- **Total Unique Placements**: 30+
### Grand Total
- **Combined Placement Categories**: 23
- **Total Unique Placements**: 100+

### Data Structure for Impressions
```javascript
interface MerchantImpression {
  placement_id: string;           // e.g., "explore_shop"
  merchant_id: string;
  merchant_name: string;
  merchant_slug: string;
  position_in_list?: number;      // 0-indexed position in grid/list
  session_id: string;
  timestamp: string;
  user_id?: string;
  intent_category?: string;       // For explore tabs
  campaign_id?: string;           // For campaign pages
  platform: "expo" | "nextjs";
}
```

### Comprehensive Placement List for Merchant Impressions
Below is a complete taxonomy of all merchant exposure/impression tracking placements across both the Expo (mobile) and Next.js (web) applications, organized by page and section.
---
## Expo Mobile App Placements
### 1. Earn Tab (Home Screen)
**Route**: `apps/expo/app/(tabs)/earn.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `earn_search_bar` | Search bar at top of Earn page | apps/expo/components/earn/search.tsx |
| `earn_hub` | Hub section with quick actions | apps/expo/components/earn/hub |
| `earn_in_app_notification` | In-app notification banners | apps/expo/components/earn/in-app-notification |
| `earn_banner` | Promotional banner carousel | apps/expo/components/earn/banner.tsx |
| `earn_experiments` | Region-specific experimental sections | apps/expo/components/earn/experiments |
| `earn_browse_all` | "Browse All" merchants section | apps/expo/components/earn/browse-all |
| `earn_activation_carousel` | HK-specific activation carousel | apps/expo/components/earn/activation/activation-carousel.tsx |
| `earn_activation_summary` | Activation summary card | apps/expo/components/earn/activation |
---
### 2. Explore Page (Intent Category Tabs)
**Route**: `apps/expo/app/explore/(tabs)/_layout.tsx`
Each intent category tab is a separate placement:
| Placement ID | Tab Name | Route | Hook |
| --- | --- | --- | --- |
| `explore_deals` | Deals | apps/expo/app/explore/(tabs)/deals.tsx | `usePromotionalMerchants` |
| `explore_shop` | Shop Online | apps/expo/app/explore/(tabs)/shop.tsx | `useIntentCategoryMerchants` |
| `explore_food` | Order Food | apps/expo/app/explore/(tabs)/food.tsx | `useIntentCategoryMerchants` |
| `explore_groceries` | Groceries | apps/expo/app/explore/(tabs)/groceries.tsx | `useIntentCategoryMerchants` |
| `explore_dine` | Dine | apps/expo/app/explore/(tabs)/dine.tsx | `useRestaurantSearch` |
| `explore_travel` | Travel | apps/expo/app/explore/(tabs)/travel.tsx | `useIntentCategoryMerchants` |
| `explore_flights` | Flights | apps/expo/app/explore/(tabs)/flights.tsx | `useIntentCategoryMerchants` |
| `explore_hotels` | Hotels | apps/expo/app/explore/(tabs)/hotels.tsx | `useIntentCategoryMerchants` |
| `explore_ride` | Ride | apps/expo/app/explore/(tabs)/ride.tsx | `useIntentCategoryMerchants` |
| `explore_shop_offline` | Shop Offline | apps/expo/app/explore/(tabs)/shop-offline.tsx | `useIntentCategoryMerchants` |
| `explore_apply_card` | Apply Card | apps/expo/app/explore/(tabs)/apply-card.tsx | `useIntentCategoryMerchants` |
| `explore_fx_n_biz` | FX n Biz | apps/expo/app/explore/(tabs)/fx-n-biz.tsx | `useIntentCategoryMerchants` |
| `explore_insurance` | Insurance | apps/expo/app/explore/(tabs)/insurance.tsx | `useIntentCategoryMerchants` |
| `explore_invest` | Invest | apps/expo/app/explore/(tabs)/invest.tsx | `useIntentCategoryMerchants` |
| `explore_vouchers` | Vouchers | apps/expo/app/explore/(tabs)/vouchers.tsx | Custom voucher grid |
| `explore_card` | Card Recommendations | apps/expo/app/explore/(tabs)/card.tsx | Card recommendation logic |
**Merchant Grid Component**: `apps/expo/components/explore/intent-category/merchant-grid.tsx`
---
### 3. Merchant Detail Page
**Route**: `apps/expo/app/merchant/[slug]/index.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `merchant_detail_header` | Merchant header with logo | apps/expo/components/merchant/header.tsx |
| `merchant_detail_info` | Merchant info card | apps/expo/components/merchant/merchant-info.tsx |
| `merchant_detail_earning_strategy` | Earning strategy section | apps/expo/components/merchant/earning-strategy/merchant-strategy.tsx |
| `merchant_detail_card_reward` | Best card recommendations | apps/expo/components/merchant/card-reward/best-card.tsx |
| `merchant_detail_campaign_extra_info` | Campaign extra information | apps/expo/components/merchant/campaign-extra-info.tsx |
| `merchant_detail_footer` | Footer with action buttons | apps/expo/components/merchant/footer.tsx |
**Related Screens**:
- `merchant_card_reward_page` - apps/expo/app/merchant/[slug]/card-reward.tsx
- `merchant_product_search` - apps/expo/app/merchant/[slug]/product-search-result-card.tsx
- `merchant_promo_codes` - apps/expo/app/merchant/[slug]/promo-codes.tsx
- `merchant_affiliation_earning_rate` - apps/expo/app/merchant/[slug]/affiliation-earning-rate.tsx
---
### 4. Miles Tab (Transaction History)
**Route**: `apps/expo/app/(tabs)/miles.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `miles_transaction_list` | Mile transaction history with merchant names | apps/expo/components/transactions/miles/item.tsx |
| `miles_transaction_callout` | Transaction callout card | apps/expo/components/transactions/miles/callout.tsx |
| `miles_click_history` | Shop Max click history | apps/expo/components/transactions/click-history |
**Hooks**:
- `useMileTransaction` - apps/expo/hooks/mile_transaction/useMileTransaction.ts
- `useMilesClicks` / `useMilesClicksInfinite` - apps/expo/hooks/mile_transaction/useMerchantClick.ts
---
### 5. Search
**Route**: `apps/expo/app/search/index.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `search_merchants` | Merchant search results | apps/expo/components/search/merchants/autocomplete.tsx |
| `search_all_autocomplete` | All search autocomplete | apps/expo/components/search/all/autocomplete.tsx |
| `search_product_shopee` | Shopee product search | apps/expo/app/search/shopee.tsx |
| `search_product_taobao` | Taobao product search | apps/expo/app/search/taobao.tsx |
| `search_product_generic` | Generic product search | apps/expo/app/search/product.tsx |
**Hooks**:
- `searchMerchant` - apps/expo/store/search.ts
- `useProductLinkSearch` - apps/expo/hooks/useProductSearch.ts
---
### 6. Bookmarks
**Route**: `apps/expo/app/bookmark/merchants.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `bookmark_merchant_grid` | Saved/bookmarked merchants grid | apps/expo/app/bookmark/merchants.tsx |
**Endpoint**: `GET /api/bookmark/merchants`
---
### 7. Deals Calendar
**Route**: `apps/expo/app/deals-calendar/index.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `deals_calendar_current` | Current deals tab | apps/expo/components/deals-calendar/CurrentDeals.tsx |
| `deals_calendar_upcoming` | Upcoming deals tab | apps/expo/components/deals-calendar/UpcomingDeals.tsx |
| `deals_calendar_upcoming_item` | Upcoming deal item card | apps/expo/components/deals-calendar/UpcomingDealItem.tsx |
**Hook**: `useUpcomingDeals` (uses `useGetUpcomingDeals`)
---
### 8. Vouchers & Gift Cards
**Route**: `apps/expo/app/voucher/my-vouchers.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `my_vouchers_available` | Available vouchers tab with merchant branding | apps/expo/components/voucher/my-vouchers/MyVoucherOrderItem.tsx |
| `my_vouchers_redeemed` | Redeemed vouchers tab with merchant branding | apps/expo/components/voucher/my-vouchers/MyVoucherOrderItem.tsx |
| `voucher_purchase_recommendations` | Voucher purchase recommendation cards | apps/expo/components/voucher/purchase/VoucherRecommendedCard.tsx |
**Hook**: `useMyVouchers` - apps/expo/hooks/voucher/useMyVouchers.ts
---
### 9. Cards Section
**Route**: `apps/expo/app/cards/`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `cards_your_cards` | Your linked cards list | apps/expo/app/cards/your-cards/index.tsx |
| `cards_transaction_detail` | Card transaction with merchant info | apps/expo/app/cards/your-cards/transaction/[transactionId].tsx |
| `cards_reward_cycles` | Reward cycles list | apps/expo/app/cards/your-cards/[cardId]/reward-cycles/index.tsx |
| `cards_apply` | Card application page | apps/expo/app/cards/apply.tsx |
| `cards_add_cards` | Add cards page | apps/expo/app/cards/add-cards.tsx |
**Hooks**:
- `useLinkedCardTransactions` - apps/expo/hooks/useSpendTracking.ts:34
- `useGetSpendTransaction` - apps/expo/hooks/useSpendTracking.ts:185
- `useSpendTrackingSummary` - apps/expo/hooks/useSpendTracking.ts:67
---
### 10. Campaign Pages
#### JRE Campaign
**Route**: `apps/expo/app/campaign/jre.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `campaign_jre_sg_content` | JRE Singapore merchants | apps/expo/components/jre/JRECampaignSGContent.tsx |
| `campaign_jre_travel_content` | JRE travel merchants | apps/expo/components/jre/JRECampaignTravelContent.tsx |
| `campaign_jre_merchant_list` | JRE merchant list | apps/expo/components/jre/JRECampaignMerchantList.tsx |
| `campaign_jre_jr_east_pass` | JR East Pass merchants | apps/expo/app/campaign/jre-merchants/jr-east-pass.tsx |
| `campaign_jre_jr_tokyo_wide_pass` | JR Tokyo Wide Pass merchants | apps/expo/app/campaign/jre-merchants/jr-tokyo-wide-pass.tsx |
| `campaign_jre_suica_mobile` | Suica Mobile merchants | apps/expo/app/campaign/jre-merchants/suica-mobile.tsx |
#### Yuu Campaign
**Route**: `apps/expo/app/campaign/yuu.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `campaign_yuu` | Yuu campaign merchants | apps/expo/app/campaign/yuu.tsx |
**Hook**: `useYuuCampaign` - apps/expo/hooks/useYuuCampaign.ts
#### Atome Campaign
**Route**: `apps/expo/app/campaign/atome.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `campaign_atome` | Atome campaign merchants | apps/expo/app/campaign/atome.tsx |
#### TakeMe Japan Campaign
**Route**: `apps/expo/app/campaign/takeme-japan/index.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `campaign_takeme_japan` | TakeMe Japan merchants | apps/expo/app/campaign/takeme-japan/index.tsx |
| `campaign_takeme_japan_best_card` | TakeMe best card recommendations | apps/expo/components/takeme-japan/TakeMeBestCard.tsx |
E**ach campaign should be treated as a unique placement**. Here's the recommended approach:
### Naming Convention
Use a structured, hierarchical naming convention:
```javascript
campaign_{campaign_slug}_{section?}

```
**Structure:**
- **Prefix**: Always `campaign_`
- **Campaign Slug**: Unique identifier (kebab-case, lowercase)
- **Section** (optional): For campaigns with multiple sections/tabs
---
## Campaign Types & Examples
### 1. Time-Bound, Merchant-Specific Campaigns
These campaigns promote specific merchants or merchant groups with a defined start/end date.
**Format**: `campaign_{campaign_slug}`
**Examples from codebase:**
| Campaign | Placement ID | Duration | Merchants |
| --- | --- | --- | --- |
| Yuu Merchants (May 2025) | `campaign_yuu_merchants_may25` | Time-bound | All Yuu-affiliated merchants |
| TakeMe Japan | `campaign_takeme_japan` | Time-bound | TakeMe Restaurant Booking |
| Atome | `campaign_atome` | Time-bound | Atome-affiliated merchants |
| Chocolate Finance | `campaign_chocolate_finance` | Time-bound | Chocolate Finance |
**Implementation**: `apps/expo/hooks/useYuuCampaign.ts:12`
```javascript
export const YUU_CAMPAIGN_NAME = "yuu_merchants_may25";
```
**Key Characteristics:**
- ✅ Each campaign gets a unique slug with temporal identifier (e.g., `may25`)
- ✅ When campaign repeats, create new placement ID (e.g., `yuu_merchants_jun26`)
- ✅ Allows tracking impressions per campaign iteration
- ✅ Historical data preserved per campaign period
---
### 2. Time-Bound, Multi-Section Campaigns
Campaigns with multiple tabs/sections showing different merchant sets.
**Format**: `campaign_{campaign_slug}_{section}`
**Example: JRE Campaign**
The JRE campaign has two sections (tabs): "Travel to Japan" and "Japan in SG"
| Placement ID | Section | Implementation |
| --- | --- | --- |
| `campaign_jre_travel` | Travel to Japan tab | `apps/expo/app/campaign/jre.tsx:62` |
| `campaign_jre_singapore` | Japan in SG tab | `apps/expo/app/campaign/jre.tsx:58` |
**Sub-pages for specific merchant groups:**
| Placement ID | Context | Route |
| --- | --- | --- |
| `campaign_jre_jr_east_pass` | JR East Pass merchants | `apps/expo/app/campaign/jre-merchants/jr-east-pass.tsx` |
| `campaign_jre_jr_tokyo_wide_pass` | JR Tokyo Wide Pass merchants | `apps/expo/app/campaign/jre-merchants/jr-tokyo-wide-pass.tsx` |
| `campaign_jre_suica_mobile` | Suica Mobile merchants | `apps/expo/app/campaign/jre-merchants/suica-mobile.tsx` |
**Why separate placements per section?**
- Different merchant sets per tab
- Different user intent (Travel vs Local)
- Need granular impression tracking per section
---
### 3. Evergreen Campaigns (All Merchants)
Campaigns that show all/most merchants with dynamic configuration (no fixed end date).
**Format**: `campaign_{campaign_slug}`
**Example:**
- If you have a general "Explore All Merchants" campaign page
- Use: `campaign_explore_all` or similar generic slug
**Note**: If the merchant set changes dynamically via feature flags/config, still use one placement ID. Track merchant-specific impressions in the impression payload, not the placement ID.
---
## Campaign Configuration & Dynamic Content
Many campaigns use **Statsig dynamic configs** for content:
**Example: TakeMe Japan** (`apps/expo/app/campaign/takeme-japan/index.tsx:50`)
```javascript
const takemeJapanConfig = getDynamicConfig("takeme-japan-info");
```
**Recommendation**:
- Placement ID remains static: `campaign_takeme_japan`
- Dynamic config controls CONTENT (merchants shown, images, etc.)
- Impression tracking includes merchant IDs in payload
---
## When to Create New Placement IDs
### ✅ Create New Placement ID When:
1. **New campaign launched** (even if similar to previous)
  - Example: `campaign_yuu_merchants_may25` → `campaign_yuu_merchants_dec25`
2. **Campaign has distinct sections/tabs**
  - Example: `campaign_jre_travel` vs `campaign_jre_singapore`
3. **Merchant set is fundamentally different**
  - Example: `campaign_jre_jr_east_pass` (specific pass merchants)
4. **Different page/route in the app**
  - Example: Each route under `/campaign/*` gets own placement ID
### ❌ Don't Create New Placement ID When:
1. **Merchant list changes within same campaign period**
  - Track merchant IDs in impression payload instead
2. **Visual design changes** (but same campaign/merchants)
  - Design changes don't require new placement ID
3. **Feature flag enables/disables sections**
  - Use section-based placement IDs that can be conditionally tracked
---
## Impression Tracking Payload for Campaigns
For campaign pages, your impression tracking should include:
```javascript
interface CampaignMerchantImpression {
  placement_id: string;               // e.g., "campaign_yuu_merchants_may25"
  campaign_slug: string;              // e.g., "yuu_merchants_may25"
  campaign_type: "merchant_specific" | "multi_section" | "general";
  
  // Campaign metadata
  campaign_start_date?: string;       // ISO timestamp
  campaign_end_date?: string;         // ISO timestamp
  campaign_config_version?: string;   // From Statsig or backend
  
  // Merchant data
  merchant_id: string;
  merchant_name: string;
  merchant_slug: string;
  
  // Position context
  section?: string;                   // "travel", "singapore", etc.
  position_in_list?: number;
  
  // Standard fields
  session_id: string;
  user_id?: string;
  timestamp: string;
  platform: "expo" | "nextjs";
}
```
**Benefits:**
- Link impressions back to specific campaign iterations
- Analyze campaign performance over time
- Compare merchant performance across different campaign periods
- Track campaign effectiveness by section
---
## Backend Campaign Endpoint Integration
Based on the investigation, campaigns use these endpoints:
**Campaign Detail**: `GET /api/campaign/{campaignName}/detail`
**Campaign Enrollment**: `POST /api/campaign/{campaignName}/enrol`
**Recommendation**: Include campaign metadata from backend response in impression tracking:
```javascript
const { data: campaignDetail } = await axios.get(`/api/campaign/${campaignName}/detail`);

// Include campaign_config_version in impressions
trackMerchantImpression({
  // ...
  campaign_config_version: campaignDetail.version || campaignDetail.updated_at,
});
```
---
## Database Schema Recommendation
For storing campaign impressions, consider adding a dedicated `campaign_impressions` table (or extending existing impressions table):
```javascript
CREATE TABLE campaign_impressions (
  id UUID PRIMARY KEY,
  placement_id VARCHAR(255) NOT NULL,
  campaign_slug VARCHAR(255) NOT NULL,
  campaign_type VARCHAR(50),
  section VARCHAR(100),
  merchant_id VARCHAR(255) NOT NULL,
  user_id VARCHAR(255),
  session_id VARCHAR(255),
  timestamp TIMESTAMP NOT NULL,
  campaign_start_date TIMESTAMP,
  campaign_end_date TIMESTAMP,
  platform VARCHAR(20),
  position_in_list INT,
  INDEX idx_campaign_slug (campaign_slug),
  INDEX idx_placement_merchant (placement_id, merchant_id),
  INDEX idx_timestamp (timestamp)
);
```
**Benefits:**
- Query impressions by campaign period
- Aggregate merchant performance across campaigns
- Track campaign ROI over time
- Historical analysis of campaign effectiveness
---
## Summary
### ✅ Recommended Approach
1. **Each campaign = unique placement ID**
2. **Use temporal identifiers in slug** (e.g., `_may25`) for time-bound campaigns
3. **Multi-section campaigns get section suffix** (e.g., `_travel`, `_singapore`)
4. **Include rich metadata in impression payload** (campaign dates, config version, section)
5. **Create new placement ID for each campaign iteration** (even if similar)
### ✅ Benefits
- **Clear attribution**: Know exactly which campaign drove merchant views
- **Historical tracking**: Compare campaign performance over time
- **A/B testing**: Test different campaign approaches
- **ROI analysis**: Calculate campaign effectiveness per merchant
- **Granular insights**: Understand which sections/tabs perform best
### ✅ Naming Convention Reference
```javascript
campaign_{campaign_slug}                    # Single-section campaigns
campaign_{campaign_slug}_{section}          # Multi-section campaigns
campaign_{campaign_slug}_{temporal_id}      # Time-bound iterations

```
**Examples:**
- `campaign_yuu_merchants_may25`
- `campaign_jre_travel`
- `campaign_jre_singapore`
- `campaign_jre_jr_east_pass`
- `campaign_takeme_japan`
- `campaign_atome`
- `campaign_chocolate_finance`

---
### 11. Product Browsing (Affiliate Shopping)
**Route**: `apps/expo/app/merchant/products.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `merchant_products_best_deals` | Best deals from merchant | apps/expo/lib/products.ts:61 |
| `merchant_products_hot_items` | Hot items from merchant | apps/expo/lib/products.ts:61 |
| `merchant_products_search` | Product search results | apps/expo/store/search.ts:261 |
**API Endpoints**:
- `GET /api/merchant/best_deals`
- `GET /api/merchant/hot_items`
- `GET /api/merchant/search_items`
---
### 12. Activation Flow
**Route**: `apps/expo/app/activation/`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `activation_earn_first_miles` | Earn first miles merchants | apps/expo/app/activation/earn-first-miles.tsx |
| `activation_shop_now` | Shop now merchants | apps/expo/app/activation/shop-now.tsx |
---
### 13. Redeem Section
**Route**: `apps/expo/app/redeem/`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `redeem_vouchers` | Voucher redemption options | apps/expo/app/redeem/vouchers.tsx |
| `redeem_partner` | Partner redemption pages | apps/expo/app/redeem/[partner]/index.tsx |
---
## Next.js Web App Placements
### 14. Home Page (Authenticated)
**Route**: `apps/nextjs/app/v2/page.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `home_hub_and_goal` | Hub and travel goal section | apps/nextjs/components/Home/HubAndGoal.tsx |
| `home_top_banner_carousel` | Top banner carousel (merchant promos) | apps/nextjs/components/Home/TopBannerCarousel.tsx |
| `home_gift_cards` | Gift cards section | apps/nextjs/components/Home/v2/GiftCards.tsx |
| `home_limited_time_deals` | Limited time deals | apps/nextjs/components/Home/v2/LimitedTimeDeals.tsx |
| `home_featured` | Featured merchants section | apps/nextjs/components/Home/v2/Featured.tsx |
| `home_dine_out` | Dine out section (restaurants) | apps/nextjs/components/Home/v2/DineOut.tsx |
| `home_credit_cards` | Credit cards section | apps/nextjs/components/Home/v2/CreditCards.tsx |
| `home_shop_all` | Shop all merchants | apps/nextjs/components/Home/v2/ShopAll.tsx |
**Hook**: `useHomeTopCarousel` - apps/nextjs/lib/hooks/useHomeTopCarousel.ts
---
### 15. Merchant Detail Page (Web)
**Route**: `apps/nextjs/app/v2/merchant/[slug]/page.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `web_merchant_detail_page_card` | Merchant page card | apps/nextjs/components/Merchant/v3/MerchantPageCard.tsx |
| `web_merchant_detail_info` | Merchant detail info | apps/nextjs/components/Merchant/v3/MerchantDetail/MerchantDetail.tsx |
| `web_merchant_earning_strategy` | Earning strategy | apps/nextjs/components/Merchant/v3/EarningStrategy/EarningStrategy.tsx |
| `web_merchant_card_rewards` | Card rewards comparison | apps/nextjs/components/Merchant/v3/CardReward/CardRewards.tsx |
| `web_merchant_recommendations` | Related merchant recommendations | apps/nextjs/components/Merchant/v3/merchantRecommendations.tsx |
| `web_merchant_footer` | Merchant footer | apps/nextjs/components/Merchant/v3/MerchantFooter.tsx |
| `web_merchant_tool_set` | Merchant tool set | apps/nextjs/components/Merchant/v3/MerchantToolSet/MerchantToolSet.tsx |
**Hook**: `useMerchantDetail` - apps/nextjs/lib/hooks/merchant/useMerchantDetail.ts
---
### 16. Search (Web)
**Route**: `apps/nextjs/app/v2/search/page.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `web_search_omni_search` | Omni search bar | apps/nextjs/components/Search/OmniSearch/OmniSearchBar.tsx |
| `web_search_recent_searches` | Recent searches section | apps/nextjs/components/Search/OmniSearch/RecentSearchSection.tsx |
| `web_search_listener` | Search listener | apps/nextjs/components/Search/v2/SearchListener.tsx |
**Store**: `apps/nextjs/stores/search.ts`
---
### 17. Miles Page (Web)
**Route**: `apps/nextjs/app/v2/miles/page.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `web_miles_transactions` | Mile transactions with merchant names | apps/nextjs/components/Profile/MaxMilesTransactionsContainer.tsx |
| `web_miles_manage` | Manage Max Miles | apps/nextjs/components/Profile/ManageMaxMilesContainer.tsx |
**Hook**: `useMileTransactions` - apps/nextjs/lib/hooks/v2/useMileTransactions.ts
---
### 18. Cards (Web)
**Route**: `apps/nextjs/app/v2/cards/`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `web_cards_your_cards` | Your cards page | apps/nextjs/app/v2/cards/your-cards/page.tsx |
| `web_cards_transaction_details` | Card transaction details | apps/nextjs/components/Cards/Manage/CardDetails/TransactionDetailsContainer.tsx |
| `web_cards_details` | Card details container | apps/nextjs/components/Cards/Manage/CardDetails/CardDetailsContainer.tsx |
| `web_cards_apply` | Card application page | apps/nextjs/app/v2/cards/apply/page.tsx |
| `web_cards_insights` | Card insights | apps/nextjs/components/Cards/Manage/CardInsights/YourCardsCardButton.tsx |
| `web_cards_reward_cycles` | Past reward cycles | apps/nextjs/components/Cards/Manage/CardDetails/RewardCycles/PastRewardCyclesContainer.tsx |
---
### 19. Dine Out / Restaurants (Web)
**Route**: `apps/nextjs/app/dine_out/page.tsx`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `web_dine_out_listing` | Restaurant listing | apps/nextjs/app/dine_out/listing.tsx |
| `web_dine_out_restaurant_grid` | Restaurant grid | apps/nextjs/app/dine_out/restaurant-grid.tsx |
| `web_dine_out_chope_carousel` | Chope restaurant carousel | apps/nextjs/components/Merchant/Chope/ChopeRestaurantCarousel.tsx |
| `web_dine_out_chope_item` | Chope restaurant item | apps/nextjs/components/Merchant/Chope/ChopeRestaurantItem.tsx |
---
### 20. Campaigns (Web)
**Route**: `apps/nextjs/app/v2/campaign/`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `web_campaign_chocolate_finance` | Chocolate Finance campaign | apps/nextjs/app/v2/campaign/chocolate-finance/page.tsx |
---
### 21. Marketing Pages (Web - Logged Out)
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `web_marketing_page` | Marketing page with merchant highlights | apps/nextjs/components/Marketing/v2/MarketingPage.tsx |
| `web_marketing_logged_out_redirect` | Logged out redirect | apps/nextjs/components/Marketing/v2/LoggedOutRedirect.tsx |
---
### 22. Resources & Articles (Web)
**Route**: `apps/nextjs/app/resources/articles/`
| Placement ID | Context | Implementation |
| --- | --- | --- |
| `web_articles_merchant_page` | Merchant-specific article pages | apps/nextjs/app/resources/articles/[page]/[merchant]/page.tsx |
---
## Cross-Platform Shared Placements
### 23. Notification-Triggered
| Placement ID | Context | Platform |
| --- | --- | --- |
| `push_notification_merchant` | Merchants shown via push notifications | Both |
| `in_app_notification_merchant` | In-app notification merchants | Expo |
| `missed_mile_bottom_sheet` | Missed mile notifications | apps/expo/components/earn/in-app-notification/MissedMileBottomSheet.tsx |

### 
