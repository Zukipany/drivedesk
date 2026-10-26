// Source code is private. This file shows only its types and signatures.

import Foundation

/// What the Today screen shows a driver (plan D1), worked out from the local store alone so
/// Today opens offline: the car they drive now, the budget that says what they may still
/// spend this month, what has gone against it, and their latest fill-ups.
public nonisolated enum DriverToday {
    /// The car the member drives now: their current permanent assignment, else the pool car
    /// they took most recently.
    public static func currentAssignment(of member: UUID, in assignments: [Assignment], at date: Date = .now) -> Assignment? { /* private */ }

    /// The month's budget for the member: their own, else their car's. Group and company
    /// budgets aren't shown on Today: a driver's phone holds only the driver's own fill-ups,
    /// so it can't add up what a whole group spent.
    public static func budget(for member: UUID, vehicle: UUID?, in budgets: [Budget], at date: Date = .now) -> Budget? { /* private */ }

    /// What has gone against the budget in its month, in cents: the member's fill-ups for a
    /// personal budget, the car's for a car budget. Deleted fill-ups don't count; the month
    /// runs from Berlin midnight to Berlin midnight.
    public static func spentCents(against budget: Budget, in fillUps: [FillUp]) -> Int { /* private */ }

    /// The member's latest fill-ups and charges, newest first, without deleted ones.
    public static func recent(of member: UUID, in fillUps: [FillUp], limit: Int = 3) -> [FillUp] { /* private */ }

    /// Noon on the first of the budget's month in Berlin: a moment certainly inside it.
    private static func monthMoment(_ storedMonth: Date) -> Date { /* private */ }
}
