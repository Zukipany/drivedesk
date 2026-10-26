// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A monthly budget for the company, a group, a car or a person (`public.budgets`). A
    /// driver's phone holds their own and their car's.
    @Model
    public final class Budget {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var scopeRaw: String
        public var groupID: UUID?
        public var vehicleID: UUID?
        public var memberID: UUID?
        /// The first day of the month it applies to (a date without time, 00:00 UTC).
        public var month: Date
        public var amountCents: Int

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            scope: BudgetScope,
            groupID: UUID? = nil,
            vehicleID: UUID? = nil,
            memberID: UUID? = nil,
            month: Date,
            amountCents: Int,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

extension Budget: SyncedRecord {
    public var scope: BudgetScope {
        get { /* private */ }
        set { /* private */ }
    }

    public var amount: Double { /* private */ }
}
