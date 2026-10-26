// Source code is private. This file shows only its types and signatures.

import Foundation

/// Every energy type the app can price, filter, log and chart.
/// Stored in SwiftData as its `rawValue` so `#Predicate` can filter on it.
public nonisolated enum FuelType: String, Codable, CaseIterable, Identifiable, Sendable {
    case e5, e10, diesel, dieselPremium, evAC, evDC

    public var id: Self { /* private */ }

    /// What a car runs on. A car can tank several fuels of one kind (E5 and E10, or
    /// diesel and premium diesel), never petrol and diesel.
    public enum Kind: String, CaseIterable, Identifiable, Sendable {
        case petrol, diesel, electric
        public var id: Self { /* private */ }

        public var fuels: [FuelType] { /* private */ }

        /// The usual choice when this kind is picked.
        public var defaultFuel: FuelType { /* private */ }

        public var label: String { /* private */ }
    }

    public static let combustion: [FuelType]
    public static let electric: [FuelType]
    /// The fuels German stations must report to the MTS-K, so Tankerkönig has prices for
    /// them. Premium fuels (Aral Ultimate Diesel, Shell V-Power Diesel…) aren't reported.
    public static let publiclyPriced: [FuelType]
    /// The map's filter chips.
    public static let mapFilters: [FuelType]

    public var isElectric: Bool { /* private */ }

    public var kind: Kind { /* private */ }

    /// Unit symbol shown next to amounts ("52,00 l", "41,30 kWh").
    public var unitSymbol: String { /* private */ }

    public var label: String { /* private */ }

    /// Compact label for chips and pins.
    public var shortLabel: String { /* private */ }

    public var symbol: String { /* private */ }
}
