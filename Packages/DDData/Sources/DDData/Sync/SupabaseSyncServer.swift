// Source code is private. This file shows only its types and signatures.

import Foundation
import Supabase

/// Sync against Postgres through PostgREST, as the signed-in person: row-level security
/// decides what every call may read and write.
public nonisolated struct SupabaseSyncServer: SyncServer {
    let client: SupabaseClient

    public init(backend: Backend) { /* private */ }

    public func insert(_ row: Row, into table: String) async throws(SyncFailure) -> Row { /* private */ }

    public func update(_ columns: Row, id: UUID, expectedVersion: Int, in table: String) async throws(SyncFailure) -> Row? { /* private */ }

    public func fetch(id: UUID, from table: String) async throws(SyncFailure) -> Row? { /* private */ }

    public func page(of table: String, after cursor: PullCursor?, limit: Int) async throws(SyncFailure) -> [Row] { /* private */ }

    /// Runs a PostgREST call and says what went wrong in sync's terms.
    private func call<T: Sendable>(_ request: () async throws -> T) async throws(SyncFailure) -> T { /* private */ }

    static func failure(_ error: any Error) -> SyncFailure { /* private */ }
}
