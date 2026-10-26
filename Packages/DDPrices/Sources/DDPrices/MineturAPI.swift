// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

/// Spain: the Ministry for the Ecological Transition's fuel price service (no key), which
/// feeds geoportalgasolineras.es and refreshes every 30 minutes. It can't search by
/// position, only by province (~1 MB for Madrid) or for the whole country (12 MB), so the
/// app loads the province from the postal code and filters by distance on the device.
public nonisolated enum MineturAPI {
    public static func provinceRequest(_ province: String) -> URLRequest { /* private */ }

    /// The province code (INE, "01"–"52") is the first two digits of a Spanish postal code.
    public static func province(postalCode: String?) -> String? { /* private */ }

    private struct Response: Decodable {
        let stations: [Record]

        private enum CodingKeys: String, CodingKey {
            case stations
        }
    }

    /// Every value is a string; numbers use a decimal comma ("1,849"), "" when not sold.
    private struct Record: Decodable {
        let id: String
        let brand: String?
        let address: String?
        let town: String?
        let latitude: String
        let longitude: String
        let e5: String?
        let e10: String?
        let diesel: String?
        let premiumDiesel: String?
        let hours: String?

        private enum CodingKeys: String, CodingKey {
            case id
            case brand
            case address
            case town
            case latitude
            case longitude
            case e5
            case e10
            case diesel
            case premiumDiesel
            case hours
        }
    }

    public static func number(_ text: String?) -> Double? { /* private */ }

    /// A price; "0,000" is a reporting error, not free fuel.
    public static func price(_ text: String?) -> Double? { /* private */ }

    /// The province's stations within `radiusKm`, nearest first.
    public static func decode(_ data: Data, origin: CLLocationCoordinate2D, radiusKm: Double) throws -> [Station] { /* private */ }

    /// The data is in capitals ("CARRETERA M-114 KM. 1"); short words like "BP" stay so.
    public static func tidy(_ text: String) -> String { /* private */ }
}
