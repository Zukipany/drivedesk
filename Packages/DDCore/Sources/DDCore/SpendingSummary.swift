// Source code is private. This file shows only its types and signatures.

import Foundation

/// The "balance" for one month: what was spent, how it splits by energy type,
/// and how it compares with the month before.
public nonisolated struct SpendingSummary: Equatable, Sendable {
    public struct Slice: Identifiable, Equatable, Sendable {
        public let fuel: FuelType
        public let total: Double
        public let share: Double
        public var id: FuelType { /* private */ }

        public init(
            fuel: FuelType,
            total: Double,
            share: Double
        ) { /* private */ }
    }

    public let month: DateInterval
    public let total: Double
    /// Spending in the comparison window of the previous month.
    public let previousTotal: Double
    /// True for the running month: it is compared with the same number of days of the
    /// previous month, so on 7 October you see 1–7 Oct vs 1–7 Sep, not vs all of September.
    public let isMonthToDate: Bool
    public let fillUpCount: Int
    /// Largest first. Shares add up to 1 when `total > 0`.
    public let slices: [Slice]

    /// Percent vs the previous month; nil when the previous month had no spending.
    public var change: Double? { /* private */ }

    public init<E: FuelEntry>(
        entries: [E],
        monthContaining date: Date,
        now: Date = .now,
        calendar: Calendar = .current
    ) { /* private */ }

    public func remaining(budget: Double) -> Double { /* private */ }

    /// 0...1 share of the budget used. 0 when no budget is set.
    public func budgetProgress(budget: Double) -> Double { /* private */ }

    public init(
        month: DateInterval,
        total: Double,
        previousTotal: Double,
        isMonthToDate: Bool,
        fillUpCount: Int,
        slices: [Slice]
    ) { /* private */ }
}
