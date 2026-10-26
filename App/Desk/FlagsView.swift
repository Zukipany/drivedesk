// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The flag queue (plan M9, section 14): what the fraud rules flagged, sorted by severity and
/// age, with the evidence in words, the driver's answer, and Resolve, Dismiss or Escalate.
/// Only the server's `decide_flag` changes a flag; this screen asks it.
struct FlagsView: View {
    @Environment(AppSession.self) private var session
    @Query private var vehicles: [Vehicle]
    @Query private var members: [Member]
    @Query private var fillUps: [FillUp]
    @State private var flags: [FlagDetail]
    @State private var showsDecided
    @State private var selection: FlagDetail.ID?
    @State private var showsInspector
    @State private var loadError: String?
    @State private var sortOrder

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    init(member: Member) { /* private */ }

    private var lines: [FlagLine] { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private func inspector(_ id: UUID) -> some View { /* private */ }

    private func table(_ lines: [FlagLine]) -> some View { /* private */ }

    private func load() async { /* private */ }
}

/// One flag in the queue.
nonisolated struct FlagLine: Identifiable, Hashable, Sendable {
    let id: UUID
    let rank: Int
    let severity: Int
    let score: Int
    let rule: String
    let driver: String
    let car: String
    let amountCents: Int?
    let createdAt: Date
    let status: FlagStatus
    let driverReason: String?

    @MainActor init(_ flag: FlagDetail, rank: Int, driver: String, car: String, amountCents: Int?) { /* private */ }

    var amountSort: Int { /* private */ }
    var statusSort: String { /* private */ }
}

/// The fraud rules' names (`public.fraud_rules`), as the desk shows them.
enum FraudRule {
    static func name(_ code: String) -> String { /* private */ }

    /// What the driver picked as the reason, in words.
    static func reason(_ key: String) -> String { /* private */ }
}

struct SeverityChip: View {
    let severity: Int
    let score: Int

    private var tone: StatusTone { /* private */ }

    var body: some View { /* private */ }
}

struct FlagStatusLabel: View {
    let status: FlagStatus

    var body: some View { /* private */ }
}

private struct CompactFlagRow: View {
    let line: FlagLine

    var body: some View { /* private */ }
}

/// A flag's evidence and its decision.
private struct FlagInspector: View {
    @Environment(AppSession.self) private var session
    @State private var note
    @State private var repays
    @State private var repayment: Double?
    @State private var working
    @State private var error: String?

    let flag: FlagDetail
    let line: FlagLine
    let member: Member
    let fillUp: FillUp?
    let changed: () async -> Void

    private var canDecide: Bool { /* private */ }

    var body: some View { /* private */ }

    private func decide(_ decision: FlagStatus) { /* private */ }
}
