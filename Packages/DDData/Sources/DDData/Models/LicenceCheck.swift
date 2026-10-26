// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A driving licence check (`public.licence_checks`, US-38, plan section 18): its result,
    /// date, method, who verified it, the licence's classes, expiry and restriction codes.
    /// Never an image of the licence or its number. A check is a record: a mistake is
    /// corrected by a new check.
    @Model
    public final class LicenceCheck {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var memberID: UUID
        /// The day of the check (00:00 UTC, a date without time).
        public var checkedOn: Date
        public var methodRaw: String
        public var resultRaw: String
        public var verifiedBy: UUID?
        public var classes: [String]
        public var expiresOn: Date?
        public var restrictions: [String]
        public var partnerReference: String?
        public var note: String

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            memberID: UUID,
            checkedOn: Date,
            method: LicenceCheckMethod = .inPerson,
            result: LicenceCheckResult,
            verifiedBy: UUID?,
            classes: [String] = [],
            expiresOn: Date? = nil,
            restrictions: [String] = [],
            note: String = "",
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

public nonisolated enum LicenceCheckMethod: String, Codable, CaseIterable, Sendable {
    case inPerson
    case partner

    public var label: String { /* private */ }
}

public nonisolated enum LicenceCheckResult: String, Codable, CaseIterable, Sendable {
    case valid, invalid, pending

    public var label: String { /* private */ }
}

extension LicenceCheck: SyncedRecord {
    public var method: LicenceCheckMethod { /* private */ }
    public var result: LicenceCheckResult { /* private */ }
}

public typealias LicenceCheck = DDSchemaV1.LicenceCheck
