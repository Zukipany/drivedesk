// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A person's membership in one company (`public.members`): their role, site and cost
    /// centre there. A driver's phone only ever holds their own member row; managers and
    /// owners see everyone in the company.
    @Model
    public final class Member {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        /// The sign-in account (`auth.users`).
        public var userID: UUID
        public var roleRaw: String
        public var statusRaw: String
        public var displayName: String
        public var personnelNumber: String?
        public var costCentre: String?
        public var groupID: UUID?
        public var joinedAt: Date

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            userID: UUID,
            role: MemberRole,
            status: MemberStatus = .active,
            displayName: String = "",
            personnelNumber: String? = nil,
            costCentre: String? = nil,
            groupID: UUID? = nil,
            joinedAt: Date = .now,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

extension Member: SyncedRecord {
    public var role: MemberRole {
        get { /* private */ }
        set { /* private */ }
    }

    public var status: MemberStatus {
        get { /* private */ }
        set { /* private */ }
    }

    public var isActive: Bool { /* private */ }
}
