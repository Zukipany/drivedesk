// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The 1 % rule against the logbook (US-36, plan section 16): per driver with a company car,
/// the taxable benefit a month each way, from the car's real costs and the logbook's
/// kilometres. Information for the driver and the tax advisor, not tax advice.
struct BenefitView: View {
    @Environment(AppSession.self) private var session
    @Query private var assignments: [Assignment]
    @Query private var vehicles: [Vehicle]
    @Query private var members: [Member]
    @Query private var trips: [LogbookTrip]
    @Query private var corrections: [TripCorrection]
    @Query private var fillUps: [FillUp]
    @Query private var costs: [VehicleCost]
    @Query private var fixedCosts: [VehicleFixedCost]
    @State private var year
    @State private var rules: BenefitRules?
    @State private var editing: Vehicle?

    let member: Member

    init(member: Member) { /* private */ }

    private var canEdit: Bool { /* private */ }
    private var yearInterval: DateInterval { /* private */ }

    /// Every driver's company car in the year, with its comparison.
    private var lines: [BenefitLine] { /* private */ }

    var body: some View { /* private */ }

    private func percent(_ value: Double, digits: Int = 0) -> String { /* private */ }
}

struct BenefitLine: Identifiable {
    let id: UUID
    let driver: String
    let vehicle: Vehicle
    let comparison: BenefitComparison
}

private struct BenefitRows: View {
    let comparison: BenefitComparison

    private func money(_ cents: Int?) -> String { /* private */ }

    var body: some View { /* private */ }
}

private struct BenefitVerdict: View {
    let comparison: BenefitComparison

    var body: some View { /* private */ }
}

/// A car's lease, insurance, tax and other fixed costs for one year.
private struct FixedCostsSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var lease: Double?
    @State private var insurance: Double?
    @State private var tax: Double?
    @State private var other: Double?
    @State private var error: String?

    let member: Member
    let vehicle: Vehicle
    let year: Int
    let existing: VehicleFixedCost?

    init(member: Member, vehicle: Vehicle, year: Int, existing: VehicleFixedCost?) { /* private */ }

    var body: some View { /* private */ }

    private func save() { /* private */ }
}
