// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDCore

nonisolated private func charger(
    _ id: String,
    operator operatorName: String?,
    fast: Bool = true,
    adHoc: Double? = nil
) -> ChargePoint { /* private */ }

@Suite("Charging plans")
struct ChargingPlanTests {
    private let enbwL
    private let ionity
    private let adac

    @Test(
        "Operator names from the feeds match the plan's network",
        arguments: [("ENBW", 0.39), ("EnBW", 0.39), ("EnBW AG", 0.39)]
    )
    func operatorNames(name: String, price: Double) { /* private */ }

    @Test("Tesla, Inc. in MobiData and IONITY GmbH in OpenStreetMap match their plans")
    func legalForms() { /* private */ }

    @Test("A separate company with a similar name doesn't get the plan price")
    func similarName() { /* private */ }

    @Test("Ionity plans cover DC only; there is no price at an AC charger")
    func dcOnly() { /* private */ }

    @Test("ADAC e-Charge: Aral pulse at its own price, other networks at the roaming price")
    func roaming() { /* private */ }

    @Test("A charger without a known operator gets no plan price, not even roaming")
    func unknownOperator() { /* private */ }

    @Test("Several plans: the cheapest one counts")
    func cheapestPlan() { /* private */ }

    @Test("The plan replaces the ad-hoc price only when it's cheaper")
    func versusAdHoc() { /* private */ }

    @Test("Without an ad-hoc price the plan still gives one, from any data source")
    func planWithoutAdHoc() { /* private */ }

    @Test("Removing every plan brings the ad-hoc price back")
    func removePlans() { /* private */ }

    @Test("A custom plan stores its operators the way the feeds are compared")
    func customPlan() { /* private */ }
}
