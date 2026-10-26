// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

/// Croatia: the Ministry of Economy's national price file (no key), every station and price in
/// one ~4 MB file, so it's kept for an hour. Its coordinates are often swapped and sometimes
/// written in degrees and minutes; the plausible reading is taken.
public nonisolated enum CroatiaAPI {
    public static let request

    private struct Response: Decodable {
        let postajas: [Record]
        let gorivos: [Fuel]
        let obvezniks: [Operator]
    }

    private struct Price: Decodable {
        let gorivoId: Int
        let cijena: Double

        private enum CodingKeys: String, CodingKey {
            case gorivoId , cijena
        }
    }

    private struct Record: Decodable {
        let id: Int
        let naziv: String?
        let adresa: String?
        let mjesto: String?
        let obveznikId: Int?
        let long: LooseNumber?
        let lat: LooseNumber?
        let cjenici: [Price]

        private enum CodingKeys: String, CodingKey {
            case id, naziv, adresa, mjesto, long, lat, cjenici
            case obveznikId
        }
    }

    private struct Fuel: Decodable {
        let id: Int
        /// Null for a few the operators added without a kind.
        let vrstaGorivaId: Int?

        private enum CodingKeys: String, CodingKey {
            case id
            case vrstaGorivaId
        }
    }

    private struct Operator: Decodable {
        let id: Int
        let naziv: String
    }

    /// Fuel kinds: Eurosuper 95 with and without additives, Eurodiesel with and without.
    public static let petrolKinds: Set<Int> , dieselKinds: Set<Int> , additiveDiesel

    /// The brand from an operator's legal name: "INA – Industrija nafte, d.d." → "INA",
    /// "Tifon d.o.o." → "Tifon".
    public static func shortName(_ legal: String) -> String { /* private */ }

    /// Inside Croatia, whichever way round the file has it.
    public static func coordinate(_ first: Double?, _ second: Double?) -> CLLocationCoordinate2D? { /* private */ }

    public static func decode(_ data: Data, origin: CLLocationCoordinate2D, radiusKm: Double) throws -> [Station] { /* private */ }
}

/// The UK: the open price feeds big retailers publish since the CMA's 2023 scheme (no key).
/// Only some still do (the statutory Fuel Finder needs a developer registration), so this is
/// a partial list. Prices are in pence a litre; stored in euros like every other source.
public nonisolated enum UKFuelFeeds {
    public static let feeds: [(name: String, url: URL)]
    /// A feed not updated for this long has been abandoned; its prices are left out.
    public static let maxFeedAge: TimeInterval

    public struct Feed: Decodable {
        /// "16/10/2026 11:00:00"
        public let lastUpdated: String?
        fileprivate let stations: [Record]

        private enum CodingKeys: String, CodingKey {
            case lastUpdated , stations
        }
    }

    fileprivate struct Record: Decodable {
        struct Location: Decodable {
            let latitude: LooseNumber
            let longitude: LooseNumber
        }

        let siteId: String
        let brand: String?
        let address: String?
        let postcode: String?
        let location: Location
        /// "E5", "E10", "B7" (diesel), "SDV" (super diesel), in pence.
        let prices: [String: Double]

        private enum CodingKeys: String, CodingKey {
            case siteId , brand, address, postcode, location, prices
        }
    }

    public static func feed(_ data: Data) throws -> Feed { /* private */ }

    /// - Parameter poundsPerEuro: the ECB's GBP rate.
    public static func stations(_ feeds: [Feed], origin: CLLocationCoordinate2D, radiusKm: Double, now: Date, poundsPerEuro: Double) -> [Station] { /* private */ }

    private static func isCurrent(_ text: String?, now: Date) -> Bool { /* private */ }
}
