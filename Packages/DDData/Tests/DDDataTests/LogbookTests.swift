// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Logbook trips")
struct LogbookTests {
    private func trip(_ day: Int, km: Double, hour: Int = 8, type: TripType = .unclassified, end: Int? = nil) -> LogbookTrip { /* private */ }

    private func fillUp(_ day: Int, odometer: Int?, hour: Int = 18) -> FillUp { /* private */ }

    @Test("A gap above 2 % and 5 km between two readings is a task; small ones aren't")
    func gaps() { /* private */ }

    @Test("Readings before the logbook started aren't gaps")
    func beforeTheLogbook() { /* private */ }

    @Test("A new trip starts at the later of the last trip's end and the last reading")
    func odometer() { /* private */ }

    @Test("A recorded trip rounds to 100 m and carries the odometer on")
    func recorded() { /* private */ }

    @Test("A private trip forgets its places; a business trip needs purpose and partner")
    func classify() { /* private */ }

    @Test("A trip row goes up and comes back the same")
    func row() throws { /* private */ }
}
