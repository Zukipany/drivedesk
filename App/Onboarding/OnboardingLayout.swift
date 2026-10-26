// Source code is private. This file shows only its types and signatures.

import DDDesignSystem
import SwiftUI

/// One onboarding screen: a symbol, a title, one sentence, then the controls, in a column
/// that stays readable on iPad and Mac.
struct OnboardingPage<Content: View>: View {
    let symbol: String
    let title: LocalizedStringKey
    let message: Text
    @ViewBuilder let content: Content

    var body: some View { /* private */ }
}

/// What failed, in one line, with its symbol so the colour isn't the only sign.
struct ErrorLine: View {
    let message: String

    var body: some View { /* private */ }
}

/// The one primary button of a screen: full width, a capsule, with a progress view while
/// its work runs.
struct PrimaryButton: View {
    let title: LocalizedStringKey
    var isWorking
    let action: () -> Void

    var body: some View { /* private */ }
}

extension View {
    /// An email address field: the right keyboard, no autocorrection or capitals.
    func emailAddressField() -> some View { /* private */ }

    /// The six-digit code from the sign-in email; iOS offers it from Mail.
    func oneTimeCodeField() -> some View { /* private */ }

    /// The rounded field style onboarding uses.
    func onboardingField() -> some View { /* private */ }
}
