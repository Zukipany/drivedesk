// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// Cost per car and use (US-30, plan features 39 and 45): each car's fuel, charging, service,
/// damage and other costs in a period, per km, and how many days it was with someone, with
/// the most cars out at once and a CSV export. Managers and owners book service and damage
/// invoices on a car; the accountant reads.
struct CostsView: View {
    @Environment(AppSession.self) private var session
    @Query private var vehicles: [Vehicle]
    @Query private var fillUps: [FillUp]
    @Query private var costs: [VehicleCost]
    @Query private var assignments: [Assignment]
    @State private var period
    @State private var sortOrder
    @State private var selection: CostRow.ID?
    @State private var showsInspector
    @State private var booking: UUID??
    @State private var columns

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    init(member: Member) { /* private */ }

    private var canBook: Bool { /* private */ }
    private var interval: DateInterval { /* private */ }
    private var inService: [Vehicle] { /* private */ }

    private var rows: [CostRow] { /* private */ }

    private var title: String { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private func detail(_ id: UUID) -> some View { /* private */ }

    private func table(_ rows: [CostRow]) -> some View { /* private */ }

    private func money(_ cents: Int) -> Text { /* private */ }

    /// Fuel and charging show on the Mac; on iPad they sit in the column menu, the total holds them.
    #if os(macOS)
        private static let secondaryColumns
    #else
        private static let secondaryColumns
    #endif
}

/// One car on the cost screen.
nonisolated struct CostRow: Identifiable, Hashable, Sendable {
    let id: UUID
    let name: String
    let plate: String
    let isPoolCar: Bool
    let line: CarCostLine

    @MainActor init(_ vehicle: Vehicle, line: CarCostLine) { /* private */ }

    var km: Int { /* private */ }
    var fuelCents: Int { /* private */ }
    var chargeCents: Int { /* private */ }
    var serviceCents: Int { /* private */ }
    var damageCents: Int { /* private */ }
    var totalCents: Int { /* private */ }
    var perKmSort: Double { /* private */ }
    var utilisation: Double { /* private */ }

    static func == (lhs: CostRow, rhs: CostRow) -> Bool { /* private */ }
    func hash(into hasher: inout Hasher) { /* private */ }
}

/// The fleet in one line: what the cars cost, per km, and how many were out at once.
private struct CostSummary: View {
    let rows: [CostRow]
    let peak: Int
    let cars: Int

    private var total: Int { /* private */ }
    private var km: Int { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private var figures: some View { /* private */ }
}

private struct LabeledFigure: View {
    let label: LocalizedStringKey
    let value: String

    var body: some View { /* private */ }
}

/// Days used as a bar with the share.
private struct UsedBar: View {
    let line: CarCostLine

    var body: some View { /* private */ }
}

private struct CompactCostRow: View {
    let row: CostRow

    var body: some View { /* private */ }
}

/// One car's costs in the period, and the invoices booked on it.
private struct CostDetail: View {
    let row: CostRow
    let costs: [VehicleCost]
    let canBook: Bool
    let book: () -> Void

    var body: some View { /* private */ }
}

/// Booking a service or damage invoice on a car.
private struct BookCostSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var vehicleID: UUID?
    @State private var kind
    @State private var day
    @State private var euros: Double?
    @State private var vatEuros: Double?
    @State private var note
    @State private var error: String?

    let member: Member
    let vehicles: [Vehicle]

    init(member: Member, vehicles: [Vehicle], vehicleID: UUID?) { /* private */ }

    private var isValid: Bool { /* private */ }

    var body: some View { /* private */ }

    private func save() { /* private */ }
}
