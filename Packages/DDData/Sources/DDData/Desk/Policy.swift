// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation

/// Budgets on the desk (plan M13): per company, group, car or person and month, what each
/// target spent, and next month's budgets made from this month's, unused money carried over
/// when the company wants that.
public nonisolated enum BudgetPlan {
    /// What a budget's target spent in a month, from the desk's monthly rows.
    public static func spentCents(scope: BudgetScope, target: UUID?, month: Date, in rows: [SpendRow]) -> Int { /* private */ }

    /// The target a budget is for, whatever its scope.
    public static func target(of budget: Budget) -> UUID? { /* private */ }

    /// A budget for `month` like `budget`, for the same target.
    public static func budget(like budget: Budget, month: Date, amountCents: Int) -> Budget { /* private */ }

    /// `month`'s budgets made from the month before's: the same targets and amounts, plus
    /// what went unused when `carryOver` is on. Targets that already have one are skipped.
    public static func copies(
        of previous: [Budget],
        into month: Date,
        existing: [Budget],
        carryOver: Bool,
        spentCents: (Budget) -> Int
    ) -> [Budget] { /* private */ }

    private struct Key: Hashable {
        let scope: BudgetScope
        let target: UUID?

        init(_ budget: Budget) { /* private */ }
    }
}

/// A fuel policy being edited (plan M13 and section 15): which fuels, premium, how far
/// above the local average, litres per day, hours and weekdays.
public nonisolated struct FuelPolicyDraft: Equatable, Sendable {
    /// Nil: each car's own fuels.
    public var allowedFuels: Set<FuelType>?
    public var premiumAllowed
    /// Cents per litre above the local average; nil: no limit.
    public var maxCentsAboveAverage: Double?
    public var maxLitresPerDay: Double?
    /// Minutes after Berlin midnight; both or neither.
    public var fromMinutes: Int?
    public var untilMinutes: Int?
    /// ISO weekdays, 1 = Monday; nil: every day.
    public var weekdays: Set<Int>?

    public enum Problem: Hashable, Sendable {
        case noFuels
        case noWeekdays
    }

    public init() { /* private */ }

    public init(_ policy: FuelPolicy) { /* private */ }

    public var problems: [Problem] { /* private */ }

    public var hasHours: Bool { /* private */ }

    public func apply(to policy: FuelPolicy) { /* private */ }

    public func makePolicy(company: UUID, group: UUID?) -> FuelPolicy { /* private */ }

    /// "06:30:00" from 390.
    static func time(_ minutes: Int) -> String { /* private */ }

    static func minutes(_ time: String?) -> Int? { /* private */ }
}

/// The editor's live preview (plan M13): "With this policy, last month would have produced
/// 7 flags." Each fuel fill-up of the cars the policy covers is checked against the draft as
/// the map and the payment check would; litres per day add up per driver and Berlin day.
public nonisolated enum PolicyPreview {
    public enum Kind: Hashable, Sendable, CaseIterable {
        case fuel, premium, aboveAverage, outsideHours, litresPerDay
    }

    public struct Result: Equatable, Sendable {
        /// Fill-ups looked at.
        public var checked
        /// Fill-ups that break at least one rule.
        public var breaches
        public var byKind: [Kind: Int]
    }

    public static func run(_ draft: FuelPolicyDraft, fillUps: [FillUp], vehicles: [Vehicle]) -> Result { /* private */ }
}
