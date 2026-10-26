// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData
import Testing
@testable import DDData

/// Against `supabase start` and the seeded demo company, not the fake. Opt in with
/// `DRIVEDESK_LOCAL_SUPABASE=1 swift test --package-path Packages/DDData` after
/// `supabase db reset`; skipped otherwise, and in CI.
nonisolated enum LocalSupabase {
    static let enabled
    static let mailpit

    /// Signs a seeded person in with the six-digit code from their sign-in email.
    static func signIn(_ email: String, backend: Backend) async throws { /* private */ }

    static func clearMail(for email: String) async throws { /* private */ }

    /// The code from the newest sign-in email to `email` (supabase/templates/magic_link.html).
    static func code(for email: String) async throws -> String { /* private */ }

    private static func search(_ email: String) -> URL { /* private */ }

    private struct Messages: Decodable {
        struct Summary: Decodable { var ID: String }
        var messages: [Summary]
    }

    private struct Message: Decodable { var Text: String }
}

@Suite("Local Supabase: sign-in", .enabled(if: LocalSupabase.enabled), .serialized)
struct LocalSignInTests {
    @Test("An email code signs Lena in, and the session survives a restart until she signs out")
    func emailCode() async throws { /* private */ }

    @Test("The server offers the email link; Sign in with Apple waits for the paid programme")
    func settings() async throws { /* private */ }
}

@Suite("Local Supabase: sync", .enabled(if: LocalSupabase.enabled), .serialized)
struct LocalSyncTests {
    private func signedIn(_ email: String) async throws -> (Backend, LocalStore, SyncEngine) { /* private */ }

    @Test("Lena's phone pulls only what row-level security lets her see")
    func driverPull() async throws { /* private */ }

    @Test("A fill-up logged offline reaches Postgres once, and a later edit lands on its version")
    func upload() async throws { /* private */ }
}

/// A server out of reach: every call fails as with no network.
nonisolated struct OfflineServer: SyncServer {
    func insert(_ row: Row, into table: String) async throws(SyncFailure) -> Row { /* private */ }
    func update(_ columns: Row, id: UUID, expectedVersion: Int, in table: String) async throws(SyncFailure) -> Row? { /* private */ }
    func fetch(id: UUID, from table: String) async throws(SyncFailure) -> Row? { /* private */ }
    func page(of table: String, after cursor: PullCursor?, limit: Int) async throws(SyncFailure) -> [Row] { /* private */ }
}
