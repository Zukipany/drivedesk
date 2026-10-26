// Source code is private. This file shows only its types and signatures.

import DDData
import DDDesignSystem
import SwiftUI

/// Sign in with an email link (US-11): the link opens the app on this device; the six-digit
/// code in the same email signs in another one, such as the Mac.
struct SignInView: View {
    @Environment(AppSession.self) private var session
    @State private var email
    @State private var code
    @State private var sentTo: String?
    @State private var isWorking
    @State private var error: SignInError?
    @FocusState private var focus: Field?

    private enum Field { case email, code }

    var body: some View { /* private */ }

    private var emailForm: some View { /* private */ }

    private func codeForm(_ address: String) -> some View { /* private */ }

    private func sendLink() { /* private */ }

    private func verify() { /* private */ }

    private func run(_ work: @escaping () async throws(SignInError) -> Void) { /* private */ }
}
