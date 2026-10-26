// Source code is private. This file shows only its types and signatures.

import DDPrices
import DDCore
import CoreLocation
import Foundation

/// Where the car is usually driven, for the weather its fill-ups were driven in: the mean
/// position of fill-ups logged with a location, else where the map was last used.
enum DrivingArea {
    private static let latitudeKey
    private static let longitudeKey

    /// Called by the map with each new position.
    static func remember(_ coordinate: CLLocationCoordinate2D, defaults: UserDefaults = .standard) { /* private */ }

    /// - Parameter fillUps: where the car's fill-ups were logged (latitude, longitude).
    static func coordinate(fillUps placed: [(Double, Double)], defaults: UserDefaults = .standard) -> CLLocationCoordinate2D? { /* private */ }
}

/// Daily mean temperature and precipitation for an area, from Open-Meteo: its archive for
/// the past (about 5 days behind) and its forecast's `past_days` for the last days. Kept on
/// the iPhone per area (0.25° grid, about 25 km), so each day is asked for once.
@MainActor
final class WeatherHistory {
    static let shared

    nonisolated struct Day: Codable, Equatable, Sendable {
        let temperature: Double
        let precipitation: Double
    }

    /// The archive lags this many days behind today.
    static let archiveLagDays

    private let fetch: HTTP.Fetcher
    private let file: URL?
    private var cache: [String: [String: Day]]

    init(fetch: @escaping HTTP.Fetcher = HTTP.data(for:), file: URL? = WeatherHistory.defaultFile) { /* private */ }

    nonisolated static var defaultFile: URL? { /* private */ }

    nonisolated static func areaKey(_ coordinate: CLLocationCoordinate2D) -> String { /* private */ }

    /// Each calendar day from `start` to `end` with its weather; days that can't be loaded
    /// (offline, before 1940) are missing.
    func days(from start: Date, to end: Date, at coordinate: CLLocationCoordinate2D, now: Date = .now) async
        -> [Date: (temperature: Double, precipitation: Double)]
    { /* private */ }

    private func load(_ request: URLRequest, into key: String) async { /* private */ }

    private func save() { /* private */ }
}

nonisolated extension OpenMeteoAPI {
    static func archiveRequest(_ coordinate: CLLocationCoordinate2D, from start: Date, to end: Date) -> URLRequest { /* private */ }

    static func recentRequest(_ coordinate: CLLocationCoordinate2D, pastDays: Int) -> URLRequest { /* private */ }

    private struct DailyValues: Decodable {
        let time: [String]
        let temperature: [Double?]
        let precipitation: [Double?]

        private enum CodingKeys: String, CodingKey {
            case time
            case temperature
            case precipitation
        }
    }

    private struct Daily: Decodable {
        let daily: DailyValues
    }

    /// "2026-10-13" → the day's mean °C and mm; days without a temperature are left out.
    static func decodeDaily(_ data: Data) throws -> [String: WeatherHistory.Day] { /* private */ }
}
