// Source code is private. This file shows only its types and signatures.

import CoreTransferable
import Foundation
import UniformTypeIdentifiers

/// The fill-ups of one car as a CSV file, for a spreadsheet or a company-car report.
/// Semicolon-separated with decimal commas when the locale uses them (as German Excel
/// expects); a comma otherwise.
public nonisolated struct FillUpExport: Transferable, Sendable {
    public let carName: String
    public let rows: [Row]
    public let decimalSeparator: String

    public struct Row: Sendable, Equatable {
        public let date: Date
        public let fuel: String
        public let amount: Double
        public let unit: String
        public let pricePerUnit: Double
        public let total: Double
        public let odometer: Int
        public let isFullTank: Bool
        public let tankLevelAfter: Double?
        public let station: String?
        /// The consumption this fill-up showed, if it gave a reading.
        public let per100km: Double?

        public init(
            date: Date,
            fuel: String,
            amount: Double,
            unit: String,
            pricePerUnit: Double,
            total: Double,
            odometer: Int,
            isFullTank: Bool,
            tankLevelAfter: Double?,
            station: String?,
            per100km: Double?
        ) { /* private */ }
    }

    public init(carName: String, rows: [Row], locale: Locale = .current) { /* private */ }

    private var separator: String { /* private */ }

    public var csv: String { /* private */ }

    public var fileName: String { /* private */ }

    private func number(_ value: Double, _ digits: Int) -> String { /* private */ }

    /// Text a spreadsheet would run as a formula ("=HYPERLINK(…)", "+1", "@SUM") gets a
    /// leading apostrophe, so a station name typed or sent by an API stays text (OWASP
    /// CSV injection).
    public static func neutralized(_ text: String) -> String { /* private */ }

    /// Quotes a field that contains the separator, a quote or a line break.
    private func escape(_ field: String) -> String { /* private */ }

    public static var transferRepresentation: some TransferRepresentation { /* private */ }
}

nonisolated extension ISO8601DateFormatter {
    public static func string(from date: Date, timeZone: TimeZone, formatOptions: ISO8601DateFormatter.Options) -> String { /* private */ }
}
