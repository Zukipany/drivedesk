// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// Today (plan D1): at a glance, the car the driver has, how much they may still spend this
/// month and their last fill-ups. Everything comes from the local store, so it opens offline;
/// pulling down syncs. Cheapest now, tasks and savings join in later commits.
struct TodayView: View {
    @Environment(AppSession.self) private var session
    @Query private var assignments: [Assignment]
    @Query private var vehicles: [Vehicle]
    @Query private var budgets: [Budget]
    /// The month's fill-ups in the company, for what has gone against the budget.
    @Query private var monthFillUps: [FillUp]
    /// The member's latest fill-ups (a few more than shown, so deleted ones never leave a gap).
    @Query private var latestFillUps: [FillUp]
    @Query private var reminders: [VehicleReminder]
    @Query private var policies: [FuelPolicy]
    @Query private var chargingPlans: [CompanyChargingPlan]
    @Query private var companies: [Company]
    @State private var capture
    @State private var myFlags: [FlagDetail]
    /// Undecided flags in the company, for a manager's desk pulse.
    @State private var openFlags
    @State private var answering: FlagDetail?

    let member: Member
    let user: AuthUser

    init(member: Member, user: AuthUser, now: Date = .now) { /* private */ }

    private var assignment: Assignment? { /* private */ }
    private var vehicle: Vehicle? { /* private */ }
    private var budget: Budget? { /* private */ }
    private var recent: [FillUp] { /* private */ }

    var body: some View { /* private */ }

    /// The flags about this driver that still wait for them or for a decision.
    private func loadFlags() async { /* private */ }

    /// The car as its pass; tapping it opens Car.
    private func carPass(_ vehicle: Vehicle) -> some View { /* private */ }
}

extension Vehicle {
    /// The car as the pass draws it.
    func pass(badge: String) -> CarPass.Car { /* private */ }
}

/// "€212 of €350 left in October": the ring is the accent up to 80 % used, amber to 100 %,
/// red beyond, and the words say the same.
private struct BudgetCard: View {
    let budget: Budget
    let spentCents: Int

    private var spent: Double { /* private */ }
    private var monthName: String { /* private */ }

    private var headline: String { /* private */ }

    private var scopeLabel: LocalizedStringKey { /* private */ }

    var body: some View { /* private */ }
}

/// The last three fill-ups or charges with their state: waiting to upload, waiting for a
/// decision, or refused.
private struct RecentCard: View {
    let fillUps: [FillUp]

    var body: some View { /* private */ }
}

private struct FillUpRow: View {
    let fillUp: FillUp

    private var title: String { /* private */ }

    private var detail: String { /* private */ }

    var body: some View { /* private */ }
}

/// How an unsent row says where it is.
private struct SyncBadge {
    let title: LocalizedStringKey
    let tone: StatusTone

    init?(_ state: SyncState) { /* private */ }
}

/// Changes still in the outbox, so nobody wonders whether a fill-up arrived.
private struct SyncStatusLine: View {
    @Environment(AppSession.self) private var session

    var body: some View { /* private */ }
}

/// What the empty state says: a driver waits for a car; whoever runs the fleet assigns one.
private func noCarMessage(_ role: MemberRole) -> LocalizedStringKey { /* private */ }

/// No car assigned, in place of the pass.
private struct NoCarCard: View {
    let role: MemberRole

    var body: some View { /* private */ }
}

/// Nothing to show at all: no car, no budget, no fill-ups.
private struct NoCarView: View {
    let role: MemberRole

    var body: some View { /* private */ }
}

/// The company at the top left. Someone in two companies taps it to switch (plan D1).
private struct CompanyChip: View {
    @Environment(AppSession.self) private var session
    @Query private var memberships: [Member]
    @Query(sort: \Company.name) private var companies: [Company]
    let member: Member

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var showsName: Bool { /* private */ }
    #else
        private let showsName
    #endif

    init(member: Member, user: AuthUser) { /* private */ }

    private func name(of company: UUID) -> String { /* private */ }

    var body: some View { /* private */ }
}

/// The one primary action of the app (plan D1): a large glass capsule above the tab bar,
/// tinted in the car's main fuel colour. It opens the ways to log a fill-up.
struct FuelUpButton: View {
    let vehicle: Vehicle
    let capture: FillUpCapture

    var body: some View { /* private */ }
}

/// The car's next due date under the pass (plan D1: "TÜV in 23 days"); tapping the pass
/// opens Car with all of them.
private struct NextDeadline: View {
    let reminder: VehicleReminder

    var body: some View { /* private */ }
}

/// A manager's or owner's glance at the company on Today (plan section 5, "Desk pulse"):
/// spend against the month's budget, flags waiting for a decision, dates passed.
private struct DeskPulseCard: View {
    let spentCents: Int
    let budget: Budget?
    let openFlags: Int
    let overdue: Int
    let open: () -> Void

    var body: some View { /* private */ }

    private func figure(_ value: String, _ label: String, tone: StatusTone? = nil) -> some View { /* private */ }
}
