# Events

#### Omni Search Events
| Event name | Event attributes | Description |
| --- | --- | --- |
| `omni_search_item` | `source`, `query`, `useVisaApi`, `country`, `paymentTags`, `userCountry`, `merchant`, `type`, `isProductSearch`, `searchStatus` | Main search event triggered when user interacts with search items. Source values include: `key_enter`, `auto_complete_item`, `voucher_purchase`, `search_card_apply`, `product_search`, `recent_search`, `recommendation`, `popular_search`, `results_found` |
| `omni_search_search_mode` | (empty object) | Triggered when user clicks the search mode/settings button to open search settings modal |
| `omni_search_search_mode_change_confirm` | `search_mode`, `payment_tags` | Triggered when user confirms changes to search mode (Default/Visa) and payment tag filters in search settings |
| `omni_search_country_change_confirm` | `country` | Triggered when user confirms country selection change in search settings |
| `omni_search_filter_products_mode` | `product_min_price`, `product_max_price`, `product_min_rating`, `product_sort_by` | Triggered when user applies product search filters (price, rating, sort order)\n |

#### Event Attribute Details
**Common attributes across omni\_search events:**
- `source`: Where the search was initiated from (key_enter, auto_complete_item, recent_search, popular_search, recommendation, voucher_purchase, search_card_apply, product_search, results_found)
- `query`: The search query string entered by user
- `useVisaApi`: "true" or "false" - whether Visa API search mode is enabled
- `country`: Selected country code for search (e.g., "SG", "AU")
- `paymentTags`: Comma-separated payment method filters (e.g., "Online", "Contactless")
- `userCountry`: User's home country
- `merchant`: Merchant name (for merchant-specific searches)
- `type`: Search tab type (All, Merchants, Products, Cards, Vouchers)
- `isProductSearch`: Boolean indicating if this is a product search
- `searchStatus`: Current search status (idle, started, in_progress, finished)