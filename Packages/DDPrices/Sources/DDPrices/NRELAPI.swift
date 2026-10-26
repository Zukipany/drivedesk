// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

/// US and Canadian chargers from the Alternative Fuels Data Center (NREL, U.S. Department of
/// Energy), public domain. Works with `DEMO_KEY` (10 requests an hour per IP); a free key
/// from developer.nlr.gov allows 1,000. Prices are free text ("$0.39 per kWh") in dollars,
/// so they're shown as the operator wrote them, never as €/kWh.
public nonisolated enum NRELAPI {
    public static let demoKey
    /// It covers these countries only.
    public static let regions: Set<String>

    public static func request(_ coordinate: CLLocationCoordinate2D, radiusKm: Double, apiKey: String, limit: Int) -> URLRequest { /* private */ }

    private struct Response: Decodable {
        let fuelStations: [Record]
    }

    private struct Connector: Decodable {
        let powerKw: Double?
        let portCount: Int?
    }

    private struct Unit: Decodable {
        /// "1", "2" or "dc_fast".
        let chargingLevel: String?
        let connectors: [String: Connector]?
    }

    private struct Record: Decodable {
        let id: Int
        let stationName: String
        let streetAddress: String?
        let city: String?
        let latitude: Double
        let longitude: Double
        let evNetwork: String?
        let evPricing: String?
        let evConnectorTypes: [String]?
        let evDcFastNum: Int?
        let evLevel2EvseNum: Int?
        let evChargingUnits: [Unit]?
    }

    public static func decode(_ data: Data, origin: CLLocationCoordinate2D?) throws -> [ChargePoint] { /* private */ }

    /// From the charging units (power per connector) when listed, else the plain counts.
    private static func connections(of record: Record) -> [ChargePoint.Connection] { /* private */ }

    /// NREL's codes as drivers know them.
    public static func connectorName(_ code: String) -> String { /* private */ }
}
