// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Cost per car and use")
struct CarCostsTests {
    private let october

    @Test("Fuel, charging and booked costs add up per car; the distance runs from the last reading before")
    func lines() throws { /* private */ }

    @Test("Days used count the days a car was with someone; the peak counts cars out at once, not handovers")
    func use() { /* private */ }

    @Test("Periods in Berlin time; last month ends where this one starts")
    func periods() { /* private */ }

    @Test("The cost CSV for German Excel, text kept from running as a formula")
    func csv() { /* private */ }
}
