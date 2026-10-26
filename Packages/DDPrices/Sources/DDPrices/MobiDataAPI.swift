// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

/// German charging stations with ad-hoc prices and live status, from MobiData BW's
/// Open ChargePoint DataBase (api.mobidata-bw.de/ocpdb). No key needed.
///
/// Under EU AFIR, operators must publish static data, live status and ad-hoc prices on
/// the national access point (Mobilithek). Mobilithek itself needs a client certificate
/// per feed; MobiData BW aggregates those feeds into one public OCPI API.
///
/// - Locations: OCPI 2.2 `/locations` with `lat`, `lon`, `radius`. Results come sorted by ID,
///   not distance, so everything in the radius is loaded and sorted on device.
/// - Prices: connectors carry `tariff_ids` that match the `original_id` of OCPI 3.0 `/tariffs`.
///   There are about 1,000 tariffs in total, so they're loaded in full (about 600 KB) and cached.
/// - The Bundesnetzagentur register (`bnetza_api`) is excluded: it repeats the operators'
///   chargers under different IDs, without prices or live status.
///
/// Licences: CC0 for most feeds, CC BY 4.0 for EnBW AG; attribution is shown in the app.
public nonisolated enum MobiDataAPI {
    public static let base
    public static let pageSize

    public static func locationsRequest(_ coordinate: CLLocationCoordinate2D, radiusKm: Double, offset: Int = 0) -> URLRequest { /* private */ }

    public static func tariffsRequest(offset: Int) -> URLRequest { /* private */ }

    /// Offset of the next page, nil on the last page.
    public static func nextOffset(in data: Data) throws -> Int? { /* private */ }

    /// Tariffs by the ID that connectors refer to (`original_id`).
    public static func decodeTariffs(_ data: Data) throws -> [String: ChargingTariff] { /* private */ }

    /// Charging sites with their connectors, prices and live status, nearest first.
    public static func decodeLocations(
        _ data: Data,
        origin: CLLocationCoordinate2D,
        tariffs: [String: ChargingTariff]
    ) throws -> [ChargePoint] { /* private */ }

    private static func chargePoint(
        from location: Location,
        origin: CLLocationCoordinate2D,
        tariffs: [String: ChargingTariff]
    ) -> ChargePoint? { /* private */ }

    /// "MOON POWER GmbH" → "MOON POWER", "Tesla, Inc." → "Tesla".
    public static func shortOperatorName(_ name: String) -> String { /* private */ }

    /// The site name when a person would write it that way. Nil for internal IDs like
    /// "Muenchen.ArnulfStrasse15.Public1" or "DE VGRD M VW … NW01_öffentlich", and when it
    /// only repeats the address.
    public static func readableSiteName(_ name: String?, address: String?) -> String? { /* private */ }

    /// OCPI connector standards → the names drivers know.
    public static func connectorName(_ standard: String?, format: String?) -> String? { /* private */ }

    // MARK: DTOs (field names match the JSON)

    private struct PageInfo: Decodable {
        let total_count: Int?
        let next_offset: Int?
    }

    private struct Page<Item: Decodable>: Decodable {
        let items: [Item]
    }

    private struct Location: Decodable {
        let id: LossyString?
        let name: String?
        let address: String?
        let city: String?
        let coordinates: Coordinates?
        let `operator`: Business?
        let evses: [EVSE]?
    }

    private struct Coordinates: Decodable {
        let latitude: LossyDouble?
        let longitude: LossyDouble?
    }

    private struct Business: Decodable {
        let name: String?
    }

    private struct EVSE: Decodable {
        let status: String?
        let connectors: [Connector]?
    }

    private struct Connector: Decodable {
        let standard: String?
        let format: String?
        let power_type: String?
        /// Watts.
        let max_electric_power: Double?
        let tariff_ids: [String]?
    }

    private struct Tariff: Decodable {
        let id: LossyString?
        let original_id: LossyString?
        let currency: String?
        /// "YES" / "NO" / "N/A" in OCPI 3.0.
        let tax_included: LossyString?
        let elements: [Element]?
    }

    private struct Element: Decodable {
        let price_components: [PriceComponent]?
        let restrictions: Restrictions?
    }

    private struct PriceComponent: Decodable {
        let type: String
        let price: Double
        let taxes: [Tax]?
        let tax_included: Bool?
    }

    private struct Tax: Decodable {
        let name: String?
        /// Sent as a string ("19").
        let percentage: LossyDouble?
    }

    private struct Restrictions: Decodable {
        let min_duration: Int?
        let start_time: String?
        let end_time: String?
        let start_date: String?
        let end_date: String?
        let min_kwh: Double?
        let max_kwh: Double?
        let min_power: Double?
        let max_power: Double?
        let day_of_week: [String]?

        var hasOtherThanMinDuration: Bool { /* private */ }
    }
}

/// Accepts a string or a number. Open data feeds aren't consistent about JSON types.
public nonisolated struct LossyString: Decodable, Hashable, Sendable {
    public let value: String

    public init(from decoder: any Decoder) throws { /* private */ }

    public var isYes: Bool { /* private */ }
}

/// Accepts a number or a numeric string ("19", "48.137").
public nonisolated struct LossyDouble: Decodable, Hashable, Sendable {
    public let value: Double?

    public init(from decoder: any Decoder) throws { /* private */ }
}

nonisolated private extension String {
    var nilIfEmpty: String? { /* private */ }
}
