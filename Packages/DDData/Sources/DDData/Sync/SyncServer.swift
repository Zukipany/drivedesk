// Source code is private. This file shows only its types and signatures.

import Foundation

/// The four calls sync makes against Postgres. The live one is PostgREST through Supabase
/// (`SupabaseSyncServer`); tests use an in-memory fake with the same rules: versions and
/// `updated_at` come from the server, an update only lands on the expected version, and
/// row-level security decides what a pull returns.
public protocol SyncServer: Sendable {
    /// Inserts a row made on the device; `.duplicate` when its ID is already there.
    func insert(_ row: Row, into table: String) async throws(SyncFailure) -> Row
    /// Updates these columns if the row still has `expectedVersion`; nil when it hasn't, or
    /// when the caller may not change it.
    func update(_ columns: Row, id: UUID, expectedVersion: Int, in table: String) async throws(SyncFailure) -> Row?
    func fetch(id: UUID, from table: String) async throws(SyncFailure) -> Row?
    /// Rows changed after the cursor, oldest first, ordered by `updated_at` then ID.
    func page(of table: String, after cursor: PullCursor?, limit: Int) async throws(SyncFailure) -> [Row]
}

/// Where a pull continues: rows after this `updated_at`, or at it with a larger ID. Many rows
/// share one `updated_at` (everything a transaction wrote), so the ID breaks the tie.
public nonisolated struct PullCursor: Equatable, Sendable {
    /// Exactly as the server wrote it, so no rounding moves the cursor.
    public var updatedAt: String
    public var id: UUID

    public init(updatedAt: String, id: UUID) { /* private */ }
}

/// Why a call to the server didn't work.
public nonisolated enum SyncFailure: Error, Equatable, Sendable {
    /// No network, or the server didn't answer: try again later, in the same order.
    case offline
    /// An insert whose ID the server already has: the earlier upload landed.
    case duplicate
    /// A policy or check refused it; sending it again won't help.
    case refused(String)
    /// The server wants a newer app (HTTP 426); nothing syncs until the update.
    case upgradeRequired
    /// Something else went wrong on the server; try again later.
    case server(String)

    /// Whether trying again later can work.
    public var isTransient: Bool { /* private */ }
}
