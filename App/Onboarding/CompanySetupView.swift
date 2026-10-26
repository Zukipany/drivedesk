// Source code is private. This file shows only its types and signatures.

import DDData
import DDDesignSystem
import SwiftUI

/// Signed in without a company (section 10): create one and become its owner, or join with
/// an invitation (US-12).
struct CompanySetupView: View {
    @Environment(AppSession.self) private var session
    let email: String?
    @State private var choice: Choice?

    enum Choice: Hashable { case create, join }

    var body: some View { /* private */ }

    private var message: Text { /* private */ }
}

private struct ChoiceCard: View {
    let symbol: String
    let title: LocalizedStringKey
    let detail: LocalizedStringKey
    let action: () -> Void

    var body: some View { /* private */ }
}

/// The owner's first screen: the company's name, legal form and VAT ID, and their own
/// name. Address, fleet, team and fuel policy follow in the owner setup.
private struct CreateCompanyView: View {
    @Environment(AppSession.self) private var session
    @State private var company
    @State private var isWorking
    @State private var error: SetupError?

    private static let legalForms

    var body: some View { /* private */ }

    private func create() { /* private */ }
}

/// Joining with an invitation: the link from the email opens this screen filled in, or the
/// person pastes the link or the code. Someone already in a company gets it as a sheet.
struct JoinCompanyView: View {
    @Environment(AppSession.self) private var session
    @State private var invitation
    @State private var name
    @State private var isWorking
    @State private var error: String?

    var body: some View { /* private */ }

    private func join() { /* private */ }
}
