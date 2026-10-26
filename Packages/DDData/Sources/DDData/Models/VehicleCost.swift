// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A cost booked on a car beyond its fill-ups (`public.vehicle_costs`, US-30): a service,
    /// a repair, damage, tyres or anything else. Managers and owners book them; drivers never
    /// see them.
    @Model
    public final class VehicleCost {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var kindRaw: String
        /// The day it was incurred (a date without time, 00:00 UTC).
        public var incurredOn: Date
        public var amountGrossCents: Int
        public var vatCents: Int?
        public var note: String

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            kind: VehicleCostKind,
            incurredOn: Date,
            amountGrossCents: Int,
            vatCents: Int? = nil,
            note: String = "",
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

/// `public.vehicle_cost_kind`.
public nonisolated enum VehicleCostKind: String, Codable, CaseIterable, Sendable {
    case service, repair, damage, tyres, other

    public var label: String { /* private */ }

    public var symbol: String { /* private */ }
}

extension VehicleCost: SyncedRecord {
    public var kind: VehicleCostKind {
        get { /* private */ }
        set { /* private */ }
    }
}

public typealias VehicleCost = DDSchemaV1.VehicleCost
