# DriveDesk

**A fleet platform for small German companies with 5 to 50 cars. One SwiftUI app is the driver app
on iPhone and iPad and the manager desk on Mac and iPad, on one shared backend.**

> [!NOTE]
> **The source code of this project is private.** This repository is its public showcase: the
> README and every source file with its types and function signatures, but none of the code inside
> them. If you'd like a demo or to talk about the project, open an issue.

Every fill-up, charge, card payment, trip and inspection lands in one company ledger that the
manager can see. DriveDesk grows out of [iDrive](https://github.com/Zukipany/iDrive), a single-user
fuel and car app: its tested logic, price sources and design system are ported into Swift packages.

DriveDesk is the working name until the trademark search is done.

| Surface      | Device              | Who                                   |
|--------------|---------------------|---------------------------------------|
| Driver app   | iPhone (main), iPad | Employees with a company or pool car  |
| Manager desk | Mac (main), iPad    | Fleet manager, owner, finance         |
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

In active development, built in phases with a gate at the end of each.

- **Phase 0, Foundation (done):** one XcodeGen target that runs on iPhone, iPad and Mac with strict
  Swift 6; four packages ported from iDrive with their tests (DDCore 173, DDPrices 64,
  DDDesignSystem 8, DDDevice with iDrive's receipt bench at 105 of 105 receipts); Supabase
  tenancy, vehicle and money tables with row-level security, an append-only audit log and 132
  pgTAP tests; CI for both platforms and the backend.
- **Phase 1, Driver app (in progress):** sign-in with an email link, the offline outbox and sync
  engine, onboarding (create a company or join with an invitation, in English and German), and
  navigation with the Today screen.

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
