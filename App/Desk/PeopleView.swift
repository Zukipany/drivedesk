// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The people of the company (plan M6): name, role, car, this month's spend and open flags,
/// with the invitations still waiting. The owner invites any role and changes anyone; a
/// manager invites and manages drivers. Each change reaches the audit log.
struct PeopleView: View {
    @Environment(AppSession.self) private var session
    @Query private var members: [Member]
    @Query private var vehicles: [Vehicle]
    @Query private var assignments: [Assignment]
    @Query private var groups: [FleetGroup]
    @State private var snapshot: DeskSnapshot?
    @State private var waiting: [InvitationRow]
    @State private var showsRemoved
    @State private var sortOrder
    @State private var selection: PersonRow.ID?
    @State private var showsInspector
    @State private var invites

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    init(member: Member) { /* private */ }

    private var canInvite: Bool { /* private */ }

    private var rows: [PersonRow] { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private func detail(_ id: UUID) -> some View { /* private */ }

    private func table(_ rows: [PersonRow]) -> some View { /* private */ }

    private func load() async { /* private */ }

    private func loadWaiting() async { /* private */ }

    private func revoke(_ invitation: InvitationRow) { /* private */ }
}

/// One person on the desk.
nonisolated struct PersonRow: Identifiable, Hashable, Sendable {
    let id: UUID
    let name: String
    let role: String
    let car: String
    let spendCents: Int
    let openFlags: Int
    let joined: Date

    @MainActor init(_ member: Member, cars: [String], spendCents: Int, openFlags: Int) { /* private */ }
}

/// A person on iPhone.
private struct CompactPersonRow: View {
    let row: PersonRow

    var body: some View { /* private */ }
}

/// The invitations still open, above the table on iPad and Mac.
private struct WaitingBanner: View {
    let waiting: [InvitationRow]
    let revoke: (InvitationRow) -> Void

    var body: some View { /* private */ }
}

/// "tom@… · Driver · valid until 2 Nov", with Take Back.
private struct WaitingInvitation: View {
    let invitation: InvitationRow
    let revoke: (InvitationRow) -> Void

    var body: some View { /* private */ }
}

/// A person on the desk (plan M7): role, car, this month, history, and what the editor may
/// change.
struct PersonDetail: View {
    @Environment(AppSession.self) private var session
    @State private var confirmsRemoval
    @State private var error: String?

    let person: Member
    let member: Member
    let members: [Member]
    let vehicles: [Vehicle]
    let assignments: [Assignment]
    let groups: [FleetGroup]
    let row: PersonRow?

    private var roles: [MemberRole] { /* private */ }
    private var running: [Assignment] { /* private */ }
    private var own: [Assignment] { /* private */ }
    private var canAssign: Bool { /* private */ }
    private var canRemove: Bool { /* private */ }

    private func carName(_ id: UUID) -> String { /* private */ }

    var body: some View { /* private */ }

    private func setRole(_ role: MemberRole) { /* private */ }

    private func give(_ vehicle: Vehicle) { /* private */ }

    private func end(_ assignment: Assignment) { /* private */ }

    private func remove() { /* private */ }

    private func perform(_ change: () throws -> Void) { /* private */ }
}
