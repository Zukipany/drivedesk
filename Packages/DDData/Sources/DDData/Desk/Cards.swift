// Source code is private. This file shows only its types and signatures.

import Foundation
import Supabase

/// The DriveDesk Card (US-33, plan section 13, ADR 004): a virtual Stripe Issuing card per
/// driver or car, its limits and merchant categories, the company's prepaid balance and the
/// driver's request for a card. Only the server's `card-issue` and `card-freeze` change a
/// card; the app reads, asks and shows. The number never reaches the app's own views: Stripe's
/// component shows it.
public nonisolated enum CardStatus: String, Sendable, CaseIterable {
    case active
    /// Frozen: no payment goes through until it's unfrozen.
    case inactive
    /// Final.
    case canceled
}

/// What `card-freeze` does.
public nonisolated enum CardAction: String, Sendable {
    case freeze, unfreeze, cancel
}

/// Stripe's merchant categories a fleet card may work at.
public nonisolated enum CardCategory: String, Sendable, CaseIterable, Identifiable {
    case serviceStations
    case fuelDispensers
    case charging
    case carWashes
    case parking
    case tolls
    case workshops

    public var id: Self { /* private */ }

    /// Fuel and charging: what every card starts with.
    public static let fuel: [CardCategory]
}

/// A card's limits in cents, set on the card in Stripe so it can't pay beyond them even when
/// DriveDesk is down. Nil is no limit of that kind; one is needed at least.
public nonisolated struct CardLimits: Equatable, Sendable, Hashable {
    public var perPaymentCents: Int?
    public var dailyCents: Int?
    public var monthlyCents: Int?

    public init(perPaymentCents: Int? = nil, dailyCents: Int? = nil, monthlyCents: Int? = nil) { /* private */ }

    public var isEmpty: Bool { /* private */ }

    /// 5,000 € a payment is more than any tank or charge (the server's limit too).
    public static let maxCents

    public var problems: [String] { /* private */ }

    /// Limits that fit a car: a full tank or charge at a high price, rounded up to 10 €, a
    /// day of one and a bit, a month of about eight. Nil for a car with neither tank nor battery.
    public static func suggested(tankLitres: Double?, batteryKWh: Double?) -> CardLimits? { /* private */ }
}

public nonisolated struct CompanyCard: Equatable, Sendable, Identifiable {
    public var id: UUID
    public var companyID: UUID
    public var memberID: UUID
    /// Locked to a car, or the person's for any of the company's cars.
    public var vehicleID: UUID?
    public var last4: String
    public var expMonth: Int
    public var expYear: Int
    public var status: CardStatus
    public var limits: CardLimits
    public var categories: [CardCategory]
    public var frozenAt: Date?
    public var canceledAt: Date?
    public var createdAt: Date

    public init(
        id: UUID = .v7(),
        companyID: UUID,
        memberID: UUID,
        vehicleID: UUID? = nil,
        last4: String,
        expMonth: Int,
        expYear: Int,
        status: CardStatus = .active,
        limits: CardLimits,
        categories: [CardCategory] = CardCategory.fuel,
        frozenAt: Date? = nil,
        canceledAt: Date? = nil,
        createdAt: Date = .now
    ) { /* private */ }

    static let columns

    init(row: Row) throws(RowError) { /* private */ }

    public var isFrozen: Bool { /* private */ }
    public var isUsable: Bool { /* private */ }
    /// "09/29".
    public var expiry: String { /* private */ }

    public func expires(before date: Date, calendar: Calendar = CalendarDays.berlin) -> Bool { /* private */ }
}

/// The company's prepaid Issuing balance (ADR 004).
public nonisolated struct CardBalance: Equatable, Sendable {
    public var companyID: UUID
    public var balanceCents: Int
    /// Below this, managers and the owner are told (about five days of spend).
    public var lowBalanceCents: Int
    public var updatedAt: Date

    public init(companyID: UUID, balanceCents: Int, lowBalanceCents: Int, updatedAt: Date = .now) { /* private */ }

    init(row: Row) throws(RowError) { /* private */ }

    public var isLow: Bool { /* private */ }
}

/// One change to the balance: a top-up adds, a card payment takes, a refund gives back.
public nonisolated struct BalanceMovement: Equatable, Sendable, Identifiable {
    public enum Kind: String, Sendable { case topup, authorization, refund, adjustment }

    public var id: UUID
    public var kind: Kind
    /// Signed.
    public var amountCents: Int
    public var cardID: UUID?
    public var note: String
    public var createdAt: Date

    public init(id: UUID = .v7(), kind: Kind, amountCents: Int, cardID: UUID? = nil, note: String = "", createdAt: Date = .now) { /* private */ }

    init(row: Row) throws(RowError) { /* private */ }

    /// A card payment or its refund: what counts as spend.
    public var isSpend: Bool { /* private */ }
}

/// How long the balance lasts at the recent pace, and the level that covers five days of it.
public nonisolated struct BalanceForecast: Equatable, Sendable {
    /// Average spend a day over the last 30 days, in cents.
    public var dailySpendCents: Int
    /// Nil while nothing is spent.
    public var daysLeft: Int?
    /// About five days of spend, rounded up to 100 €.
    public var suggestedLevelCents: Int

    public init(balance: CardBalance, movements: [BalanceMovement], now: Date = .now) { /* private */ }

    /// What each card spent since a date, refunds taken off.
    public static func spend(by movements: [BalanceMovement], since: Date) -> [UUID: Int] { /* private */ }

    /// When each card last paid.
    public static func lastUsed(by movements: [BalanceMovement]) -> [UUID: Date] { /* private */ }
}

