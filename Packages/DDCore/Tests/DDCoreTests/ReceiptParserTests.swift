// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

@Suite("Receipt parser")
struct ReceiptParserTests {
    @Test("Petrol receipt from the plan")
    func petrolReceipt() { /* private */ }

    @Test("Full receipt as OCR lines, with date and a net amount that must not win")
    func realisticLines() throws { /* private */ }

    @Test("DC charging receipt")
    func chargingReceipt() { /* private */ }

    @Test("Missing total is computed from amount and price")
    func computesTotal() { /* private */ }

    @Test("Unreadable receipt leaves fields empty for the user to check")
    func unreadable() { /* private */ }

    @Test(
        "German and plain number formats",
        arguments: [
            ("1,749", 1.749), ("1.234,56", 1234.56), ("90,95", 90.95), ("1.749", 1.749), (" 52,00 ", 52.0)
        ]
    )
    func numbers(input: String, expected: Double) { /* private */ }
}
