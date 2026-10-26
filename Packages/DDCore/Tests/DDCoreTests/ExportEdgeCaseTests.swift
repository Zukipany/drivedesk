// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

@Suite("Export edge cases")
struct ExportEdgeCaseTests {
    private func export(station: String?, carName: String = "Golf") -> FillUpExport { /* private */ }

    @Test("A station name a spreadsheet would run as a formula stays text")
    func formulaInjection() { /* private */ }

    @Test("Separators, quotes and line breaks in a name are quoted")
    func quoting() { /* private */ }

    @Test("File names keep umlauts readable and never end up empty")
    func fileNames() { /* private */ }
}
