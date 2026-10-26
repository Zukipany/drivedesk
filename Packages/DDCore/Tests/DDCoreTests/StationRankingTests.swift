// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

@Suite("Station ranking")
struct StationRankingTests {
    private func station(_ id: String, diesel: Double?, open: Bool = true, dist: Double = 1) -> Station { /* private */ }

    @Test("Open and priced first, cheapest first; then closed; then no price")
    func sorting() { /* private */ }

    @Test("Stats ignore closed stations and missing prices")
    func stats() throws { /* private */ }

    @Test("Plan example: 1.789 avg, 1.729 min, 60 l → 3.60 € saved")
    func savings() { /* private */ }

    @Test("Price tiers split the range into cheap / average / expensive")
    func tiers() { /* private */ }
}
