// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDCore

/// Synthetic logs where the truth is known: does the engine find it, and does it stay
/// careful when the log can't tell?
@Suite("Consumption engine")
struct ConsumptionEngineTests {
    /// A stretch of `km` at `temperature`, using `per100km`.
    private func stretch(_ index: Int, _ temperature: Double, _ per100km: Double, km: Double = 500) -> ConsumptionEngine.Interval { /* private */ }

    /// The truth for these tests: 6.0 l/100 km from 15 °C up, +0.06 per °C below.
    private func truth(_ temperature: Double) -> Double { /* private */ }

    @Test("Stage 1 finds a car's cold effect from a year of stretches")
    func learnsTheSlope() throws { /* private */ }

    @Test("Only mild weather in the log: the cold effect stays close to typical cars")
    func carefulWithoutSpread() throws { /* private */ }

    @Test("Warmth never makes a car use more than at comfort")
    func noNegativeSlope() throws { /* private */ }

    @Test("Walk-forward accuracy: the weather model beats the plain average on a seasonal log")
    func accuracy() throws { /* private */ }

    @Test("Seasons by the middle of each stretch, km-weighted")
    func seasons() throws { /* private */ }

    @Test("A stretch's weather is the mean of the days after the fill-up through the next")
    func weatherOfAStretch() throws { /* private */ }

    @Test("A trip from the driver's own model at each forecast point, wet roads on top")
    func tripPrediction() throws { /* private */ }

    @Test("Stage 2 learns what motorway driving costs this car, from covered stretches")
    func drivingStage() throws { /* private */ }

    @Test("The linear solver handles a pivot and refuses a singular system")
    func solver() { /* private */ }
}

@Suite("Drive analysis")
struct RideAnalysisTests {
    /// Points north along a meridian: `speeds` in km/h, one per second.
    private func trace(_ speeds: [Double], altitudes: [Double]? = nil) -> [Ride.Point] { /* private */ }

    @Test("Distance, speed bands and the 95th-percentile top speed")
    func bands() throws { /* private */ }

    @Test("Stops of 10 s or more and harsh braking are counted")
    func stopsAndHarsh() throws { /* private */ }

    @Test("Climbing per 100 km from the altitudes; too short or empty is no drive")
    func climb() throws { /* private */ }

    @Test("Thinning keeps a point every 5 s or 50 m, and sharp speed changes")
    func thinning() { /* private */ }
}
