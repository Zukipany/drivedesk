// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The audit log (plan S4, section 19): who changed what, when. Every change to cars,
/// assignments, people, invitations, groups, money and flags lands here through the
/// database's triggers; nobody can edit or delete a line.
struct AuditLogView: View {
    @Environment(AppSession.self) private var session
    @Query private var members: [Member]
    @Query private var vehicles: [Vehicle]
    @Query private var groups: [FleetGroup]
    @State private var entries: [AuditEntry]?
    @State private var error: String?
    let member: Member

    init(member: Member) { /* private */ }

    private var names: AuditNames { /* private */ }

    private var days: [(day: Date, entries: [AuditEntry])] { /* private */ }

    var body: some View { /* private */ }

    private func load() async { /* private */ }
}

/// The last changes to some rows (a car and its assignments, a person), for a detail screen.
struct AuditHistory: View {
    @Environment(AppSession.self) private var session
    @State private var entries: [AuditEntry]
    let company: UUID
    let rows: [UUID]
    let names: AuditNames

    var body: some View { /* private */ }
}

/// The names behind the IDs an audit line mentions.
struct AuditNames {
    let members: [UUID: String]
    let vehicles: [UUID: String]
    let groups: [UUID: String]

    init(members: [Member], vehicles: [Vehicle], groups: [FleetGroup]) { /* private */ }

    func member(_ id: String?) -> String { /* private */ }

    func vehicle(_ id: String?) -> String { /* private */ }
}

/// One change in words: "Marco Huber gave Passat 3 to Tom Berger", with the changed values
/// below an update.
struct AuditLine: View {
    let entry: AuditEntry
    let names: AuditNames
    var showsDay

    private var actor: String { /* private */ }

    var body: some View { /* private */ }

    private var symbol: String { /* private */ }

    private func value(_ key: String) -> String? { /* private */ }

    private func change(_ field: String) -> AuditEntry.Change? { /* private */ }

    private var sentence: String { /* private */ }

    /// "Status: Active → Workshop" for each changed field worth reading.
    private var details: [String] { /* private */ }

    private func role(_ raw: String?) -> String { /* private */ }

    private func shown(_ field: String, _ raw: String?) -> String { /* private */ }

    /// The fields an update shows, by name; others stay in the log but aren't spelled out.
    private static func label(_ field: String) -> String? { /* private */ }
}

extension VehicleStatus {
    var label: String { /* private */ }

    var symbol: String { /* private */ }
}
