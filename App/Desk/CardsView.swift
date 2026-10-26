// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The DriveDesk Card on the desk (US-33, plan M8): the prepaid balance and how long it
/// lasts, the drivers' requests, and every card with its holder, car, limits, spend and state.
/// Managers and the owner issue, freeze, unfreeze and cancel; the accountant reads. Every
/// change goes through the server's card functions, which change Stripe first.
struct CardsView: View {
    @Environment(AppSession.self) private var session
    @Query private var vehicles: [Vehicle]
    @Query private var members: [Member]
    @State private var cards: [CompanyCard]
    @State private var balance: CardBalance?
    @State private var movements: [BalanceMovement]
    @State private var requests: [CardRequest]
    @State private var loadError: String?
    @State private var loaded
    @State private var selection: CompanyCard.ID?
    @State private var showsInspector
    @State private var showsCancelled
    @State private var issuing: IssueStart?
    @State private var sortOrder

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    init(member: Member) { /* private */ }

    private var decides: Bool { /* private */ }
    private var monthStart: Date { /* private */ }
    private var openRequests: [CardRequest] { /* private */ }

    private var lines: [CardLine] { /* private */ }

    var body: some View { /* private */ }

    private func name(of id: UUID) -> String { /* private */ }
    private func car(of id: UUID?) -> String? { /* private */ }

    private func startIssue(_ request: CardRequest?) { /* private */ }

    private func decline(_ request: CardRequest) { /* private */ }

    private func load() async { /* private */ }

    @ViewBuilder private func inspector(_ id: UUID) -> some View { /* private */ }

    /// A cancelled card stays open in the inspector after "Show Cancelled" is switched off.
    private func cancelledLine(_ id: UUID) -> CardLine? { /* private */ }

    private func table(_ lines: [CardLine]) -> some View { /* private */ }
}

/// Where the issue sheet starts: from a request, a person, or empty.
struct IssueStart: Identifiable {
    let id
    var memberID: UUID?
    var vehicleID: UUID?
    var requestID: UUID?
}

nonisolated struct CardLine: Identifiable, Sendable {
    let card: CompanyCard
    let holder: String
    let car: String?
    let spentCents: Int
    let lastUsed: Date?

    init(_ card: CompanyCard, holder: String, car: String?, spentCents: Int, lastUsed: Date?) { /* private */ }

    var id: UUID { /* private */ }
    var carSort: String { /* private */ }
    var lastUsedSort: Date { /* private */ }
    var statusSort: Int { /* private */ }
}

/// The balance, how long it lasts at the last 30 days' pace, and the level below which
/// managers and the owner are told (ADR 004: about five days of spend).
private struct BalanceHeader: View {
    let balance: CardBalance?
    let forecast: BalanceForecast?
    let cards: Int
    let loaded: Bool
    @State private var explainsTopUp

    var body: some View { /* private */ }

    @ViewBuilder private func figures(_ balance: CardBalance, _ forecast: BalanceForecast) -> some View { /* private */ }
}

private struct Figure: View {
    let label: LocalizedStringKey
    let value: String

    var body: some View { /* private */ }
}

/// The drivers who asked for a card, above the table.
private struct RequestStrip: View {
    let requests: [CardRequest]
    let name: (UUID) -> String
    let car: (UUID?) -> String?
    let issue: (CardRequest) -> Void
    let decline: (CardRequest) -> Void

    var body: some View { /* private */ }
}

private struct RequestRow: View {
    let request: CardRequest
    let name: String
    let car: String?
    let issue: (CardRequest) -> Void
    let decline: (CardRequest) -> Void

    var body: some View { /* private */ }
}

private struct CompactCardRow: View {
    let line: CardLine

    var body: some View { /* private */ }
}

/// One card: its face, state, limits, places, recent payments and what the desk can do.
private struct CardInspector: View {
    @Environment(AppSession.self) private var session
    @State private var working
    @State private var error: String?
    @State private var confirmsCancel
    let card: CompanyCard
    let line: CardLine
    let payments: [BalanceMovement]
    let canChange: Bool
    let changed: (CompanyCard) -> Void

    var body: some View { /* private */ }

    private func change(_ action: CardAction) { /* private */ }
}

struct LimitRows: View {
    let limits: CardLimits

    var body: some View { /* private */ }
}

/// The card as a card: the wordmark, the last four digits, the holder and the expiry, never
/// the number. Frozen and cancelled cards say so on their face.
struct CardFace: View {
    let card: CompanyCard
    let holder: String
    let car: String?

    var body: some View { /* private */ }
}

struct CardStatusLabel: View {
    let status: CardStatus

    var body: some View { /* private */ }
}

enum CardText {
    static func euros(_ cents: Int) -> String { /* private */ }

    /// "120 € a payment · 150 € a day · 1,200 € a month".
    static func limits(_ limits: CardLimits) -> String { /* private */ }

    /// "110 / 140 / 1.100": a payment, a day, a month in whole euros, a dash for no limit (the
    /// table's column, its header says €).
    static func shortLimits(_ limits: CardLimits) -> String { /* private */ }

    static func status(_ status: CardStatus) -> String { /* private */ }
}

extension CardCategory {
    var title: LocalizedStringKey { /* private */ }

    var symbol: String { /* private */ }
}
