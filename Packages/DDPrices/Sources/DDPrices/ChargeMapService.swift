// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

/// EV chargers for the map.
///
/// Source order:
/// 1. The country's official feed, no key needed:
///    - Germany (or before the country is known): MobiData BW, operators' data with
///      ad-hoc €/kWh prices and live status.
///    - US and Canada: NREL, power per connector and the operator's price text.
/// 2. Open Charge Map when a key is set: worldwide, power and connectors, no prices.
/// 3. OpenStreetMap (Overpass), no key: worldwide, often without power figures.
///
/// A source that fails or returns nothing (for example outside Germany) falls through
/// to the next one, so chargers always show.
public actor ChargeMapService {
    public struct Result: Sendable {
        public let points: [ChargePoint]
        public let source: ChargePoint.Source
        /// Why a fallback source or missing prices, shown under the list. Nil when all went well.
        public let note: String?

        public init(
            points: [ChargePoint],
            source: ChargePoint.Source,
            note: String?
        ) { /* private */ }
    }

    /// For OCM and OSM. MobiData BW keeps everything in range so the cheapest charger is
    /// never dropped for being 50 m further away; the map draws only a subset.
    public static let maxResults
    public static let maxMobiDataResults

    private let openChargeMapKey: String
    private let nrelKey: String
    private let fetch: HTTP.Fetcher
    private let now: @Sendable () -> Date
    private let cacheLifetime: TimeInterval
    private let tariffLifetime: TimeInterval
    private var cache
    private var tariffCache: (date: Date, tariffs: [String: ChargingTariff])?

    public init(
        openChargeMapKey: String = APIConfig.openChargeMapKey,
        nrelKey: String = APIConfig.nrelKey,
        fetch: @escaping HTTP.Fetcher = HTTP.data(for:),
        now: @escaping @Sendable () -> Date = { }
    ) { /* private */ }

    /// Fetches every charger in range once; AC/DC filtering happens on device.
    /// - Parameter regionCode: the country ("DE", "US"…), nil when not known yet.
    public func chargers(
        near coordinate: CLLocationCoordinate2D,
        radiusKm: Double,
        regionCode: String? = nil,
        forceRefresh: Bool = false
    ) async throws -> Result { /* private */ }

    private func load(near coordinate: CLLocationCoordinate2D, radiusKm: Double, regionCode: String?) async throws -> Result { /* private */ }

    /// NREL in the US and Canada, MobiData BW in Germany; nil elsewhere or when they fail.
    private func officialFeed(
        near coordinate: CLLocationCoordinate2D,
        radiusKm: Double,
        regionCode: String?,
        reasons: inout [String]
    ) async throws -> Result? { /* private */ }

    /// Locations and tariffs load in parallel. If only the tariffs fail, chargers still
    /// show, just without prices.
    private func mobiData(
        near coordinate: CLLocationCoordinate2D,
        radiusKm: Double
    ) async throws -> (points: [ChargePoint], pricesMissing: Bool) { /* private */ }

    /// All ad-hoc tariffs, cached for an hour. Returns the last good copy, or nil, on failure.
    private func loadTariffs() async -> [String: ChargingTariff]? { /* private */ }
}
