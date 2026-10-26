// Source code is private. This file shows only its types and signatures.

import Foundation
import Supabase
import SwiftData

/// One line of the audit log (plan S4, section 19): who changed which row, when, and what.
/// Triggers write it on the server; managers, owners and accountants read it.
public nonisolated struct AuditEntry: Equatable, Sendable, Identifiable {
    public enum Action: String, Sendable {
        case insert, update, delete
    }

    /// A changed column, with its values as text.
    public struct Change: Equatable, Sendable {
        public var field: String
        public var before: String?
        public var after: String?

        public init(field: String, before: String?, after: String?) { /* private */ }
    }

    public var id: String
    public var at: Date
    public var action: Action
    public var table: String
    public var rowID: UUID
    /// Nil for the server itself (a card import, a nightly job).
    public var actorMemberID: UUID?
    /// For updates, what changed; bookkeeping columns are left out.
    public var changes: [Change]
    /// For inserts and deletes, the row's telling values: plate, name, role, dates.
    public var values: [String: String]

    public init(
        id: String,
        at: Date,
        action: Action,
        table: String,
        rowID: UUID,
        actorMemberID: UUID?,
        changes: [Change] = [],
        values: [String: String] = [:]
    ) { /* private */ }

    /// Columns that say nothing to a person reading the log.
    static let hidden: Set<String>

    init(row: Row) throws(RowError) { /* private */ }

    static func object(_ value: JSONValue?) -> Row { /* private */ }

    static func values(_ row: Row) -> [String: String] { /* private */ }

    /// A column's value as text: arrays joined, nil for null.
    static func text(_ value: JSONValue?) -> String? { /* private */ }
}

/// Where the audit log comes from.
public protocol AuditSource: Sendable {
    /// The newest entries first; `rows` narrows them to some rows (a car, a person).
    func entries(company: UUID, rows: [UUID]?, limit: Int) async throws(SyncFailure) -> [AuditEntry]
}

/// The audit log through PostgREST; the table's policy lets managers, owners and accountants
/// read their company's.
public nonisolated struct SupabaseAuditSource: AuditSource {
    let client: SupabaseClient

    public init(backend: Backend) { /* private */ }

    public func entries(company: UUID, rows: [UUID]?, limit: Int) async throws(SyncFailure) -> [AuditEntry] { /* private */ }
}

/// The demo's audit log: the changes made on this device, from the outbox, after any
/// entries it starts with. Nothing reaches a server, so the outbox holds every change.
public struct LocalAuditSource: AuditSource {
    let store: LocalStore
    let seed: [AuditEntry]
    /// Who made the device's changes.
    let actor: UUID?

    public init(store: LocalStore, actor: UUID?, seed: [AuditEntry] = []) { /* private */ }

    public func entries(company: UUID, rows: [UUID]?, limit: Int) async throws(SyncFailure) -> [AuditEntry] { /* private */ }
}
