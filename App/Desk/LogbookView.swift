// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The logbook on the desk (US-35, plan section 16): every car's trips in a period by type,
/// what's still to classify, how much is sealed, and the verifier that recomputes every
/// car's chain and names the first broken link. A car's logbook opens with its corrections
/// inline and exports as CSV and as a PDF that can be read on its own.
struct LogbookView: View {
    @Environment(AppSession.self) private var session
    @Query private var trips: [LogbookTrip]
    @Query private var corrections: [TripCorrection]
    @Query private var vehicles: [Vehicle]
    @Query private var members: [Member]
    @Query private var companies: [Company]
    @State private var period
    @State private var selection: UUID?
    @State private var showsInspector
    @State private var sortOrder

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    init(member: Member) { /* private */ }

    private var interval: DateInterval { /* private */ }
    private var checks: [LogbookSeal.ChainCheck] { /* private */ }

    private var rows: [CarLogbookRow] { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private func detail(_ vehicleID: UUID) -> some View { /* private */ }

    private var periodName: String { /* private */ }

    private func table(_ rows: [CarLogbookRow]) -> some View { /* private */ }

    private func km(_ value: Double) -> Text { /* private */ }
}

nonisolated struct CarLogbookRow: Identifiable, Sendable {
    let vehicleID: UUID
    let car: String
    let plate: String
    let drivers: String
    let trips: Int
    let businessKm: Double
    let commuteKm: Double
    let privateKm: Double
    let toClassify: Int
    let sealed: Int
    let chain: LogbookSeal.ChainCheck?

    var id: UUID { /* private */ }
    /// Broken chains first.
    var chainSort: Int { /* private */ }
}

private struct ChainLabel: View {
    let row: CarLogbookRow

    var body: some View { /* private */ }
}

private struct CompactLogbookRow: View {
    let row: CarLogbookRow

    var body: some View { /* private */ }
}

/// The verifier's verdict over every chain, on top of the screen.
private struct VerifierBanner: View {
    let checks: [LogbookSeal.ChainCheck]
    let cars: [UUID: String]
    let trips: [LogbookTrip]

    private var broken: [LogbookSeal.ChainCheck] { /* private */ }

    var body: some View { /* private */ }
}

/// One car's logbook for the period: every trip with its corrections, and the exports.
private struct CarLogbookDetail: View {
    @State private var pdf: URL?
    let vehicle: Vehicle
    let trips: [CorrectedTrip]
    let names: [UUID: String]
    let period: String
    let company: String
    let chain: LogbookSeal.ChainCheck?

    private var export: LogbookExport { /* private */ }

    var body: some View { /* private */ }
}

private struct LogbookTripLine: View {
    let trip: CorrectedTrip
    let driver: String

    var body: some View { /* private */ }
}
