// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData
import Testing
@testable import DDData

@Suite("Desk overview")
struct DeskOverviewTests {
    /// 18 October 2026, noon in Berlin: day 18 of 31.
    private let now
    private let october
    private let september
    private let august

    private func row(
        _ month: Date,
        vehicle: UUID = Demo.caddy,
        kind: FillUpKind = .fuel,
        euros: Int,
        card: Int = 0,
        noReceipt: Int = 0,
        odometer: ClosedRange<Int>? = nil
    ) -> SpendRow { /* private */ }

    private func snapshot(
        spend: [SpendRow],
        savings: [SavingsRow] = [],
        flags: [FlagRow] = [],
        compliance: [ComplianceRow] = []
    ) -> DeskSnapshot { /* private */ }

    @Test("Spend against budget and last month, with a forecast from the daily average")
    func spend() { /* private */ }

    @Test("Without a company budget the groups' budgets add up; none at all leaves it empty")
    func groupBudgets() { /* private */ }

    @Test("Savings in euros and cents per litre; missed only when the server sent it")
    func savings() { /* private */ }

    @Test("Card share of spend, this month against last")
    func cardShare() { /* private */ }

    @Test("Cost per km: each car's distance from last month's last reading; the first month uses its own range")
    func costPerKm() { /* private */ }

    @Test("Flags, due dates and what needs attention")
    func attention() { /* private */ }

    @Test("Thirteen months up to this one, fuel and electricity apart, empty months at zero")
    func months() { /* private */ }

    @Test("Rows from the views: spend, savings, flags and due dates")
    func rows() throws { /* private */ }

    @Test("The local source computes the same rows from the store")
    func localSource() async throws { /* private */ }
}
