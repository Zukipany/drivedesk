// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation

/// A drive recorded from the iPhone's location: who, when, the trace, and what it says about
/// the roads and the driving (`RideAnalysis`). Kept on the iPhone only (`RideStore`).
public nonisolated struct Ride: Codable, Equatable, Identifiable, Sendable {
    public struct Point: Codable, Equatable, Sendable {
        public let time: Date
        public let latitude: Double
        public let longitude: Double
        /// m/s from GPS; negative when unknown.
        public let speed: Double
        /// m above sea level; nil when unknown.
        public let altitude: Double?

        public var coordinate: CLLocationCoordinate2D { /* private */ }

        public init(
            time: Date,
            latitude: Double,
            longitude: Double,
            speed: Double,
            altitude: Double?
        ) { /* private */ }
    }

    /// How the car was recognised.
    public enum Recognition: String, Codable, Sendable {
        /// Its CarPlay connected.
        case carPlay
        /// Its Bluetooth (hands-free or audio), linked to it.
        case bluetooth
        /// A Shortcut started the drive ("When CarPlay connects").
        case shortcut
        /// Older drives: the car's CarPlay or Bluetooth audio, before the two were told apart.
        case carAudio
        /// No car connection: the active car in the Garage.
        case activeCar
    }

    public var id
    /// The company whose car it was; nil for a private car. Optional, so drives saved before
    /// it existed still decode.
    public var companyID: String?
    /// The car's ID in the local store.
    public var carID: String
    public var carName: String
    public var recognition: Recognition
    /// The car connection's name ("BMW 41532"), when there was one.
    public var audioPort: String?
    /// Its id, so the drive ends when that car disconnects.
    public var audioUID: String?
    public var points: [Point]

    public var start: Date? { /* private */ }
    public var end: Date? { /* private */ }

    public init(
        id: UUID = UUID(),
        companyID: String? = nil,
        carID: String,
        carName: String,
        recognition: Recognition,
        audioPort: String? = nil,
        audioUID: String? = nil,
        points: [Point] = []
    ) { /* private */ }
}

/// What a ride's trace says, for the consumption engine and the developer panel.
public nonisolated struct RideAnalysis: Codable, Equatable, Sendable {
    /// Speed bands by GPS speed: city below 50 km/h, country roads to 90, motorway above.
    public static let cityKmh
    public static let motorwayKmh
    /// Below this the car stands (traffic lights, jams).
    public static let standingKmh
    /// Speeding up or braking harder than this (m/s², over at least a second) counts as harsh.
    public static let harshAcceleration
    public static let harshBraking
    /// GPS points further apart than this (a tunnel, the app stopped) don't count as driving.
    public static let maxGap: TimeInterval

    public let km: Double
    public let duration: TimeInterval
    /// Time with the car moving.
    public let movingTime: TimeInterval
    /// km/h over the moving time.
    public let averageKmh: Double
    /// km/h, the 95th percentile so a GPS spike doesn't count.
    public let topKmh: Double
    /// Shares of the km: city, country roads, motorway (they add up to 1).
    public let cityShare: Double
    public let ruralShare: Double
    public let motorwayShare: Double
    /// Stops (standing 10 s or more) per 10 km.
    public let stopsPer10km: Double
    /// Harsh accelerations and brakings per 100 km.
    public let harshPer100km: Double
    /// Metres climbed per 100 km.
    public let climbPer100km: Double

    public init?(_ points: [Ride.Point]) { /* private */ }

    /// Running sums over the trace's segments.
    private struct Totals {
        var km , moving , cityKm , ruralKm , motorwayKm , climb
        var stops , harsh
        var standingSince: Date?
        var speeds: [Double]

        mutating func add(from previous: Ride.Point, to point: Ride.Point) { /* private */ }

        /// A stop is standing 10 s or more, counted when the car moves again.
        private mutating func countStanding(kmh: Double, previous: Ride.Point, point: Ride.Point, seconds: TimeInterval) { /* private */ }
    }

    /// Thins a live trace for storage: a point every 5 s or 50 m, whichever comes first,
    /// keeping every speed change that matters for the harsh-driving count.
    public static func shouldKeep(_ point: Ride.Point, after last: Ride.Point?) -> Bool { /* private */ }
}
