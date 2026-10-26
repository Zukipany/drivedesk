// Source code is private. This file shows only its types and signatures.

import Foundation

/// Sorting and price statistics for the station list and map pins.
public nonisolated enum StationRanking {
    public struct PriceStats: Equatable, Sendable {
        public let min: Double
        public let average: Double
        public let max: Double
        public let count: Int

        public init(
            min: Double,
            average: Double,
            max: Double,
            count: Int
        ) { /* private */ }
    }

    public enum Tier: Equatable, Sendable {
        /// The single cheapest open station.
        case cheapest
        case cheap, average, expensive
    }

    /// Open stations with a price first (cheapest first), then closed ones,
    /// then stations that don't sell this fuel. Ties go to the nearer station.
    public static func sorted(_ stations: [Station], by fuel: FuelType) -> [Station] { /* private */ }

    private static func rank(_ station: Station, _ fuel: FuelType) -> Int { /* private */ }

    /// Min / average / max over open stations that sell the fuel.
    public static func stats(_ stations: [Station], fuel: FuelType) -> PriceStats? { /* private */ }

    public static func cheapest(_ stations: [Station], fuel: FuelType) -> Station? { /* private */ }

    /// What filling `liters` at the cheapest station saves compared with the average.
    /// Example: average 1.789, cheapest 1.729, 60 l → 3.60 €.
    public static func savings(_ stats: PriceStats, liters: Double) -> Double { /* private */ }

    /// Bottom 20 % of the price range is cheap, top 20 % expensive.
    public static func tier(price: Double, stats: PriceStats, isCheapest: Bool) -> Tier { /* private */ }
}
