// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A car's fixed costs for one year (`public.vehicle_fixed_costs`, US-36): lease, insurance,
    /// vehicle tax and anything else not booked per invoice. The logbook method of the 1 % rule
    /// comparison needs them besides fuel, charging and the booked costs.
    @Model
    public final class VehicleFixedCost {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var year: Int
        public var leaseCents: Int
        public var insuranceCents: Int
        public var taxCents: Int
        public var otherCents: Int

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            year: Int,
            leaseCents: Int = 0,
            insuranceCents: Int = 0,
            taxCents: Int = 0,
            otherCents: Int = 0,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

extension VehicleFixedCost: SyncedRecord {
    public var totalCents: Int { /* private */ }
}

public typealias VehicleFixedCost = DDSchemaV1.VehicleFixedCost
