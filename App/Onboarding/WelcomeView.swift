// Source code is private. This file shows only its types and signatures.

import AuthenticationServices
import DDData
import DDDesignSystem
import SwiftUI

/// First launch (section 10): three short pages, Pay, Save, Stay compliant, then Sign in
/// with Apple or an email link.
struct WelcomeView: View {
    @Environment(AppSession.self) private var session
    @State private var page
    @State private var signsInWithEmail
    @State private var exploresDemo

    var body: some View { /* private */ }

    @ViewBuilder private var pages: some View { /* private */ }
}

enum WelcomePage: CaseIterable, Identifiable {
    case pay, save, comply

    var id: Self { /* private */ }

    var symbol: String { /* private */ }

    var title: LocalizedStringKey { /* private */ }

    var message: LocalizedStringKey { /* private */ }
}

private struct WelcomePageView: View {
    let page: WelcomePage

    var body: some View { /* private */ }
}

/// Sign in with Apple, shown only when the build carries the entitlement and the server
/// offers the provider (`AuthService.offersApple`).
struct AppleSignInButton: View {
    @Environment(AppSession.self) private var session
    @Environment(\.colorScheme) private var colorScheme
    @State private var nonce
    @State private var error: SignInError?

    var body: some View { /* private */ }
}
