// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Ledger")
struct LedgerTests {
    private let october
    private let berlinGroup

    private var entries: [FillUp] { /* private */ }

    @Test("Each filter narrows the ledger; deleted entries never show")
    func filters() { /* private */ }

    private func line(station: String, note: String = "") -> LedgerExport.Line { /* private */ }

    @Test("German CSV: semicolons, decimal commas, Berlin times")
    func germanCSV() { /* private */ }

    @Test("Text a spreadsheet would run as a formula stays text; separators and quotes are quoted")
    func injection() { /* private */ }

    @Test("A comma file for locales with a decimal point, and a safe file name")
    func englishCSV() { /* private */ }
}
