// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A change to a sealed trip (`public.trip_corrections`, US-35): the trip itself never
    /// changes; every export shows the correction inline. "Changed on 12 Nov 2026: purpose from
    /// private to business. Reason: customer visit forgotten."
    @Model
    public final class TripCorrection {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var tripID: UUID
        public var fieldRaw: String
        /// Filled in by the server from the trip as corrected so far.
        public var oldValue: String?
        public var newValue: String?
        public var reason: String
        public var correctedBy: UUID
        public var correctedAt: Date

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            tripID: UUID,
            field: TripCorrectionField,
            oldValue: String? = nil,
            newValue: String?,
            reason: String,
            correctedBy: UUID,
            correctedAt: Date = .now,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

/// What a correction may change: the classification, never times or kilometres.
public nonisolated enum TripCorrectionField: String, Codable, CaseIterable, Sendable {
    case type, purpose, partner
    case detourNote

    public var label: String { /* private */ }
}

extension TripCorrection: SyncedRecord {
    public var field: TripCorrectionField { /* private */ }
}

public typealias TripCorrection = DDSchemaV1.TripCorrection
