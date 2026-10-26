// Source code is private. This file shows only its types and signatures.

import Foundation

/// What the car uses on a trip, which differs from its everyday average.
public nonisolated enum TripConsumption {
    /// Extra use at motorway speed, combustion share (+20 %)…
    public static let motorwayExtraFuel
    /// …and electric (+35 %).
    public static let motorwayExtraElectric
    /// Electric cars in winter (December–February) use this much more (+25 %)…
    public static let winterExtraElectric
    /// …in November and March (+12 %)…
    public static let coolExtraElectric
    /// …and combustion cars in winter (+5 %).
    public static let winterExtraFuel

    /// Extra use from speed (measure 5a). Drag grows with the square of speed: a petrol car
    /// at 130 km/h uses about 20 % more than its mixed figure, an electric car about 35 %
    /// (ADAC Autobahn tests). The route's average speed includes towns and traffic, so 110 km/h
    /// on average already means long fast stretches.
    public static func speedFactor(averageKmh: Double, electric: Bool) -> Double { /* private */ }

    /// Extra use from cold (measure 5b): heating and a cold battery cost an electric car
    /// 20–30 % in winter, a combustion car about 5 %. Nil `cold` means decide by the month.
    public static func coldFactor(month: Int, cold: Bool?, electric: Bool) -> Double { /* private */ }

    /// The everyday figure to start from (measure 5c): the driver's own measured average
    /// once it covers 500 km, otherwise the rated figure plus 10 % (WLTP is optimistic).
    public static func baseline(measured: FuelMath.Averages?, rated: Double) -> Double { /* private */ }

    /// The trip figure: baseline × speed × weather, with the parts for the summary line.
    public struct Figure: Codable, Equatable, Sendable {
        public let per100km: Double
        public let baseline: Double
        public let speedFactor: Double
        public let weatherFactor: Double
        public let isMeasured: Bool
        /// Measured stretches the consumption engine learned the weather effect from; nil
        /// when typical cars' figures were used.
        public var learnedFrom: Int?

        public init(
            per100km: Double,
            baseline: Double,
            speedFactor: Double,
            weatherFactor: Double,
            isMeasured: Bool,
            learnedFrom: Int? = nil
        ) { /* private */ }
    }

    /// - Parameter weatherFactor: from the forecast along the route (`TripWeather`), or by
    ///   season when it can't be loaded (`coldFactor`).
    public static func figure(
        measured: FuelMath.Averages?,
        rated: Double,
        averageKmh: Double,
        weatherFactor: Double,
        electric: Bool
    ) -> Figure { /* private */ }

    // MARK: Level when leaving (measure 1b)

    /// Where the gauge is probably now: the last known level, minus the km driven since at
    /// the car's usual km per day. Nil without a known level in the log.
    public static func estimatedLevel(
        lastLevel: Double?,
        lastDate: Date?,
        kmPerDay: Double,
        per100km: Double,
        capacity: Double,
        now: Date = .now
    ) -> Double? { /* private */ }

    /// km per day over the log: last odometer minus the first, over the days between.
    public static func kmPerDay(_ entries: [some FuelEntry]) -> Double { /* private */ }

    // MARK: Electric cars (measure 6)

    public enum Plug: String, Codable, CaseIterable, Sendable {
        case ccs, chademo, type2, nacs

        public var label: String { /* private */ }

        /// What sources call it: "CCS", "CCS1", "Combo 2", "IEC 62196 Type 2"…
        public static func matching(_ kind: String?) -> Plug? { /* private */ }
    }

    /// Minutes to charge `kWh` at a charger: the power the car and charger agree on, at 75 %
    /// on average from 10 to 80 % (the curve tapers), plus 3 minutes to plug in and pay.
    public static func chargingMinutes(kWh: Double, chargerKW: Double?, carMaxKW: Double) -> Double { /* private */ }

    // MARK: Plug-in hybrids (measure 7)

    /// km on electricity when leaving: battery level × size ÷ electric use, with the speed
    /// and weather factors too.
    public static func electricKm(batteryLevel: Double, batteryKWh: Double, electricPer100km: Double, factor: Double) -> Double { /* private */ }
}
