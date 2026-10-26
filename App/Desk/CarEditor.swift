// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftUI

/// Adding or editing a car on the desk (plan M4): plate, what drivers call it, group, fuels,
/// ownership and lease end, and how its pass looks. Checked as the database would before it
/// is saved.
struct CarEditor: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var draft: VehicleDraft
    @State private var error: String?

    let vehicle: Vehicle?
    let member: Member
    let vehicles: [Vehicle]
    let groups: [FleetGroup]

    init(vehicle: Vehicle?, member: Member, vehicles: [Vehicle], groups: [FleetGroup]) { /* private */ }

    private var problems: [VehicleDraft.Problem] { /* private */ }
    private var burns: Bool { /* private */ }
    private var charges: Bool { /* private */ }

    var body: some View { /* private */ }

    /// The lease end as the picker shows it: the stored day, in the person's own calendar.
    private var leaseEnd: Binding<Date> { /* private */ }

    @ViewBuilder private func problemText(_ shown: [VehicleDraft.Problem]) -> some View { /* private */ }

    private func message(_ problem: VehicleDraft.Problem) -> String { /* private */ }

    private func save() { /* private */ }
}
