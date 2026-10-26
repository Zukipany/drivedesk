// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// Home-charging claims on the desk (US-37, plan section 17): a month's claims with their kWh,
/// price and whether the kWh fit the car; managers approve or reject (a manager's own claim
/// goes to the owner), the owner picks the year's method, and the approved claims export for
/// the payroll as tax-free reimbursement.
struct HomeChargingView: View {
    @Environment(AppSession.self) private var session
    @Query private var claims: [ChargingClaim]
    @Query private var years: [HomeChargingYear]
    @Query private var members: [Member]
    @Query private var vehicles: [Vehicle]
    @Query private var trips: [LogbookTrip]
    @Query private var fillUps: [FillUp]
    @State private var month
    @State private var selection: UUID?
    @State private var showsInspector
    @State private var flatMilli
    @State private var error: String?

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    init(member: Member) { /* private */ }

    private var year: Int { /* private */ }
    private var yearChoice: HomeChargingYear? { /* private */ }
    private var method: HomeChargingMethod { /* private */ }
    private var methodLocked: Bool { /* private */ }
    private var monthClaims: [ChargingClaim] { /* private */ }
    private var months: [Date] { /* private */ }

    private var monthName: String { /* private */ }

    private func name(_ id: UUID) -> String { /* private */ }
    private func vehicle(_ id: UUID) -> Vehicle? { /* private */ }

    private func plausibility(_ claim: ChargingClaim) -> HomeChargingClaims.Plausibility { /* private */ }

    private var payroll: HomeChargingPayrollExport { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private func detail(_ id: UUID) -> some View { /* private */ }

    private func choose(_ method: HomeChargingMethod) { /* private */ }
}

private struct MethodHeader: View {
    let year: Int
    let method: HomeChargingMethod
    let flatMilli: Int
    let canChoose: Bool
    let total: Int
    let choose: (HomeChargingMethod) -> Void

    var body: some View { /* private */ }

    private var label: String { /* private */ }
}

private struct ClaimLine: View {
    let claim: ChargingClaim
    let driver: String
    let car: String
    let plausible: Bool

    var body: some View { /* private */ }
}

private struct ClaimDetail: View {
    @Environment(AppSession.self) private var session
    @State private var reason
    @State private var rejecting
    @State private var error: String?
    let claim: ChargingClaim
    let member: Member
    let driver: String
    let car: String
    let plausibility: HomeChargingClaims.Plausibility

    private var canDecide: Bool { /* private */ }

    var body: some View { /* private */ }

    private func decide(_ status: ClaimStatus) { /* private */ }
}
