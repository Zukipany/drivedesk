// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation

/// A fuel station from Tankerkönig `list.php?type=all`, or built from another country's
/// price database (`source`).
public nonisolated struct Station: Decodable, Identifiable, Hashable, Sendable {
    public let id: String
    public let name: String
    public let brand: String
    public let street: String
    public let houseNumber: String?
    public let place: String
    public let lat: Double
    public let lng: Double
    /// km from the search point.
    public let dist: Double
    public let isOpen: Bool
    public let e5: FlexiblePrice?
    public let e10: FlexiblePrice?
    public let diesel: FlexiblePrice?
    /// Not from Tankerkönig: set by the map from the brand and OpenStreetMap.
    public var premiumDiesel: PremiumDiesel.Availability?
    /// Not from Tankerkönig: the driver's best fuel-card discount here, per fuel.
    public var discounts: [FuelType: AppliedDiscount]
    /// Where the prices come from; everything decoded from JSON is Tankerkönig.
    public var source: FuelPriceSource
    /// A premium diesel price the station reported itself (Spain's "Gasóleo Premium").
    public var premiumDieselPrice: Double?
    /// Weekly hours where the source has them (Austria, Spain); nil when unknown.
    public var openingHours: Trip.OpeningHours?

    private enum CodingKeys: String, CodingKey {
        case id, name, brand, street, houseNumber, place, lat, lng, dist, isOpen, e5, e10, diesel
    }

    public var coordinate: CLLocationCoordinate2D { /* private */ }

    /// Brand when known, otherwise the station name ("" brands are common for independents).
    public var displayName: String { /* private */ }

    /// "Leopoldstr. 12, München"; parts a source leaves empty are skipped, never ", ".
    public var address: String { /* private */ }

    /// This station with the best discount of `cards` for each fuel it sells.
    public func applyingDiscounts(_ cards: [DiscountCard], on date: Date = .now) -> Station { /* private */ }

    /// What the driver pays per litre: the board price minus their best fuel-card
    /// discount. Sorting, the cheapest pin, averages and the widget all use this.
    public func price(for fuel: FuelType) -> Double? { /* private */ }

    /// €/l on the price board, for a combustion fuel; nil for electric or when the station
    /// doesn't sell it. Premium diesel only when the station reports it (Spain, Italy, …):
    /// German stations don't report it to the MTS-K, and a guessed price is worse than none.
    public func pumpPrice(for fuel: FuelType) -> Double? { /* private */ }

    public init(
        id: String,
        name: String,
        brand: String,
        street: String,
        houseNumber: String?,
        place: String,
        lat: Double,
        lng: Double,
        dist: Double,
        isOpen: Bool,
        e5: FlexiblePrice?,
        e10: FlexiblePrice?,
        diesel: FlexiblePrice?,
        premiumDiesel: PremiumDiesel.Availability? = nil,
        discounts: [FuelType: AppliedDiscount] = [:],
        source: FuelPriceSource = .tankerkoenig,
        premiumDieselPrice: Double? = nil,
        openingHours: Trip.OpeningHours? = nil
    ) { /* private */ }
}

/// Tankerkönig sends a missing price as `false` (or `null`) instead of a number. A price
/// of 0 (or less) is a reporting error, never free fuel, so it counts as missing too:
/// otherwise it would be the cheapest pin on the map.
public nonisolated struct FlexiblePrice: Decodable, Hashable, Sendable {
    public let value: Double?

    public init(_ value: Double?) { /* private */ }

    public init(from decoder: any Decoder) throws { /* private */ }
}
