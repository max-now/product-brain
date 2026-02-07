# Phase 1 Sop

## User Flows

### Standard Operating Procedure (Draft)

**Use Cases for ranking campaigns**:
- New merchant onboarding: General visibility boost for first 14 days (free tier - no specific rank guarantee, just improved placement within ranking algorithm)
- Merchant performance inquiry: "Why is my performance low?"
- Partner agreement: Contractual visibility commitment
- Seasonal promotions: Boost travel merchants during holiday season

**How to choose placements**:
| Use case | Recommended placements | Duration |
| --- | --- | --- |
| General visibility boost | earn home → popular + deals | 14 days |
| Deal-specific boost | earn home → deals + deals calendar | 7-14 days (aligned with deal expiry) |
| New merchant onboarding | earn home → popular | 14 days |
| Partner agreement | All placements (negotiated) | Contract duration |
**Duration guidelines**:
- **7 days**: Short-term test (new merchant, seasonal)
- **14 days**: Standard visibility boost (most common)
- **30 days**: Partner agreement (contractual)
- **90+ days**: Avoid (manual cleanup risk) — use Phase 3 incentives instead

**Conflict resolution**:
- If two campaigns overlap (same merchant, same placement, overlapping dates):
  - **Rule**: Latest start_date wins
  - **Example**: Campaign A (Jan 1-15), Campaign B (Jan 10-20) → Jan 1-9: A active, Jan 10-20: B active
- Dashboard will warn before creating conflicting campaigns
- Ops can override by confirming conflict modal

**Merchant communication template** (if BD sells visibility):
```
"We're boosting your visibility on [placements] from [start date] to [end date].
You'll appear higher in [section names] during this period.
We'll measure CTR/CVR impact and share results after the campaign ends."
```

## User Flows

### Flow 1: Ops Creates Campaign (Happy Path)

```
1. Ops receives merchant inquiry from BD: "Merchant A wants higher visibility"
2. Ops opens Campaign Management Dashboard
3. Clicks "Create Campaign"
4. Searches for Merchant A (dropdown autocomplete)
5. Selects placements:
   ☑ earn home → popular merchants
   ☑ earn home → limited time deals
6. Sets dates: Jan 20 - Feb 3 (14 days)
7. Reviews preview panel:
   - Current rank: earn home popular = 8, deals = 12
   - Projected rank: earn home popular = 2, deals = 3
   - No conflicts detected ✓
8. Clicks "Create Campaign"
9. Success message: "Campaign created. Merchant A will be boosted on 2 placements from Jan 20-Feb 3."
10. Campaign appears in "Scheduled" tab
11. Jan 20 arrives → Campaign auto-starts (status: Active)
12. Feb 3 arrives → Campaign auto-expires (status: Expired)
13. Ops confirms auto-expiry in dashboard
```

---

### Flow 2: Ops Creates Campaign (Conflict Resolution)

```
1. Ops opens "Create Campaign" form
2. Selects Merchant B
3. Selects placement: earn home → popular merchants
4. Sets dates: Jan 25 - Feb 8
5. Preview panel shows warning:
   ⚠️ "Merchant B already has campaign on earn home → popular from Jan 20 - Feb 5"
6. Conflict modal appears:
   "Overlapping campaign detected:
    - Existing: Jan 20 - Feb 5
    - New: Jan 25 - Feb 8

    Resolution: Latest campaign (Jan 25 start) will override from Jan 25 onward.
    Jan 20-24: Existing campaign active
    Jan 25-Feb 8: New campaign active

    [Cancel] [Override and Create]"
7. Ops clicks "Override and Create"
8. Campaign created with warning badge in dashboard
9. Jan 25 arrives → New campaign takes over (existing campaign still shows in history)
```

---

### Flow 3: BD Responds to Merchant Inquiry

```
1. Merchant emails BD: "Why is my CTR low? How can I improve?"
2. BD opens internal playbook (Phase 1 SOP)
3. BD checks merchant's current ranking:
   - Opens Merchant Ranking Visibility Dashboard
   - Searches for merchant
   - Sees: earn home popular = rank 15, deals = rank 20
4. BD assesses placement recommendation:
   - Merchant is in "travel" category
   - Recommendations: earn home popular + deals (14-day boost)
5. BD drafts response to merchant:
   "We'll boost your visibility on Earn Home and Deals for 14 days.
    You'll rank higher during this period. We'll measure CTR/CVR impact and share results."
6. BD forwards request to Ops with details:
   - Merchant: [Name]
   - Placements: earn home popular, earn home deals
   - Duration: Jan 20 - Feb 3
   - Reason: Performance improvement campaign
7. Ops creates campaign (Flow 1)
8. After campaign ends, Product shares CTR/CVR results with BD
9. BD follows up with merchant: "Your CTR increased 12% during the boost. Here's the data."
```

---

### Flow 4: Product Reviews Placement Performance

```
1. Product opens Statsig experiment: "Phase 1 Placement Ranking"
2. Reviews CTR/CVR by placement (treatment vs control):
   - earn home → popular: CTR +8%, CVR +3%
   - earn home → deals: CTR +15%, CVR +5%
   - deals calendar: CTR +5%, CVR +1%
3. Insight: "Deals placement drives highest conversion uplift"
4. Product documents findings for Phase 2:
   - Prioritize "earn home → deals" for personalisation (Phase 2A)
   - "Deals calendar" may benefit from intent-based ranking (Phase 2B)
5. Product shares learnings in weekly sync with Ops/BD
6. Ops adjusts SOP: "For deal-heavy merchants, prioritize deals placements"
```
