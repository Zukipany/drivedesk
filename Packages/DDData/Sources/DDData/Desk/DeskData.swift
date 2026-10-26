// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData
import Supabase

/// One row of `v_spend_monthly`: a car, a person, a fuel and a month.
public nonisolated struct SpendRow: Equatable, Sendable {
    /// The month's first day (a date without time, 00:00 UTC).
    public var month: Date
    public var groupID: UUID?
    public var vehicleID: UUID
    public var memberID: UUID
    public var kind: FillUpKind
    public var fuelType: FuelType
    public var fillups: Int
    public var quantity: Double
    public var spendCents: Int
    public var vatCents: Int
    public var cardCents: Int
    public var cardWithoutReceipt: Int
    public var minOdometerKm: Int?
    public var maxOdometerKm: Int?

    public init(
        month: Date,
        groupID: UUID?,
        vehicleID: UUID,
        memberID: UUID,
        kind: FillUpKind,
        fuelType: FuelType,
        fillups: Int,
        quantity: Double,
        spendCents: Int,
        vatCents: Int = 0,
        cardCents: Int = 0,
        cardWithoutReceipt: Int = 0,
        minOdometerKm: Int? = nil,
        maxOdometerKm: Int? = nil
    ) { /* private */ }

    init(row: Row) throws(RowError) { /* private */ }
}

/// One row of `v_savings_monthly`: a person's saved and missed totals in a month.
public nonisolated struct SavingsRow: Equatable, Sendable {
    public var month: Date
    public var memberID: UUID
    public var litres: Double
    public var savedCents: Int
    /// Only managers, owners and the accountant get it.
    public var missedCents: Int?

    public init(month: Date, memberID: UUID, litres: Double, savedCents: Int, missedCents: Int?) { /* private */ }

    init(row: Row) throws(RowError) { /* private */ }
}

/// An undecided flag (`public.flags`): open, explained by the driver, or escalated.
public nonisolated struct FlagRow: Equatable, Sendable, Identifiable {
    public var id: UUID
    /// 2 medium, 3 high.
    public var severity: Int
    public var status: String
    public var createdAt: Date
    public var memberID: UUID?
    public var vehicleID: UUID?
    /// The fill-up it's about, for flags on a fill-up.
    public var fillupID: UUID?
    public var score: Int

    public init(
        id: UUID,
        severity: Int,
        status: String,
        createdAt: Date,
        memberID: UUID?,
        vehicleID: UUID?,
        fillupID: UUID? = nil,
        score: Int
    ) { /* private */ }

    init(row: Row) throws(RowError) { /* private */ }
}

/// One row of `v_compliance_due`: a reminder or document due within 30 days.
public nonisolated struct ComplianceRow: Equatable, Sendable {
    public var vehicleID: UUID
    /// "reminder" or "document".
    public var source: String
    /// A reminder kind (inspection, service, tyres, uvv) or a document kind.
    public var kind: String
    public var dueOn: Date
    public var daysLeft: Int

    public init(vehicleID: UUID, source: String, kind: String, dueOn: Date, daysLeft: Int) { /* private */ }

    init(row: Row) throws(RowError) { /* private */ }

    /// "TÜV inspection", "Insurance card".
    public var label: String { /* private */ }
}

/// What the desk overview is computed from.
public nonisolated struct DeskSnapshot: Sendable {
    public var spend: [SpendRow]
    public var savings: [SavingsRow]
    public var flags: [FlagRow]
    public var compliance: [ComplianceRow]
    public var fetchedAt: Date
    /// Kept on this device from an earlier answer, because the server couldn't be reached.
    public var isOffline

    public init(spend: [SpendRow], savings: [SavingsRow], flags: [FlagRow], compliance: [ComplianceRow], fetchedAt: Date, isOffline: Bool = false) { /* private */ }
}

/// Where the desk's numbers come from: the server's views, or this device's store (the demo).
public protocol DeskSource: Sendable {
    func snapshot(company: UUID, now: Date) async throws(SyncFailure) -> DeskSnapshot
}

/// The desk views through PostgREST, as the signed-in manager (ADR 002: the desk reads views,
/// never raw tables). The last answer is kept, so the desk opens offline with it, marked.
public nonisolated struct SupabaseDeskSource: DeskSource {
    let client: SupabaseClient
    let cache: URL

    public init(backend: Backend, cache: URL = URL.cachesDirectory.appending(path: "desk-snapshot.json")) { /* private */ }

    public func snapshot(company: UUID, now: Date) async throws(SyncFailure) -> DeskSnapshot { /* private */ }

    /// The raw rows, as kept on the device.
    struct Kept: Codable {
        let spend: [Row]
        let savings: [Row]
        let flags: [Row]
        let compliance: [Row]
        let fetchedAt: Date

        func snapshot() -> DeskSnapshot { /* private */ }
    }
}

/// The same numbers computed from this device's store, the way the views compute them: for
/// the demo, which has no server, and for tests.
public struct LocalDeskSource: DeskSource {
    struct SpendKey: Hashable {
        let month: Date
        let vehicle: UUID
        let member: UUID
        let fuel: FuelType
    }

    /// One v_spend_monthly row from the fill-ups of a month, car, person and fuel.
    static func spendRow(_ key: SpendKey, _ rows: [FillUp], group: UUID?) -> SpendRow { /* private */ }

    let store: LocalStore
    /// Flags don't sync to the device yet; the demo hands its own, or its flag service.
    let flags: [FlagRow]
    let flagService: (any FlagService)?

    public init(store: LocalStore, flags: [FlagRow] = [], flagService: (any FlagService)? = nil) { /* private */ }

    public func snapshot(company: UUID, now: Date) async throws(SyncFailure) -> DeskSnapshot { /* private */ }
}
