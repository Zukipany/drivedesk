// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The company's recurring duties (plan section 18): licence checks now (US-38), the yearly
/// vehicle inspection and driver instruction next. Each person's next due date, who needs
/// attention first, the in-person check, and from 14 days overdue the letter withdrawing
/// permission to drive.
struct ComplianceView: View {
    @State private var part
    @State private var proof: URL?
    @Query private var members: [Member]
    @Query private var vehicles: [Vehicle]
    @Query private var licenceChecks: [LicenceCheck]
    @Query private var inspections: [UVVInspection]
    @Query private var completions: [InstructionCompletion]
    @Query private var companies: [Company]
    let member: Member

    init(member: Member) { /* private */ }

    private var year: Int { /* private */ }

    var body: some View { /* private */ }

    /// The year's proof PDF from everything on record.
    private func renderProof() -> URL? { /* private */ }
}

enum CompliancePart: Hashable {
    case licences, inspections, instruction
}

/// Every driver's licence check (US-38).
struct LicenceComplianceView: View {
    @Environment(AppSession.self) private var session
    @Query private var members: [Member]
    @Query private var checks: [LicenceCheck]
    @Query private var companies: [Company]
    @State private var selection: UUID?
    @State private var showsInspector

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    init(member: Member) { /* private */ }

    private var drivers: [Member] { /* private */ }

    private var lines: [LicenceLine] { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private func detail(_ id: UUID) -> some View { /* private */ }
}

struct LicenceLine: Identifiable {
    let person: Member
    let status: LicenceStatus

    var id: UUID { /* private */ }
    /// Overdue and never first, then due soon, then valid.
    var rank: Int { /* private */ }
}

private struct ComplianceSummary: View {
    let lines: [LicenceLine]

    var body: some View { /* private */ }

    private func figure(_ label: LocalizedStringKey, _ count: Int, tone: StatusTone?) -> some View { /* private */ }
}

struct LicenceStateLabel: View {
    let state: LicenceStatus.State

    var body: some View { /* private */ }
}

private struct LicenceRow: View {
    let line: LicenceLine

    var body: some View { /* private */ }
}

private struct LicenceDetail: View {
    @State private var checking
    @State private var letter: URL?
    let line: LicenceLine
    let checks: [LicenceCheck]
    let member: Member
    let names: [UUID: String]
    let company: String

    private var canCheck: Bool { /* private */ }

    var body: some View { /* private */ }
}

/// Confirming a licence seen in person: the date, the result, the classes, the card's expiry
/// and the restriction codes.
private struct CheckLicenceSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var checkedOn
    @State private var isValid
    @State private var classes: Set<String>
    @State private var hasExpiry
    @State private var expiresOn
    @State private var restrictions: Set<String>
    @State private var note
    @State private var error: String?
    let member: Member
    let person: Member

    var body: some View { /* private */ }

    private func save() { /* private */ }
}

/// The letter withdrawing permission to drive company cars until the licence is shown, as an
/// A4 PDF for the manager to sign.
enum WithdrawalLetter {
    @MainActor static func render(person: String, since: Date, company: String, manager: String) -> URL? { /* private */ }
}

private struct WithdrawalLetterPage: View {
    let person: String
    let since: Date
    let company: String
    let manager: String

    var body: some View { /* private */ }
}
