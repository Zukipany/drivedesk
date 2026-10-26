// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// One unsent change in the outbox (section 9): which row, what changed, and the server
    /// version the change was made against. A row has at most one waiting change; later
    /// edits merge into it until it is sent.
    @Model
    public final class PendingChange {
        @Attribute(.unique) public var id: UUID
        /// First in, first out.
        public var sequence: Int
        public var table: String
        public var rowID: UUID
        public var companyID: UUID
        public var operationRaw: String
        /// The columns this device changed since the server last saw the row.
        public var changedFields: [String]
        /// The changed columns' values before the first unsent edit: what the server had (JSON).
        public var base: Data
        /// The server's version the change was made against; 0 for a new row.
        public var expectedVersion: Int
        /// The role of whoever made the change, for the fill-up conflict rule.
        public var editorRoleRaw: String
        public var stateRaw: String
        public var attempts: Int
        public var lastError: String?
        /// The server's row when a conflict waits for a decision (JSON).
        public var serverRow: Data?
        /// Counts edits, so an edit made while the change was uploading is never lost.
        public var revision: Int
        public var createdAt: Date

        init(
            sequence: Int,
            table: String,
            rowID: UUID,
            companyID: UUID,
            operation: PendingOperation,
            changedFields: [String],
            base: Row,
            expectedVersion: Int,
            editorRole: MemberRole
        ) { /* private */ }
    }

    /// Where each table's pull stopped: the last row's `updated_at` exactly as the server
    /// wrote it, and its ID for rows that share that moment.
    @Model
    public final class SyncCursor {
        @Attribute(.unique) public var table: String
        public var updatedAt: String
        public var lastID: UUID

        init(table: String, updatedAt: String, lastID: UUID) { /* private */ }
    }
}

public typealias PendingChange = DDSchemaV1.PendingChange
public typealias SyncCursor = DDSchemaV1.SyncCursor

public nonisolated enum PendingOperation: String, Codable, Sendable {
    /// A row made on this device; the whole row goes up.
    case insert
    /// Only the changed columns go up, if the server still has the expected version.
    case update
}

public nonisolated enum PendingState: String, Codable, Sendable {
    /// Goes up with the next sync.
    case waiting
    /// Changed here and on the server in the same field; waits for someone to decide.
    case conflict
    /// The server refused it; kept for the person to see, never resent by itself.
    case rejected
}

extension PendingChange {
    public var operation: PendingOperation {
        get { /* private */ }
        set { /* private */ }
    }

    public var state: PendingState {
        get { /* private */ }
        set { /* private */ }
    }

    public var editorRole: MemberRole { /* private */ }

    var baseRow: Row {
        get { /* private */ }
        set { /* private */ }
    }

    var conflictingRow: Row? {
        get { /* private */ }
        set { /* private */ }
    }
}
