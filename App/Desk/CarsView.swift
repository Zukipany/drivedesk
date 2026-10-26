// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The car register (plan M4): every car with its driver, group, this month's distance and
/// cost, the next deadline and its state. Managers and owners add cars, hand them over, send
/// them to the workshop and retire them; each change reaches the audit log.
struct CarsView: View {
    @Environment(AppSession.self) private var session
    @Query private var vehicles: [Vehicle]
    @Query private var assignments: [Assignment]
    @Query private var members: [Member]
    @Query private var groups: [FleetGroup]
    @Query private var reminders: [VehicleReminder]
    @State private var snapshot: DeskSnapshot?
    @State private var show
    @State private var sortOrder
    @State private var selection: CarRow.ID?
    @State private var showsInspector
    @State private var editing: EditTarget?
    @State private var columns

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    enum Shown: String, CaseIterable, Identifiable {
        case inService, workshop, retired
        var id: Self { /* private */ }

        var label: LocalizedStringKey { /* private */ }

        func includes(_ status: VehicleStatus) -> Bool { /* private */ }
    }

    enum EditTarget: Identifiable {
        case new
        case edit(Vehicle)

        var id: String { /* private */ }
    }

    init(member: Member) { /* private */ }

    private var canEdit: Bool { /* private */ }

    private var costs: [UUID: DeskOverview.CarCost] { /* private */ }

    private var rows: [CarRow] { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private func detail(_ id: UUID) -> some View { /* private */ }

    private func table(_ rows: [CarRow]) -> some View { /* private */ }

    /// Group and cost per km show on the Mac; on iPad they're one tap away in the column menu.
    #if os(macOS)
        private static let secondaryColumns
    #else
        private static let secondaryColumns
    #endif

    private func load(refreshing: Bool) async { /* private */ }
}

/// One car in the register.
nonisolated struct CarRow: Identifiable, Hashable, Sendable {
    struct Due: Hashable, Sendable {
        let label: String
        let days: Int
    }

    let id: UUID
    let name: String
    let plate: String
    let subtitle: String
    let driver: String?
    let group: String
    let fuelSymbol: String
    let km: Int
    let costCents: Int
    let costPerKm: Double
    let next: Due?
    let status: VehicleStatus

    @MainActor init(_ vehicle: Vehicle, driver: String?, group: String, cost: DeskOverview.CarCost?, next: VehicleReminder?) { /* private */ }

    var driverSort: String { /* private */ }
    var nextDays: Int { /* private */ }
    var statusSort: Int { /* private */ }
}

/// A car on iPhone.
private struct CompactCarRow: View {
    let row: CarRow

    var body: some View { /* private */ }
}

/// A car on the desk (plan M5): the pass, who drives it and since when, this month's cost,
/// its papers and due dates, its history, and what a manager can do with it.
struct DeskCarDetail: View {
    @Environment(AppSession.self) private var session
    @State private var confirmsRetire
    @State private var error: String?
    @State private var dropped: DroppedDocument?

    let vehicle: Vehicle
    let member: Member
    /// This car's assignments, newest first.
    let assignments: [Assignment]
    let allAssignments: [Assignment]
    let members: [Member]
    let groups: [FleetGroup]
    let vehicles: [Vehicle]
    let cost: DeskOverview.CarCost?
    let reminders: [VehicleReminder]
    let edit: () -> Void

    private var canEdit: Bool { /* private */ }
    private var current: Assignment? { /* private */ }

    private func name(_ id: UUID) -> String { /* private */ }

    /// People who can take a car: active, and not the accountant.
    private var drivers: [Member] { /* private */ }

    var body: some View { /* private */ }

    private func span(_ assignment: Assignment) -> String { /* private */ }

    private func assign(to person: Member) { /* private */ }

    private func endRunning() { /* private */ }

    private func setStatus(_ status: VehicleStatus) { /* private */ }

    private func retire() { /* private */ }

    private func perform(_ change: () throws -> Void) { /* private */ }
}
