// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import DDDevice
import QuickLook
import SwiftData
import SwiftUI
import UserNotifications

/// The driver's company car (plan D9): the pass, larger, flipping to its facts; the due
/// dates the company set, with reminders 30 and 7 days ahead; and the car's papers, kept on
/// the phone once opened so a roadside check works without signal.
struct CarView: View {
    @Environment(AppSession.self) private var session
    @Query private var assignments: [Assignment]
    @Query private var vehicles: [Vehicle]
    @Query private var reminders: [VehicleReminder]
    @Query private var documents: [VehicleDocument]

    /// Whether the phone may remind; asked only when the driver taps the reason (section 10).
    @State private var notifications

    let member: Member

    init(member: Member) { /* private */ }

    private var assignment: Assignment? { /* private */ }
    private var vehicle: Vehicle? { /* private */ }

    var body: some View { /* private */ }

    /// Schedules the car's reminders when the phone may remind, and keeps its papers.
    private func prepare(_ vehicle: Vehicle) async { /* private */ }

    /// The driver tapped the reason: the system asks, then the reminders are set.
    private func allowReminders(for vehicle: Vehicle) async { /* private */ }

    private func schedule(_ vehicle: Vehicle) async { /* private */ }
}

/// The car's screen once there is a car.
private struct CarDetail: View {
    let vehicle: Vehicle
    let badge: String
    let reminders: [VehicleReminder]
    let documents: [VehicleDocument]
    let notifications: UNAuthorizationStatus
    let member: Member
    let allowReminders: () -> Void

    var body: some View { /* private */ }
}

/// The pass; a tap flips it to the car's facts and back (Reduce Motion: no turn, a fade).
private struct FlippingPass: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var showsFacts
    let vehicle: Vehicle
    let badge: String

    var body: some View { /* private */ }
}

/// VIN, tank, battery, fuels, list price, ownership: the back of the pass.
private struct CarFacts: View {
    let vehicle: Vehicle

    private var fuels: String { /* private */ }

    var body: some View { /* private */ }

    private func fact(_ title: LocalizedStringKey, _ value: String) -> some View { /* private */ }
}

/// The car's open due dates, the earliest first, each with a countdown.
private struct RemindersCard: View {
    let reminders: [VehicleReminder]
    let notifications: UNAuthorizationStatus
    let allowReminders: () -> Void

    var body: some View { /* private */ }
}

struct ReminderRow: View {
    let reminder: VehicleReminder
    var carName: String?

    private var days: Int { /* private */ }

    /// Overdue is critical, the last week a warning, the month before a note.
    private var tone: StatusTone? { /* private */ }

    var body: some View { /* private */ }
}

/// "in 23 days" in a capsule, in the tone's colour with its symbol when it matters.
struct CountdownChip: View {
    let days: Int
    let tone: StatusTone?

    var body: some View { /* private */ }
}

/// The car's papers: open from the phone, fetched once when there's signal.
private struct DocumentsCard: View {
    @Environment(AppSession.self) private var session
    @State private var preview: URL?
    @State private var opening: UUID?
    @State private var error: String?
    let documents: [VehicleDocument]

    var body: some View { /* private */ }

    private func open(_ document: VehicleDocument) { /* private */ }
}

private struct DocumentRow: View {
    let document: VehicleDocument
    let isOpening: Bool

    private var expiryDays: Int? { /* private */ }

    var body: some View { /* private */ }
}

extension DocumentKind {
    /// Registration first: it's the one asked for at a roadside check.
    var order: Int { /* private */ }
}
