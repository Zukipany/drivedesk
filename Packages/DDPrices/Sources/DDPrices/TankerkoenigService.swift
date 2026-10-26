// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

// MARK: - DTOs

public nonisolated struct StationListResponse: Decodable, Sendable {
    public let ok: Bool
    public let message: String?
    public let stations: [Station]?

    public init(
        ok: Bool,
        message: String?,
        stations: [Station]?
    ) { /* private */ }
}

public nonisolated enum TankerkoenigError: LocalizedError, Equatable {
    case api(String)
    case badResponse
    /// Another request ran less than a minute ago (fair use); try again shortly.
    case tooSoon

    public var errorDescription: String? { /* private */ }
}

/// Current prices of one station from `prices.php`.
public nonisolated struct StationPrices: Decodable, Hashable, Sendable {
    /// "open", "closed" or "no prices".
    public let status: String
    public let e5: FlexiblePrice?
    public let e10: FlexiblePrice?
    public let diesel: FlexiblePrice?

    public var isOpen: Bool { /* private */ }

    public func price(for fuel: FuelType) -> Double? { /* private */ }

    public init(
        status: String,
        e5: FlexiblePrice?,
        e10: FlexiblePrice?,
        diesel: FlexiblePrice?
    ) { /* private */ }
}

public nonisolated struct StationPricesResponse: Decodable, Sendable {
    public let ok: Bool
    public let message: String?
    public let prices: [String: StationPrices]?

    public init(
        ok: Bool,
        message: String?,
        prices: [String: StationPrices]?
    ) { /* private */ }
}

// MARK: - Service

/// Fuel prices for Germany from Tankerkönig (MTS-K data, CC BY 4.0).
///
/// Fair-use rules from creativecommons.tankerkoenig.de, enforced here:
/// - at most one request per minute; inside that window the newest cached result is returned
/// - results are cached for 5 minutes and reused within 500 m
/// - `type=all` so one call carries E5, E10 and Diesel and switching fuel chips never hits the network
/// - requests only on user action (the caller decides when; there is no polling loop)
public actor TankerkoenigService {
    /// One instance for the map and the trip planner, so together they never ask more than
    /// once a minute.
    public static let shared

    public struct Result: Sendable {
        public let stations: [Station]
        public let fetchedAt: Date
        /// True when served from cache because of the rate limit or a fresh cache entry.
        public let fromCache: Bool
        /// Set when the request failed and older cached prices stand in: why it failed.
        public var staleBecause: String?

        public init(
            stations: [Station],
            fetchedAt: Date,
            fromCache: Bool,
            staleBecause: String? = nil
        ) { /* private */ }
    }

    /// `prices.php` takes at most 10 stations per request.
    public static let maxPriceIDs

    public static let attributionURL
    public static let maxRadiusKm

    private let apiKey: String
    private let fetch: HTTP.Fetcher
    private let now: @Sendable () -> Date
    private let minimumInterval: TimeInterval
    private let cacheLifetime: TimeInterval

    private var cache
    private var lastNetworkRequest: Date

    public init(
        apiKey: String = APIConfig.tankerkoenigKey,
        fetch: @escaping HTTP.Fetcher = HTTP.data(for:),
        now: @escaping @Sendable () -> Date = { }
    ) { /* private */ }

    public func stations(
        near coordinate: CLLocationCoordinate2D,
        radiusKm: Double,
        forceRefresh: Bool = false
    ) async throws -> Result { /* private */ }

    /// When the next request is allowed (fair use: one a minute).
    public var nextRequestAllowed: Date { /* private */ }

    /// Waits for the next allowed request, then loads the stations there. For places the
    /// app hasn't looked at before (the trip planner): within the minute the map would get
    /// another place's cached list instead.
    public func stationsWaitingForSlot(near coordinate: CLLocationCoordinate2D, radiusKm: Double) async throws -> Result { /* private */ }

    /// Current prices of up to 10 stations (favourites outside the search radius). Counts
    /// towards the one-request-per-minute limit like a list request.
    public func prices(ids: [String]) async throws -> [String: StationPrices] { /* private */ }

    // MARK: Pure helpers (unit-tested)

    public static func listURL(_ coordinate: CLLocationCoordinate2D, radiusKm: Double, apiKey: String) -> URL { /* private */ }

    public static func pricesURL(ids: [String], apiKey: String) -> URL { /* private */ }

    public static func decodeStations(from data: Data) throws -> [Station] { /* private */ }
}
