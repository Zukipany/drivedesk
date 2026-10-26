// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The yearly vehicle inspections (US-39, DGUV Vorschrift 70): every car's last inspection,
/// its result and the next due date, overdue ones first. Recording an inspection closes the
/// car's UVV reminder and opens the next, a year later or with the service.
struct UVVComplianceView: View {
    @Environment(AppSession.self) private var session
    @Query private var vehicles: [Vehicle]
    @Query private var inspections: [UVVInspection]
    @Query private var reminders: [VehicleReminder]
    @Query private var documents: [VehicleDocument]
    @State private var recording: Vehicle?

    let member: Member

    init(member: Member) { /* private */ }

    private var canRecord: Bool { /* private */ }

    private var rows: [(vehicle: Vehicle, status: UVVPlan.Status)] { /* private */ }

    var body: some View { /* private */ }
}

private struct UVVRow: View {
    let vehicle: Vehicle
    let status: UVVPlan.Status
    let history: [UVVInspection]

    var body: some View { /* private */ }
}

private struct UVVStateLabel: View {
    let daysLeft: Int?
    let dueOn: Date?

    var body: some View { /* private */ }
}

/// Recording an inspection: when, who, the result and defects, the report, and the next date.
private struct RecordInspectionSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var inspectedOn
    @State private var inspector
    @State private var workshop
    @State private var result
    @State private var defects
    @State private var reportID: UUID?
    @State private var alignWithService
    @State private var error: String?

    let member: Member
    let vehicle: Vehicle
    let reports: [VehicleDocument]
    let openReminders: [VehicleReminder]
    let serviceDue: Date?

    private var inspectedDay: Date { /* private */ }
    private var nextDue: Date { /* private */ }
    private var defectList: [String] { /* private */ }

    private var problems: [String] { /* private */ }

    var body: some View { /* private */ }

    private func save() { /* private */ }
}
