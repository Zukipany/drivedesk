// Source code is private. This file shows only its types and signatures.

import CryptoKit
import Foundation

/// The logbook's seal (US-35, plan section 16): the same v1 payload and SHA-256 chain as the
/// server's `trip_seal_payload` and `seal_trips` (migration 0019), so the desk can recompute
/// every chain on the device and the demo can seal its own trips.
public nonisolated enum LogbookSeal {
    /// The unit separator between fields: never part of an address or a purpose.
    static let separator

    private static let utc: DateFormatter

    /// Every field in the fixed v1 order: timestamps in UTC to the second, the distance with
    /// one decimal, a missing value as "".
    public static func payload(of trip: LogbookTrip, sequence: Int) -> String { /* private */ }

    public static func hash(previous: String, payload: String) -> String { /* private */ }

    /// Seals every unsealed trip that ended `days` or more before `now`, car by car in the order
    /// they started, after the car's last sealed trip (what the server does nightly). Returns
    /// how many were sealed.
    @discardableResult
    public static func seal(_ trips: [LogbookTrip], now: Date, days: Int = 7) -> Int { /* private */ }

    /// One car's chain, recomputed.
    public struct ChainCheck: Equatable, Sendable, Identifiable {
        public var vehicleID: UUID
        public var sealedTrips: Int
        /// The first trip whose link doesn't hold; nil when the chain is whole.
        public var firstBroken: UUID?

        public var id: UUID { /* private */ }
        public var isIntact: Bool { /* private */ }
    }

    /// Recomputes every car's chain: each link's number, the hash before it and its own hash.
    public static func verify(_ trips: [LogbookTrip]) -> [ChainCheck] { /* private */ }
}

/// A trip as the logbook shows it: its own values with every correction applied, and the
/// corrections in words for the exports.
public nonisolated struct CorrectedTrip: Identifiable {
    public let trip: LogbookTrip
    public let corrections: [TripCorrection]

    public init(_ trip: LogbookTrip, corrections: [TripCorrection]) { /* private */ }

    public var id: UUID { /* private */ }

    private func latest(_ field: TripCorrectionField) -> TripCorrection? { /* private */ }

    public var type: TripType { /* private */ }

    /// A trip corrected to private shows no purpose, partner or places.
    public var purpose: String? { /* private */ }
    public var partner: String? { /* private */ }
    public var detourNote: String? { /* private */ }
    public var startAddress: String? { /* private */ }
    public var endAddress: String? { /* private */ }

    /// "Changed on 12 Nov 2026: purpose from "private" to "business". Reason: customer visit forgotten."
    public var notes: [String] { /* private */ }
}
