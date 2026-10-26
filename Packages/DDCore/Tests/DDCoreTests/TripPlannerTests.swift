// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDCore

/// A straight route north from Munich with a point every km, 100 km/h on average.
nonisolated func straightRoute(km: Int, hours: Double? = nil) -> RouteProfile { /* private */ }

nonisolated func stationAt(
    _ km: Double,
    _ price: Double?,
    id: String? = nil,
    detour: Double = 1,
    hours: Trip.OpeningHours? = .twentyFourSeven,
    priceDate: Date? = nil
) -> Trip.Candidate { /* private */ }

/// A 50 l car using 7 l/100 km: 714 km per tank.
nonisolated func golf(level: Double = 0.5, estimated: Bool = false) -> Trip.Car { /* private */ }

nonisolated func at(_ hour: Int, day: Int = 14) -> Date { /* private */ }

@Suite("Trip planner: range and reserve (1)")
struct TripRangeTests {
    @Test("1a: can't reach any station: 'fill up before you leave', no plan")
    func cannotStart() { /* private */ }

    @Test("1b: an estimated level is planned with 85 % of it, and comes from the log")
    func estimatedLevel() { /* private */ }

    @Test("1c: the reserve can't be kept: the nearest station, marked critical")
    func critical() throws { /* private */ }

    @Test("Enough in the tank: no stop at all, arrival with what's left")
    func noStopNeeded() { /* private */ }
}

@Suite("Trip planner: stretches without stations (2)")
struct TripGapTests {
    @Test("2a: a stretch longer than a full tank can't be planned and says where")
    func unreachable() { /* private */ }

    @Test("2b: the last station before a long gap fills up completely")
    func fillBeforeGap() throws { /* private */ }

    @Test("2c: a station without a price is used only when nothing priced is in reach")
    func unpricedFallback() throws { /* private */ }
}

@Suite("Trip planner: opening hours (3)")
struct TripHoursTests {
    private let daytime

    @Test("3a: a station closed when the car gets there is left out")
    func closedOnArrival() { /* private */ }

    @Test("3b: at night a known 24/7 station beats an unknown one a little cheaper")
    func night() throws { /* private */ }

    @Test("3c: each stop names a backup on the same stretch")
    func backup() throws { /* private */ }

    @Test("Opening hours from E-Control and Spain; motorway stations are open all night")
    func parsing() throws { /* private */ }
}

@Suite("Trip planner: prices on the way (4)")
struct TripPriceTests {
    @Test("4a: a price hours old by arrival is an estimate with a range")
    func priceAge() throws { /* private */ }

    @Test("4c: 'fewest stops' never stops more often, 'cheapest' never costs more")
    func preferences() { /* private */ }
}

@Suite("Trip planner: consumption, electric and hybrid (5–7)")
struct TripEnergyTests {
    @Test("5a: speed adds up to 20 % for fuel and 35 % for electric")
    func speed() { /* private */ }

    @Test("5b: winter costs an electric car 25 %, cooler months 12 %; a switch overrides it")
    func cold() { /* private */ }

    @Test("5c: the driver's own average once it covers 500 km, else rated + 10 %")
    func baseline() { /* private */ }

    @Test("6a: plug names from every source map to the right plug")
    func plugs() { /* private */ }

    @Test("6c: an electric car charges to 80 %, timed with the slower of car and charger")
    func electric() throws { /* private */ }

    @Test("7a: a plug-in hybrid drives on the battery first")
    func hybrid() { /* private */ }
}

@Suite("Trip planner: offline and hand-off (8–9)")
struct TripPersistenceTests {
    @Test("8a: a plan survives being saved and read back")
    func codable() throws { /* private */ }

    @Test("9b: the next stop skips the ones already done")
    func nextStop() throws { /* private */ }

    @Test("Route geometry: where a station lies along the route and how far off")
    func geometry() throws { /* private */ }
}
