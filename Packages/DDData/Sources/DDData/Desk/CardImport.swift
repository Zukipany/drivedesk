// Source code is private. This file shows only its types and signatures.

import CryptoKit
import DDCore
import Foundation

/// A fuel card's monthly CSV, read as it comes (US-28, plan feature 7): semicolons, commas or
/// tabs, quoted fields, a header row.
public nonisolated struct CardCSV: Equatable, Sendable {
    public var headers: [String]
    public var rows: [[String]]

    public init(headers: [String], rows: [[String]]) { /* private */ }

    public static func parse(_ text: String) -> CardCSV? { /* private */ }

    /// One line into fields, honouring quotes and doubled quotes.
    static func split(_ line: String, by separator: Character) -> [String] { /* private */ }
}

/// Which column holds what, saved per company (US-28). Columns are header names.
public nonisolated struct CardColumnMapping: Codable, Equatable, Sendable {
    public enum Field: String, Codable, CaseIterable, Sendable {
        case date, time, plate, product, quantity, unitPrice, gross, vat, station, transaction

        public var isRequired: Bool { /* private */ }
    }

    public var columns: [Field: String]

    public init(columns: [Field: String] = [:]) { /* private */ }

    public var isComplete: Bool { /* private */ }

    /// The common German cards' headers (DKV, UTA, Shell, Aral, Total, esso), matched by the
    /// words they use, so most files map themselves.
    static let hints: [Field: [String]]

    /// A mapping guessed from the headers: each field takes the first header that names it.
    public static func guess(_ headers: [String]) -> CardColumnMapping { /* private */ }
}

/// What importing one row would do, shown before anything is written.
public nonisolated enum ImportOutcome: Equatable, Sendable {
    /// A new card fill-up.
    case new
    /// The driver already logged it with a receipt: same car, within 30 minutes and 1 €.
    case matchesReceipt(UUID)
    /// Imported before, or already there from the card feed.
    case duplicate
    case unknownPlate(String)
    /// AdBlue, a car wash, the shop: not fuel or charging.
    case notFuel(String)
    case unreadable(String)

    public var isImported: Bool { /* private */ }
}

public nonisolated struct ImportLine: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let row: Int
    public let outcome: ImportOutcome
    public let date: Date?
    public let plate: String
    public let vehicleID: UUID?
    public let memberID: UUID?
    public let fuel: FuelType?
    public let quantity: Double
    public let unitPriceMilli: Int?
    public let grossCents: Int
    public let vatCents: Int?
    public let station: String
}

/// Turns a card file into fill-ups (US-28): rows matched to cars by plate and to the car's
/// driver at that moment, receipts already logged and earlier imports recognised, nothing
/// written until the preview is confirmed.
public nonisolated enum CardImport {
    public static func preview(
        _ csv: CardCSV,
        mapping: CardColumnMapping,
        company: UUID,
        vehicles: [Vehicle],
        assignments: [Assignment],
        existing: [FillUp]
    ) -> [ImportLine] { /* private */ }

    /// The fill-up a new line becomes; the importing person stands in when nobody had the car.
    public static func fillUp(for line: ImportLine, company: UUID, importer: UUID) -> FillUp? { /* private */ }

    /// The same row always gets the same ID, so a file imported twice, or on two devices,
    /// lands once: the server refuses the second insert of an ID.
    static func importID(company: UUID, plate: String, date: Date?, grossCents: Int, transaction: String) -> UUID { /* private */ }

    /// "1.234,56", "1234.56", "45,20 l" or "97,59 €".
    static func parseNumber(_ text: String) -> Double? { /* private */ }

    /// "03.10.2026", "2026-10-03", "03.10.26" with "07:40" or "07:40:12", in Berlin time.
    static func parseDate(_ date: String, time: String) -> Date? { /* private */ }

    /// The fuel a card's product text names, checked against the car; nil for AdBlue, a car
    /// wash or the shop.
    static func fuelType(_ product: String, vehicle: Vehicle?) -> FuelType? { /* private */ }

    /// Lowercase, without accents, letters and digits only, for matching headers and products.
    static func fold(_ text: String) -> String { /* private */ }
}
