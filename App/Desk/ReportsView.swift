// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// Reports and exports (plan M14, section 21): a month's fill-ups as a DATEV booking batch
/// for the tax advisor and as the ledger CSV, a one-page monthly report as PDF, and what
/// still stands in the way of closing the month.
struct ReportsView: View {
    @Environment(AppSession.self) private var session
    @Query private var fillUps: [FillUp]
    @Query private var vehicles: [Vehicle]
    @Query private var members: [Member]
    @Query private var groups: [FleetGroup]
    @Query private var companies: [Company]
    @State private var month
    @State private var settings
    @State private var openFlags
    @State private var reportURL: URL?
    let member: Member

    init(member: Member) { /* private */ }

    private var months: [Date] { /* private */ }

    private var interval: DateInterval { /* private */ }

    private var monthFillUps: [FillUp] { /* private */ }
    private var monthName: String { /* private */ }
    private var companyName: String { /* private */ }

    private var datev: DATEVExport { /* private */ }

    private var ledger: LedgerExport { /* private */ }

    private var summary: MonthSummary { /* private */ }

    var body: some View { /* private */ }
}

/// What a month adds up to, and what keeps it from being closed.
struct MonthSummary {
    let count: Int
    let grossCents: Int
    let vatCents: Int
    let cardCents: Int
    let missingReceipts: Int
    let lostVATCents: Int
    let waiting: Int
    let openFlags: Int

    @MainActor init(fillUps: [FillUp], interval: DateInterval, openFlags: Int) { /* private */ }
}

private struct BlockerRow: View {
    let isClear: Bool
    let text: LocalizedStringKey
    let detail: String?

    var body: some View { /* private */ }
}

/// The DATEV numbers, kept on this device until the Integrations settings arrive.
private struct DATEVSettingsSection: View {
    @Binding var settings: DATEVSettings
    let canEdit: Bool

    var body: some View { /* private */ }

    private func number(_ label: LocalizedStringKey, _ value: Binding<Int?>, prompt: String) -> some View { /* private */ }
}

/// The DATEV numbers per company on this device.
enum DATEVSettingsStore {
    private static func key(_ company: UUID) -> String { /* private */ }

    static func load(company: UUID) -> DATEVSettings { /* private */ }

    static func save(_ settings: DATEVSettings, company: UUID) { /* private */ }
}

/// The month on one A4 page, as PDF.
enum MonthlyReport {
    @MainActor static func render(summary: MonthSummary, company: String, month: String) -> URL? { /* private */ }
}

private struct MonthlyReportPage: View {
    let summary: MonthSummary
    let company: String
    let month: String

    var body: some View { /* private */ }

    private func row(_ label: LocalizedStringKey, _ value: String) -> some View { /* private */ }
}
