// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation

/// A charging location, independent of where the data came from.
/// `MobiDataAPI`, `NRELAPI`, `OpenChargeMapAPI` and `OverpassAPI` all decode into this type.
public nonisolated struct ChargePoint: Identifiable, Hashable, Sendable {
    public enum Source: String, Sendable {
        case mobiData, nrel, openChargeMap, openStreetMap

        /// Licence attribution, required by every source.
        public var attribution: String { /* private */ }

        public var shortAttribution: String { /* private */ }

        public var url: URL { /* private */ }
    }

    public struct Connection: Hashable, Sendable {
        /// "Type 2", "CCS", "CHAdeMO", … nil when the source doesn't say.
        public let kind: String?
        /// nil when unknown, which is common in OpenStreetMap.
        public let powerKW: Double?
        public let quantity: Int
        public let isDC: Bool
        /// Ad-hoc tariff, when the operator publishes one (MobiData BW only).
        public var tariff: ChargingTariff?

        /// Adds up connectors of the same kind, power and tariff.
        public static func combined(_ connections: [Connection]) -> [Connection] { /* private */ }

        public init(
            kind: String?,
            powerKW: Double?,
            quantity: Int,
            isDC: Bool,
            tariff: ChargingTariff? = nil
        ) { /* private */ }
    }

    /// Live occupancy from the operator, e.g. 2 of 4 points free.
    public struct Availability: Hashable, Sendable {
        public let available: Int
        public let total: Int

        public init(
            available: Int,
            total: Int
        ) { /* private */ }
    }

    /// Prefixed with the source ("ocm-123", "osm-node-456") so IDs never collide.
    public let id: String
    public let source: Source
    public let title: String
    public let operatorName: String?
    /// Open Charge Map only; resolve via `/v3/referencedata` to show a name.
    public let operatorID: Int?
    public let addressLine: String?
    public let town: String?
    public let latitude: Double
    public let longitude: Double
    /// km from the search point.
    public let distanceKm: Double?
    /// Free text as reported by the source. Never treat it as a reliable price.
    public let usageCost: String?
    public let connections: [Connection]
    /// Nil when the source has no live status.
    public var availability: Availability?
    /// The site's own name ("Tiefgarage Marienplatz") when it's readable and not just the address.
    public var siteName: String?
    /// Not from the data source: the driver's cheapest charging plan here, when it beats the ad-hoc price.
    public var plan: AppliedChargingPlan?

    public var coordinate: CLLocationCoordinate2D { /* private */ }
    public var maxPowerKW: Double? { /* private */ }
    /// DC when any connector is DC (CCS, CHAdeMO, …) or delivers 50 kW or more.
    public var isFast: Bool { /* private */ }
    public var chargeType: FuelType { /* private */ }
    public var pointCount: Int { /* private */ }

    /// Power of the connectors that match `chargeType`. A DC station with an unlisted
    /// CCS power and a 22 kW Type 2 socket must not be labelled "22 kW".
    public var labelPowerKW: Double? { /* private */ }

    /// The tariff of the connectors that match `chargeType`, cheapest first. A DC
    /// station that also has a Type 2 socket is priced by its DC connectors.
    public var tariff: ChargingTariff? { /* private */ }

    /// Ad-hoc €/kWh (card payment, no contract), nil when the operator doesn't publish it.
    public var adHocPricePerKWh: Double? { /* private */ }

    /// What the driver pays per kWh: their cheapest charging plan here, or the ad-hoc price
    /// when no plan beats it. Sorting, the cheapest pin and the averages all use this.
    public var pricePerKWh: Double? { /* private */ }

    /// This charger with the cheapest of `plans`, kept only when it beats the ad-hoc price.
    public func applyingPlans(_ plans: [ChargingPlan]) -> ChargePoint { /* private */ }

    /// "150 kW", or "DC" / "AC" when the power isn't known.
    public var powerLabel: String { /* private */ }

    private static func isDCLike(_ connection: Connection) -> Bool { /* private */ }

    /// "CCS, Type 2"
    public var connectorSummary: String? { /* private */ }

    /// "north-east" etc. from `origin`; helps tell sites apart when OSM has no address.
    public func direction(from origin: CLLocationCoordinate2D) -> String { /* private */ }

    public static func distanceKm(from origin: CLLocationCoordinate2D?, latitude: Double, longitude: Double) -> Double? { /* private */ }

    public init(
        id: String,
        source: Source,
        title: String,
        operatorName: String?,
        operatorID: Int?,
        addressLine: String?,
        town: String?,
        latitude: Double,
        longitude: Double,
        distanceKm: Double?,
        usageCost: String?,
        connections: [Connection],
        availability: Availability? = nil,
        siteName: String? = nil,
        plan: AppliedChargingPlan? = nil
    ) { /* private */ }
}

/// One of the eight compass directions from one point to another.
public nonisolated enum CompassDirection: Int, CaseIterable {
    case north, northEast, east, southEast, south, southWest, west, northWest

    /// Initial great-circle bearing, rounded to the nearest 45°.
    public init(from a: CLLocationCoordinate2D, to b: CLLocationCoordinate2D) { /* private */ }

    public var label: String { /* private */ }
}
