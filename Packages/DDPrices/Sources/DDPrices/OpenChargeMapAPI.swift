// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

/// Open Charge Map v3 (`/v3/poi`). A free API key is required (HTTP 403 without one).
///
/// `compact=true` drops nested reference objects (`OperatorInfo`, `StatusType`, …)
/// and keeps only their IDs, which makes responses much smaller.
public nonisolated enum OpenChargeMapAPI {
    public static func request(
        _ coordinate: CLLocationCoordinate2D,
        radiusKm: Double,
        apiKey: String,
        maxResults: Int
    ) -> URLRequest { /* private */ }

    public static func decode(_ data: Data, origin: CLLocationCoordinate2D?) throws -> [ChargePoint] { /* private */ }

    /// The common European connector IDs from `/v3/referencedata` (ConnectionTypes).
    public static let connectorNames: [Int: String]
    /// CHAdeMO, Tesla Supercharger, CCS1, CCS2.
    public static let dcConnectorIDs: Set<Int>

    private struct POI: Decodable {
        let ID: Int
        let AddressInfo: Address
        let Connections: [Connection]?
        let UsageCost: String?
        let OperatorID: Int?
    }

    private struct Address: Decodable {
        let Title: String?
        let AddressLine1: String?
        let Town: String?
        let Latitude: Double
        let Longitude: Double
        let Distance: Double?
    }

    private struct Connection: Decodable {
        let ConnectionTypeID: Int?
        let PowerKW: Double?
        let Quantity: Int?
        /// 10 = AC single-phase, 20 = AC three-phase, 30 = DC.
        let CurrentTypeID: Int?
    }
}
