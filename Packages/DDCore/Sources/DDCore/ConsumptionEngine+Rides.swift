// Source code is private. This file shows only its types and signatures.

import Foundation

/// The engine's second stage: what the roads and the driving add, learned from recorded rides.
///
/// Stage one (`fit`) explains each measured stretch by its temperature. Where recorded rides
/// cover a stretch, its leftover (measured minus stage one) is explained by how it was
/// driven: motorway share, city share, harsh accelerations and brakings, and climbing, each
/// compared with the driver's usual mix. Every effect starts at what typical cars show and
/// moves towards the driver's own numbers as covered stretches come in.
nonisolated extension ConsumptionEngine {
    /// The ride features of a stretch (or a trip), km-weighted.
    public struct Driving: Codable, Equatable, Sendable {
        public var motorwayShare: Double
        public var cityShare: Double
        public var harshPer100km: Double
        public var climbPer100km: Double

        /// A typical mix before any ride is recorded.
        public static let typical

        public var values: [Double] { /* private */ }

        public init(
            motorwayShare: Double,
            cityShare: Double,
            harshPer100km: Double,
            climbPer100km: Double
        ) { /* private */ }
    }

    /// A stretch counts as covered when rides recorded this share of its km.
    public static let coverageNeeded

    /// What typical cars use more, as a share of their base, per unit of each feature:
    /// all-motorway +20 % (electric +35 %), all-city +15 % (electric ±0: it recuperates),
    /// 10 harsh events per 100 km +5 %, 1,000 m climbed per 100 km +10 % (electric +5 %).
    public static func typicalEffects(electric: Bool) -> [Double] { /* private */ }

    /// How sure the typical effects are: their usual spread across drivers' stretches.
    public static let featureSpread

    public struct DrivingModel: Codable, Equatable, Sendable {
        /// Stage one: temperature.
        public let weather: Model
        /// Extra l or kWh per 100 km per unit of each `Driving` value, against `usual`.
        public let effects: [Double]
        /// The driver's usual mix (the covered stretches' mean, or `Driving.typical`).
        public let usual: Driving
        /// Covered stretches the effects were learned from.
        public let coveredIntervals: Int
        /// 0…1 per effect: how much is learned rather than typical.
        public let learnedShares: [Double]

        public func predict(temperature: Double, driving: Driving) -> Double { /* private */ }

        public init(
            weather: Model,
            effects: [Double],
            usual: Driving,
            coveredIntervals: Int,
            learnedShares: [Double]
        ) { /* private */ }
    }

    /// The stretches' driving from the rides inside them: (stretch index, driving, coverage).
    public static func driving(for intervals: [Interval], rides: [(start: Date, km: Double, analysis: RideAnalysis)]) -> [Int: (Driving, Double)] { /* private */ }

    /// Stage two on top of `weather`. Works without any covered stretch (typical effects).
    public static func fitDriving(
        _ intervals: [Interval],
        weather: Model,
        driving: [Int: (Driving, Double)],
        electric: Bool
    ) -> DrivingModel { /* private */ }

    /// Gaussian elimination with partial pivoting; nil for a singular system.
    public static func solve(_ matrix: [[Double]], _ vector: [Double]) -> [Double]? { /* private */ }

    /// A route's driving from its average speed (Apple's route has no speed per road):
    /// fast averages mean motorway, slow ones town.
    public static func routeDriving(averageKmh: Double, usual: Driving) -> Driving { /* private */ }
}
