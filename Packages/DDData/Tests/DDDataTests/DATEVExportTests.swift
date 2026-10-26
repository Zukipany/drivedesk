// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("DATEV booking batch")
struct DATEVExportTests {
    private let october

    private func export(_ bookings: [DATEVExport.Booking], chart: DATEVSettings.Chart = .skr03) -> DATEVExport { /* private */ }

    @Test("The EXTF header names the batch, the numbers, the fiscal year and the month")
    func header() { /* private */ }

    @Test("One booking per fill-up: vehicle costs against Geldtransit, VAT key only with a receipt, KOST1")
    func rows() { /* private */ }

    @Test("Bookings from fill-ups: deleted ones out, the group's cost centre when the fill-up has none")
    func fromFillUps() { /* private */ }

    @Test("Windows-1252 for DATEV, and the usual file name")
    func encoding() { /* private */ }
}
