// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation

/// The desk overview (plan M1): six KPIs against last month, the 13-month spend, the cars
/// costing most per kilometre, and what needs attention. Pure: computed from a `DeskSnapshot`
/// and the budgets, so the server and the demo give the same numbers.
public nonisolated struct DeskOverview: Sendable {
    /// A value this month and last month.
    public struct Metric: Equatable, Sendable {
        public var current: Double?
        public var previous: Double?

        /// The change against last month as a share (0.12 = 12 % more); nil without both.
        public var change: Double? { /* private */ }
    }

    public struct MonthSpend: Equatable, Sendable, Identifiable {
        public var month: Date
        public var fuelCents: Int
        public var chargeCents: Int
        public var id: Date { /* private */ }
    }

    public struct CarCost: Equatable, Sendable, Identifiable {
        public var vehicleID: UUID
        public var km: Int
        public var spendCents: Int
        public var id: UUID { /* private */ }
        /// € per km.
        public var costPerKm: Double { /* private */ }
    }

    /// One line of "Needs your attention", each with the place that fixes it.
    public enum Attention: Equatable, Sendable {
        /// Flags undecided for more than 48 hours.
        case oldFlags(Int)
        /// Card payments this month still without a receipt.
        case missingReceipts(Int)
        /// Reminders and documents past their date.
        case overdue(Int)
        /// This month's spend has passed the budget, by this many cents.
        case budgetPassed(Int)
    }

    /// The month the overview is about (its first day, as stored).
    public var month: Date
    /// € spent this month and last.
    public var spend: Metric
    /// The fleet's budget for the month, in €; nil when none is set.
    public var budget: Double?
    /// Where spend lands at month end at the current daily average, in €.
    public var forecast: Double?
    /// The forecast against last month's total: a month half gone compares fairly that way.
    public var forecastChange: Double? { /* private */ }
    /// € saved against the local average.
    public var saved: Metric
    /// Cents saved per litre this month and last: a rate, so a part month compares fairly.
    public var savedPerLitre: Metric
    /// € left on the table against the cheapest station nearby (managers only).
    public var missed: Double?
    public var openFlags: Int
    public var highFlags: Int
    /// The share of spend paid by card, 0…1.
    public var cardShare: Metric
    /// € per km over the cars with a known distance.
    public var costPerKm: Metric
    public var overdue: Int
    public var dueSoon: Int
    public var months: [MonthSpend]
    public var topCars: [CarCost]
    public var attention: [Attention]

    public static func make(_ snapshot: DeskSnapshot, budgets: [Budget], now: Date = .now) -> DeskOverview { /* private */ }

    /// The company's own budget for the month, else the sum of its groups' budgets.
    static func fleetBudget(_ budgets: [Budget], month: Date) -> Double? { /* private */ }

    /// Each car's distance and spend per month. A month's distance runs from the previous
    /// month's last reading to this month's last; the first month known uses its own range.
    public static func carCosts(_ rows: [SpendRow]) -> [Date: [CarCost]] { /* private */ }

    static func fleetCostPerKm(_ cars: [CarCost]?) -> Double? { /* private */ }

    /// The 13 months up to this one, fuel and electricity apart; months without spend at 0.
    static func monthSeries(_ rows: [SpendRow], ending month: Date) -> [MonthSpend] { /* private */ }
}
