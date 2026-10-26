// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// One trip in the electronic logbook (`public.trips`, US-34, plan section 16): recorded by
    /// the phone, entered by hand, or later read from the car cloud. The driver records and
    /// classifies their own; the desk reads them all. A private trip keeps its date and
    /// kilometres only.
    @Model
    public final class LogbookTrip {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var memberID: UUID
        public var startedAt: Date
        public var endedAt: Date
        public var startOdometerKm: Int?
        public var endOdometerKm: Int?
        public var distanceKm: Double
        public var startAddress: String?
        public var endAddress: String?
        public var typeRaw: String
        public var purpose: String?
        public var partner: String?
        public var detourNote: String?
        public var sourceRaw: String
        /// The seal (US-35), set by the server 7 days after the trip ends: its place in the car's
        /// chain, the hash before it and its own. Nil until sealed.
        public var sealSequence: Int?
        public var previousHash: String?
        public var sealHash: String?
        public var sealedAt: Date?

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            memberID: UUID,
            startedAt: Date,
            endedAt: Date,
            startOdometerKm: Int? = nil,
            endOdometerKm: Int? = nil,
            distanceKm: Double,
            startAddress: String? = nil,
            endAddress: String? = nil,
            type: TripType = .unclassified,
            purpose: String? = nil,
            partner: String? = nil,
            detourNote: String? = nil,
            source: TripSource = .recorder,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

/// `public.trip_type`: how a trip counts for tax.
public nonisolated enum TripType: String, Codable, CaseIterable, Sendable {
    case unclassified, business, commute, `private`

    public var label: String { /* private */ }

    public var symbol: String { /* private */ }
}

/// `public.trip_source`: where a trip came from; manual ones say so in every export.
public nonisolated enum TripSource: String, Codable, CaseIterable, Sendable {
    case recorder, manual
    case carCloud
}

extension LogbookTrip: SyncedRecord {
    public var type: TripType {
        get { /* private */ }
        set { /* private */ }
    }

    public var source: TripSource { /* private */ }

    /// Sealed trips never change; corrections are added instead.
    public var isSealed: Bool { /* private */ }
}

public typealias LogbookTrip = DDSchemaV1.LogbookTrip
