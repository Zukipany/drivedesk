// Source code is private. This file shows only its types and signatures.

import Foundation
import Observation
import SwiftData

/// Keeps the local store and Postgres in step (section 9). A sync first drains the outbox,
/// first in first out, each change an upload that only lands on the version it was made
/// against; then it pulls every table's rows changed since its cursor, 500 at a time.
/// Row-level security does the filtering, so a driver's phone only ever receives their own.
@Observable
public final class SyncEngine {
    public enum Status: Equatable, Sendable {
        case idle
        case syncing
        /// The last sync couldn't reach the server; changes wait in the outbox.
        case offline
        /// The server wants a newer app: "Please update" instead of syncing.
        case upgradeRequired
        case failed(String)
    }

    public private(set) var status
    /// Changes waiting for the network, for the offline capsule.
    public private(set) var waitingCount
    public private(set) var lastSynced: Date?

    /// Rows per pull request.
    public static let pageSize

    private let store: LocalStore
    private let server: any SyncServer
    private let receipts: (any ReceiptFileStore)?
    private let tables: [SyncTable]
    private var running: Task<Void, Never>?

    public init(
        store: LocalStore,
        server: any SyncServer,
        receipts: (any ReceiptFileStore)? = nil,
        tables: [SyncTable] = SyncTable.all
    ) { /* private */ }

    private var context: ModelContext { /* private */ }
    private var outbox: Outbox { /* private */ }

    /// Uploads what waits, then pulls what changed. A sync asked for while one runs waits
    /// for it instead of running twice, so nothing is ever sent twice at once.
    public func sync() async { /* private */ }

    private func run() async { /* private */ }

    // MARK: Push

    /// Sends the outbox in order. A change the network couldn't take stops the drain, so
    /// nothing overtakes it; a refused one is set aside with the later changes to its row.
    func push() async throws(SyncFailure) { /* private */ }

    private func send(_ change: PendingChange, _ record: any SyncRecord) async throws(SyncFailure) { /* private */ }

    private func sendUpdate(_ change: PendingChange, _ record: any SyncRecord, revision: Int) async throws(SyncFailure) { /* private */ }

    /// The server took the change: store its version and `updated_at` and remove the entry.
    /// An edit made while the change was on its way stays queued against the new version.
    private func finish(_ change: PendingChange, _ record: any SyncRecord, revision: Int, answer: Row) { /* private */ }

    // MARK: Receipts

    /// Uploads the photos of fill-ups whose rows are on the server, then queues each photo's
    /// path for the row. Returns how many went up. The network failing stops the uploads;
    /// a photo the bucket refuses stays here and is tried again with the next sync.
    func uploadReceipts() async throws(SyncFailure) -> Int { /* private */ }

    // MARK: Pull

    /// Pulls every table's rows changed since its cursor, in pages, oldest first. A row with
    /// unsent changes here keeps them: the outbox settles it against the server's version.
    func pull() async throws(SyncFailure) { /* private */ }

    private func merge(_ rows: [Row], as model: any SyncRecord.Type) { /* private */ }

    private func savedCursor(_ table: String) -> PullCursor? { /* private */ }

    private func saveCursor(_ cursor: PullCursor?, for table: String) { /* private */ }

    /// Recounts the outbox, after a sync or a local change.
    public func refreshCount() { /* private */ }
}