/// A driver asking for a card; a manager approves (by issuing it) or declines.
public nonisolated struct CardRequest: Equatable, Sendable, Identifiable {
    public enum Status: String, Sendable { case requested, approved, declined }

    public var id: UUID
    public var companyID: UUID
    public var memberID: UUID
    public var vehicleID: UUID?
    public var note: String
    public var status: Status
    public var decidedBy: UUID?
    public var decidedAt: Date?
    public var createdAt: Date

    public init(
        id: UUID = .v7(),
        companyID: UUID,
        memberID: UUID,
        vehicleID: UUID? = nil,
        note: String = "",
        status: Status = .requested,
        decidedBy: UUID? = nil,
        decidedAt: Date? = nil,
        createdAt: Date = .now
    ) { /* private */ }

    static let columns

    init(row: Row) throws(RowError) { /* private */ }
}

/// What a manager fills in to issue a card.
public nonisolated struct CardIssue: Equatable, Sendable {
    public var companyID: UUID
    public var memberID: UUID
    public var vehicleID: UUID?
    /// The driver's request this card answers.
    public var requestID: UUID?
    public var limits: CardLimits
    public var categories: [CardCategory]

    public init(
        companyID: UUID,
        memberID: UUID,
        vehicleID: UUID? = nil,
        requestID: UUID? = nil,
        limits: CardLimits,
        categories: [CardCategory] = CardCategory.fuel
    ) { /* private */ }

    public var problems: [String] { /* private */ }
}

public nonisolated enum CardError: Error, Equatable, Sendable {
    case notAllowed(String)
    /// The server has no Stripe test key yet.
    case notSetUp(String)
    /// Stripe or the request refused; the message says why.
    case refused(String)
    case offline
    case server(String)

    public var message: String { /* private */ }
}

/// Cards, the balance and requests, read as the signed-in person; issuing and freezing go
/// through the server's functions.
public protocol CardService: Sendable {
    func cards(company: UUID) async throws(CardError) -> [CompanyCard]
    /// Nil until the company's balance is set up (and for a driver, who doesn't see it).
    func balance(company: UUID) async throws(CardError) -> CardBalance?
    func movements(company: UUID) async throws(CardError) -> [BalanceMovement]
    func requests(company: UUID) async throws(CardError) -> [CardRequest]
    func issue(_ issue: CardIssue) async throws(CardError) -> CompanyCard
    func change(_ card: UUID, _ action: CardAction) async throws(CardError) -> CompanyCard
    func request(company: UUID, member: UUID, vehicle: UUID?, note: String) async throws(CardError) -> CardRequest
    func decline(_ request: UUID, by member: UUID) async throws(CardError)
}

/// Cards through PostgREST and the card functions.
public nonisolated struct SupabaseCardService: CardService {
    let client: SupabaseClient

    public init(backend: Backend) { /* private */ }

    public func cards(company: UUID) async throws(CardError) -> [CompanyCard] { /* private */ }

    public func balance(company: UUID) async throws(CardError) -> CardBalance? { /* private */ }

    public func movements(company: UUID) async throws(CardError) -> [BalanceMovement] { /* private */ }

    public func requests(company: UUID) async throws(CardError) -> [CardRequest] { /* private */ }

    public func issue(_ issue: CardIssue) async throws(CardError) -> CompanyCard { /* private */ }

    public func change(_ card: UUID, _ action: CardAction) async throws(CardError) -> CompanyCard { /* private */ }

    public func request(company: UUID, member: UUID, vehicle: UUID?, note: String) async throws(CardError) -> CardRequest { /* private */ }

    public func decline(_ request: UUID, by member: UUID) async throws(CardError) { /* private */ }

    private func invoke(_ function: String, _ body: [String: JSONValue]) async throws(CardError) -> CompanyCard { /* private */ }

    static func failure(_ error: any Error) -> CardError { /* private */ }
}

/// Cards in memory with the server's rules: the demo and tests. Issuing makes a test card
/// with the last four digits Stripe's test cards have.
public actor LocalCardService: CardService {
    private var cards: [UUID: CompanyCard]
    private var balance: CardBalance?
    private var movements: [BalanceMovement]
    private var requests: [UUID: CardRequest]
    private let me: UUID
    private let role: MemberRole
    private var issued

    public init(
        cards: [CompanyCard] = [],
        balance: CardBalance? = nil,
        movements: [BalanceMovement] = [],
        requests: [CardRequest] = [],
        me: UUID,
        role: MemberRole
    ) { /* private */ }

    private var decides: Bool { /* private */ }

    public func cards(company: UUID) async throws(CardError) -> [CompanyCard] { /* private */ }

    public func balance(company: UUID) async throws(CardError) -> CardBalance? { /* private */ }

    public func movements(company: UUID) async throws(CardError) -> [BalanceMovement] { /* private */ }

    public func requests(company: UUID) async throws(CardError) -> [CardRequest] { /* private */ }

    public func issue(_ issue: CardIssue) async throws(CardError) -> CompanyCard { /* private */ }

    public func change(_ id: UUID, _ action: CardAction) async throws(CardError) -> CompanyCard { /* private */ }

    public func request(company: UUID, member: UUID, vehicle: UUID?, note: String) async throws(CardError) -> CardRequest { /* private */ }

    public func decline(_ id: UUID, by member: UUID) async throws(CardError) { /* private */ }

    /// A card payment as Stripe would approve it (the demo's live simulation). False when the
    /// card can't pay: frozen, cancelled, or beyond the balance.
    @discardableResult
    public func pay(_ cents: Int, card id: UUID, at date: Date = .now) -> Bool { /* private */ }

    /// The card a person pays with in a car: the one locked to it, else their own.
    public func card(for member: UUID, vehicle: UUID?) -> CompanyCard? { /* private */ }
}
