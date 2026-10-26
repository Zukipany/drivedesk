// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A month's home-charging claim (`public.charging_claims`, US-37, plan section 17): the kWh
    /// the wallbox meter shows, priced by the server at the year's flat rate or the driver's
    /// tariff, approved or rejected by the desk, paid tax-free with the payroll.
    @Model
    public final class ChargingClaim {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var memberID: UUID
        public var vehicleID: UUID
        /// The first day of the month claimed (00:00 UTC, a date without time).
        public var month: Date
        public var meterStart: Double?
        public var meterEnd: Double?
        public var kwh: Double
        /// The server's: how it's paid, and the amount.
        public var methodRaw: String
        public var rateMilli: Int?
        public var baseFeeCents: Int?
        public var householdKWh: Double?
        public var amountCents: Int
        public var photoPath: String?
        /// The meter photo on this device until it's uploaded.
        @Attribute(.externalStorage) public var photo: Data?
        public var note: String
        public var statusRaw: String
        public var decidedBy: UUID?
        public var decidedAt: Date?
        public var decisionNote: String?

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            memberID: UUID,
            vehicleID: UUID,
            month: Date,
            meterStart: Double? = nil,
            meterEnd: Double? = nil,
            kwh: Double,
            method: HomeChargingMethod = .flatRate,
            amountCents: Int = 0,
            note: String = "",
            status: ClaimStatus = .submitted,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }

    /// A driver's own electricity tariff (`public.home_tariffs`), for the actual-cost method.
    @Model
    public final class HomeTariff {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var memberID: UUID
        public var priceMilli: Int
        public var baseFeeCents: Int
        /// The household's own consumption a month, without the car.
        public var householdKWh: Double

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            memberID: UUID,
            priceMilli: Int,
            baseFeeCents: Int = 0,
            householdKWh: Double = 0,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }

    /// The owner's choice of method for a calendar year (`public.home_charging_methods`).
    @Model
    public final class HomeChargingYear {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var year: Int
        public var methodRaw: String

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            year: Int,
            method: HomeChargingMethod,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

/// `public.home_charging_method`: one per calendar year.
public nonisolated enum HomeChargingMethod: String, Codable, CaseIterable, Sendable {
    case flatRate
    case actualCost

    public var label: String { /* private */ }
}

/// `public.claim_status`.
public nonisolated enum ClaimStatus: String, Codable, CaseIterable, Sendable {
    case submitted, approved, rejected

    public var label: String { /* private */ }
}

extension ChargingClaim: SyncedRecord {
    public var method: HomeChargingMethod { /* private */ }
    public var status: ClaimStatus {
        get { /* private */ }
        set { /* private */ }
    }
}

extension HomeTariff: SyncedRecord {}

extension HomeChargingYear: SyncedRecord {
    public var method: HomeChargingMethod {
        get { /* private */ }
        set { /* private */ }
    }
}

public typealias ChargingClaim = DDSchemaV1.ChargingClaim
public typealias HomeTariff = DDSchemaV1.HomeTariff
public typealias HomeChargingYear = DDSchemaV1.HomeChargingYear
