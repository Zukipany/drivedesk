// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Fuel-card import")
struct CardImportTests {
    /// A month as a DKV-style export: semicolons, decimal commas, a quoted station with a semicolon.
    private let file

    private func lines(existing: [FillUp] = []) throws -> [ImportLine] { /* private */ }

    @Test("The file reads with quotes and semicolons, and the common German headers map themselves")
    func mapping() throws { /* private */ }

    @Test("New card fill-ups, the driver at the time, AdBlue and unknown plates left out")
    func preview() throws { /* private */ }

    @Test("A receipt already logged is matched; a second import of the file is refused")
    func duplicates() throws { /* private */ }

    @Test("Numbers and dates as the cards write them")
    func parsing() { /* private */ }
}
