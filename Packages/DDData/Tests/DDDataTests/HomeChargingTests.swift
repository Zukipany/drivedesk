// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDData

@Suite("Home-charging claims")
struct HomeChargingTests {
    @Test("The plan's October example: 312 kWh are 106.08 € at 34 ct and 104.40 € at actual cost")
    func pricing() { /* private */ }

    @Test("kWh must fit the kilometres driven and the battery")
    func plausibility() { /* private */ }

    @Test("From the 1st of a month the month before is due")
    func dueMonth() { /* private */ }

    @Test("A claim row goes up without the server's price and comes back with it")
    func row() throws { /* private */ }
}
