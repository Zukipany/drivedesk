// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Cars and people")
struct RegisterTests {
    private func member(_ role: MemberRole, id: UUID = .v7(), active: Bool = true) -> Member { /* private */ }

    @Test("The owner manages anyone; a manager other drivers; nobody demotes the last owner")
    func permissions() { /* private */ }

    @Test("A handover ends the car's assignment and the driver's other company car at one moment")
    func handover() throws { /* private */ }

    @Test("A new car needs a plate no car in service has, a fuel, a group and a real VIN")
    func draftProblems() { /* private */ }

    @Test("A draft writes a clean car: plate in capitals, no tank on an EV, no lease end on an owned car")
    func draftApplies() throws { /* private */ }

    @Test("Invitation addresses are trimmed and lowercased; anything else is refused")
    func emails() { /* private */ }

    @Test("The server's answer to an invitation, in camel or snake case")
    func sentInvitation() throws { /* private */ }

    @Test("Local invitations refuse a second one to the same address and can be taken back")
    func localInvitations() async throws { /* private */ }

    @Test("An audit row: changed fields with before and after, bookkeeping left out")
    func auditEntry() throws { /* private */ }

    @Test("The demo's audit log shows what was changed on the device")
    @MainActor
    func localAudit() async throws { /* private */ }
}
