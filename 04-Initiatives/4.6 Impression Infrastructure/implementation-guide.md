# Impression Tracking: Implementation Reference

Quick reference for engineers implementing impression tracking across placements. Organized by priority tier.

---

## Tier 1: Critical Path Placements

### 1. Explore Intent Category Tabs (16 placements)

**Component:** `apps/expo/components/explore/intent-category/merchant-grid.tsx`
**Route:** `apps/expo/app/explore/(tabs)/*.tsx`

| Placement ID | Intent Category | Hook | Endpoint |
| --- | --- | --- | --- |
| `explore_deals` | deals | `usePromotionalMerchants` | `/api/merchants/promotional` |
| `explore_shop` | shop | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_food` | food | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_groceries` | groceries | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_dine` | dine | `useRestaurantSearch` | `/api/restaurants/search` |
| `explore_travel` | travel | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_flights` | flights | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_hotels` | hotels | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_ride` | ride | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_shop_offline` | shop_offline | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_apply_card` | apply_card | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_fx_n_biz` | fx_n_biz | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_insurance` | insurance | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_invest` | invest | `useIntentCategoryMerchants` | `/api/merchants/by-category` |
| `explore_vouchers` | vouchers | Custom voucher grid | `/api/vouchers/list` |
| `explore_card` | card | Card recommendation logic | `/api/cards/recommendations` |

**Related Files:**
- Layout: `apps/expo/app/explore/(tabs)/_layout.tsx`
- Grid component: `apps/expo/components/explore/intent-category/merchant-grid.tsx`
- Hooks location: `apps/expo/hooks/useIntentCategoryMerchants.ts`

---

### 2. Search Results

**Component:** `apps/expo/components/search/merchants/autocomplete.tsx`
**Route:** `apps/expo/app/search/index.tsx`
| Placement ID | Context | Hook | Endpoint |
| --- | --- | --- | --- |
| `search_merchants` | Merchant search results | `searchMerchant` (store) | `/api/search/merchants` |
| `search_all_autocomplete` | Global search | `searchMerchant` | `/api/search/all` |
| `search_product_shopee` | Shopee product search | `useProductLinkSearch` | `/api/search/shopee` |
| `search_product_taobao` | Taobao product search | `useProductLinkSearch` | `/api/search/taobao` |
| `search_product_generic` | Generic product search | `useProductLinkSearch` | `/api/search/products` |

**Store:** `apps/expo/store/search.ts`
**Hooks:** `apps/expo/hooks/useProductSearch.ts`

---

### 3. Merchant Detail Page

**Component:** `apps/expo/app/merchant/[slug]/index.tsx`
| Placement ID | Section | Component | Endpoint |
| --- | --- | --- | --- |
| `merchant_detail_header` | Header with logo | `apps/expo/components/merchant/header.tsx` | `/api/merchant/[slug]/detail` |
| `merchant_detail_info` | Merchant info card | `apps/expo/components/merchant/merchant-info.tsx` | `/api/merchant/[slug]/detail` |
| `merchant_detail_earning_strategy` | Earning strategy | `apps/expo/components/merchant/earning-strategy/merchant-strategy.tsx` | `/api/merchant/[slug]/earning-strategy` |
| `merchant_detail_card_reward` | Best card recommendations | `apps/expo/components/merchant/card-reward/best-card.tsx` | `/api/merchant/[slug]/card-rewards` |
| `merchant_detail_footer` | Footer with action buttons | `apps/expo/components/merchant/footer.tsx` | N/A |
---

**Related Pages:**
- Card rewards: `apps/expo/app/merchant/[slug]/card-reward.tsx`
- Product search: `apps/expo/app/merchant/[slug]/product-search-result-card.tsx`
- Promo codes: `apps/expo/app/merchant/[slug]/promo-codes.tsx`

### 4. Home Top Banner Carousel

**Component:** `apps/nextjs/components/Home/TopBannerCarousel.tsx`
**Route:** `apps/nextjs/app/v2/page.tsx`
| Placement ID | Context | Hook | Endpoint |
| --- | --- | --- | --- |
| `home_top_banner_carousel` | Top banner carousel | `useHomeTopCarousel` | `/api/home/carousel` |
**Hook:** `apps/nextjs/lib/hooks/useHomeTopCarousel.ts`

---

### 5. Deals Calendar

**Component:** `apps/expo/app/deals-calendar/index.tsx`

| Placement ID | Tab | Component | Hook | Endpoint |
| --- | --- | --- | --- | --- |
| `deals_calendar_current` | Current deals | `CurrentDeals.tsx` | `useUpcomingDeals` | `/api/deals/current` |
| `deals_calendar_upcoming` | Upcoming deals | `UpcomingDeals.tsx` | `useUpcomingDeals` | `/api/deals/upcoming` |

**Components:**
- `apps/expo/components/deals-calendar/CurrentDeals.tsx`
- `apps/expo/components/deals-calendar/UpcomingDeals.tsx`
- `apps/expo/components/deals-calendar/UpcomingDealItem.tsx`

---

## Tier 2: Phase 2 Enablers

### 6. Transaction History

**Component:** `apps/expo/components/transactions/miles/item.tsx`
**Route:** `apps/expo/app/(tabs)/miles.tsx`
| Placement ID | Context | Hook | Endpoint |
| --- | --- | --- | --- |
| `miles_transaction_list` | Mile transaction history | `useMileTransaction` | `/api/transactions/miles` |
| `miles_click_history` | Shop Max click history | `useMilesClicks` | `/api/transactions/clicks` |

**Hooks:**
- `apps/expo/hooks/mile_transaction/useMileTransaction.ts`
- `apps/expo/hooks/mile_transaction/useMerchantClick.ts`

---

### 7. Bookmarks

**Component:** `apps/expo/app/bookmark/merchants.tsx`

| Placement ID | Context | Endpoint |
| --- | --- | --- |
| `bookmark_merchant_grid` | Saved merchants grid | `GET /api/bookmark/merchants` |

---

### 8. Earn Tab Browse All

**Component:** `apps/expo/components/earn/browse-all/index.tsx`
**Route:** `apps/expo/app/(tabs)/earn.tsx`
| Placement ID | Context | Hook | Endpoint |
| --- | --- | --- | --- |
| `earn_browse_all` | Main merchant discovery | `useBrowseAllMerchants` | `/api/merchants/browse-all` |

**Related Placements (same page):**
- `earn_search_bar` - Search bar component: `apps/expo/components/earn/search.tsx`
- `earn_hub` - Hub section: `apps/expo/components/earn/hub`
- `earn_banner` - Banner carousel: `apps/expo/components/earn/banner.tsx`

---

## Tier 3: Conversion Depth

### 9. Vouchers & Gift Cards

**Route:** `apps/expo/app/voucher/my-vouchers.tsx`

| Placement ID | Context | Component | Hook | Endpoint |
| --- | --- | --- | --- | --- |
| `my_vouchers_available` | Available vouchers tab | `MyVoucherOrderItem.tsx` | `useMyVouchers` | `/api/vouchers/my-vouchers` |
| `my_vouchers_redeemed` | Redeemed vouchers tab | `MyVoucherOrderItem.tsx` | `useMyVouchers` | `/api/vouchers/my-vouchers` |
| `voucher_purchase_recommendations` | Voucher recommendations | `VoucherRecommendedCard.tsx` | N/A | `/api/vouchers/recommendations` |

**Hook:** `apps/expo/hooks/voucher/useMyVouchers.ts`

---

### 10. Card Rewards

**Route:** `apps/expo/app/cards/`

| Placement ID | Context | Route | Hook | Endpoint |
| --- | --- | --- | --- | --- |
| `cards_your_cards` | Your linked cards | `cards/your-cards/index.tsx` | `useLinkedCards` | `/api/cards/linked` |
| `cards_transaction_detail` | Card transaction detail | `cards/your-cards/transaction/[transactionId].tsx` | `useGetSpendTransaction` | `/api/cards/transactions/[id]` |
| `cards_reward_cycles` | Reward cycles list | `cards/your-cards/[cardId]/reward-cycles/index.tsx` | `useRewardCycles` | `/api/cards/[id]/reward-cycles` |

**Hooks:**
- `apps/expo/hooks/useSpendTracking.ts:34` - `useLinkedCardTransactions`
- `apps/expo/hooks/useSpendTracking.ts:185` - `useGetSpendTransaction`
- `apps/expo/hooks/useSpendTracking.ts:67` - `useSpendTrackingSummary`

---

### 11. Product Browsing (Affiliate)

**Route:** `apps/expo/app/merchant/products.tsx`

| Placement ID | Context | Endpoint |
| --- | --- | --- |
| `merchant_products_best_deals` | Best deals from merchant | `GET /api/merchant/best_deals` |
| `merchant_products_hot_items` | Hot items from merchant | `GET /api/merchant/hot_items` |
| `merchant_products_search` | Product search results | `GET /api/merchant/search_items` |

**Implementation:** `apps/expo/lib/products.ts:61`
**Store:** `apps/expo/store/search.ts:261`

---

### 12. Campaign Pages

#### JRE Campaign

**Route:** `apps/expo/app/campaign/jre.tsx`

| Placement ID | Section | Component | Endpoint |
| --- | --- | --- | --- |
| `campaign_jre_singapore` | Japan in SG tab | `JRECampaignSGContent.tsx` | `/api/campaign/jre/detail` |
| `campaign_jre_travel` | Travel to Japan tab | `JRECampaignTravelContent.tsx` | `/api/campaign/jre/detail` |
| `campaign_jre_jr_east_pass` | JR East Pass merchants | `jre-merchants/jr-east-pass.tsx` | `/api/campaign/jre/merchants` |
| `campaign_jre_jr_tokyo_wide_pass` | JR Tokyo Wide Pass | `jre-merchants/jr-tokyo-wide-pass.tsx` | `/api/campaign/jre/merchants` |
| `campaign_jre_suica_mobile` | Suica Mobile merchants | `jre-merchants/suica-mobile.tsx` | `/api/campaign/jre/merchants` |

**Components:**
- `apps/expo/components/jre/JRECampaignSGContent.tsx`
- `apps/expo/components/jre/JRECampaignTravelContent.tsx`
- `apps/expo/components/jre/JRECampaignMerchantList.tsx`

---

#### Yuu Campaign

**Route:** `apps/expo/app/campaign/yuu.tsx`

| Placement ID | Context | Hook | Endpoint |
| --- | --- | --- | --- |
| `campaign_yuu` | Yuu campaign merchants | `useYuuCampaign` | `/api/campaign/yuu_merchants_may25/detail` |

**Hook:** `apps/expo/hooks/useYuuCampaign.ts`
**Campaign Name:** `YUU_CAMPAIGN_NAME = "yuu_merchants_may25"`

---

#### Atome Campaign

**Route:** `apps/expo/app/campaign/atome.tsx`

| Placement ID | Endpoint |
| --- | --- |
| `campaign_atome` | `/api/campaign/atome/detail` |

---

#### TakeMe Japan Campaign

**Route:** `apps/expo/app/campaign/takeme-japan/index.tsx`

| Placement ID | Component | Config | Endpoint |
| --- | --- | --- | --- |
| `campaign_takeme_japan` | TakeMe Japan page | Statsig: `takeme-japan-info` | `/api/campaign/takeme_japan/detail` |

**Component:** `apps/expo/components/takeme-japan/TakeMeBestCard.tsx`

---

## Tier 4: Deferred (Low Priority)

### 13. Activation Flow

**Route:** `apps/expo/app/activation/`

| Placement ID | Route | Context |
| --- | --- | --- |
| `activation_earn_first_miles` | `activation/earn-first-miles.tsx` | New users only |
| `activation_shop_now` | `activation/shop-now.tsx` | New users only |

---

### 14. Web-Specific Placements

#### Home Page (Web)

**Route:** `apps/nextjs/app/v2/page.tsx`

| Placement ID | Component | Endpoint |
| --- | --- | --- |
| `home_hub_and_goal` | `Home/HubAndGoal.tsx` | `/api/home/hub` |
| `home_gift_cards` | `Home/v2/GiftCards.tsx` | `/api/home/gift-cards` |
| `home_limited_time_deals` | `Home/v2/LimitedTimeDeals.tsx` | `/api/home/deals` |
| `home_featured` | `Home/v2/Featured.tsx` | `/api/home/featured` |
| `home_dine_out` | `Home/v2/DineOut.tsx` | `/api/home/dine-out` |
| `home_shop_all` | `Home/v2/ShopAll.tsx` | `/api/home/shop-all` |

---

#### Merchant Detail (Web)

**Route:** `apps/nextjs/app/v2/merchant/[slug]/page.tsx`

| Placement ID | Component | Hook |
| --- | --- | --- |
| `web_merchant_detail_page_card` | `Merchant/v3/MerchantPageCard.tsx` | `useMerchantDetail` |
| `web_merchant_earning_strategy` | `Merchant/v3/EarningStrategy/EarningStrategy.tsx` | `useMerchantDetail` |
| `web_merchant_recommendations` | `Merchant/v3/merchantRecommendations.tsx` | `useMerchantDetail` |

**Hook:** `apps/nextjs/lib/hooks/merchant/useMerchantDetail.ts`

---

#### Search (Web)

**Route:** `apps/nextjs/app/v2/search/page.tsx`

| Placement ID | Component | Store |
| --- | --- | --- |
| `web_search_omni_search` | `Search/OmniSearch/OmniSearchBar.tsx` | `stores/search.ts` |
| `web_search_recent_searches` | `Search/OmniSearch/RecentSearchSection.tsx` | `stores/search.ts` |

---

#### Dine Out (Web)

**Route:** `apps/nextjs/app/dine_out/page.tsx`

| Placement ID | Component | Endpoint |
| --- | --- | --- |
| `web_dine_out_listing` | `dine_out/listing.tsx` | `/api/restaurants/list` |
| `web_dine_out_chope_carousel` | `Merchant/Chope/ChopeRestaurantCarousel.tsx` | `/api/chope/restaurants` |

---

## Backend Endpoints

### Core Impression Tracking
| Endpoint | Method | Purpose |
| --- | --- | --- |
| `/api/impressions/batch` | POST | Batch impression ingestion |
| `/api/impressions/stats` | GET | Impression statistics |
| `/api/impressions/placement/{id}` | GET | Placement-specific metrics |

### Campaign Management
| Endpoint | Method | Purpose |
| --- | --- | --- |
| `/api/campaign/{campaignName}/detail` | GET | Campaign configuration |
| `/api/campaign/{campaignName}/enrol` | POST | User enrollment |
| `/api/campaign/{campaignName}/merchants` | GET | Campaign merchant list |

---

## Data Schema Reference

```typescript
interface MerchantImpression {
  // Core identification
  placement_id: string;           // e.g., "explore_shop"
  merchant_id: string;
  merchant_slug: string;

  // Phase 1: Position tracking
  position_in_list: number;       // 0-indexed
  total_items_in_list: number;

  // Phase 2: Intent signals
  intent_category?: string;       // For explore tabs
  entry_point?: string;           // "search" | "browse" | "deals" | "direct"

  // Phase 2: Personalisation context
  user_id?: string;
  session_id: string;

  // Tier 3: Campaign context
  campaign_id?: string;
  campaign_slug?: string;

  // Metadata
  timestamp: string;
  platform: "expo" | "nextjs";
}
```

---

## Quick Start Checklist

### For Each Placement:

1. ✅ Identify the component file from the table above
2. ✅ Locate the data hook/endpoint
3. ✅ Add impression tracking with correct `placement_id`
4. ✅ Include `intent_category` if it's an explore tab
5. ✅ Include `campaign_id` if it's a campaign page
6. ✅ Test locally with `/api/impressions/batch` endpoint
7. ✅ Verify data appears in warehouse with correct schema

### Priority Order:

**Week 1-2:** Tier 1 (explore tabs, earn_browse_all, search, merchant detail)
**Week 3-4:** Tier 2 (transactions, bookmarks, home carousel, deals calendar)
**Week 5+:** Tier 3 & 4 (vouchers, campaigns, activation flow)
