// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// Budgets and the fuel policy in one place (plan M13): monthly budgets per company, group,
/// car and person with what each spent, and the fuel rules per company or group with a live
/// preview of what they would have flagged last month. Every change reaches the audit log.
struct PolicyView: View {
    @State private var pane
    let member: Member

    enum Pane: String, CaseIterable, Identifiable {
        case budgets, fuel, charging
        var id: Self { /* private */ }
    }

    var body: some View { /* private */ }
}

// MARK: - Budgets

private struct BudgetsPane: View {
    @Environment(AppSession.self) private var session
    @Query private var budgets: [Budget]
    @Query private var vehicles: [Vehicle]
    @Query private var members: [Member]
    @Query private var groups: [FleetGroup]
    @Query private var companies: [Company]
    @State private var month
    @State private var snapshot: DeskSnapshot?
    @State private var carryOver
    @State private var error: String?
    let member: Member

    init(member: Member) { /* private */ }

    private var thisMonth: [Budget] { /* private */ }
    private var previousMonth: Date { /* private */ }
    private var previous: [Budget] { /* private */ }
    private var current: Date { /* private */ }

    private func spent(_ budget: Budget) -> Int { /* private */ }

    private func name(_ budget: Budget) -> String { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private func scopeSection(_ scope: BudgetScope, title: LocalizedStringKey, targets: [(UUID?, String)]) -> some View { /* private */ }

    private func shift(_ months: Int) { /* private */ }

    /// A first amount to edit: the company 3,000 €, a group 1,500 €, a car 350 €, a person 300 €.
    private func add(_ scope: BudgetScope, target: UUID?) { /* private */ }

    private func copyPrevious() { /* private */ }

    private func perform(_ change: () throws -> Void) { /* private */ }
}

/// One budget: its target, the amount to edit and how much of it is gone.
private struct BudgetRow: View {
    let name: String
    let budget: Budget
    let spentCents: Int
    let isPast: Bool
    let save: (Int) -> Void

    @State private var euros: Double

    private var share: Double { /* private */ }
    private var tone: Color { /* private */ }

    var body: some View { /* private */ }

    private func commit() { /* private */ }
}

// MARK: - Fuel rules

private struct FuelPolicyPane: View {
    @Environment(AppSession.self) private var session
    @Query private var policies: [FuelPolicy]
    @Query private var vehicles: [Vehicle]
    @Query private var groups: [FleetGroup]
    @Query private var fillUps: [FillUp]
    @State private var scope: UUID?
    @State private var draft
    @State private var saved: FuelPolicyDraft?
    @State private var error: String?
    let member: Member

    init(member: Member, now: Date = .now) { /* private */ }

    private var policy: FuelPolicy? { /* private */ }
    private var companyPolicy: FuelPolicy? { /* private */ }

    /// The cars these rules cover: a group's cars, or for the company's rules every car whose
    /// group has none of its own.
    private var covered: [Vehicle] { /* private */ }

    private var lastMonth: [FillUp] { /* private */ }

    private var preview: PolicyPreview.Result { /* private */ }

    var body: some View { /* private */ }

    private var previewSentence: String { /* private */ }

    private func label(_ kind: PolicyPreview.Kind) -> String { /* private */ }

    /// A time of day for the pickers, as minutes after midnight in the draft.
    private func time(_ keyPath: WritableKeyPath<FuelPolicyDraft, Int?>) -> Binding<Date> { /* private */ }

    /// The scope's own rules, or for a group without them, the company's to start from.
    private func load() { /* private */ }

    private func save() { /* private */ }
}

/// Mon to Sun as toggles.
private struct WeekdayPicker: View {
    @Binding var days: Set<Int>

    var body: some View { /* private */ }
}

// MARK: - Charging plans (US-19)

/// The company's charging cards and subscriptions: known ones with their current prices, or
/// the company's own with a price per operator. Drivers see them priced on the map.
private struct ChargingPlansPane: View {
    @Environment(AppSession.self) private var session
    @Query private var plans: [CompanyChargingPlan]
    @State private var editing: CompanyChargingPlan?
    @State private var addsOwn
    @State private var error: String?
    let member: Member

    init(member: Member) { /* private */ }

    private var unused: [ChargingPlanPreset] { /* private */ }

    var body: some View { /* private */ }

    private func summary(_ plan: CompanyChargingPlan) -> String { /* private */ }

    private func add(_ preset: ChargingPlanPreset) { /* private */ }

    private func perform(_ change: () throws -> Void) { /* private */ }
}

/// The company's own card: a name, a monthly fee and prices per operator.
private struct OwnPlanForm: View {
    struct EditableRule: Identifiable {
        let id
        var operatorName: String?
        var ac: Double?
        var dc: Double?
    }

    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var name
    @State private var fee: Double?
    @State private var rules: [EditableRule]
    @State private var error: String?

    let plan: CompanyChargingPlan?
    let member: Member

    private var isValid: Bool { /* private */ }

    var body: some View { /* private */ }

    private func load() { /* private */ }

    private func save() { /* private */ }
}
