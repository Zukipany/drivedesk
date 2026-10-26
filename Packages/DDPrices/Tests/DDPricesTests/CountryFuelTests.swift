// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDPrices
import DDCore

@Suite("Chargers in the US and Canada")
struct NRELChargerTests {
    nonisolated private final class BundleToken {}

    private let sanFrancisco

    private func fixture() throws -> Data { /* private */ }

    @Test("Power per connector from the charging units; dollar prices stay text")
    func decode() throws { /* private */ }

    @Test("The key goes in a header; DEMO_KEY when none is set")
    func request() throws { /* private */ }

    @Test("In the US the service asks NREL and never MobiData BW")
    func routing() async throws { /* private */ }
}
