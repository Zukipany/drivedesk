// Source code is private. This file shows only its types and signatures.

import DDCore
import CoreLocation
import Foundation

/// Caches API results by place. A lookup within `matchDistance` of a stored search
/// point reuses that result, so GPS jitter never causes a new request. (Rounding
/// coordinates to a grid doesn't work: two points 50 m apart can sit on either side
/// of a grid line.)
public nonisolated struct NearbyCache<Value: Sendable>: Sendable {
    public struct Entry: Sendable {
        public let latitude: Double
        public let longitude: Double
        public let radiusKm: Double
        public let date: Date
        public let value: Value

        public func distance(to coordinate: CLLocationCoordinate2D) -> CLLocationDistance { /* private */ }

        public init(
            latitude: Double,
            longitude: Double,
            radiusKm: Double,
            date: Date,
            value: Value
        ) { /* private */ }
    }

    public var matchDistance: CLLocationDistance
    public var capacity
    private(set) var entries: [Entry]

    /// The newest entry for the same radius near `coordinate`, however old.
    public func entry(near coordinate: CLLocationCoordinate2D, radiusKm: Double) -> Entry? { /* private */ }

    public var newest: Entry? { /* private */ }

    public mutating func store(_ value: Value, at coordinate: CLLocationCoordinate2D, radiusKm: Double, date: Date) { /* private */ }

    public init(
        matchDistance: CLLocationDistance = 500,
        capacity: Int = 20,
        entries: [Entry] = []
    ) { /* private */ }
}
