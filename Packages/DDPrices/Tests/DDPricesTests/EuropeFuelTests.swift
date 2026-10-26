// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDPrices
import DDCore

@Suite("More European fuel prices")
struct EuropeFuelTests {
    private func data(_ json: String) -> Data { /* private */ }

    @Test("Countries: Italy (with San Marino), Portugal, Slovenia, Croatia, the UK")
    func regions() { /* private */ }

    @Test("Italy: self-service price where there is one, served otherwise; premium diesel by name")
    func italy() throws { /* private */ }

    @Test("Portugal: the nearest district, its neighbour near a border; rows merged per station")
    func portugal() throws { /* private */ }

    @Test("Slovenia: prices by name, nulls skipped, pages followed")
    func slovenia() throws { /* private */ }

    @Test("Croatia: swapped and degree-minute coordinates, the cheapest 95 and diesel, a dearer additive diesel")
    func croatia() throws { /* private */ }

    @Test("UK: pence to euros at the ECB's rate; abandoned feeds left out")
    func unitedKingdom() throws { /* private */ }
}
