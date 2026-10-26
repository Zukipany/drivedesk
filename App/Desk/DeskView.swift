// Source code is private. This file shows only its types and signatures.

import Charts
import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The desk overview (plan M1): the fleet's state in ten seconds. Six KPIs against last
/// month, the 13-month spend split into fuel and electricity, the cars costing most per km,
/// what needs attention, and what's due within 30 days. The numbers come from the server's
/// views (`v_spend_monthly`, `v_savings_monthly`, `v_compliance_due` and the flags); offline,
/// the last answer stays, marked.
struct DeskView: View {
    @Environment(AppSession.self) private var session
    @Query private var budgets: [Budget]
    @Query private var vehicles: [Vehicle]
    @Query private var reminders: [VehicleReminder]
    /// The month's fill-ups on this device, for the input VAT at stake.
    @Query private var monthFillUps: [FillUp]
    @State private var snapshot: DeskSnapshot?
    @State private var loadError: String?
    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
    #endif
    let member: Member

    init(member: Member) { /* private */ }

    private var overview: DeskOverview? { /* private */ }

    private func carName(_ id: UUID) -> String { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private var header: some View { /* private */ }

    private func load() async { /* private */ }
}

/// The six KPI tiles (plan M1), each against last month.
private struct KPIGrid: View {
    let overview: DeskOverview

    private var spendDetail: String? { /* private */ }

    private var spendTone: StatusTone? { /* private */ }

    private var savedDetail: String? { /* private */ }

    var body: some View { /* private */ }
}

/// Spend over 13 months, fuel and electricity stacked, the month's budget as a line.
private struct SpendChart: View {
    let months: [DeskOverview.MonthSpend]
    let budget: Double?

    private struct Bar: Identifiable {
        let month: Date
        let series: String
        let euros: Double
        var id: String { /* private */ }
    }

    private var bars: [Bar] { /* private */ }

    var body: some View { /* private */ }
}

/// "Needs your attention": what's late, one line each (plan M1).
private struct AttentionCard: View {
    let attention: [DeskOverview.Attention]
    /// The input VAT the month's card payments without a receipt lose (US-31).
    var vatAtStakeCents

    var body: some View { /* private */ }
}

private struct AttentionRow: View {
    let item: DeskOverview.Attention
    let vatAtStakeCents: Int

    private var content: (symbol: String, tone: StatusTone, text: String) { /* private */ }

    var body: some View { /* private */ }
}

/// The five cars costing most per km this month (plan M1).
private struct TopCarsCard: View {
    let cars: [DeskOverview.CarCost]
    let carName: (UUID) -> String

    var body: some View { /* private */ }
}

/// Due within 30 days across the fleet: the same reminders the drivers get.
private struct DueSoonCard: View {
    let reminders: [VehicleReminder]
    let carName: (UUID) -> String

    var body: some View { /* private */ }
}

/// The ledger, cars, people and policy as a row of buttons on iPhone.
private struct DeskLinks: View {
    let member: Member

    var body: some View { /* private */ }

    @ViewBuilder private func destination(_ section: AppSection) -> some View { /* private */ }
}
