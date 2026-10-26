// Source code is private. This file shows only its types and signatures.

import Foundation

/// One price a charging subscription, card or membership gives: at some operators'
/// chargers, or (with no operators) at every other operator where the card is accepted.
public nonisolated struct ChargingPlanRule: Codable, Hashable, Sendable {
    /// Operators as `normalized(_:)` gives them ("enbw", "ionity", "tesla", "aral pulse").
    /// Empty means every other operator: a roaming price.
    public var operators: [String]
    /// €/kWh at AC chargers; nil when the plan has no price for AC there.
    public var acPerKWh: Double?
    /// €/kWh at DC fast chargers; nil when the plan has no price for DC there.
    public var dcPerKWh: Double?

    public var isRoaming: Bool { /* private */ }

    public func price(isFast: Bool) -> Double? { /* private */ }

    /// How an operator is compared: folded and without its legal form, so MobiData's
    /// "ENBW" and "Tesla, Inc." and OpenStreetMap's "IONITY GmbH" match the plan's operators.
    /// A separate company with a similar name ("EnBW Ostwürttemberg DonauRies") doesn't.
    public static func normalized(_ operatorName: String) -> String { /* private */ }

    public init(
        operators: [String],
        acPerKWh: Double? = nil,
        dcPerKWh: Double? = nil
    ) { /* private */ }
}

/// A plan the driver added, by name, with its prices.
public nonisolated struct ChargingPlan: Hashable, Sendable {
    public let name: String
    public let rules: [ChargingPlanRule]

    public init(
        name: String,
        rules: [ChargingPlanRule]
    ) { /* private */ }
}

/// The plan price used at one charger.
public nonisolated struct AppliedChargingPlan: Hashable, Sendable {
    public let planName: String
    public let pricePerKWh: Double
    /// The plan's price for other networks, which only holds where the card is accepted.
    public let isRoaming: Bool

    public init(
        planName: String,
        pricePerKWh: Double,
        isRoaming: Bool
    ) { /* private */ }
}

public nonisolated enum ChargingPlans {
    /// The cheapest price any of the plans gives at this charger. Within one plan the
    /// operator's own price comes first, then the plan's price for other networks.
    /// A charger without a known operator gets no plan price: nobody can say which cards work there.
    public static func best(operatorName: String?, isFast: Bool, plans: [ChargingPlan]) -> AppliedChargingPlan? { /* private */ }

    private static func price(of plan: ChargingPlan, operator key: String, isFast: Bool) -> AppliedChargingPlan? { /* private */ }
}

/// Subscriptions common in Germany, with their prices as of October 2026 (Dr. Web,
/// ecomento, Einfach E-Auto, elektronik-zeit). Stored by id, so an app update can change the
/// prices without the driver adding the plan again.
public nonisolated struct ChargingPlanPreset: Identifiable, Hashable, Sendable {
    public let id: String
    public let name: String
    public let summary: String
    public let rules: [ChargingPlanRule]

    public var plan: ChargingPlan { /* private */ }

    public static let all: [ChargingPlanPreset]

    public static func preset(id: String?) -> ChargingPlanPreset? { /* private */ }

    public static let enbwS

    public static let enbwL

    public static let ionityPower

    public static let ionityMotion

    /// 0.40–0.55 €/kWh depending on the site and time of day; the highest is used, so the
    /// map never promises less than the driver pays.
    public static let tesla

    public static let adac

    /// Operators a custom plan can be set for: the biggest networks in the MobiData BW feed,
    /// spelled as drivers know them.
    public static let operators

    public init(
        id: String,
        name: String,
        summary: String,
        rules: [ChargingPlanRule]
    ) { /* private */ }
}
