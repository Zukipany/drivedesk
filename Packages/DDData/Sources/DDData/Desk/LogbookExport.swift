// Source code is private. This file shows only its types and signatures.

import CoreTransferable
import DDCore
import Foundation
import UniformTypeIdentifiers

/// One trip as the logbook prints it: corrected values, manual marked, the seal, and every
/// correction in words.
public nonisolated struct LogbookLine: Sendable, Identifiable {
    public var id: UUID
    public var startedAt: Date
    public var endedAt: Date
    public var startOdometerKm: Int?
    public var endOdometerKm: Int?
    public var km: Double
    public var from: String
    public var to: String
    public var type: TripType
    public var purpose: String
    public var partner: String
    public var detour: String
    public var driver: String
    public var isManual: Bool
    public var sealHash: String?
    public var notes: [String]

    public init(_ trip: CorrectedTrip, driver: String) { /* private */ }
}

/// A car's logbook for a period as CSV (plan section 16, "Exports"): one line per trip, the
/// corrections inline, the seal hash on every line and the chain's last hash at the end.
public nonisolated struct LogbookExport: Transferable, Sendable {
    public let car: String
    public let plate: String
    public let period: String
    public let lines: [LogbookLine]
    let decimalSeparator: String

    public init(car: String, plate: String, period: String, lines: [LogbookLine], locale: Locale = .current) { /* private */ }

    private var separator: String { /* private */ }

    /// The last sealed trip's hash: what the month's export record keeps as proof.
    public var chainEnd: String? { /* private */ }

    public var kilometres: [TripType: Double] { /* private */ }

    public var csv: String { /* private */ }

    public var fileName: String { /* private */ }

    private func escape(_ field: String) -> String { /* private */ }

    public static var transferRepresentation: some TransferRepresentation { /* private */ }
}
