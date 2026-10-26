// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDCore

@Suite("Trip search and progress")
struct TripSearchTests {
    @Test("Prices are asked for only before the points where the range runs out")
    func priceMarks() { /* private */ }

    @Test("2c: where nothing is close to the route, stations further off count")
    func corridor() { /* private */ }

    @Test("An Apple Maps place next to a priced station is that station")
    func merging() { /* private */ }

    @Test("6a/6b: only DC chargers with the car's plug and enough power")
    func chargers() { /* private */ }

    @Test("A motorway station counts as open all night; Austria's hours come along")
    func stationHours() throws { /* private */ }

    @Test("4b/9b: range on the way, the check near the next stop, a skipped stop")
    func progress() throws { /* private */ }

    @Test("Planning the rest from where the car is")
    func remainder() { /* private */ }
}
