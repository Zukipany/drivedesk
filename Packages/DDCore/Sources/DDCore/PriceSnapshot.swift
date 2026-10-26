// Source code is private. This file shows only its types and signatures.

import Foundation

/// The latest prices the app loaded, shared with the widget through an App Group. The
/// widget never calls Tankerkönig itself (fair use: requests only on demand).
public nonisolated struct PriceSnapshot: Codable, Equatable, Sendable {
    public static let appGroup
    private static let key

    /// FuelType raw value, e.g. "e10".
    public let fuel: String
    public let fuelLabel: String
    public let cheapestPrice: Double
    public let cheapestStation: String
    public let averagePrice: Double
    public let stationCount: Int
    public let updatedAt: Date
    /// The fuel-card discount already in `cheapestPrice` ("−2 ct ADAC"), if any.
    public var discountLabel: String?

    public static func load(from defaults: UserDefaults? = UserDefaults(suiteName: appGroup)) -> PriceSnapshot? { /* private */ }

    public func save(to defaults: UserDefaults? = UserDefaults(suiteName: appGroup)) { /* private */ }

    /// Opens the map with this fuel: idrive://map?fuel=e10
    public var url: URL? { /* private */ }

    public init(
        fuel: String,
        fuelLabel: String,
        cheapestPrice: Double,
        cheapestStation: String,
        averagePrice: Double,
        stationCount: Int,
        updatedAt: Date,
        discountLabel: String? = nil
    ) { /* private */ }
}
