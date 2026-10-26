// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import SwiftData
import Testing
@testable import DDPrices
import DDCore

@Suite("Station data edge cases")
struct StationDataEdgeCaseTests {
    private func station(street: String, number: String?, place: String) -> Station { /* private */ }

    @Test("A price of 0 is a reporting error: missing, never the cheapest pin")
    func zeroPrice() throws { /* private */ }

    @Test("Addresses skip the parts a source leaves empty")
    func addresses() { /* private */ }

    @Test("A discount as big as the price is ignored, not free fuel")
    func hugeDiscount() { /* private */ }

    @Test("Search ignores case and accents")
    func search() { /* private */ }
}
