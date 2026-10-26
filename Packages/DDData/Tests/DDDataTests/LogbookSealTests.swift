// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Logbook seal")
struct LogbookSealTests {
    private func trip(_ id: String, day: Int, hour: Int, km: Double, type: TripType = .business) -> LogbookTrip { /* private */ }

    @Test("The payload is the server's v1 format, field for field")
    func payload() { /* private */ }

    @Test("Trips are sealed 7 days after they end, in the order they started, one chain per car")
    func seal() { /* private */ }

    @Test("A changed sealed trip breaks the chain at that trip")
    func tampering() { /* private */ }

    @Test("Corrections show in the trip and in words; a correction to private hides the places")
    func corrections() { /* private */ }

    @Test("The CSV has one line per trip, the corrections inline and the chain's end")
    func csv() { /* private */ }
}
