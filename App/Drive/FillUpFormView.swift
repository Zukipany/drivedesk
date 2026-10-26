// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// Logging a fill-up or a charge (plan D7, from iDrive's FillUpForm): any two of amount,
/// price and total give the third; values read from a receipt can always be edited, and the
/// ones the parser couldn't read or that don't add up are marked to check. The checks from
/// `FillUpCheck` explain themselves; the driver corrects or saves with a note for the desk.
/// Saving stores the fill-up on this device at once and syncs it when the network allows.
struct FillUpFormView: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @Query private var carFillUps: [FillUp]
    @Query private var companies: [Company]

    let vehicle: Vehicle
    let member: Member
    let draft: FillUpDraft
    /// Called with the new fill-up after it's saved.
    let onSave: (FillUp) -> Void

    @State private var date
    @State private var fuel: FuelType
    @State private var amount: Double?
    @State private var price: Double?
    @State private var total: Double?
    @State private var odometer: Int?
    @State private var isFullTank
    /// Level after a partial fill (0…1); nil while "Not sure".
    @State private var partialLevel: Double?
    @State private var stationName
    @State private var note
    /// The two fields edited most recently; the third is computed.
    @State private var recentEdits: [FuelMath.Field]
    @State private var flagged: Set<FuelMath.Field>
    @State private var confirmsDiscard
    @State private var saveError: String?

    init(vehicle: Vehicle, member: Member, draft: FillUpDraft, onSave: @escaping (FillUp) -> Void) { /* private */ }

    /// Above 250 € the receipt must name the company with its address (US-31).
    private var missesRecipient: Bool { /* private */ }

    private var hasChanges: Bool { /* private */ }

    private var issues: [FillUpCheck.Issue] { /* private */ }

    /// Complete, and either passing the checks or explained in a note.
    private var canSave: Bool { /* private */ }

    var body: some View { /* private */ }

    // MARK: Receipt

    @ViewBuilder private var receiptSection: some View { /* private */ }

    private var discount: Double { /* private */ }

    @ViewBuilder private var receiptStatus: some View { /* private */ }

    // MARK: Amount, price, total

    private func field(_ title: LocalizedStringKey, _ field: FuelMath.Field) -> some View { /* private */ }

    private func value(_ field: FuelMath.Field) -> Double? { /* private */ }

    private func set(_ field: FuelMath.Field, _ newValue: Double?) { /* private */ }

    /// Typed values go through this binding; computed ones are set directly, so working
    /// out the third value never triggers another calculation.
    private func binding(_ field: FuelMath.Field) -> Binding<Double?> { /* private */ }

    // MARK: Odometer and tank

    private var odometerSection: some View { /* private */ }

    /// Gauge eighths for fuel; 10 % steps for a battery, as the car shows them.
    private var levelChoices: [Double] { /* private */ }

    private func levelLabel(_ level: Double) -> String { /* private */ }

    private var issueSection: some View { /* private */ }

    // MARK: Lifecycle

    private func prefill() { /* private */ }

    private func save() { /* private */ }
}
