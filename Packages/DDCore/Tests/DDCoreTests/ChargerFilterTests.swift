// Source code is private. This file shows only its types and signatures.

import Testing
@testable import DDCore

@Suite("Charging list filters")
struct ChargerFilterTests {
    private func charger(
        _ id: String,
        kW: Double?,
        dc: Bool = false,
        price: Double? = nil,
        free: Int? = nil,
        km: Double,
        operatorName: String = "EnBW"
    ) -> ChargePoint { /* private */ }

    private var chargers: [ChargePoint] { /* private */ }

    @Test("No filter keeps every charger, cheapest first, unpriced last")
    func noFilter() { /* private */ }

    @Test("A minimum power drops slower chargers and those of unknown power")
    func minimumPower() { /* private */ }

    @Test("Available now keeps chargers with a free point; unknown status is left out")
    func freeNow() { /* private */ }

    @Test("With price drops chargers without a published price")
    func priced() { /* private */ }

    @Test("Sorted by distance or by power, fastest first")
    func sorting() { /* private */ }

    @Test("Search matches the operator")
    func search() { /* private */ }
}
