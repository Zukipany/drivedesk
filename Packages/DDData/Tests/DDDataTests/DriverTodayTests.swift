// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDData

@Suite("Today for a driver")
struct DriverTodayTests {
    private let now

    private func assignment(_ kind: AssignmentKind, vehicle: UUID = Demo.caddy, from: Date, to: Date? = nil) -> Assignment { /* private */ }

    private func budget(_ scope: BudgetScope, month: Int = 10, member: UUID? = nil, vehicle: UUID? = nil, euros: Int) -> Budget { /* private */ }

    @Test("The car is the current permanent assignment; an ended or future one doesn't count")
    func currentCar() { /* private */ }

    @Test("A permanent car wins over a pool car; without one, the latest pool car")
    func poolCars() { /* private */ }

    @Test("The driver's own budget comes first, then the car's; group, company and other months don't show")
    func whichBudget() { /* private */ }

    @Test("Spent counts the month's fill-ups in the budget's scope, from Berlin midnight, without deleted ones")
    func spent() { /* private */ }

    @Test("Recent shows the driver's last three, newest first, without deleted ones")
    func recent() { /* private */ }
}
