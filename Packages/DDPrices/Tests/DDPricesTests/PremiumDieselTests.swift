// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDPrices
import DDCore

@Suite("Premium diesel availability")
struct PremiumDieselTests {
    @Test(
        "Brands that sell it nearly everywhere count without OpenStreetMap",
        arguments: [
            ("ARAL", "Aral Ultimate Diesel"), ("Shell", "Shell V-Power Diesel"), ("TotalEnergies", "TotalEnergies Excellium Diesel")
        ]
    )
    func brand(brand: String, product: String) { /* private */ }

    @Test("Esso (selected stations only), AVIA, Eni and JET need OpenStreetMap", arguments: ["ESSO", "AVIA", "AGIP ENI", "JET", ""])
    func needsConfirmation(brand: String) { /* private */ }

    @Test("OpenStreetMap confirms a station; the product is named when the brand is known")
    func confirmed() { /* private */ }

    @Test("A station tagged no never counts, even for Aral")
    func taggedNo() { /* private */ }

    @Test("No made-up price: premium diesel is priced only when the station reports it")
    func price() { /* private */ }

    @Test("OSM tags match the nearest station within 80 m")
    func matching() { /* private */ }

    @Test("Overpass answer: nodes and ways, yes and no; other values skipped")
    func decode() throws { /* private */ }
}
