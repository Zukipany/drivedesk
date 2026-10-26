// Source code is private. This file shows only its types and signatures.

import Foundation
import Observation

/// Who is signed in on this device, and the ways to sign in and out (US-11): Sign in with
/// Apple when the build and the server allow it, otherwise an email link with a six-digit
/// code for when the link opens on another device. The session survives a restart in the
/// keychain; signing out wipes the local store and every keychain item.
@Observable
public final class AuthService {
    public enum State: Equatable, Sendable {
        /// Reading the session kept from the last launch.
        case restoring
        case signedOut
        case signedIn(AuthUser)
    }

    public private(set) var state
    /// Shows the Apple button; false until the server confirms the provider is on.
    public private(set) var offersApple

    private let provider: any AuthProvider
    private let store: LocalStore
    private let wipeSessionStore: () throws -> Void
    private let defaults: UserDefaults
    private let redirectURL: URL
    private let appleSignInEntitled: Bool
    private var listener: Task<Void, Never>?

    /// The account whose rows the local store holds, so a different account never sees them.
    static let storeOwnerKey

    public init(
        provider: any AuthProvider,
        store: LocalStore,
        wipeSessionStore: @escaping () throws -> Void,
        redirectURL: URL = BackendConfiguration.authCallback,
        appleSignInEntitled: Bool = false,
        defaults: UserDefaults = .standard
    ) { /* private */ }

    public var user: AuthUser? { /* private */ }

    /// Starts following the session; call once at launch.
    public func start() { /* private */ }

    /// Whether Sign in with Apple can be offered: the build carries the entitlement and the
    /// server has the provider turned on.
    public func checkAppleSignIn(serverSettings: AuthSettings?) { /* private */ }

    public func sendEmailLink(to email: String) async throws(SignInError) { /* private */ }

    public func verify(email: String, code: String) async throws(SignInError) { /* private */ }

    /// Finishes signing in when the email link opens the app; false for any other link.
    public func handle(_ url: URL) async throws(SignInError) -> Bool { /* private */ }

    public func signInWithApple(idToken: String, nonce: String) async throws(SignInError) { /* private */ }

    /// Signs out on this device. The local rows and keychain items go even when the server
    /// can't be reached; the server session then simply expires.
    public func signOut() async { /* private */ }

    private func apply(_ account: AuthUser?) { /* private */ }

    private func wipeLocalData() { /* private */ }

    static func normalized(_ email: String) -> String { /* private */ }

    /// Good enough to catch a typo before a link goes out; the server checks the rest.
    static func isEmailAddress(_ text: String) -> Bool { /* private */ }
}
