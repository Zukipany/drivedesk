// Source code is private. This file shows only its types and signatures.

import Foundation
@testable import DDData

/// Postgres and PostgREST in memory, with the rules sync relies on: the server sets
/// `version` and `updated_at` (the `touch_row` trigger), an update only lands on the
/// expected version, IDs are unique, and pulls come oldest first by `updated_at` then ID.
nonisolated final class FakeSyncServer: SyncServer, @unchecked Sendable {
    private let lock
    private var tables: [String: [UUID: Row]]
    private var tick
    private var log: [String]

    /// No network: every call fails before it reaches the server.
    var isOffline
    /// The next write reaches the database, but its answer never comes back.
    var losesNextAnswer
    /// Calls that still get through before the network drops.
    var callsBeforeOffline: Int?
    /// A policy or check: returns why a written row is refused, or nil.
    var refuses: (@Sendable (_ table: String, _ row: Row) -> String?)?
    /// Runs on the main actor while a write is on its way, as a person editing meanwhile.
    var whileWriting: (@MainActor @Sendable () -> Void)?

    /// What reached the server, in order: "insert fillups 0190…", "update …", "page …".
    var requests: [String] { /* private */ }

    func rows(in table: String) -> [Row] { /* private */ }

    func row(_ id: UUID, in table: String) -> Row? { /* private */ }

    /// Rows already on the server, written in one transaction: they share one `updated_at`.
    func seed(_ rows: [Row], in table: String) { /* private */ }

    /// Someone else changes a row on the server: a manager on the desk, another phone.
    func edit(_ id: UUID, in table: String, _ columns: Row) { /* private */ }

    // MARK: SyncServer

    func insert(_ row: Row, into table: String) async throws(SyncFailure) -> Row { /* private */ }

    func update(_ columns: Row, id: UUID, expectedVersion: Int, in table: String) async throws(SyncFailure) -> Row? { /* private */ }

    func fetch(id: UUID, from table: String) async throws(SyncFailure) -> Row? { /* private */ }

    func page(of table: String, after cursor: PullCursor?, limit: Int) async throws(SyncFailure) -> [Row] { /* private */ }

    // MARK: Plumbing

    private func reach(_ request: String) throws(SyncFailure) { /* private */ }

    private func answerBack() async throws(SyncFailure) { /* private */ }

    /// The `touch_row` trigger: a new version and `updated_at` on every write.
    private func write(_ columns: Row, to id: UUID, in table: String) -> Row? { /* private */ }

    /// Postgres' own format: microseconds and an offset.
    private func stamp() -> String { /* private */ }
}
