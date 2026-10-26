// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData
import Testing
@testable import DDCore

@Suite("Fuel kinds")
struct FuelKindTests {
    @Test("Each fuel belongs to one kind")
    func kinds() { /* private */ }

    /// Stations only report E5, E10 and diesel to the MTS-K.
    @Test("Premium diesel has its own map chip, priced only where stations report it")
    func publicPrices() { /* private */ }
}

@Suite("Premium diesel on receipts")
struct PremiumDieselReceiptTests {
    @Test(
        "Brand names for premium diesel",
        arguments: [
            "Aral Ultimate Diesel", "Shell V-Power Diesel", "Excellium Diesel", "Esso Diesel MaxxMotion", "Diesel Premium"
        ]
    )
    func premium(product: String) { /* private */ }

    @Test("Regular diesel, including Shell's standard FuelSave", arguments: ["DIESEL", "Shell FuelSave Diesel", "Diesel B7"])
    func regular(product: String) { /* private */ }

    @Test("An advert further down doesn't make regular diesel premium")
    func advert() { /* private */ }
}
