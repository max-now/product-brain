# Search Improvements

**Project:** https://linear.app/heymax/project/merchant-search-improvements-8f0dd9cc3272

---

## Problem / Objective

Users are experiencing friction when searching for merchants in the app. Key issues include:
- Search results don't surface relevant matches (e.g., searching "UOB" doesn't show UOB cards)
- Keyboard blocks scroll, preventing users from viewing full results
- Search performance is slow and inconsistent

**Objective**: Fix critical search bugs and improve search accuracy, performance, and user experience to help users get their jobs done faster.

---

## What success looks like
| Metric | Target |
| --- | --- |
| Search-to-merchant find rate | Increase by X% |
| Search abandonment rate | Decrease by X% |
| Search accuracy rate | Increase by X% |
---

## Supporting signals
- User feedback on search not returning expected results
- User feedback on not being able to find merchants - due to visa search no
- Bug reports on keyboard blocking scroll behaviour

---

## Product requirements

### P0 - Critical bugs
| # | User story | Acceptance criteria |
| --- | --- | --- |
| 1 | As a user, while searching, I want to scroll search results while the keyboard is open | Keyboard should not block scrollable content; user can scroll full results list<br><br>Keyboard disappears when user scroll |
| 2 | As a user, while searching, I want card search to return relevant results | Searching "UOB" should return UOB cards; results should match search intent |

### P1 - Core improvements
| # | User story | Acceptance criteria |
| --- | --- | --- |
| 3 | As a user, I want to find my merchants in search results without having to toggle Visa Search | Call Visa API to get visa  results and display them together when there is only 1 HeyMax merchant left |
| 4 | As a user, I want search suggestions to match typing patterns | Suggestions only show matches where search text matches start of the word (e.g., "gi" should not show "iShopChangi") |
| 5 | As a user, I want search suggestions to match what appears in the searching screen | Search results replicate the suggestions shown in searching screen |
| 6 | As a user, I want search results to feel smooth, executed without significant delay | 1. search query executed within 0.5s of user stop typing 2. search results returned within 1s |

### P2 - Enhancements
| # | User story | Acceptance criteria |
| --- | --- | --- |
| 7 | As a user, I want visual distinction between typed and suggested text | Typed letters show in default-000 color; suggested text shows in light grey\n\n[Figma](https://www.figma.com/design/kSCAqiLzY1p2B6IwE46Q4B/-HeyMax--Search?node-id=211-3341&t=iy8owN6MQUmIHjkH-1) |
| 8 | As a user, I don't need "see all" for vouchers in searching screen | Remove "See all" button from vouchers section in searching screen |
| 11 | As a user, I want to search for MCCs and be able to know the best card to use for said MCC | Create a MCC page type; Show best card to use feature inside the page\n\n[Figma](https://www.figma.com/design/kSCAqiLzY1p2B6IwE46Q4B/-HeyMax--Search?node-id=184-1924&t=iy8owN6MQUmIHjkH-1) |

### P3 - Future consideration
| # | User story | Acceptance criteria |
| --- | --- | --- |
| 12 | As a user, I want product recommendations as text in the searching screen | Searching screen includes text-based product recommendations |
| --- | --- | --- |

---


## Events tracking
| Event name | Event attributes | Description |
| --- | --- | --- |
| search_performed | query, results_count, heymax_results_count | User performs a search |
| search_result_clicked | query, merchant_id, position, is_heymax | User taps on a search result |

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Prioritising HeyMax may hide relevant Visa merchants | M | We are already doing it in today's search. Call Visa API to show results after there are only 1 HeyMax merchant. |

---

## Launch checklist

- [ ] Tracking events implemented
- [ ] QA validation on keyboard scroll fix
- [ ] QA validation on search result accuracy
- [ ] Performance testing (< 0.5s query execution, < 1s results)

---

*Generated from PRD: 4.5 Merchant Search Improvements/prd.md*
*Published: 2026-01-23*