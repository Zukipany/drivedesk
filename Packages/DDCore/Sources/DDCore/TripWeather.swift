// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation

/// The weather along a route at the hour the car passes each point (measure 5b), from a
/// forecast for the start, the destination and every point between.
public nonisolated enum TripWeather {
    /// A point every this many km gets its own forecast, at most `maxPoints` points.
    public static let spacingKm
    public static let maxPoints

    /// One forecast point: where, when the car is there, and the weather then.
    public struct Sample: Codable, Equatable, Sendable {
        public let km: Double
        public let latitude: Double
        public let longitude: Double
        public let eta: Date
        /// °C at 2 m.
        public var temperature: Double?
        /// mm in that hour.
        public var precipitation: Double?
        /// cm in that hour.
        public var snowfall: Double?

        public init(
            km: Double,
            latitude: Double,
            longitude: Double,
            eta: Date,
            temperature: Double? = nil,
            precipitation: Double? = nil,
            snowfall: Double? = nil
        ) { /* private */ }
    }

    /// What the summary line says: the coldest and warmest point, and where it rains or snows.
    public struct Summary: Codable, Equatable, Sendable {
        public let lowest: Double
        public let highest: Double
        /// km of the first point with rain, nil when dry.
        public let rainFromKm: Double?
        /// km of the first point with snow.
        public let snowFromKm: Double?
        /// The factors the plan used, distance-weighted over the route.
        public let fuelFactor: Double
        public let electricFactor: Double

        public init(
            lowest: Double,
            highest: Double,
            rainFromKm: Double?,
            snowFromKm: Double?,
            fuelFactor: Double,
            electricFactor: Double
        ) { /* private */ }
    }

    /// The points to ask for: the start, every `spacingKm`, the destination, each with the
    /// time the car is there (departure + driving time to it).
    public static func samples(route: RouteProfile, departure: Date) -> [Sample] { /* private */ }

    // MARK: Effect on consumption

    /// Below this an electric car needs heating and a warm battery: up to `electricColdExtra`
    /// more at 0 °C, at most `electricColdCap` (ADAC winter tests: 20–40 %).
    public static let electricComfortTemperature
    public static let electricColdExtra
    public static let electricColdCap
    /// Above this the air conditioning costs an electric car a little (+5 %).
    public static let electricHotTemperature
    public static let electricHotExtra
    /// A cold engine and denser air cost a combustion car a little: +5 % at −5 °C (15 °C
    /// below 10 °C), at most +8 %.
    public static let fuelComfortTemperature
    public static let fuelColdExtra
    public static let fuelColdCap
    /// Wet roads (0.5 mm an hour or more) add rolling resistance: +5 %; snow +10 %.
    public static let rainThreshold
    public static let rainExtra
    public static let snowExtra

    /// The factor at one point.
    public static func factor(_ sample: Sample, electric: Bool) -> Double { /* private */ }

    /// The factor over the whole route: each point counts for the km until the next one.
    /// Nil when no point has a forecast (offline): the plan falls back to the season.
    public static func summary(_ samples: [Sample]) -> Summary? { /* private */ }
}

/// Open-Meteo's forecast (no key, CC BY 4.0, free for non-commercial use under 10,000
/// requests a day): one request for every point of the route, hourly, times in Unix seconds.
public nonisolated enum OpenMeteoAPI {
    public static let attributionURL

    public static func request(_ samples: [TripWeather.Sample], now: Date = .now) -> URLRequest { /* private */ }

    private struct Hourly: Decodable {
        let time: [Double]
        let temperature2m: [Double?]
        let precipitation: [Double?]
        let snowfall: [Double?]

        private enum CodingKeys: String, CodingKey {
            case time, precipitation, snowfall
            case temperature2m
        }
    }

    private struct Location: Decodable {
        let hourly: Hourly
    }

    /// The samples with the hour nearest to each one's arrival. One location answers as an
    /// object, several as a list in the order asked.
    public static func decode(_ data: Data, into samples: [TripWeather.Sample]) throws -> [TripWeather.Sample] { /* private */ }
}

nonisolated extension Array {
    public subscript(safe index: Int) -> Element? { /* private */ }
}
