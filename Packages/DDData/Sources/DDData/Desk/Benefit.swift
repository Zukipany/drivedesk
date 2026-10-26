// Source code is private. This file shows only its types and signatures.

import Foundation
import Supabase

/// The tax rules for a company car's private use in one year (`public.tax_benefit_rules`,
/// US-36): read from the server's table, never decided in code. `fallback` is only what the
/// demo and an offline desk use until the table has been read.
public nonisolated struct BenefitRules: Equatable, Sendable {
    public var taxYear: Int
    public var baseRate: Double
    public var commuteRate: Double
    public var listPriceRoundingCents: Int
    public var electricShare: Double
    public var electricCapCents: Int
    public var electricOverCapShare: Double
    public var plugInHybridShare: Double
    /// Home charging paid back at a flat rate per kWh, in tenths of a cent (340 = 34 ct).
    public var homeChargingFlatMilli: Int

    public init(
        taxYear: Int,
        baseRate: Double = 0.01,
        commuteRate: Double = 0.0003,
        listPriceRoundingCents: Int = 10_000,
        electricShare: Double = 0.25,
        electricCapCents: Int = 10_000_000,
        electricOverCapShare: Double = 0.5,
        plugInHybridShare: Double = 0.5,
        homeChargingFlatMilli: Int = 340
    ) { /* private */ }

    /// The 2026 rules as seeded in migration 0020.
    public static func fallback(_ year: Int) -> BenefitRules { /* private */ }

    init(row: Row) throws(RowError) { /* private */ }

    /// The list price that counts: rounded down to whole hundreds, then the electric or
    /// plug-in hybrid share.
    public func countedListPrice(cents: Int, electric: Bool, plugInHybrid: Bool) -> Double { /* private */ }
}

/// Where the rules come from: the server's table, or the demo's.
public protocol BenefitRuleSource: Sendable {
    func rules(for year: Int) async -> BenefitRules
}

public nonisolated struct SupabaseBenefitRules: BenefitRuleSource {
    let client: SupabaseClient

    public init(backend: Backend) { /* private */ }

    public func rules(for year: Int) async -> BenefitRules { /* private */ }
}

public nonisolated struct LocalBenefitRules: BenefitRuleSource {
    public init() { /* private */ }
    public func rules(for year: Int) async -> BenefitRules { /* private */ }
}

/// Which way of taxing the private use costs the driver less (plan section 16, "1 % rule
/// against the logbook"), month by month. Information, not tax advice.
public nonisolated struct BenefitComparison: Equatable, Sendable {
    public enum Missing: Equatable, Sendable {
        /// The car has no gross list price.
        case listPrice
        /// Lease, insurance and tax for the year aren't entered.
        case fixedCosts
        /// Too few kilometres in the logbook to say anything.
        case trips
    }

    /// The taxable benefit a month with the 1 % rule, in cents.
    public var oneRuleMonthlyCents: Int?
    /// The taxable benefit a month with the logbook, in cents.
    public var logbookMonthlyCents: Int?
    /// The private and commute share of all kilometres.
    public var privateShare: Double
    public var businessKm: Double
    public var commuteKm: Double
    public var privateKm: Double
    /// The one-way commute the 1 % rule counts, from the logbook's commute trips.
    public var commuteDistanceKm: Double
    /// The car's costs in the period: energy, booked costs and the fixed costs' share.
    public var costsCents: Int
    public var months: Double
    public var missing: [Missing]

    /// The cheaper method's saving a month; positive when the logbook costs less.
    public var logbookSavesCents: Int? { /* private */ }

    public static func compare(
        listPriceCents: Int?,
        electric: Bool,
        plugInHybrid: Bool,
        rules: BenefitRules,
        trips: [CorrectedTrip],
        energyCents: Int,
        bookedCents: Int,
        fixed: VehicleFixedCost?,
        months: Double
    ) -> BenefitComparison { /* private */ }
}
