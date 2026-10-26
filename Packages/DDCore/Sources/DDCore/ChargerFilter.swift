// Source code is private. This file shows only its types and signatures.

import Foundation

/// The Charging list's filters and order: free points only, a price only, a minimum power,
/// and sorted by price, distance or power. Pure, so it's easy to test.
public nonisolated struct ChargerFilter: Equatable, Sendable {
    public enum Sort: String, CaseIterable, Identifiable, Sendable {
        case price, distance, power

        public var id: Self { /* private */ }

        public var label: String { /* private */ }

        public var symbol: String { /* private */ }
    }

    /// kW; 0 means any.
    public static let powerSteps

    public var sort
    public var minimumPowerKW
    public var freeNow
    public var pricedOnly

    public var isFiltering: Bool { /* private */ }

    /// `chargers` that pass the filters and match `search`, in the chosen order. A charger
    /// whose power or status isn't known is left out once that filter is on.
    public func apply(_ chargers: [ChargePoint], search: String = "") -> [ChargePoint] { /* private */ }

    public init(
        sort: Sort = Sort.price,
        minimumPowerKW: Int = 0,
        freeNow: Bool = false,
        pricedOnly: Bool = false
    ) { /* private */ }
}
