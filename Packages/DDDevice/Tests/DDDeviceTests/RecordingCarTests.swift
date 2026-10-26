// Source code is private. This file shows only its types and signatures.

import CoreLocation
import DDCore
import Foundation
import Testing
@testable import DDDevice

@Suite("Drives for the logbook")
struct RecordingCarTests {
    private let point

    @Test("A drive carries the company and car it was recorded for")
    func carriesCompanyAndCar() { /* private */ }

    @Test("A private car has no company; no car at all keeps the drive without one")
    func privateAndUnknown() { /* private */ }

    @Test("Drives saved before company IDs existed still decode")
    func oldDrivesDecode() throws { /* private */ }

    @Test("A company's drive survives the ride store's file")
    func roundTrip() throws { /* private */ }
}

@Suite("Weather history")
struct WeatherHistoryTests {
    @Test("Areas are a quarter-degree grid, about 25 km, so nearby fill-ups share their weather")
    func areaKey() { /* private */ }

    @Test("The driving area is the mean of the fill-ups logged with a place")
    func drivingArea() throws { /* private */ }
}
