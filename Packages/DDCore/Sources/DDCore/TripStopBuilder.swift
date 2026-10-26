// Source code is private. This file shows only its types and signatures.

import Foundation

/// Turns the solver's legs into the stops the driver sees: arrival time, litres or kWh,
/// cost, notes and a backup station.
public nonisolated struct TripStopBuilder {
    public let solver: TripSolver
    public let route: RouteProfile
    public let settings: Trip.Settings
    public let calendar: Calendar

    public func stops(for legs: [TripSolver.Leg]) -> [Trip.Stop] { /* private */ }

    private func notes(_ candidate: Trip.Candidate, node: Int, arrival: Double, eta: Date) -> Set<Trip.StopNote> { /* private */ }

    /// The best other station on the same stretch (3c): reachable with what the car left the
    /// stop before with, open on arrival, able to reach the next stop after filling up.
    private func backup(for node: Int, previous: TripSolver.Leg, next: Int, eta: Date) -> Trip.Candidate? { /* private */ }

    public init(
        solver: TripSolver,
        route: RouteProfile,
        settings: Trip.Settings,
        calendar: Calendar
    ) { /* private */ }
}
