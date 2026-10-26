// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDPrices
import DDCore

nonisolated private let marienplatz

/// `compact=true` response: reference objects are IDs only.
nonisolated let openChargeMapJSON

/// First two elements copied from a live Overpass response around Marienplatz (7 Oct 2026);
/// the rest cover a way with a centre, a CCS hub, an e-bike station and a private charger.
nonisolated let overpassJSON

@Suite("Charging APIs")
struct ChargingAPITests {
    // MARK: Open Charge Map

    @Test("Open Charge Map compact response decodes and classifies AC/DC")
    func openChargeMap() throws { /* private */ }

    @Test("Open Charge Map key goes in the header, not the URL")
    func openChargeMapRequest() throws { /* private */ }

    // MARK: OpenStreetMap

    @Test("Overpass response: nearest first, private and e-bike stations skipped")
    func overpass() throws { /* private */ }

    @Test(
        "Power tags in OSM's formats",
        arguments: [
            ("150 kW", 150.0), ("22kW", 22), ("11 kW;22 kW", 22), ("3.7 kW", 3.7), ("50000 W", 50), ("22", 22)
        ] as [(String, Double)]
    )
    func power(text: String, kW: Double) { /* private */ }

    /// Regression: a CCS socket without a power tag next to a 22 kW Type 2 socket
    /// showed as a purple DC pin labelled "22 kW".
    @Test("A DC station is labelled with its DC power, not its AC power")
    func dcLabel() { /* private */ }

    /// Regression: five identical "Stadtwerke München · 2 points" rows for posts metres apart.
    @Test("Neighbouring posts of the same operator merge into one site")
    func mergeNeighbours() { /* private */ }

    @Test(
        "Compass direction from the user",
        arguments: [
            (48.15, 11.575, "north"), (48.137, 11.60, "east"), (48.12, 11.575, "south"),
            (48.137, 11.55, "west"), (48.15, 11.595, "north-east")
        ] as [(Double, Double, String)]
    )
    func direction(lat: Double, lon: Double, expected: String) { /* private */ }

    @Test("Unreadable power is nil")
    func unreadablePower() { /* private */ }

    @Test("CCS without a power figure still counts as DC")
    func dcFromSocketType() { /* private */ }

    @Test("Overpass request is a form-encoded POST that asks for JSON")
    func overpassRequest() throws { /* private */ }

    @Test("HTTP errors read as plain language")
    func httpErrors() { /* private */ }
}

/// Answers by host and path and records what was called.
private actor FakeServers {
    var mobiDataLocations: Result<Data, HTTPError>
    var mobiDataTariffs: Result<Data, HTTPError>
    var openChargeMap: Result<Data, HTTPError>
    var overpass: [String: Result<Data, HTTPError>]
    private(set) var calls: [String]

    /// Calls other than MobiData BW, whose two requests run in parallel in no fixed order.
    var otherCalls: [String] { /* private */ }

    func setMobiData(locations: Result<Data, HTTPError>) { /* private */ }
    func setMobiData(tariffs: Result<Data, HTTPError>) { /* private */ }
    func setOpenChargeMap(_ result: Result<Data, HTTPError>) { /* private */ }
    func setOverpass(_ host: String, _ result: Result<Data, HTTPError>) { /* private */ }

    func respond(to request: URLRequest) throws -> Data { /* private */ }
}

@Suite("Charger source fallback")
struct ChargeMapServiceTests {
    private let servers

    private func service(key: String) -> ChargeMapService { /* private */ }

    @Test("MobiData BW comes first: prices and live status, no other source called")
    func mobiDataFirst() async throws { /* private */ }

    @Test("If only the tariffs fail, chargers still show, without prices and with a note")
    func tariffsFail() async throws { /* private */ }

    @Test("Tariffs are loaded once an hour, not per location")
    func tariffCache() async throws { /* private */ }

    @Test("No MobiData chargers (e.g. abroad) and no key: OpenStreetMap")
    func noKey() async throws { /* private */ }

    @Test("No MobiData chargers and a key: Open Charge Map, OpenStreetMap isn't called")
    func withKey() async throws { /* private */ }

    @Test("MobiData down and a rejected key: OpenStreetMap, and the note says why")
    func everythingButOSMFails() async throws { /* private */ }

    @Test("A busy Overpass server falls through to the next one")
    func busyServer() async throws { /* private */ }

    @Test("When every source fails, the error reaches the UI")
    func allFail() async { /* private */ }

    @Test("Results are cached for 10 minutes")
    func cached() async throws { /* private */ }
}
