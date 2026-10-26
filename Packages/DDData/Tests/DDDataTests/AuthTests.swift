// Source code is private. This file shows only its types and signatures.

import Auth
import Foundation
import SwiftData
import Testing
@testable import DDData

/// Supabase Auth without the network: records the calls and replays account changes.
nonisolated final class FakeAuthProvider: AuthProvider, @unchecked Sendable {
    private let lock
    private var continuation: AsyncStream<AuthUser?>.Continuation?
    private var stream: AsyncStream<AuthUser?>
    private(set) var calls: [String]
    var failure: (any Error)?

    init(stored: AuthUser?) { /* private */ }

    func emit(_ user: AuthUser?) { /* private */ }

    private func record(_ call: String) throws { /* private */ }

    func accounts() -> AsyncStream<AuthUser?> { /* private */ }
    func sendEmailLink(to email: String, redirectTo: URL) async throws { /* private */ }
    func verify(email: String, code: String) async throws { /* private */ }
    func signIn(from url: URL) async throws { /* private */ }
    func signInWithApple(idToken: String, nonce: String) async throws { /* private */ }
    func signOut() async throws { /* private */ }
}

@Suite("Signing in and out")
struct AuthServiceTests {
    let store: LocalStore
    let sessions
    let defaults: UserDefaults
    let lena

    init() throws { /* private */ }

    private func service(_ provider: FakeAuthProvider, apple: Bool = false) -> AuthService { /* private */ }

    /// Lets the service's listener read what the provider emitted.
    private func settle(_ service: AuthService, until expected: AuthService.State) async { /* private */ }

    @Test("The session kept from the last launch signs in again at once")
    func restores() async { /* private */ }

    @Test("Without a kept session the app starts signed out")
    func signedOut() async { /* private */ }

    @Test("The email link goes to the normalised address and back to the app")
    func emailLink() async throws { /* private */ }

    @Test("A mistyped address is caught before any link goes out", arguments: ["", "lena", "lena@", "@huber.de", "lena@huber", "le na@huber.de"])
    func invalidEmail(address: String) async { /* private */ }

    @Test("The six-digit code may be typed with spaces; anything else is refused")
    func code() async throws { /* private */ }

    @Test("Only the email link's redirect finishes signing in; other links are left to the router")
    func callback() async throws { /* private */ }

    @Test("Sign in with Apple shows only when the build is entitled and the server allows it")
    func apple() async throws { /* private */ }

    @Test("Signing out wipes the local rows and the keychain, even offline")
    func signOutWipes() async throws { /* private */ }

    @Test("A session ended on the server (revoked, expired refresh) wipes too")
    func revoked() async throws { /* private */ }

    @Test("Another account never sees the rows the last one left on this device")
    func otherAccount() async throws { /* private */ }

    @Test("Network and Supabase errors read as one line the screen can show")
    func errors() throws { /* private */ }

    @Test("Apple's nonce: random, URL-safe, and sent as its SHA-256")
    func nonce() { /* private */ }
}

@Suite("Wiping the local store")
struct WipeTests {
    @Test("Signing out deletes the store's files and leaves an empty store behind")
    func wipeAll() throws { /* private */ }

    @Test("Removed from one company: only that company's rows go")
    func wipeCompany() throws { /* private */ }
}

@Suite("Session in the keychain", .enabled(if: KeychainProbe.available))
struct KeychainStoreTests {
    let keychain

    @Test("Stores, replaces, reads and removes; removing everything empties the service")
    func roundTrip() throws { /* private */ }
}

/// Some CI machines have no unlocked keychain; the keychain test runs where one exists.
nonisolated enum KeychainProbe {
    static let available: Bool
}
