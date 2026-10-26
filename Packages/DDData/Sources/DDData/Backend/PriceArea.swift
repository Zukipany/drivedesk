// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Supabase

/// Fuel prices around a point (plan section 15): stations from the server's shared price
/// cache (`prices-area`, US-15), with when each price last changed and where they came from.
public nonisolated struct PriceArea: Sendable {
    public var stations: [Station]
    /// When each station's price for a fuel last changed, by station ID.
    public var changedAt: [String: [FuelType: Date]]
    /// When the server last fetched this area; older cells make it older.
    public var fetchedAt: Date?
    /// Why the server answered from its cache rather than fresh (no slot, source down).
    public var staleBecause: String?
    public var attribution: String
    /// Kept on the phone from an earlier answer, because the server couldn't be reached.
    public var isOffline
    /// Where the prices were asked for.
    public var latitude: Double
    public var longitude: Double

    public init(
        stations: [Station],
        changedAt: [String: [FuelType: Date]] = [:],
        fetchedAt: Date?,
        staleBecause: String? = nil,
        attribution: String,
        isOffline: Bool = false,
        latitude: Double,
        longitude: Double
    ) { /* private */ }

    /// The prices-area answer: Tankerkönig's list.php shape plus source, attribution and when
    /// each price changed (fixtures/api/prices-area-response.json).
    public static func decode(_ data: Data, latitude: Double, longitude: Double) throws -> PriceArea { /* private */ }

    private struct Answer: Decodable {
        let ok: Bool
        let message: String?
        let stations: [Station]?
        let times: [StationTimes]?
        let fetchedAt: String?
        let staleBecause: String?
        let attribution: Attribution?

        enum CodingKeys: String, CodingKey { case ok, message, stations, fetchedAt, staleBecause, attribution }

        init(from decoder: any Decoder) throws { /* private */ }
    }

    private struct StationTimes: Decodable {
        let id: String
        let changedAt: [String: String]?
    }

    private struct Attribution: Decodable {
        let text: String
    }
}

/// Where prices come from: the server, or the demo's stations.
public protocol PriceProvider: Sendable {
    func prices(latitude: Double, longitude: Double, radiusKm: Double) async throws(SyncFailure) -> PriceArea
}

/// prices-area through Supabase, as the signed-in person. The last answer is kept on the
/// phone, so the map shows the last prices offline, clearly marked.
public nonisolated struct SupabasePriceProvider: PriceProvider {
    let client: SupabaseClient
    let cache: URL

    public init(backend: Backend, cache: URL = PriceCacheFile.standard) { /* private */ }

    public func prices(latitude: Double, longitude: Double, radiusKm: Double) async throws(SyncFailure) -> PriceArea { /* private */ }

    private struct Request: Encodable, Sendable {
        let latitude: Double
        let longitude: Double
        let radiusKm: Double
    }

    static func failure(_ error: any Error) -> SyncFailure { /* private */ }
}

/// The last prices-area answer on the phone.
public nonisolated enum PriceCacheFile {
    public static var standard: URL { /* private */ }

    struct Kept: Codable {
        let answer: Data
        let latitude: Double
        let longitude: Double
    }

    static func write(_ answer: Data, latitude: Double, longitude: Double, to url: URL) { /* private */ }

    static func read(_ url: URL) -> PriceArea? { /* private */ }
}
