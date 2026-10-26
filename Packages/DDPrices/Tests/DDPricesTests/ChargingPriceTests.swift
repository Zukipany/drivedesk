// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDPrices
import DDCore

/// MobiData BW's answer when a page has no more charging sites.
nonisolated let emptyMobiDataPage

nonisolated private let origin

/// OCPI 2.2 locations shaped like api.mobidata-bw.de responses (7 Oct 2026): numeric and
/// string IDs and coordinates, REMOVED charging points, and a site without live status.
nonisolated let mobiDataLocationsJSON

/// OCPI 3.0 tariffs: EnBW and EcoMovement publish net prices plus VAT, Chargecloud publishes
/// no VAT information. Values copied from the live feed.
nonisolated let mobiDataTariffsJSON

@Suite("Charging prices")
struct ChargingPriceTests {
    private var tariffs: [String: ChargingTariff] { /* private */ }

    // MARK: Tariffs

    @Test("EnBW: 0.664 € net + 19 % VAT = 0.79 €/kWh, time fee after 30 min")
    func enbw() throws { /* private */ }

    @Test("EcoMovement: VAT added to energy and session fee, time fee from the start")
    func ecoMovement() throws { /* private */ }

    @Test("Chargecloud: no VAT info, used as published; a 0 € time fee isn't a fee")
    func chargecloud() throws { /* private */ }

    @Test("A tariff without an energy price has no €/kWh; non-euro tariffs are skipped")
    func edgeCases() { /* private */ }

    // MARK: Locations

    @Test("Locations: removed points dropped, live status counted, nearest first")
    func locations() throws { /* private */ }

    /// Regression: rows titled "Muenchen.ArnulfStrasse15.Public1" and "Hirtenstraße 2" twice.
    @Test(
        "Internal IDs and repeated addresses aren't shown as site names",
        arguments: [
            ("Muenchen.ArnulfStrasse15.Public1", "Arnulfstraße 15", nil),
            ("DE VGRD M VW Schleibinger Strasse 81669 NW01_öffentlich", "Schleibingerstraße 12-16", nil),
            ("DE*SWM*E0009", nil, nil),
            ("Hirtenstraße 2", "Hirtenstraße 2", nil),
            ("Tiefgarage Marienplatz", "Rindermarkt 16", "Tiefgarage Marienplatz"),
            ("CarVia GmbH - München - Parkhaus Gollierstrasse #1", "Gollierstraße 70", "CarVia GmbH - München - Parkhaus Gollierstrasse #1")
        ] as [(String, String?, String?)]
    )
    func siteNames(name: String, address: String?, expected: String?) { /* private */ }

    @Test(
        "Legal suffixes are trimmed from operator names",
        arguments: [
            ("MOON POWER GmbH", "MOON POWER"), ("Tesla, Inc.", "Tesla"), ("EnBW", "EnBW"),
            ("Fraunhofer-Gesellschaft e. V.", "Fraunhofer-Gesellschaft"), ("Ladenetz GmbH & Co. KG", "Ladenetz")
        ]
    )
    func operatorNames(raw: String, expected: String) { /* private */ }

    @Test("Without tariffs, locations still decode")
    func locationsWithoutTariffs() throws { /* private */ }

    @Test("Paging: the last page has no next offset")
    func paging() throws { /* private */ }

    @Test("Locations request excludes the Bundesnetzagentur register and uses metres")
    func request() throws { /* private */ }

    // MARK: Ranking

    @Test("Chargers: cheapest first, unpriced after by distance")
    func ranking() throws { /* private */ }

    @Test("Saving on a charge: average 0.79, cheapest 0.48, 40 kWh → 12.40 €")
    func savings() { /* private */ }
}
