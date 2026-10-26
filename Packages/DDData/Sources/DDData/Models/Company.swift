// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A customer company (`public.companies`). Only the owner changes it.
    @Model
    public final class Company {
        @Attribute(.unique) public var id: UUID
        public var name: String
        /// "GmbH", "GmbH & Co. KG", "e.K." …
        public var legalForm: String?
        public var vatID: String?
        public var street: String?
        public var postalCode: String?
        public var city: String?
        /// ISO 3166 country code; "DE" for every pilot company.
        public var country: String
        public var plan: String
        /// `companies.settings` as JSON, read from the server: the daily check, the licence
        /// interval and the like. The app doesn't write it back.
        public var settingsJSON: String

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            name: String,
            legalForm: String? = nil,
            vatID: String? = nil,
            street: String? = nil,
            postalCode: String? = nil,
            city: String? = nil,
            country: String = "DE",
            plan: String = "pilot",
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

extension Company: SyncedRecord {
    /// A company is its own tenant.
    public var companyID: UUID { /* private */ }

    private var settings: [String: JSONValue] { /* private */ }

    /// Whether drivers do the daily check before the first trip (US-41).
    public var dailyCheckEnabled: Bool { /* private */ }

    /// Months between licence checks (US-38), 6 unless set.
    public var licenceIntervalMonths: Int { /* private */ }
}
