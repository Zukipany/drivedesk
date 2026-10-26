// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDData

@Suite("1 % rule against the logbook")
struct BenefitTests {
    private func trips(business: Double, commuteDays: Int, commuteKm: Double, personal: Double) -> [CorrectedTrip] { /* private */ }

    private let fixed

    @Test("The plan's worked example: 696 € with the 1 % rule, about 243 € with the logbook")
    func workedExample() { /* private */ }

    @Test("Electric cars count a quarter of the list price up to the cap, half above; plug-in hybrids half")
    func electric() { /* private */ }

    @Test("Without the year's fixed costs or enough kilometres the logbook side stays open")
    func missing() { /* private */ }

    @Test("Part of a year counts the fixed costs' share for the months so far")
    func partYear() { /* private */ }
}
