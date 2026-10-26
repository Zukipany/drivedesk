// Source code is private. This file shows only its types and signatures.

import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The first decision: who is signed in, and in which company. Signed out shows the welcome
/// pages; signed in without a company shows the company setup; otherwise the app.
struct RootView: View {
    @Environment(AppSession.self) private var session

    var body: some View { /* private */ }

    @ViewBuilder private var content: some View { /* private */ }

    @ViewBuilder private var signedInContent: some View { /* private */ }
}

/// The person's active memberships decide the rest.
private struct SignedInView: View {
    @Environment(AppSession.self) private var session
    @Query private var memberships: [Member]
    let user: AuthUser

    init(user: AuthUser) { /* private */ }

    /// The selected company's membership, or the first one.
    private var member: Member? { /* private */ }

    var body: some View { /* private */ }
}

/// While the kept session is read and the first pull runs: placeholders, never a spinner on
/// a blank screen (section 11).
struct LaunchView: View {
    var message: LocalizedStringKey?

    var body: some View { /* private */ }
}
