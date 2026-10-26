// Source code is private. This file shows only its types and signatures.

import Foundation
import Supabase

/// The one Supabase client the app uses, set up for DriveDesk: the session in the keychain,
/// the PKCE flow for the email link, and the app version on every request.
public nonisolated final class Backend: Sendable {
    public let configuration: BackendConfiguration
    public let client: SupabaseClient
    /// Where the session lives; signing out empties it.
    public let sessionStore: any AuthLocalStorage

    public init(configuration: BackendConfiguration, sessionStore: any AuthLocalStorage = KeychainStore()) { /* private */ }

    /// What the server offers for signing in (`GET /auth/v1/settings`); nil when it can't be
    /// reached.
    public func authSettings() async -> AuthSettings? { /* private */ }
}

/// The sign-in methods the server has turned on.
public nonisolated struct AuthSettings: Decodable, Equatable, Sendable {
    public struct Providers: Decodable, Equatable, Sendable {
        public var apple: Bool
        public var email: Bool
    }

    public var external: Providers

    public init(apple: Bool, email: Bool) { /* private */ }
}
