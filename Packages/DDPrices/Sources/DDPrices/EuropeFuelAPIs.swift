// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

/// A number sent as a number or as text ("45.81", "45,81"), as some feeds mix both.
public nonisolated struct LooseNumber: Decodable, Sendable {
    public let value: Double?

    public init(from decoder: any Decoder) throws { /* private */ }

    /// "45.81", "45,81" or degrees and minutes ("45° 39.4112' N").
    public static func parse(_ text: String) -> Double? { /* private */ }
}

/// Italy: MIMIT's Osservaprezzi Carburanti, the ministry's own search (no key), live: stations
/// report every price change. Searches around a point; prices for self-service and served.
public nonisolated enum MimitAPI {
    public static func request(_ coordinate: CLLocationCoordinate2D, radiusKm: Double) -> URLRequest { /* private */ }

    private struct Response: Decodable {
        let results: [Record]
    }

    private struct Record: Decodable {
        struct Fuel: Decodable {
            let price: Double
            let name: String
            let fuelId: Int
            let isSelf: Bool
        }

        struct Location: Decodable {
            let lat: Double
            let lng: Double
        }

        let id: Int
        let name: String?
        let brand: String?
        let address: String?
        let location: Location
        let fuels: [Fuel]
    }

    /// "Benzina" is Italy's E5, "Gasolio" its diesel; the premium diesels have own ids
    /// ("Blue Diesel", "Supreme Diesel" …).
    public static let petrol , diesel

    public static func decode(_ data: Data, origin: CLLocationCoordinate2D, radiusKm: Double) throws -> [Station] { /* private */ }

    /// Self-service where the station has it (what most drivers pay), else served.
    private static func price(_ fuels: [Record.Fuel]) -> Double? { /* private */ }
}

/// Portugal: DGEG's Preços dos Combustíveis Online (no key), where stations must report a
/// price before charging it. It searches by district, not position, so the app loads the
/// nearest district (and its neighbour near a border) and filters by distance.
public nonisolated enum DgegAPI {
    /// DGEG's fuel ids: Gasóleo simples, Gasolina simples 95, Gasóleo especial.
    public static let dieselID , petrolID , premiumDieselID
    /// Prices last reported more than this long ago are left out.
    public static let maxPriceAge: TimeInterval

    /// Mainland districts and their capitals (Madeira and the Azores aren't in the service).
    public static let districts: [(id: Int, latitude: Double, longitude: Double)]

    /// The nearest capital's district, and the second nearest when the search could reach into
    /// it (its capital is barely farther away). At most two requests.
    public static func districts(near coordinate: CLLocationCoordinate2D, radiusKm: Double) -> [Int] { /* private */ }

    public static func request(district: Int) -> URLRequest { /* private */ }

    private struct Response: Decodable {
        let resultado: [Row]
    }

    /// One row per station and fuel.
    private struct Row: Decodable {
        let id: Int
        let name: String?
        let brand: String?
        let street: String?
        let town: String?
        let latitude: Double?
        let longitude: Double?
        /// "1,939 €"
        let price: String?
        let fuel: String?
        /// "2026-10-09 17:55"
        let updated: String?

        private enum CodingKeys: String, CodingKey {
            case id , name , brand , street , town
            case latitude , longitude , price , fuel , updated
        }
    }

    public static func decode(_ districts: [Data], origin: CLLocationCoordinate2D, radiusKm: Double, now: Date) throws -> [Station] { /* private */ }

    /// "1,939 €" → "1,939"
    private static func digits(_ text: String?) -> String? { /* private */ }

    private static func isFresh(_ text: String?, now: Date) -> Bool { /* private */ }
}

/// Slovenia: goriva.si, the price register stations report to (no key). Searches around a
/// point, 25 stations a page.
public nonisolated enum GorivaAPI {
    public static let maxPages

    public static func request(_ coordinate: CLLocationCoordinate2D, radiusKm: Double, page: Int = 1) -> URLRequest { /* private */ }

    public struct Page: Decodable {
        public let next: String?
        fileprivate let results: [Record]
    }

    fileprivate struct Record: Decodable {
        let pk: Int
        let name: String
        let address: String?
        let lat: Double
        let lng: Double
        /// "95", "dizel", "dizel-premium", "100", "avtoplin-lpg" …; null when not sold.
        let prices: [String: Double?]
        let zipCode: String?

        private enum CodingKeys: String, CodingKey {
            case pk, name, address, lat, lng, prices
            case zipCode
        }
    }

    public static func page(_ data: Data) throws -> Page { /* private */ }

    public static func stations(_ pages: [Page], origin: CLLocationCoordinate2D) -> [Station] { /* private */ }
}
