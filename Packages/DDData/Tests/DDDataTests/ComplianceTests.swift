// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDData

@Suite("Licence checks")
struct ComplianceTests {
    private func day(_ year: Int, _ month: Int, _ day: Int) -> Date { /* private */ }

    private func check(_ on: Date, _ result: LicenceCheckResult = .valid, expires: Date? = nil) -> LicenceCheck { /* private */ }

    @Test("The next check is due six months after the last valid one")
    func due() { /* private */ }

    @Test("An invalid check doesn't count; the card's own expiry comes first")
    func expiry() { /* private */ }

    @Test("Never checked: due since joining, and the letter is offered")
    func never() { /* private */ }

    @Test("A check row goes up and comes back the same")
    func row() throws { /* private */ }
}

@Suite("UVV inspections")
struct UVVTests {
    private func day(_ year: Int, _ month: Int, _ day: Int) -> Date { /* private */ }

    @Test("Due a year later, or with the service when it comes within the three months before")
    func nextDue() { /* private */ }

    @Test("A car's status comes from its open reminder, else the last inspection")
    func status() { /* private */ }
}
