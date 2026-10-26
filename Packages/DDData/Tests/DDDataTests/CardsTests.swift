// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDData

@Suite("DriveDesk Card")
struct CardsTests {
    private let now

    private func card(_ member: UUID = Demo.lena, vehicle: UUID? = Demo.caddy, status: CardStatus = .active) -> CompanyCard { /* private */ }

    @Test("A card row: its limits, places and state, never more than the last four digits")
    func decode() throws { /* private */ }

    @Test("Limits: one at least, each within 5,000 €, a payment within the day, the day within the month")
    func limits() { /* private */ }

    @Test("Suggested limits fit the car: a full tank at a high price, rounded up to 10 €")
    func suggested() { /* private */ }

    @Test("The balance lasts as long as the last 30 days' pace says, and five days of it is the level")
    func forecast() { /* private */ }

    @Test("A driver freezes their own card; unfreezing and cancelling are the desk's")
    func freezing() async throws { /* private */ }

    @Test("A driver sees only their own card and no balance")
    func driverSees() async throws { /* private */ }

    @Test("A driver asks once; a manager issues the card and the request is approved with it")
    func requests() async throws { /* private */ }

    @Test("A frozen card or an empty balance doesn't pay")
    func paying() async throws { /* private */ }
}
