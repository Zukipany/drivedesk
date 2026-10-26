// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

/// OpenStreetMap charging stations via the Overpass API. No key needed.
///
/// Usage policy (wiki.openstreetmap.org/wiki/Overpass_API): under 10,000 requests and
/// 1 GB per day, and identify the client. `ChargeMapService` caches results for
/// 10 minutes and only queries when the location changes, far below that.
/// Licence: ODbL, so the app must show "© OpenStreetMap contributors".
///
/// OSM often has no power figures. AC/DC is then read from the socket types:
/// CCS (`type2_combo`), CHAdeMO and Tesla Supercharger are DC.
public nonisolated enum OverpassAPI {
    /// Public instances, tried in order. The main one is sometimes overloaded (HTTP 504).
    public static let servers

    /// Every charging station within the radius. `out center` gives ways and
    /// relations (e.g. a car park) a single coordinate.
    public static func query(_ coordinate: CLLocationCoordinate2D, radiusKm: Double) -> String { /* private */ }

    public static func request(_ query: String, server: URL) -> URLRequest { /* private */ }

    /// Percent-encodes everything except unreserved characters, as curl --data-urlencode does.
    public static func formEncode(_ string: String) -> String { /* private */ }

    /// Decodes, merges neighbouring posts and sorts nearest first.
    /// Skips private stations and ones not meant for cars.
    public static func decode(_ data: Data, origin: CLLocationCoordinate2D) throws -> [ChargePoint] { /* private */ }

    /// OSM maps every charging post on its own, and operators like SWM put two posts a
    /// few metres apart, often with no name or address. Without merging, the list shows
    /// several identical "Stadtwerke München" rows. Posts with the same title and AC/DC
    /// type within `meters` of each other become one site. Input order is kept.
    public static func mergeNeighbours(_ points: [ChargePoint], within meters: Double = 30) -> [ChargePoint] { /* private */ }

    private static func chargePoint(from element: Element, origin: CLLocationCoordinate2D) -> ChargePoint? { /* private */ }

    /// OSM socket keys → display name and whether it's DC.
    public static let socketKinds: [String: (name: String, isDC: Bool)]

    /// Reads `socket:<type>=<count>` and `socket:<type>:output=<power>`, most powerful first.
    public static func connections(from tags: [String: String]) -> [ChargePoint.Connection] { /* private */ }

    /// "150 kW" → 150 · "22kW" → 22 · "11 kW;22 kW" → 22 · "50000 W" → 50
    public static func power(_ value: String?) -> Double? { /* private */ }

    private struct Response: Decodable {
        let elements: [Element]
    }

    private struct Element: Decodable {
        struct Center: Decodable {
            let lat: Double
            let lon: Double
        }

        let type: String
        let id: Int64
        let lat: Double?
        let lon: Double?
        let center: Center?
        let tags: [String: String]?
    }
}
