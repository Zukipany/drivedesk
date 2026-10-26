// Source code is private. This file shows only its types and signatures.

import CryptoKit
import Foundation
import Supabase

/// The signed-in account (`auth.users`): one person, who may belong to several companies.
public nonisolated struct AuthUser: Equatable, Sendable {
    public var id: UUID
    public var email: String?

    public init(id: UUID, email: String?) { /* private */ }
}

/// Why signing in didn't work, in one line the sign-in screen can show (section 11: what
/// failed and a way to retry; details go to the crash report).
public nonisolated enum SignInError: Error, Equatable, Sendable {
    case invalidEmail
    case offline
    case tooManyRequests
    case invalidCode
    case appleUnavailable
    case failed(String)

    public var message: String { /* private */ }
}

/// The sign-in calls the app makes. The live one talks to Supabase Auth; tests use a fake.
public protocol AuthProvider: Sendable {
    /// The signed-in account now and after every change; nil when signed out. The first
    /// value is the session kept from the last launch.
    func accounts() -> AsyncStream<AuthUser?>
    func sendEmailLink(to email: String, redirectTo: URL) async throws
    func verify(email: String, code: String) async throws
    /// Finishes signing in from the email link's redirect.
    func signIn(from url: URL) async throws
    func signInWithApple(idToken: String, nonce: String) async throws
    /// Ends this device's session on the server and removes it from the session store.
    func signOut() async throws
}

/// Supabase Auth, through the app's `Backend`.
public nonisolated struct SupabaseAuthProvider: AuthProvider {
    let auth: AuthClient

    public init(backend: Backend) { /* private */ }

    public func accounts() -> AsyncStream<AuthUser?> { /* private */ }

    public func sendEmailLink(to email: String, redirectTo: URL) async throws { /* private */ }

    public func verify(email: String, code: String) async throws { /* private */ }

    public func signIn(from url: URL) async throws { /* private */ }

    public func signInWithApple(idToken: String, nonce: String) async throws { /* private */ }

    public func signOut() async throws { /* private */ }
}

/// Sign in with Apple's nonce: the request carries its SHA-256, Supabase checks the raw one
/// against the identity token, so a stolen token can't be replayed.
public nonisolated enum AppleSignInNonce {
    private static let characters

    public static func make(length: Int = 32) -> String { /* private */ }

    public static func sha256(_ nonce: String) -> String { /* private */ }
}

extension SignInError {
    /// Maps what the network or Supabase Auth threw to what the sign-in screen says.
    nonisolated static let offlineCodes: Set<URLError.Code>

    nonisolated init(_ error: any Error) { /* private */ }
}
