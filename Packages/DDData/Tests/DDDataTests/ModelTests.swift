// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData
import Testing
@testable import DDData

@Suite("Company cars")
struct VehicleTests {
    private func car(_ fuels: [FuelType], tank: Double? = 50, battery: Double? = nil) -> Vehicle { /* private */ }

    @Test("Fuels: the usual one first, and only of one kind, so petrol and diesel never mix")
    func fuels() { /* private */ }

    @Test("Battery-electric cars and plug-in hybrids are told apart by their fuel types")
    func electricKinds() { /* private */ }

    @Test("Energy types: fuels first, then the charging types the car takes")
    func energyTypes() { /* private */ }

    @Test("Capacity: litres for fuel, kWh for charging, nil when unknown")
    func capacity() { /* private */ }

    @Test("Pass details: subtitle, paint, body and the list price in euros")
    func passDetails() { /* private */ }
}

@Suite("Fill-ups")
struct FillUpTests {
    @Test("Money stays in cents and prices in milli-euro; the ported maths reads euros")
    func euros() { /* private */ }

    @Test("Without a unit price the price comes from the total; charges are their own kind")
    func charges() { /* private */ }

    @Test("A full tank reads as level 1; a partial fill without a level is unknown")
    func levels() { /* private */ }

    @Test("Consumption from stored fill-ups: full tank to full tank")
    func consumption() throws { /* private */ }
}

@Suite("Sync fields")
struct SyncFieldTests {
    @Test("A row made here starts pending at version 0; a pulled row is synced")
    func newRows() { /* private */ }

    @Test("Every table carries its company; a company is its own")
    func companies() { /* private */ }

    @Test("An unknown raw value reads as the safe default instead of failing")
    func unknownRawValues() { /* private */ }
}

@Suite("Roles and assignments")
struct RoleAndAssignmentTests {
    @Test(
        "Who drives and who opens the desk",
        arguments: [
            (MemberRole.driver, true, false),
            (.manager, true, true),
            (.owner, true, true),
            (.accountant, false, true)
        ]
    )
    func roles(role: MemberRole, drives: Bool, opensDesk: Bool) { /* private */ }

    @Test("An assignment is current from its start until its end")
    func current() { /* private */ }
}
