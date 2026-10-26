// Source code is private. This file shows only its types and signatures.

import Foundation

/// Sorting and price statistics for chargers. AC and DC are ranked separately:
/// DC is always dearer, so mixing them would hide the cheapest fast charger.
public nonisolated enum ChargerRanking {
    /// Priced chargers first (cheapest, then nearest), then unpriced ones by distance.
    public static func sorted(_ chargers: [ChargePoint]) -> [ChargePoint] { /* private */ }

    /// Min / average / max €/kWh over priced chargers.
    public static func stats(_ chargers: [ChargePoint]) -> StationRanking.PriceStats? { /* private */ }

    /// What charging `kWh` at the cheapest charger saves against the average one.
    /// Example: average 0.79, cheapest 0.48, 40 kWh → 12.40 €.
    public static func savings(_ stats: StationRanking.PriceStats, kWh: Double) -> Double { /* private */ }
}
