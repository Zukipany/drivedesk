// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

/// Replays real OCR output (text boxes from `RecognizeDocumentsRequest` on 105 receipt
/// images: 15 layouts, clean, tilted, blurred, faded and noisy) through row rebuilding
/// and the parser. Regenerate with tools/receipt-bench/run.sh, then copy
/// receipt-ocr-fixtures.json into iDriveTests/Fixtures.
@Suite("Receipt OCR replay")
struct ReceiptOCRReplayTests {
    nonisolated private final class BundleToken {}

    nonisolated static let fixtures: [String: ReceiptFixture]

    @Test("Fixtures are bundled")
    func fixturesLoad() { /* private */ }

    @Test("Every receipt reads correctly from real OCR boxes", arguments: fixtures.keys.sorted())
    func receipt(name: String) throws { /* private */ }

    /// Regression: the document OCR returns columns one after another, which separated
    /// every label from its value ("Energie", "Preis/kWh", … then "38,560 kWh", "0,59 €", …).
    @Test("Columns are put back into rows")
    func columnsBecomeRows() throws { /* private */ }

    @Test("A 4.5° tilted photo still gives one row per printed line")
    func tilt() throws { /* private */ }
}

@Suite("Receipt parser rules")
struct ReceiptParserRuleTests {
    @Test(
        "OCR misreads are repaired",
        arguments: [
            ("45,03 | x 1,799 EUR/L", "45,03 l x 1,799 EUR/L"),
            ("40,00 | * 1,659 €/1 = 66,36 €", "40,00 l * 1,659 €/l = 66,36 €"),
            ("Preis 1, 799 EUR", "Preis 1,799 EUR"),
            ("Energie 12,5 kVVh", "Energie 12,5 kWh")
        ]
    )
    func normalize(raw: String, fixed: String) { /* private */ }

    @Test("AdBlue in SUMME: the fuel line's own total wins because it multiplies out")
    func shopItemIgnored() { /* private */ }

    @Test("Payback discount: the total is what was paid, and it still counts as consistent")
    func discount() { /* private */ }

    /// Regression: OCR read 77,30 as 17,30. The labelled amount and price win and the
    /// total is marked as calculated, so the form asks the user to check it.
    @Test("A misread total is replaced and flagged")
    func misreadTotal() { /* private */ }

    @Test("Three unlabelled numbers that multiply out are read as amount, price, total")
    func selfCheckingRow() { /* private */ }

    @Test(
        "Date formats",
        arguments: [
            ("2026-10-03 21:30", 3), ("Datum: 06.10.26", 6), ("06/10/2026", 6)
        ]
    )
    func dates(row: String, day: Int) { /* private */ }
}

/// One bench image's OCR output and ground truth, replayed by the unit tests. Written by the
/// receipt bench (DDDevice's ReceiptBenchTests, tools/receipt-bench/run.sh).
nonisolated struct ReceiptFixture: Codable {
    let aspectRatio: Double
    let fragments: [ReceiptLayout.Fragment]
    let amount: Double
    let price: Double
    let total: Double
    let fuel: String
    let date: String
}
