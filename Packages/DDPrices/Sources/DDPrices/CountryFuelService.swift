// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

public nonisolated enum FuelPriceError: LocalizedError, Equatable {
    /// Spain's data is per province, found from the postal code.
    case unknownProvince

    public var errorDescription: String? { /* private */ }
}

/// Fuel prices outside Germany: the countries in `FuelPriceSource`.
/// Germany stays with `TankerkoenigService` and its fair-use rules.
///
/// These APIs publish no rate limits; the app still asks only on user action, keeps
/// results for 5 minutes per place, and whole regional files longer (Spain's provinces and
/// Portugal's districts 30 minutes, Croatia's national file and the UK's feeds an hour),
/// and falls back to older prices, marked as such, when a request fails.
public actor CountryFuelService {
    public typealias Result = TankerkoenigService.Result

    private let fetch: HTTP.Fetcher
    private let now: @Sendable () -> Date
    private let cacheLifetime: TimeInterval
    private let provinceLifetime: TimeInterval
    private let nationalLifetime: TimeInterval

    private var cache
    /// Whole files (a province, a district, a country's list), by what they cover.
    private var datasets: [String: (date: Date, data: Data)]

    public init(fetch: @escaping HTTP.Fetcher = HTTP.data(for:), now: @escaping @Sendable () -> Date = { }) { /* private */ }

    /// - Parameter postalCode: of the search point; Spain needs it for the province.
    public func stations(
        from source: FuelPriceSource,
        near coordinate: CLLocationCoordinate2D,
        radiusKm: Double,
        postalCode: String?,
        forceRefresh: Bool = false
    ) async throws -> Result { /* private */ }

    private func load(
        _ source: FuelPriceSource,
        near coordinate: CLLocationCoordinate2D,
        radiusKm: Double,
        postalCode: String?
    ) async throws -> [Station] { /* private */ }

    /// The sources added in October 2026: Portugal, Slovenia, Croatia, the UK.
    private func loadNewer(_ source: FuelPriceSource, near coordinate: CLLocationCoordinate2D, radiusKm: Double) async throws -> [Station] { /* private */ }

    /// Every retailer's feed that loads; one that's down leaves the others.
    private func ukStations(near coordinate: CLLocationCoordinate2D, radiusKm: Double) async throws -> [Station] { /* private */ }

    private func dataset(_ key: String, _ request: URLRequest, lifetime: TimeInterval) async throws -> Data { /* private */ }
}
