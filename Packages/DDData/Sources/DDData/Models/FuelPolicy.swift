// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData

extension DDSchemaV1 {
    /// The company's fuel rules (`public.fuel_policies`, plan section 15): which fuels, whether
    /// premium is allowed, how far above the local average a price may be, and when payments
    /// are allowed. One for the company, and one per group that has its own.
    @Model
    public final class FuelPolicy {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        /// Nil: the company's default for every group without its own.
        public var groupID: UUID?
        /// Nil: each car's own fuels.
        public var allowedFuelTypesRaw: [String]?
        public var premiumAllowed: Bool
        /// How far above the local average a price may be, in tenths of a cent per litre.
        public var maxMilliAboveAverage: Int?
        public var maxLitresPerDay: Double?
        /// Local time window (Europe/Berlin) as "HH:MM:SS"; nil: any time.
        public var allowedFrom: String?
        public var allowedUntil: String?
        /// ISO weekdays, 1 = Monday; nil: every day.
        public var allowedWeekdays: [Int]?

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            groupID: UUID? = nil,
            allowedFuelTypes: [FuelType]? = nil,
            premiumAllowed: Bool = false,
            maxMilliAboveAverage: Int? = nil,
            maxLitresPerDay: Double? = nil,
            allowedFrom: String? = nil,
            allowedUntil: String? = nil,
            allowedWeekdays: [Int]? = nil,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

public typealias FuelPolicy = DDSchemaV1.FuelPolicy

extension FuelPolicy: SyncedRecord {
    public var allowedFuelTypes: [FuelType]? { /* private */ }
}

/// Whether a station is one the driver may use (plan D3: "Policy overlay: stations outside
/// the fuel policy are dimmed with a short reason"), and the cheapest one that is.
public nonisolated enum FuelPolicyCheck {
    public enum Reason: Equatable, Sendable {
        /// Not a fuel the car takes, or not one the policy lists.
        case fuelNotAllowed(FuelType)
        case premiumNotAllowed
        /// Above the local average by more than the policy allows, in tenths of a cent.
        case aboveAverage(milli: Int)
        /// Outside the hours or days the company allows payments.
        case outsideHours

        public var message: String { /* private */ }
    }

    /// The policy that applies to a car: its group's own, else the company's default.
    public static func policy(for vehicle: Vehicle, in policies: [FuelPolicy]) -> FuelPolicy? { /* private */ }

    /// Why the driver may not fill up `fuel` at this price; nil when they may. Without a
    /// policy only the car's own fuels count.
    public static func reason(
        fuel: FuelType,
        priceMilli: Int?,
        averageMilli: Int?,
        vehicle: Vehicle,
        policy: FuelPolicy?,
        at date: Date = .now
    ) -> Reason? { /* private */ }

    /// What the map draws for one fuel: the area's average price, why each station that
    /// isn't allowed isn't, and the cheapest allowed open station within `starWithinKm` (the
    /// star, plan D3).
    public struct Overlay: Equatable, Sendable {
        public var averageMilli: Int?
        public var reasons: [String: Reason]
        public var cheapestID: String?
    }

    public static func overlay(
        _ stations: [Station],
        fuel: FuelType,
        vehicle: Vehicle,
        policy: FuelPolicy?,
        at date: Date = .now,
        starWithinKm: Double = 5
    ) -> Overlay { /* private */ }

    /// A station's price for the fuel in tenths of a cent.
    public static func milli(_ station: Station, _ fuel: FuelType) -> Int { /* private */ }

    /// Payments allowed now: the weekday and the Berlin time window, when the policy sets them.
    public static func isWithinHours(_ policy: FuelPolicy, at date: Date) -> Bool { /* private */ }

    private static func minutes(_ time: String?) -> Int? { /* private */ }
}
