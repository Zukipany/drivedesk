// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import MapKit

/// Which country a map point lies in, so the map asks that country's price database.
/// Uses Apple's reverse geocoder, once per 2 km: the map reloads often, the border rarely moves.
@MainActor
public final class CountryLocator {
    public nonisolated struct Place: Equatable, Sendable {
        /// ISO 3166 code: "DE", "AT"…
        public let regionCode: String
        /// Spain's price data is per province, which the postal code tells.
        public let postalCode: String?

        public init(
            regionCode: String,
            postalCode: String?
        ) { /* private */ }
    }

    public typealias Lookup = @MainActor (CLLocationCoordinate2D) async throws -> Place?

    private let lookup: Lookup
    private var cache

    public init(lookup: @escaping Lookup = CountryLocator.appleMaps) { /* private */ }

    /// Always the same country, for tests and previews.
    public static func fixed(_ regionCode: String, postalCode: String? = nil) -> CountryLocator { /* private */ }

    /// The country at `coordinate`; offline, the last one found (the driver rarely
    /// crosses a border between two reloads), or nil before any lookup worked.
    public func place(at coordinate: CLLocationCoordinate2D) async -> Place? { /* private */ }

    public static func appleMaps(_ coordinate: CLLocationCoordinate2D) async throws -> Place? { /* private */ }

    /// The first five-digit number in an address ("Calle Mayor 1, 28013 Madrid").
    public nonisolated static func postalCode(in address: String?) -> String? { /* private */ }
}
