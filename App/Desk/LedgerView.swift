// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The ledger (plan M2): every fill-up and charge of the company in one sortable table, with
/// filters for month, group, car, driver, fuel, source and flag state, and a CSV export of
/// what the filters show. New rows slide in as Realtime reports them (A12).
struct LedgerView: View {
    @Environment(AppSession.self) private var session
    @Query private var fillUps: [FillUp]
    @Query private var vehicles: [Vehicle]
    @Query private var members: [Member]
    @State private var filter
    @State private var sortOrder
    @State private var selection: LedgerRow.ID?
    @State private var flagged: Set<UUID>
    @State private var showsInspector
    @State private var importsCard
    @State private var columns

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    init(member: Member) { /* private */ }

    private var groups: [UUID: UUID] { /* private */ }

    private var rows: [LedgerRow] { /* private */ }

    private var export: LedgerExport { /* private */ }

    var body: some View { /* private */ }

    private func table(_ rows: [LedgerRow]) -> some View { /* private */ }

    /// Fuel, VAT and source show on the Mac; on iPad they're one tap away in the table's
    /// column menu, so names and stations keep their room.
    #if os(macOS)
        private static let secondaryColumns
    #else
        private static let secondaryColumns
    #endif

    @ViewBuilder private func inspector(_ rows: [LedgerRow]) -> some View { /* private */ }

    private func refresh() async { /* private */ }

    /// The fill-ups with an undecided flag, from the desk's flags.
    private func loadFlags() async { /* private */ }
}

/// One ledger line, ready to show, sort and export.
nonisolated struct LedgerRow: Identifiable, Hashable, Sendable {
    let id: UUID
    let date: Date
    let driver: String
    let car: String
    let plate: String
    let station: String
    let fuel: String
    let isElectric: Bool
    let quantity: Double
    let unitPrice: Double?
    let grossCents: Int
    let vatCents: Int?
    let source: String
    let sourceSymbol: String
    let costCentre: String
    let note: String
    let isFlagged: Bool
    let receipt: ReceiptStatus
    let syncState: SyncState
    let receiptImage: Data?
    /// A card payment without a receipt loses its input VAT until one comes (US-31).
    let vatAtStakeCents: Int

    @MainActor init(_ fillUp: FillUp, vehicle: Vehicle?, member: Member?, isFlagged: Bool) { /* private */ }

    var vatSort: Int { /* private */ }
    /// Flagged first, then missing receipts, then the rest.
    var statusSort: Int { /* private */ }

    var line: LedgerExport.Line { /* private */ }
}

/// The status chips of a row: flag, receipt, sync.
private struct LedgerStatus: View {
    let row: LedgerRow

    var body: some View { /* private */ }
}

/// A ledger line on iPhone.
private struct CompactLedgerRow: View {
    let row: LedgerRow

    var body: some View { /* private */ }
}

/// The selected entry (plan M3, first part): its values, receipt and state.
private struct LedgerInspector: View {
    let row: LedgerRow

    var body: some View { /* private */ }
}

/// The ledger's filters as one menu, with a count of what's set.
private struct LedgerFilterMenu: View {
    @Binding var filter: LedgerFilter
    let vehicles: [Vehicle]
    let members: [Member]

    private var months: [Date] { /* private */ }

    var body: some View { /* private */ }
}
