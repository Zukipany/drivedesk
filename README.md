# DriveDesk

**A fleet platform for small German companies with 5 to 50 cars. One SwiftUI app is the driver app
on iPhone and iPad and the manager desk on Mac and iPad, on one shared backend.**

> [!NOTE]
> **The source code of this project is private.** This repository is its public showcase: the
> README and every source file with its types and function signatures, but none of the code inside
> them. For a demo or access to the source code, email me at
> [christodontchev@gmail.com](mailto:christodontchev@gmail.com).

Every fill-up, charge, card payment, trip and inspection lands in one company ledger that the
manager can see. DriveDesk grows out of [iDrive](https://github.com/Zukipany/iDrive), a single-user
fuel and car app: its tested logic, price sources and design system are ported into Swift packages.

DriveDesk is the working name until the trademark search is done.

| Surface      | Device              | Who                                   |
|--------------|---------------------|---------------------------------------|
| Driver app   | iPhone (main), iPad | Employees with a company or pool car  |
| Manager desk | Mac (main), iPad    | Fleet manager, owner, accountant      |
| Backend      | Supabase, Frankfurt | Both                                  |

## What it does

- **One app, two faces:** the layout follows the person's role in the company (Drive, Desk or both)
  and the screen width: a tab bar on narrow screens, a sidebar on wide ones.
- **Driver app:** Today shows the car as a pass, the budget ring and the last three fill-ups.
  Fill-ups are logged by hand or from a scanned receipt, and live fuel prices nearby come from iDrive.
- **Manager desk:** the company ledger of every fill-up, charge, card payment and trip, and where
  each car last fuelled.
- **Prepaid company cards:** Stripe Issuing, where each customer company is its own Stripe Connect
  account and tops up by bank transfer. Cards can be issued and frozen.
- **Fraud scoring:** every fill-up, card transaction and trip gets a score from 0 to 100 from 16
  simple, named rules. A score of 30 or more opens a flag that says in one sentence what looked wrong.
- **Private by default:** no live tracking. Location is captured only at a payment or fill-up, and
  the route of a private trip is visible only to its driver; everyone else sees the kilometres.
- **Works offline:** an outbox uploads first in, first out when the phone is back online, and a lost
  answer never stores a row twice.

## Design decisions

Each one has a written decision record in the private repository.

| # | Decision |
|---|----------|
| 001 | One app with a driver face and a desk face |
| 002 | A native Mac app before a web dashboard |
| 003 | Supabase in Frankfurt as the backend (EU data, row-level security) |
| 004 | Prepaid card funding, each customer its own Stripe account |
| 005 | Privacy by default: no live tracking, private trips stay private |
| 006 | Local-first sync with UUIDv7 IDs made on the device |
| 007 | Fraud rules before machine learning |
| 008 | Working name DriveDesk until the trademark search |

## Status

In active development, built in phases with a gate at the end of each. Phases 0 to 4 have shipped
their app and server parts:

- **Phase 0, Foundation:** one XcodeGen target for iPhone, iPad and Mac with strict Swift 6; the
  packages ported from iDrive with their tests; Supabase tenancy with row-level security and an
  append-only audit log; CI for both platforms and the backend.
- **Phase 1, Driver app:** sign-in, the offline outbox and sync, onboarding, Today, the map,
  fill-up capture, the car screen and invitation emails.
- **Phase 2, Desk and money:** the ledger, cars and people, budgets and fuel rules, fuel-card
  import, cost per car, input VAT checks, and a month close with DATEV, ledger and payroll exports.
- **Phase 3, Company cards:** prepaid virtual cards on Stripe Issuing, approve or decline at the
  pump, card rules applied by the server, and receipts attached to card payments.
- **Phase 4, Compliance and logbook:** the ride recorder and a logbook sealed in a hash chain,
  licence checks, UVV inspections, the yearly driver instruction, damage reports, home charging
  and "who drove?".

Still open: the receipts ZIP and ledger PDF for the month close, a tax advisor's sign-off on the
DATEV file, and a recorded load test for card decisions.

## Tech stack

- **App:** Swift 6 (strict concurrency), SwiftUI, SwiftData as the local cache, iOS / iPadOS / macOS
- **Packages:** DDCore, DDData, DDPrices, DDDevice, DDDesignSystem
- **Backend:** Supabase (Postgres with row-level security, Deno edge functions), pgTAP tests
- **Payments:** Stripe prepaid cards
- **Project:** XcodeGen, Swift Testing, GitHub Actions

## Repository layout

```
App/            the app target: Drive (driver) and Desk (manager) faces
Widgets/        WidgetKit extension
Packages/       DDCore, DDData, DDPrices, DDDevice, DDDesignSystem
AppTests/       app-level unit tests
AppUITests/     key flows on iPhone and Mac
supabase/       server functions (signatures only here)
```

## License

© 2026 Christo Dontchev. All rights reserved. The source code is private and is not licensed for
use, copying or distribution; see [LICENSE](LICENSE).
