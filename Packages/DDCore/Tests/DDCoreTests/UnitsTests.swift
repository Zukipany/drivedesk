// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

@Suite("Units and currencies")
struct UnitsTests {
    /// Runs `body` with these units and today's sample rates, apart from the driver's settings.
    private func with(_ preferences: UnitPreferences, _ body: () throws -> Void) rethrows { /* private */ }

    private var british: UnitPreferences { /* private */ }

    @Test("Prices: two decimals and the currency sign, no tenth-of-a-cent digit")
    func prices() { /* private */ }

    @Test("Per US gallon in dollars: litres × 3.785, euros × the ECB's rate")
    func gallonPrice() { /* private */ }

    @Test("Consumption: l/100 km, miles per gallon (inverse, US and imperial), kWh per 100 miles")
    func consumption() { /* private */ }

    @Test("Distances: metres under a kilometre, miles when chosen")
    func distances() { /* private */ }

    @Test("What's typed is stored in km, litres and euros, and shown back the same")
    func roundTrip() { /* private */ }

    @Test("The ECB's daily file: day and rates; garbage gives nothing")
    func parse() throws { /* private */ }

    @Test("A currency without a rate falls back to euros rather than a wrong number")
    func unknownCurrency() { /* private */ }
}
