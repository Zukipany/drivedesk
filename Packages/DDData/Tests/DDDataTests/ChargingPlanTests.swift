// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Company charging plans")
struct CompanyChargingPlanTests {
    @Test("A plan's rules go up as a JSON list and come back the same")
    func roundTrip() throws { /* private */ }

    @Test("A known subscription is priced as the app knows it today; switched-off plans don't count")
    func plans() { /* private */ }
}
