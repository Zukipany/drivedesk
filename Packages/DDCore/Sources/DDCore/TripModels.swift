// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation

/// The trip planner's data. Everything is Codable so an active trip survives losing the
/// network or the app being closed (measure 8a: the plan lives on the iPhone).
public nonisolated enum Trip {
    /// What the car brings to the trip, already adjusted for speed and weather.
    public struct Car: Codable, Equatable, Sendable {
        public enum Kind: String, Codable, Sendable { case combustion, electric, plugInHybrid }

        public let kind: Kind
        /// Litres for fuel (the petrol tank of a plug-in hybrid), kWh for an electric car.
        public let capacity: Double
        /// 0…1 when leaving.
        public let level: Double
        /// True when the level comes from the log, not the gauge (measure 1b: planned with a margin).
        public let levelIsEstimated: Bool
        /// l or kWh per 100 km on this trip, after the speed and weather factors (measure 5).
        public let per100km: Double
        /// Plug-in hybrids: km on the battery when leaving, used first (measure 7a).
        public var electricKm: Double
        /// Electric cars: charge to this share at stops; above 80 % charging slows down (measure 6c).
        public var chargeTo: Double
        /// Electric cars: the most the car takes at a DC charger, kW.
        public var maxChargingKW: Double

        /// Units (l or kWh) per km.
        public var perKm: Double { /* private */ }
        /// Km a stop can fill up to.
        public var fullRangeKm: Double { /* private */ }
        /// Km in the tank or battery when leaving. An estimated level counts 85 %, so a
        /// gauge read a little high never leaves the car short (measure 1b).
        public var startRangeKm: Double { /* private */ }

        public init(
            kind: Kind,
            capacity: Double,
            level: Double,
            levelIsEstimated: Bool,
            per100km: Double,
            electricKm: Double = 0,
            chargeTo: Double = 0.8,
            maxChargingKW: Double = 100
        ) { /* private */ }
    }

    /// The share of an estimated level the planner relies on.
    public static let estimatedLevelShare

    public enum Preference: String, Codable, CaseIterable, Sendable { case cheapest, fewestStops }

    public struct Settings: Codable, Equatable, Sendable {
        /// Never arrive anywhere with less (measure 1c).
        public var reserveKm: Double
        /// Stations further off the route are left out.
        public var maxDetourKm: Double
        public var preference: Preference
        public var departure: Date
        /// Stations the driver picked on the trip map: the plan has to stop there.
        public var chosen: Set<String>
        /// Stations the driver swapped out: never planned again.
        public var avoided: Set<String>

        public init(
            reserveKm: Double = 50,
            maxDetourKm: Double = 5,
            preference: Preference = .cheapest,
            departure: Date = .now,
            chosen: Set<String> = [],
            avoided: Set<String> = []
        ) { /* private */ }
    }

    /// Weekly opening hours. Nil hours on a candidate mean "not known".
    public struct OpeningHours: Codable, Hashable, Sendable {
        /// Minutes after midnight, per weekday (1 = Sunday … 7 = Saturday, as `Calendar`).
        public struct Interval: Codable, Hashable, Sendable {
            public let weekday: Int
            public let opens: Int
            public let closes: Int

            public init(
                weekday: Int,
                opens: Int,
                closes: Int
            ) { /* private */ }
        }

        public let intervals: [Interval]
        public let alwaysOpen: Bool

        public static let twentyFourSeven

        public func isOpen(at date: Date, calendar: Calendar = .current) -> Bool { /* private */ }

        public init(
            intervals: [Interval],
            alwaysOpen: Bool
        ) { /* private */ }
    }

    /// A place to fuel or charge near the route.
    public struct Candidate: Codable, Equatable, Identifiable, Sendable {
        public let id: String
        public let name: String
        public let address: String?
        public let latitude: Double
        public let longitude: Double
        /// km from the start where the driver leaves the route for it.
        public let kmAlong: Double
        /// Extra km there and back (measure 2c widens this where stations are rare).
        public let detourKm: Double
        /// €/l or €/kWh; nil when no source reports one (Apple Maps places, countries without data).
        public let price: Double?
        /// When the price was published, for its age at arrival (measure 4a).
        public let priceDate: Date?
        public let hours: OpeningHours?
        /// Electric: the charger's DC power, kW.
        public var chargingKW: Double?
        /// Electric: false when the source doesn't list the plugs (measure 6a).
        public var plugConfirmed
        /// Who reported it: "Tankerkönig", "E-Control", "Apple Maps"…
        public var source: String

        public var coordinate: CLLocationCoordinate2D { /* private */ }

        public init(
            id: String,
            name: String,
            address: String?,
            latitude: Double,
            longitude: Double,
            kmAlong: Double,
            detourKm: Double,
            price: Double?,
            priceDate: Date?,
            hours: OpeningHours?,
            chargingKW: Double? = nil,
            plugConfirmed: Bool = true,
            source: String = ""
        ) { /* private */ }
    }

    public enum StopNote: String, Codable, Sendable, Hashable {
        /// Arrives with less than the reserve: the nearest station, not the cheapest (measure 1c).
        case critical
        /// The last station before a long stretch without any (measure 2a): fills up completely (2b).
        case lastBeforeGap
        /// Opening hours unknown and arriving at night (measure 3b).
        case mayBeClosed
        /// The price is hours old by arrival: an estimate (measure 4a).
        case priceMayChange
        /// No price published here; chosen because it's needed (measure 2c).
        case noPrice
        /// The charger's plugs aren't listed (measure 6a).
        case plugUnconfirmed
    }

    public struct Stop: Codable, Equatable, Identifiable, Sendable {
        public let candidate: Candidate
        public let eta: Date
        /// km left when arriving at the station.
        public let arrivalRangeKm: Double
        /// Litres or kWh to fill.
        public let amount: Double
        /// €; nil without a price.
        public let cost: Double?
        /// Minutes at the stop: 6 for fuel, the charging time for an electric car (measure 6c).
        public let minutes: Double
        public let notes: Set<StopNote>
        /// The next-best station on the same stretch, if this one is closed (measure 3c).
        public let backup: Candidate?
        /// Set when the driver has been there (measure 9b).
        public var isDone

        public var id: String { /* private */ }

        public init(
            candidate: Candidate,
            eta: Date,
            arrivalRangeKm: Double,
            amount: Double,
            cost: Double?,
            minutes: Double,
            notes: Set<StopNote>,
            backup: Candidate?,
            isDone: Bool = false
        ) { /* private */ }
    }

    public enum Warning: Codable, Equatable, Sendable, Hashable {
        /// The car can't reach any station on the route with its reserve (measure 1a).
        case fillUpBeforeLeaving
        /// No station reachable for this stretch even with a full tank (measure 2a).
        case cannotReach(fromKm: Double, gapKm: Double)
        /// The level when leaving is an estimate (measure 1b).
        case levelEstimated
        /// Stations left out because they're closed on arrival (measure 3a).
        case closedOnArrival(count: Int)

        /// The trip can't be driven as planned until the driver acts.
        public var isBlocking: Bool { /* private */ }
    }

    public struct Plan: Codable, Equatable, Sendable {
        public let distanceKm: Double
        public let travelTime: TimeInterval
        public var stops: [Stop]
        public let warnings: [Warning]
        /// km left at the destination.
        public let arrivalRangeKm: Double
        /// € for everything bought, low and high with price changes until arrival (measure 4a).
        public let costLow: Double
        public let costHigh: Double
        public let car: Car
        public let settings: Settings

        public var arrivalTime: Date { /* private */ }

        /// The first stop not done yet (measure 9a/9b).
        public var nextStop: Stop? { /* private */ }

        /// This plan with a stop ticked off: by the driver, or when a fill-up is logged there (9b).
        public func markingDone(_ id: Stop.ID) -> Plan { /* private */ }

        public init(
            distanceKm: Double,
            travelTime: TimeInterval,
            stops: [Stop],
            warnings: [Warning],
            arrivalRangeKm: Double,
            costLow: Double,
            costHigh: Double,
            car: Car,
            settings: Settings
        ) { /* private */ }
    }
}
