// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Fuel policy on the map")
struct FuelPolicyTests {
    private let caddy

    private func station(_ id: String, diesel: Double?, dist: Double = 1, open: Bool = true) -> Station { /* private */ }

    private func policy(premium: Bool = false, maxAbove: Int? = 50, fuels: [FuelType]? = nil, group: UUID? = nil) -> FuelPolicy { /* private */ }

    @Test("The car's group has its own policy; otherwise the company's default applies")
    func whichPolicy() { /* private */ }

    @Test("A fuel the car doesn't take, or the policy doesn't list, is not allowed")
    func fuels() { /* private */ }

    @Test("Premium fuel needs the policy's permission")
    func premium() { /* private */ }

    @Test("A price more than the allowed amount above the local average is dimmed with its distance")
    func aboveAverage() { /* private */ }

    @Test("Hours and weekdays in Berlin time, including a window past midnight")
    func hours() { /* private */ }

    @Test("The overlay: the area's average, reasons per station, and the star on the cheapest allowed one within 5 km")
    func overlay() { /* private */ }

    @Test("A fuel the car doesn't take dims every station and gives no star")
    func wrongFuelOverlay() { /* private */ }

    @Test("A policy row from PostgREST, with its arrays, and back")
    func row() throws { /* private */ }
}

@Suite("Prices from the server's cache")
struct PriceAreaTests {
    private static let fixture

    @Test("The prices-area answer: stations, when each price changed, when the area was fetched")
    func decodes() throws { /* private */ }

    @Test("The last answer is kept and comes back marked offline")
    func keptOffline() throws { /* private */ }

    @Test("An answer that isn't ok is refused")
    func notOK() { /* private */ }
}
