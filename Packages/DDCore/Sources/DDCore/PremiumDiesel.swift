// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation

/// Where premium diesel (Aral Ultimate Diesel, Shell V-Power Diesel…) is sold, and what it
/// roughly costs.
///
/// Its prices aren't reported anywhere public: stations only have to report Super E5,
/// Super E10 and Diesel to the MTS-K. So availability comes from two sources:
/// - the brand: Aral, Shell and TotalEnergies sell it at nearly all their stations; JET
///   sells none. Esso sells it only at selected stations (esso.de), so Esso, AVIA, Eni
///   and independents count only when OpenStreetMap confirms the station.
/// - OpenStreetMap's `fuel:GTL_diesel` tag (yes/no), set by mappers per station. On
///   8 Oct 2026 about 25 of 160 Munich stations had it, so it confirms or rules out
///   individual stations; it can't cover a city on its own.
/// A station tagged "no" never counts, whatever its brand.
public nonisolated enum PremiumDiesel {
    public struct Availability: Hashable, Sendable {
        public enum Source: Hashable, Sendable {
            /// The brand sells it at nearly all of its stations.
            case brand
            /// OpenStreetMap says this station sells it.
            case openStreetMap
            /// The station reports its price (Spain), so it's real, not estimated.
            case reported
        }

        public let product: String
        public let source: Source

        public init(
            product: String,
            source: Source
        ) { /* private */ }
    }

    /// Brands selling it at (nearly) every station, with their product names.
    private static let everywhere: [(match: String, product: String)]
    /// Brands selling it at some stations only: named when OpenStreetMap confirms one.
    private static let someStations: [(match: String, product: String)]
    /// JET sells regular diesel only.
    private static let never

    /// - Parameter openStreetMap: the station's `fuel:GTL_diesel` tag; nil when untagged.
    public static func availability(brand: String, openStreetMap tag: Bool?) -> Availability? { /* private */ }

    // MARK: OpenStreetMap

    /// A station's `fuel:GTL_diesel` tag and position.
    public struct Tag: Equatable, Sendable {
        public let latitude: Double
        public let longitude: Double
        public let sellsPremium: Bool

        public init(
            latitude: Double,
            longitude: Double,
            sellsPremium: Bool
        ) { /* private */ }
    }

    /// The tag of the nearest OSM station within `meters` of each Tankerkönig station.
    /// The two databases place a station a few metres apart (pumps vs. shop).
    public static func match(_ stations: [Station], tags: [Tag], within meters: Double = 80) -> [Station.ID: Bool] { /* private */ }
}
