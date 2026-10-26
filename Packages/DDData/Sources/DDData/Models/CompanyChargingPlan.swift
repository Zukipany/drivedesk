// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A charging card or subscription the company pays for (`public.charging_plans`, US-19):
    /// its price per kWh at some operators' chargers and elsewhere. Everyone in the company
    /// reads them; managers and owners set them; a plan is switched off, not deleted.
    @Model
    public final class CompanyChargingPlan {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var name: String
        /// A known subscription (`ChargingPlanPreset.id`), whose prices the app keeps current.
        public var presetID: String?
        /// `[ChargingPlanRule]` as JSON.
        public var rulesData: Data
        public var monthlyFeeCents: Int?
        public var isActive: Bool

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            name: String,
            presetID: String? = nil,
            rules: [ChargingPlanRule] = [],
            monthlyFeeCents: Int? = nil,
            isActive: Bool = true,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

extension CompanyChargingPlan: SyncedRecord {
    public var rules: [ChargingPlanRule] {
        get { /* private */ }
        set { /* private */ }
    }

    /// The plan as the map prices it: a preset's current prices, else the stored ones.
    public var plan: ChargingPlan { /* private */ }

    /// The active plans of a company, as the map uses them.
    public static func plans(_ records: [CompanyChargingPlan]) -> [ChargingPlan] { /* private */ }
}

public typealias CompanyChargingPlan = DDSchemaV1.CompanyChargingPlan
