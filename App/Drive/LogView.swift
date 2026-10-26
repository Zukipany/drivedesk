// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The Log (plan D6): the driver's own fill-ups, charges and card payments by month, each
/// with its source, amount, litres or kWh, station and state. Filters at the top; the plus
/// button logs a new one.
struct LogView: View {
    @Environment(AppSession.self) private var session
    @Query private var fillUps: [FillUp]
    @Query private var assignments: [Assignment]
    @Query private var vehicles: [Vehicle]
    @State private var filter
    @State private var capture
    @State private var page

    let member: Member

    init(member: Member) { /* private */ }

    private var vehicle: Vehicle? { /* private */ }

    private var shown: [FillUp] { /* private */ }

    /// Months, newest first, with their entries.
    private var months: [(start: Date, entries: [FillUp])] { /* private */ }

    var body: some View { /* private */ }

    private var fillUpList: some View { /* private */ }
}

/// The Log's two pages: money (fill-ups, charges, card payments) and the logbook's trips.
enum LogPage: Hashable {
    case fillUps, trips
}

/// The filters at the top of the Log.
enum LogFilter: String, CaseIterable, Identifiable {
    case all, card, receipts, charges

    var id: Self { /* private */ }

    var title: LocalizedStringKey { /* private */ }

    func includes(_ fillUp: FillUp) -> Bool { /* private */ }
}

private struct MonthHeader: View {
    let start: Date
    let entries: [FillUp]

    var body: some View { /* private */ }
}

/// One entry: source, station or fuel, amount and price, date, state.
struct LogRow: View {
    let fillUp: FillUp

    private var title: String { /* private */ }

    private var detail: String { /* private */ }

    var body: some View { /* private */ }
}

/// The state a row shows (plan D6): Uploading, Needs receipt, or what the sync says.
struct StatusChip {
    let title: LocalizedStringKey
    let tone: StatusTone

    init?(_ fillUp: FillUp) { /* private */ }
}

/// One fill-up in full, with its receipt when this device has the photo.
struct FillUpDetailView: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var confirmsDelete
    let fillUp: FillUp
    let member: Member

    /// Drivers delete their own typed or scanned entries; card payments come from the card.
    private var canDelete: Bool { /* private */ }

    var body: some View { /* private */ }
}
