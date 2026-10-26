// Source code is private. This file shows only its types and signatures.

import CoreTransferable
import DDCore
import Foundation
import UniformTypeIdentifiers

/// The span the cost screen adds up, in Berlin time.
public nonisolated enum CostPeriod: String, CaseIterable, Identifiable, Sendable {
    case thisMonth, lastMonth, lastThreeMonths, lastTwelveMonths

    public var id: Self { /* private */ }

    public func interval(now: Date = .now) -> DateInterval { /* private */ }
}

/// What one car cost in a period and how much it was used (US-30, plan features 39 and 45).
public nonisolated struct CarCostLine: Identifiable, Equatable, Sendable {
    public let vehicleID: UUID
    public var fuelCents
    public var chargeCents
    /// Services and tyres.
    public var serviceCents
    /// Repairs and damage.
    public var damageCents
    public var otherCents
    public var km
    /// Days the car was with someone (a running assignment, permanent or pool).
    public var daysUsed
    public var periodDays

    public var id: UUID { /* private */ }
    public var totalCents: Int { /* private */ }
    public var costPerKm: Double? { /* private */ }
    public var utilisation: Double { /* private */ }
}

/// Adds up each car's cost and use from the cached rows: fill-ups (fuel and charging), booked
/// costs (service, damage, other), readings for the distance, and assignments for the days
/// used. The server's `v_vehicle_tco` gives the same sums per month.
public nonisolated enum CarCosts {
    public static func lines(
        vehicles: [Vehicle],
        fillUps: [FillUp],
        costs: [VehicleCost],
        assignments: [Assignment],
        in period: DateInterval
    ) -> [CarCostLine] { /* private */ }

    /// The most cars out at the same moment in the period, from their assignments.
    public static func peakInUse(assignments: [Assignment], vehicles: Set<UUID>, in period: DateInterval) -> Int { /* private */ }

    /// The Berlin days the period touches, as day intervals.
    static func berlinDays(in period: DateInterval) -> [DateInterval] { /* private */ }

    private static func usedDays(of vehicle: UUID, assignments: [Assignment], days: [DateInterval]) -> Int { /* private */ }
}

/// The cost table as a CSV file: semicolons and decimal commas for German Excel, like the
/// ledger's export.
public nonisolated struct CarCostExport: Transferable, Sendable {
    public struct Row: Sendable {
        public var car: String
        public var plate: String
        public var line: CarCostLine

        public init(car: String, plate: String, line: CarCostLine) { /* private */ }
    }

    public let rows: [Row]
    public let title: String
    let decimalSeparator: String

    public init(rows: [Row], title: String, locale: Locale = .current) { /* private */ }

    private var separator: String { /* private */ }

    public var csv: String { /* private */ }

    public var fileName: String { /* private */ }

    private func euros(_ cents: Int) -> String { /* private */ }

    private func number(_ value: Double, _ digits: Int) -> String { /* private */ }

    private func escape(_ field: String) -> String { /* private */ }

    public static var transferRepresentation: some TransferRepresentation { /* private */ }
}
