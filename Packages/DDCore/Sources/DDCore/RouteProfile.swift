// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation

/// A driving route as the planner needs it: points with the km and seconds from the start.
/// Travel time is spread by distance (Apple's route gives one total).
public nonisolated struct RouteProfile: Codable, Equatable, Sendable {
    public struct Point: Codable, Equatable, Sendable {
        public let latitude: Double
        public let longitude: Double
        public let km: Double

        public var coordinate: CLLocationCoordinate2D { /* private */ }

        public init(
            latitude: Double,
            longitude: Double,
            km: Double
        ) { /* private */ }
    }

    public let points: [Point]
    public let travelTime: TimeInterval

    public var distanceKm: Double { /* private */ }
    public var averageKmh: Double { /* private */ }

    /// From the route's coordinates, thinned to one point every `spacingKm` so long routes
    /// stay small enough to save (measure 8a) and fast to search.
    public init(coordinates: [CLLocationCoordinate2D], travelTime: TimeInterval, spacingKm: Double = 0.5) { /* private */ }

    /// Seconds from the start to `km`.
    public func seconds(at km: Double) -> TimeInterval { /* private */ }

    /// The point `km` from the start.
    public func coordinate(at km: Double) -> CLLocationCoordinate2D? { /* private */ }

    /// Where a place lies along the route: the km where it's closest and how far off it is.
    public func project(_ coordinate: CLLocationCoordinate2D) -> (kmAlong: Double, offsetKm: Double)? { /* private */ }

    /// Extra km to leave the route, reach the place and come back: roads aren't straight, so
    /// 1.3 × the distance each way.
    public static func detourKm(offsetKm: Double) -> Double { /* private */ }

    /// Points every `everyKm` between two km marks, for searches along the route.
    public func samples(from start: Double, to end: Double, everyKm: Double) -> [(km: Double, coordinate: CLLocationCoordinate2D)] { /* private */ }

    /// How far along the route the driver is now (measure 4b, 9b); nil when off the route by
    /// more than `toleranceKm`.
    public func progress(at location: CLLocationCoordinate2D, toleranceKm: Double = 3) -> Double? { /* private */ }
}
