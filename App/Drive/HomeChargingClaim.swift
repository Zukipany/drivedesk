// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import ImageIO
import PhotosUI
import SwiftData
import SwiftUI

/// Home charging for drivers of electric and plug-in hybrid cars (US-37, plan section 17):
/// from the 1st of each month a task to claim the month before, the claims with their state,
/// and the tariff for the actual-cost method.
struct HomeChargingDueCard: View {
    @Query private var claims: [ChargingClaim]
    @State private var claiming
    let member: Member
    let vehicle: Vehicle

    init(member: Member, vehicle: Vehicle) { /* private */ }

    private var due: Date { /* private */ }
    private var isDue: Bool { /* private */ }
    private var monthName: String { /* private */ }

    var body: some View { /* private */ }
}

/// The claims on the Car screen.
struct HomeChargingPanel: View {
    @Query private var claims: [ChargingClaim]
    @Query private var years: [HomeChargingYear]
    @Query private var tariffs: [HomeTariff]
    @State private var claiming: Date?
    @State private var editsTariff
    let member: Member
    let vehicle: Vehicle

    init(member: Member, vehicle: Vehicle) { /* private */ }

    private var method: HomeChargingMethod { /* private */ }

    private var due: Date { /* private */ }

    var body: some View { /* private */ }
}

private struct IdentifiedMonth: Identifiable {
    let month: Date
    var id: Date { /* private */ }
}

struct ClaimRow: View {
    let claim: ChargingClaim

    private var tone: Color { /* private */ }

    var body: some View { /* private */ }
}

/// Claiming a month: the wallbox meter at the start and end (or the kWh), a photo, and the
/// price the server will pay, with a check that the kWh fit the car.
struct ClaimSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @Query private var years: [HomeChargingYear]
    @Query private var tariffs: [HomeTariff]
    @Query private var trips: [LogbookTrip]
    @Query private var fillUps: [FillUp]
    @State private var meterStart: Double?
    @State private var meterEnd: Double?
    @State private var kwh: Double?
    @State private var note
    @State private var pick: PhotosPickerItem?
    @State private var photo: Data?
    @State private var flatMilli
    @State private var error: String?

    let member: Member
    let vehicle: Vehicle
    let month: Date
    let existing: ChargingClaim?

    init(member: Member, vehicle: Vehicle, month: Date, existing: ChargingClaim? = nil) { /* private */ }

    private var year: Int { /* private */ }
    private var method: HomeChargingMethod { /* private */ }

    /// The kWh from the meter readings, or as typed.
    private var claimedKWh: Double? { /* private */ }

    private var monthInterval: DateInterval { /* private */ }

    private var plausibility: HomeChargingClaims.Plausibility? { /* private */ }

    private var problems: [String] { /* private */ }

    var body: some View { /* private */ }

    private func send() { /* private */ }

    /// The meter photo goes to the receipts bucket; the claim keeps its path once it's there.
    private func upload(_ jpeg: Data, for claim: ChargingClaim) async { /* private */ }
}

/// The driver's own tariff for the actual-cost method.
private struct TariffSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var price: Double?
    @State private var baseFee: Double?
    @State private var household: Double?
    @State private var error: String?
    let member: Member
    let existing: HomeTariff?

    init(member: Member, existing: HomeTariff?) { /* private */ }

    var body: some View { /* private */ }

    private func save() { /* private */ }
}

/// The meter photo, made small and JPEG with ImageIO on both platforms.
enum ClaimPhoto {
    static func image(_ data: Data, maxPixels: Int = 1_600) -> CGImage? { /* private */ }

    static func jpeg(_ data: Data) -> Data? { /* private */ }
}
