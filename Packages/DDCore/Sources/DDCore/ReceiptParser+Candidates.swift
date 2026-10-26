// Source code is private. This file shows only its types and signatures.

import Foundation

/// The values a receipt's rows could be: amounts, prices and totals, each with a score for
/// how certain the row makes it. `ReceiptParser.solve` picks the most consistent set.
nonisolated extension ReceiptParser {
    public enum Kind { case amount, price, total }

    public struct Candidate: Equatable {
        public let kind: Kind
        public let value: Double
        /// Higher is more certain.
        public let score: Int

        public init(
            kind: Kind,
            value: Double,
            score: Int
        ) { /* private */ }
    }

    private struct Token {
        let value: Double
        let decimals: Int
        let before: String
        let after: String
    }

    /// Decimal numbers in a row with the text around them (lowercased).
    private static func tokens(in row: String) -> [Token] { /* private */ }

    /// Rows that describe shop items, not the fuel ("AdBlue 10L Kanister 14,99").
    private static let shopWords
    private static let amountWords
    private static let priceWords
    /// Total keywords and how much they're trusted. "Netto", VAT and change lines never count.
    private static let totalWords: [(String, Int)]
    private static let notTotalWords
    private static let paymentWords

    public static func collectCandidates(_ rows: [String], isCharging: Bool) -> [Candidate] { /* private */ }

    /// Amounts and prices marked by their unit: "45,03 l", "52,48 LTR", "38,560 kWh",
    /// "1,799 EUR/l", "0,59 €/kWh", "x 1,859 EUR", "zu je 1,859", "à 0,69".
    private static func unitCandidates(_ tokens: [Token]) -> [Candidate] { /* private */ }

    /// Cent prices: "59 ct/kWh".
    private static func centPrices(_ tokens: [Token]) -> [Candidate] { /* private */ }

    /// "= 66,36": the line total of "amount × price = total".
    private static func lineTotals(_ tokens: [Token]) -> [Candidate] { /* private */ }

    /// Label before the value: "Liter: 29,84", "EUR/Liter: 1,939", "kWh 18,40".
    private static func labelledCandidates(_ tokens: [Token]) -> [Candidate] { /* private */ }

    /// Three unlabelled numbers that multiply out ("Super E10  33,07  1,779  58,83"): the row
    /// checks itself, so it's strong evidence whatever the labels say.
    private static func selfCheckingCandidates(_ tokens: [Token], isCharging: Bool) -> [Candidate] { /* private */ }

    /// Keyword rows: "Menge 31,12", "Preis/Ltr 1,829 €".
    private static func keywordCandidates(_ lower: String, _ tokens: [Token]) -> [Candidate] { /* private */ }

    /// "SUMME 81,01 EUR", a total label with its value on the next row, or the card payment.
    private static func totalCandidates(_ lower: String, _ tokens: [Token], next: String?) -> [Candidate] { /* private */ }

    /// The fuel line's own total, often printed after the price or on the next row ("81,01 EUR A").
    private static func fuelLineTotals(_ rows: [String], fuelRow: Int) -> [Candidate] { /* private */ }

    /// Ranges that rule out IDs, VAT rates and the like.
    public static func isPlausible(_ candidate: Candidate, isCharging: Bool) -> Bool { /* private */ }
}
