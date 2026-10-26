// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// Who has which car when (`public.assignments`): a permanent company car or a pool
    /// booking. Answers "who drove car X at time T" for fines and the logbook.
    @Model
    public final class Assignment {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var memberID: UUID
        public var kindRaw: String
        public var startsAt: Date
        /// Nil while it lasts; an assignment ends, it is never deleted.
        public var endsAt: Date?

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            memberID: UUID,
            kind: AssignmentKind = .permanent,
            startsAt: Date = .now,
            endsAt: Date? = nil,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

extension Assignment: SyncedRecord {
    public var kind: AssignmentKind {
        get { /* private */ }
        set { /* private */ }
    }

    /// Whether the member has the car at `date`: started, and not ended yet.
    public func isCurrent(at date: Date = .now) -> Bool { /* private */ }
}
