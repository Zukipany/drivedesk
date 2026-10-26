// Source code is private. This file shows only its types and signatures.

import Foundation

/// Where the backend is and who is asking: the Supabase project's URL and publishable key
/// (public by design; row-level security protects the data), and the app version every
/// request carries, so the server can answer 426 below the minimum it accepts (section 9).
public nonisolated struct BackendConfiguration: Equatable, Sendable {
    public var url: URL
    public var publishableKey: String
    public var appVersion: String
    /// Where the email link comes back to.
    public var redirectURL: URL
    /// The build carries the Sign in with Apple entitlement, which needs the paid Apple
    /// Developer Program (plan section 25, step 9). Until then only the email link shows.
    public var appleSignInEntitled: Bool

    public init(
        url: URL,
        publishableKey: String,
        appVersion: String,
        redirectURL: URL = BackendConfiguration.authCallback,
        appleSignInEntitled: Bool = false
    ) { /* private */ }

    /// The email link opens the app here; Supabase only redirects to URLs listed in
    /// `supabase/config.toml`.
    public static let authCallback

    /// `supabase start` on this Mac, with the CLI's default publishable key (the same on
    /// every machine). Previews and the opt-in integration tests use it.
    public static let localDevelopment

    /// Reads `SupabaseURL`, `SupabaseKey` and `DDSignInWithApple` from the Info.plist, which
    /// get them from Base.xcconfig (overridden by the ignored Config.xcconfig).
    public init?(bundle: Bundle) { /* private */ }
}
