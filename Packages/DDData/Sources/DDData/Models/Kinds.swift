// Source code is private. This file shows only its types and signatures.

import Foundation

/// A person's role in one company (`public.member_role`). A person can belong to several
/// companies with one role in each.
public nonisolated enum MemberRole: String, Codable, CaseIterable, Sendable {
    case driver, manager, owner, accountant

    /// Drives a company or pool car, so the driver app's screens apply: Today, Map, Log, Car.
    public var drives: Bool { /* private */ }

    /// Opens the manager desk: the overview and ledger for managers and owners, the ledger,
    /// logbooks and exports for the accountant (plan section 10).
    public var opensDesk: Bool { /* private */ }

    public var label: String { /* private */ }
}

/// `public.member_status`: members are removed, never deleted, so their history stays.
public nonisolated enum MemberStatus: String, Codable, CaseIterable, Sendable {
    case active, removed
}

/// `public.vehicle_ownership`.
public nonisolated enum VehicleOwnership: String, Codable, CaseIterable, Sendable {
    case owned, leased, rented

    public var label: String { /* private */ }
}

/// `public.vehicle_status`.
public nonisolated enum VehicleStatus: String, Codable, CaseIterable, Sendable {
    case active, workshop, retired
}

/// `public.assignment_kind`: a permanent company car or a pool booking.
public nonisolated enum AssignmentKind: String, Codable, CaseIterable, Sendable {
    case permanent, pool
}

/// `public.fillup_kind`: a charge is electric, a fill-up isn't.
public nonisolated enum FillUpKind: String, Codable, CaseIterable, Sendable {
    case fuel, charge
}

/// `public.fillup_source`: how a fill-up arrived. Card fill-ups come from the server only.
public nonisolated enum FillUpSource: String, Codable, CaseIterable, Sendable {
    case card, receipt, manual
    case `import`

    public var symbol: String { /* private */ }

    public var label: String { /* private */ }
}

/// `public.budget_scope`: a monthly budget for the company, a group, a car or a person.
public nonisolated enum BudgetScope: String, Codable, CaseIterable, Sendable {
    case company, group, vehicle, member
}
