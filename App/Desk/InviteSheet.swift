// Source code is private. This file shows only its types and signatures.

import DDData
import DDDesignSystem
import SwiftUI

/// Inviting someone (plan M6): their email and role. The server sends the link, which works
/// once, for this address, for 14 days; a manager invites drivers only.
struct InviteSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var email
    @State private var role
    @State private var sending
    @State private var sent: SentInvitation?
    @State private var error: String?
    @FocusState private var focused: Bool

    let member: Member

    private var roles: [MemberRole] { /* private */ }
    private var isValid: Bool { /* private */ }

    var body: some View { /* private */ }

    private var roleNote: String { /* private */ }

    private func send() { /* private */ }
}
