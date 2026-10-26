// Source code is private. This file shows only its types and signatures.

import Foundation

/// Values read from a fuel or charging receipt. Anything the parser couldn't
/// find stays nil so the form can ask the user to check it.
public nonisolated struct ParsedReceipt: Equatable, Sendable {
    public var amount: Double?
    public var pricePerUnit: Double?
    public var total: Double?
    public var date: Date?
    public var fuel: FuelType?
    /// A discount on the receipt (Payback, coupon), as a positive number. `total` is then
    /// what was paid: amount × price − discount.
    public var discount: Double?
    /// Fields calculated from the other two instead of read, e.g. because the OCR misread
    /// the total. The form asks the user to check these.
    public var computedFields: Set<FuelMath.Field>

    /// Fields that were neither read nor computable from the other two.
    public var missingFields: Set<FuelMath.Field> { /* private */ }

    /// True when amount × price (minus any discount) matches the total within a few cents.
    public var isConsistent: Bool { /* private */ }

    public init(
        amount: Double? = nil,
        pricePerUnit: Double? = nil,
        total: Double? = nil,
        date: Date? = nil,
        fuel: FuelType? = nil,
        discount: Double? = nil,
        computedFields: Set<FuelMath.Field> = []
    ) { /* private */ }
}

/// Parses OCR rows from German fuel and charging receipts.
///
/// Receipts differ a lot ("45,03 l x 1,799 EUR/l", "Menge 31,12 Ltr / Preis/Ltr 1,829 €",
/// "Energie 38,560 kWh / Preis/kWh 0,59 €"), and OCR adds its own mistakes ("45,03 |",
/// "€/1"). So instead of one pattern per field, the parser collects every plausible
/// amount, price and total with a confidence score, then picks the combination where
/// amount × price = total. That also ignores shop items such as AdBlue, whose price
/// is in SUMME but not in the fuel line.
public nonisolated enum ReceiptParser {
    public static func parse(_ text: String, calendar: Calendar = .current) -> ParsedReceipt { /* private */ }

    public static func parse(lines: [String], calendar: Calendar = .current) -> ParsedReceipt { /* private */ }

    /// Parses German ("1.234,56") and plain ("1234.56") numbers.
    public static func number(_ string: String) -> Double? { /* private */ }

    // MARK: Normalising OCR text

    /// Fixes the OCR mistakes seen on receipts, e.g. "45,03 | x" → "45,03 l x",
    /// "€/1" → "€/l", "1, 799" → "1,799", "kVVh" → "kWh".
    public static func normalize(_ row: String) -> String { /* private */ }

    // MARK: Choosing

    /// The best amount, price and total. A consistent triple (amount × price ≈ total)
    /// always beats an inconsistent one; otherwise the strongest pair fills in the third.
    public static func solve(
        _ candidates: [Candidate],
        isCharging: Bool
    ) -> (amount: Double?, price: Double?, total: Double?, computed: Set<FuelMath.Field>) { /* private */ }

    /// "Rabatt Payback -0,90", "Coupon 1,00-" → 0.90 / 1.00.
    private static let discountWords

    private static func discount(in rows: [String]) -> Double? { /* private */ }

    // MARK: Date and fuel

    /// "06.10.2026", "06.10.26", "2026-10-06", "06/10/2026".
    private static func date(in rows: [String], calendar: Calendar) -> Date? { /* private */ }

    private static func makeDate(_ year: Int?, _ month: Int?, _ day: Int?, _ calendar: Calendar) -> Date? { /* private */ }

    /// Fuel from the product name. Premium petrol (Super Plus, V-Power, Ultimate 102) counts as E5.
    private static func fuel(in text: String) -> FuelType? { /* private */ }
}
