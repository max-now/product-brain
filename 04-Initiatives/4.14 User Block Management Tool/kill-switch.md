# Kill Switch

### **Redemptions**
| Kill Switch | Phase | Purpose |
| --- | --- | --- |
| Block specific users from redeeming flyanywhere & point transfers / vouchers | ✅ | Prevent fraudulent or exploitative redemptions |
| Pause all redemptions systemwide | ✅ | Contain partner-side or system bugs |
---
### **Authentication**
| Kill Switch | Phase | Purpose |
| --- | --- | --- |
| Block specific users from logging in (across all auth methods) | 🟢 Phase 1 | Immediately stop compromised or fraudulent accounts |
| Temporarily disable new sign-ups | 🟢 Phase 1 | Prevent mass fake account creation during abuse or incidents |
---
### **Phone Numbers**
| Kill Switch | Phase | Purpose |
| --- | --- | --- |
| Block specific phone numbers from being used to verify | 🟢 Phase 1 | Stop repeated abuse from the same number |
| Temporarily disable new phone number verifications | 🟢 Phase 1 | Contain systemwide OTP or SMS abuse |
---
### **Card**
| Kill Switch | Phase | Purpose |
| --- | --- | --- |
| Block specific card numbers from being added or used | 🟢 Phase 1 | Stop known fraudulent or stolen cards |
| Block specific issuing banks / BIN ranges | 🟢 Phase 1 | Contain risky prepaid or blacklisted issuers |
---
### **Transactions**
| Kill Switch | Phase | Purpose | FE additions |
| --- | --- | --- | --- |
| Block specific users from creating or receiving transactions | 🟢 Phase 1 | Freeze suspicious users’ financial activity | User to see a banner at the top of app for them to know that their account has been blocked and to reach out to support. |
| Cancel all pending transactions for a flagged user | 🟢 Phase 1 | Reverse ongoing fraudulent flows |  |
