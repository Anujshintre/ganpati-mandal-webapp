# Ganpati Mandal Manager (Multi-Tenant)

A working Java + JDBC + Servlet + JSP + MySQL app, structured like
smartmandal.in's flow: one Super Admin, multiple mandals ("clients") each
identified by `client_id`, a per-mandal dashboard with day-wise vargani
(donation) tracking, and a public donation page that generates a UPI QR
and a PDF receipt once payment is confirmed.

## 1. What's included and working end-to-end

- **Super Admin login** — hardcoded credentials as you asked:
  - Username: `Admin@123`
  - Password: `Admin@123#512`
  (set in `com/mandal/util/AppConstants.java` — change there if needed)
- **Super Admin dashboard** — lists every registered mandal; clicking
  "Open Dashboard" on client #1 shows client #1's data, #2 shows #2's data,
  etc. (session-based client switch, exactly like the "config" behaviour
  you described).
- **Register New Mandal** form — mandal name, symbol/logo upload, founding
  date, taluka, district, leader, mandal account number, an admin
  username/password for that mandal, and the 5 names for the receipt:
  Adhyaksh, Upadhyaksh, Khajindar + 2 other members (with optional contact
  numbers). Saves into `clients` + `office_bearers`, both keyed by the new
  `client_id`.
- **Mandal (client) dashboard** — shows mandal info, Ganpati photo, office
  bearers, today's total collection, running total, a form to add a
  day-wise vargani entry, and the full day-wise collection table. Every
  query is scoped by `client_id` from the session.
- **Public invoice/donation page** (`/invoice`) — shows the mandal name and
  symbol pulled from the database (currently always the first registered
  mandal, client #1, as you asked for this first stage). Donor enters
  name + WhatsApp number, picks an amount from a dropdown, and gets a
  UPI QR code generated live (via ZXing) from the mandal's account number.
- **Payment confirmation → PDF receipt** — once confirmed, a PDF is
  generated (via iText) containing the mandal name, symbol, the Adhyaksh /
  Upadhyaksh / Khajindar names, donor name, amount, and the exact payment
  timestamp. The receipt is saved under `/receipts` and downloadable.
- Fully responsive (Bootstrap 5, mobile-first) — built and tested visually
  for phone-width screens first.

## 2. What is intentionally stubbed (needs your business accounts)

These two require real third-party credentials that can't be fabricated —
they're isolated behind clear extension points so you can drop the real
integration in without touching the rest of the app:

- **Actual payment settlement.** The QR currently encodes a UPI
  *payment-intent* string built from the mandal's account number (this is
  the same mechanism most static UPI QR codes use) — a real
  gateway/aggregator (Razorpay, Cashfree, PayU, an NPCI-approved UPI PSP,
  etc.) is what gives you server-verified "payment succeeded" webhooks
  instead of a manual "I've Paid" button. `ConfirmPaymentServlet` is
  exactly where you'd plug that webhook handler in — right now it's wired
  to a manual confirm button so you can test the whole flow today.
- **Sending the PDF over WhatsApp.** WhatsApp does not let a plain number
  send documents programmatically — you need a WhatsApp Business API
  account (Meta Cloud API, or a BSP like Twilio/Gupshup) with an approved
  message template. `com/mandal/util/WhatsAppSender.java` is a one-method
  stub with the exact API shape you'd fill in — right now it just logs
  what it would have sent.

## 3. Setup

### Requirements
- JDK 17+
- Apache Tomcat 10.1+ (needs `jakarta.*` namespace, not `javax.*`)
- MySQL 8+
- These jars in `src/main/webapp/WEB-INF/lib/`:
  - `mysql-connector-j-8.x.x.jar`
  - `core-3.5.x.jar` and `javase-3.5.x.jar` (ZXing, for QR generation)
  - `kernel-8.x.x.jar`, `layout-8.x.x.jar`, `io-8.x.x.jar`, `font-asian-8.x.x.jar` (iText 7, for PDF)
  - `jakarta.servlet-api` is provided by Tomcat, don't bundle it.

### Steps
1. **Database**: run `database/schema.sql` in MySQL. It creates the DB,
   all tables, and seeds one demo mandal as client #1 so the invoice page
   has real data immediately.
2. **DB credentials**: edit `src/main/java/com/mandal/util/DBConnection.java`
   — set your MySQL username/password.
3. **Build**: this is a plain Servlet/JSP project (no Maven config
   included) — compile the `com.mandal.*` classes into `WEB-INF/classes`
   (keeping the package folder structure) and drop the jars above into
   `WEB-INF/lib`. If you'd rather use Maven, tell me and I'll generate a
   `pom.xml` + standard Maven layout for it.
4. **Deploy**: copy the whole `src/main/webapp` folder as an app under
   Tomcat's `webapps/` (e.g. `webapps/mandal/`), with your compiled
   classes inside `WEB-INF/classes`.
5. **Run**: start Tomcat, open `http://localhost:8080/mandal/` → redirects
   to login.
6. Log in as Super Admin → Register a mandal (or use the seeded demo one)
   → Open its dashboard → also visit `http://localhost:8080/mandal/invoice`
   to see the public donation page for that first mandal.

## 4. Next steps (as you described — done in later stages)

- Route `/invoice` per-client (`/invoice?clientId=2`, `/invoice?clientId=3`
  ...) instead of always showing the first mandal — the code already
  supports a `clientId` query param, it just isn't linked from anywhere
  yet since you said we'd wire that up after this stage.
- Swap the manual "I've Paid" button for a real gateway webhook.
- Swap `WhatsAppSender`'s stub for a live WhatsApp Business API call.
- Add a separate "mandal admin" login (using the `admin_username`/
  `admin_password` columns already stored per client) so each mandal can
  log in directly without going through the super admin — currently only
  the super admin can open a mandal's dashboard.
