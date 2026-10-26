// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A group of cars ("Site Munich", `public.groups`). Every car belongs to one from day one;
    /// a new company starts with a group named after it. Everyone in the company sees them,
    /// the owner manages them.
    @Model
    public final class FleetGroup {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var name: String
        public var costCentre: String?

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            name: String,
            costCentre: String? = nil,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

extension FleetGroup: SyncedRecord {}

public typealias FleetGroup = DDSchemaV1.FleetGroup
