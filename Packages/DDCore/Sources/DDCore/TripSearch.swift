// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation

/// Where along a route to look for stations, and how the results become candidates.
///
/// Tankerkönig allows one request a minute, so asking every 25 km of a 600 km trip would
/// take a quarter of an hour. Prices are asked for only where the car will need to stop:
/// twice before each point where the range runs out (each search covers about 50 km of
/// route). Apple Maps places, without prices, cover the whole route so gaps are found (2a).
public nonisolated enum TripSearch {
    /// The search radius at each mark; Tankerkönig's maximum.
    public static let radiusKm

    /// km marks to ask for prices at.
    public static func priceMarks(distance: Double, startRange: Double, fullRange: Double, reserve: Double) -> [Double] { /* private */ }

    /// Apple Maps place searches: every this many km along the route, at most 30 searches.
    public static let placeSpacingKm
    /// The radius of each place search.
    public static let placeRadiusKm

    /// km marks for Apple Maps place searches along the whole route.
    public static func placeMarks(distance: Double) -> [Double] { /* private */ }

    private static func deduplicated(_ marks: [Double], within km: Double) -> [Double] { /* private */ }

    /// Stations within the detour limit. Where none is within 30 km of route, stations up to
    /// three times as far off count too: a longer detour beats running dry (2c).
    public static func corridor(_ candidates: [Trip.Candidate], maxDetourKm: Double) -> [Trip.Candidate] { /* private */ }

    /// Priced stations plus Apple Maps places; a place within 150 m of a priced station is that station.
    public static func merged(priced: [Trip.Candidate], places: [Trip.Candidate]) -> [Trip.Candidate] { /* private */ }

    // MARK: Building candidates

    /// A fuel station as a trip candidate, priced with the first of `fuels` it sells.
    public static func candidate(_ station: Station, fuels: [FuelType], route: RouteProfile, priceDate: Date) -> Trip.Candidate? { /* private */ }

    /// A charger as a trip candidate: DC only, at least `minimumKW`, with the car's plug (6a, 6b).
    /// A charger whose plugs aren't listed counts, marked as unconfirmed.
    public static func candidate(_ charger: ChargePoint, plug: TripConsumption.Plug, minimumKW: Double, route: RouteProfile) -> Trip.Candidate? { /* private */ }

    /// An Apple Maps place (no price, hours unknown), so stretches without data still have stations (2c).
    public static func place(id: String, name: String, coordinate: CLLocationCoordinate2D, route: RouteProfile) -> Trip.Candidate? { /* private */ }
}
