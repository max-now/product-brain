# Trip.com Direct Integration

**Status**: In Progress
**Priority**: Medium
**Owner**: cheehong@heymax.ai
**Start Date**: February 2, 2026
**Last Updated**: January 21, 2026

---

# Problem / Objective

Currently, HeyMax is integrated with Partnerize which

1. reduces our commission due to network fees
2. extra useful data not being sent to us and
3. miles take longer to confirm due to network processing

HeyMax is exploring a direct integration with Trip.com's Server-to-Server (S2S) API to allow us to

1. can retrieve real time data vs the current dashboard of D+1 day data.
2. expand our ways of working with the Trip.com
  1. better experience for new users
  2. push better deals to users
3. provide users with instant booking confirmation
4. provide users with clearer miles confirmation timelines

---

# Trip.com Integration - Technical Requirements

```
to book a test order to check on the data postback

Here is the link structure:
https://www.trip.com/index?locale=en_us&allianceid=XXXXX&SID=XXXXX&utm_campaign=xxxxx&trip_sub1=xxx

&utm_campaign = Campaign ID
&trip_sub1 = Click ID or other value the partner would like to receive with booking data from Trip.com

Alliance ID:6925465
SG SID: 248231894
HK SID: 261393840

See booking IDs:
1688893066502971
1578941904074572
1653708696387982 (cancelled order)
1688892723066646
```

```
FTP server details for HeyMax

username: ctrip56407752
password: mki{sfI{7^y2
address: filexftp.infosec.ctripcorp.com
port: 2222

whitelisted IP addresses
- 34.124.147.158
- 34.87.10.206
- 34.96.243.178
- 34.124.239.69
```

## Key API Parameters Elaboration

- `orderStatusID` - Order status (see values above)
- `orderAmount` - Order total
- `currency` - Transaction currency
- `endDateTime` - Completion timestamp (varies by product, see below)
- `cityName` - City name (Hotel has separate parameter from Flight; not available for Car Rental)

## `(orderStatusID)`by Product Type

| Product Type | Status Values |
| --- | --- |
| **Hotel** | `HOTEL_CONFIRMED`, `HOTEL_CANCELLED`, `HOTEL_COMPLETED` |
| **Flight** | `FLIGHT_TICKETED`, `FLIGHT_TICKETED_PART`, `FLIGHT_CANCELLED`, `FLIGHT_CANCEL_PART`, `FLIGHT_PAYED_TICKETING` |
| **Bundle** | `BUNDLE_CONFIRMED`, `BUNDLE_CANCELLED` |
| **Trains (CN Domestic)** | `TRANS_COMPLETED`, `TRANS_CANCELLED` |
| **International Trains** | `RAILSINTL_COMPLETED`, `RAILSINTL_CANCELED`, `RAILSINTL_CARD_ISSUED` |
| **Activity** | `ACTIVITY_PAYED`, `ACTIVITY_CANCELLED` |
| **Piao (Tickets)** | `PIAO_COMPLETED`, `PIAO_CANCELLED` |
| **Car Rental** | `CAR_CONFIRMED`, `CAR_CANCELLED`, `CAR_COMPLETED` |

## `(endDateTime)`by Product Type

| Product Type | `endDateTime` Represents |
| --- | --- |
| **Activity (Tours)** | Latest use time |
| **Piao (Ticket)** | Latest use time |
| **Flight** | Landing (arrival) time |
| **Hotel** | Checkout time |
| **Trains** | Arrival time |
| **Car Rental** | Return time |
| **Bundle** | Later of: Flight arrival time OR Hotel checkout time |

**Important:** For flights, order status will not change after `endDateTime`.

## Commission Confirmation Timeline by Product Type

### Miles Confirmation Logic

1. **Pending Miles**
  1. postback from tripcom does not contain amount, we need to calculate an estimate based on the MPD rate for product category and spend amount
      - reference product category
      - pull from affiliate record based on transaction date
      - calculate miles amount & set confirmation date according to product category
2. **Confirmed Miles**
  1. Finalise based on FTP commission report

### General Confirmation Rule

- **Confirm miles:** `endDateTime` + 30 days (except Pay at Hotel orders)

### Confirmation Rules by Product Type

| Product Type | Base Confirmation Trigger | Additional Wait Period | Total Timeline |
| --- | --- | --- | --- |
| **Flight** | Ticketed order | +30 days after flight departure | 30 days post-departure |
| **Hotel (Prepaid)** | Checkout date (`endDateTime`) | +30 days | 30 days post-checkout |
| **Hotel (Pay at Hotel)** | Special handling required | +180 days | See FTP report timing |
| **Tours & Tickets** | Ticketed order | +30 days after use date | 30 days post-use |
| **CN Train** | Departure date | +30 days | 30 days post-departure |
| **International Train** | Departure date | +30 days | 30 days post-departure |
| **Bundle** | Both hotel checkout AND flight arrival complete | +30 days | 30 days post-completion |
| **Car Rental** | Rental period complete (`endDateTime`) | +30 days | 30 days post-return |

## Data Sources & Validation

### S2S API (Real-time)

- Provides real-time order details
- **Cannot be used for final commission settlement**
- Use for calculating **pending miles estimates**

### FTP Commission Report (Monthly)

- Sent after 6th of each month for previous month's data
- Contains all commissions confirmed in the previous month
- **Use for final miles confirmation**
- No negative adjustments reflected in data

### Order Status Completion

For Hotel, Rails, and Car Rental: Must wait for `COMPLETED` status after `endDateTime` is passed.

## Refunds & Clawbacks

### Risk Profile

- Refunds after booking completion are rare (very low %)
- Possible for bookings to be cancelled/refunded even after end date
- Trip.com standard validation: 180 days (primarily for Pay at Hotel orders)

### Clawback Handling

**Critical:** System must be able to:

1. Read FTP commission reports
2. Identify clawbacks (shown as deductions in following month's report)
3. Deduct miles from user accounts

**T&Cs:** Must state we reserve the right to clawback miles for refunded orders

### Flight-Specific Refund Notes

- Most flight tickets are non-refundable after ticketing
- Small number may still be cancelled/refunded by user
- Cannot identify which flights are refundable vs non-refundable via API
- Clawbacks appear as deductions in next month's commission report

## UX Improvements

- Merchant Miles Confirmation Timeline
  - set to 30 days after trip completion with asterisk* pointing towards t&c
- Pay at Hotel Orders
  - Call out that "Pay at Hotel" bookings take longer to confirm (up to 180 days).
  - Position this as transparency that makes Trip.com more attractive.
- Standard Messaging
  - Indicate 180-day standard after completion in T&Cs to set clear customer expectations and provide reference when needed.

## Implementation Checklist

### Setup Tasks

- [ ] Confirm FTP connection and API response format
- [ ] Setup roll out phasing
  - [ ] Replace affiliate link on HeyMax with Trip.com link
  - [ ] Implement pending miles calculation from S2S data
  - [ ] Implement confirmed miles calculation from FTP reports
- [ ] Build clawback detection and processing
- [ ] Add booking date and order ID to transaction descriptions
- [ ] Update T&Cs with 180-day validation period and clawback rights

### Rollout Plan

1. **Phase 1:** 10% of users
2. **Phase 2:** Monitor until first batch gets miles confirmed
3. **Phase 3:** Increase to 50%
4. **Phase 4:** Scale to 100%

## Open Questions

- [ ] What is the specific dependency for Pay at Hotel orders to receive commission?
- [ ] How to handle negative adjustments if they're not reflected in FTP data?
