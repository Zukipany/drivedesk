// Source code is private. This file shows only its types and signatures.

import Foundation

/// Picks where to stop on a trip and how much to fill.
///
/// The cheapest plan only ever fills up completely or buys just enough to reach the next
/// stop with the reserve (the "gas station problem": anything in between can be bought later
/// for the same or less). So every stop is arrived at with one of a few levels, and a search
/// over (station, level on arrival) finds the cheapest plan exactly: fuel bought, plus the
/// detour, plus a small charge per stop so a few cents never cost an extra stop (measure 4c).
public nonisolated enum TripPlanner {
    /// € a stop has to save to be worth it (4c)…
    public static let cheapestStopPenalty
    /// …and with "Fewest stops", which makes every stop expensive.
    public static let fewestStopsPenalty

    public static func stopPenalty(_ preference: Trip.Preference) -> Double { /* private */ }
    /// At night a station with unknown hours counts this much dearer (measure 3b).
    public static let nightPenalty
    /// The station before a stretch this long without stations fills up completely (2b).
    public static let gapKm
    /// Prices move about 1.5 ct an hour, at most 10 ct before arrival (measure 4a).
    public static let driftPerHour
    public static let maxDrift
    /// A fuel stop takes about 6 minutes.
    public static let fuelStopMinutes

    public static func isNight(_ date: Date, calendar: Calendar = .current) -> Bool { /* private */ }

    public static func plan(
        route: RouteProfile,
        candidates all: [Trip.Candidate],
        car: Trip.Car,
        settings: Trip.Settings,
        calendar: Calendar = .current
    ) -> Trip.Plan { /* private */ }

    /// Unknown hours and arriving at night: it may be closed (3b). Known 24/7 is fine.
    public static func nightRisk(_ candidate: Trip.Candidate, at date: Date, calendar: Calendar) -> Bool { /* private */ }

    /// At most the 3 cheapest per 10 km of route (plus every unpriced one where none is
    /// priced), so long routes stay quick to plan.
    /// Stations the driver chose always stay.
    public static func thinned(_ candidates: [Trip.Candidate], keeping chosen: Set<String> = []) -> [Trip.Candidate] { /* private */ }

    /// Why no plan exists: the car can't reach any station from the start (1a), or a stretch
    /// has no station within a full tank (2a).
    public static func infeasibility(
        candidates: [Trip.Candidate],
        car: Trip.Car,
        settings: Trip.Settings,
        distance: Double
    ) -> [Trip.Warning] { /* private */ }

    /// Lowest and highest total if prices move until the car gets there (4a). Electricity
    /// tariffs don't change by the hour, so charging has no range.
    public static func costRange(_ stops: [Trip.Stop], car: Trip.Car) -> (Double, Double) { /* private */ }
}
