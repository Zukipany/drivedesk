// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

/// Where a local row stands against the server (plan section 9). Each unsent row shows a
/// small clock badge that turns into a check when it lands.
public nonisolated enum SyncState: String, Codable, CaseIterable, Sendable {
    /// The same as the server's row.
    case synced
    /// Changed on this device, waiting in the outbox.
    case pending
    /// Changed here and on the server in the same field; someone has to decide which wins.
    case conflict
    /// The server refused the change (a policy or a check); it stays here, unsent.
    case rejected

    /// Still has to reach the server, or someone has to look at it.
    public var isUnsent: Bool { /* private */ }
}

/// A row the local store mirrors from Postgres. Every table has the same bookkeeping: the
/// company it belongs to (row-level security checks it on every read and write), the
/// server's version and `updated_at` (set by a trigger, never by the app), and where the row
/// stands in sync.
public protocol SyncedRecord: PersistentModel {
    var id: UUID { get }
    var companyID: UUID { get }
    /// The server's version of the row; 0 until it has been uploaded once.
    var version: Int { get set }
    /// The server's `updated_at`; nil until the row has been uploaded once.
    var updatedAt: Date? { get set }
    var syncStateRaw: String { get set }
}

extension SyncedRecord {
    public var syncState: SyncState {
        get { /* private */ }
        set { /* private */ }
    }

    /// Known to the server: uploaded at least once, or pulled from it.
    public var existsOnServer: Bool { /* private */ }
}
