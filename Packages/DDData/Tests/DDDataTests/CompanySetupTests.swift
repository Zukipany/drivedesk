// Source code is private. This file shows only its types and signatures.

import CryptoKit
import Foundation
import Supabase
import SwiftData
import Testing
@testable import DDData

@Suite("Company setup")
struct CompanySetupTests {
    @Test(
        "An invitation pasted as the email's link, the app link or the code alone",
        arguments: [
            ("https://drivedesk.app/join/Qm9yZGVyLTEyMzQ1Njc4", "Qm9yZGVyLTEyMzQ1Njc4"),
            ("drivedesk://join/Qm9yZGVyLTEyMzQ1Njc4", "Qm9yZGVyLTEyMzQ1Njc4"),
            ("  Qm9yZGVyLTEyMzQ1Njc4\n", "Qm9yZGVyLTEyMzQ1Njc4"),
            ("https://drivedesk.app/join/abc_DEF-12345?utm=mail", "abc_DEF-12345"),
            ("drivedesk://invite?token=Qm9yZGVyLTEyMzQ1Njc4", "Qm9yZGVyLTEyMzQ1Njc4")
        ]
    )
    func tokens(text: String, token: String) { /* private */ }

    @Test(
        "Anything else is not an invitation",
        arguments: ["", "short", "https://drivedesk.app/today", "drivedesk://join/", "drivedesk://invite?token=short", "two words here"]
    )
    func notTokens(text: String) { /* private */ }

    @Test("What the owner typed is trimmed; an empty VAT ID or legal form is left out")
    func cleaned() { /* private */ }

    @Test("A nameless company never reaches the server")
    func missingName() async { /* private */ }

    @Test("The server's refusals in one line each")
    func failures() { /* private */ }
}

@Suite("Local Supabase: company setup", .enabled(if: LocalSupabase.enabled), .serialized)
struct LocalCompanySetupTests {
    private func newAccount() async throws -> (Backend, String) { /* private */ }

    private struct Membership {
        var id: UUID
        var companyID: UUID
        var role: MemberRole
        var displayName: String
    }

    /// The signed-in person's memberships after a pull, as plain values (the store ends here).
    private func memberships(_ backend: Backend) async throws -> [Membership] { /* private */ }

    @Test("Creating a company makes me its owner; an invitation link makes the invitee a driver")
    func createAndJoin() async throws { /* private */ }
}
