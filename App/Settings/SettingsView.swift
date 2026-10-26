// Source code is private. This file shows only its types and signatures.

import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The account and the company: who is signed in, the role, switching companies, and
/// signing out (which wipes this device's copy of the company's data).
struct SettingsView: View {
    @Environment(AppSession.self) private var session
    @Query private var memberships: [Member]
    @Query(sort: \Company.name) private var companies: [Company]
    let member: Member
    let user: AuthUser

    @State private var confirmsSignOut

    init(member: Member, user: AuthUser) { /* private */ }

    private func name(of company: UUID) -> String { /* private */ }

    private var version: String { /* private */ }

    var body: some View { /* private */ }
}
