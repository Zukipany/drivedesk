// Source code is private. This file shows only its types and signatures.

import Foundation

/// How the station list is ordered. Remembered between launches.
public nonisolated enum StationSort: String, CaseIterable, Identifiable, Sendable {
    case price, distance, openFirst

    public var id: Self { /* private */ }

    public var label: String { /* private */ }

    public var symbol: String { /* private */ }

    public func sorted(_ stations: [Station], fuel: FuelType) -> [Station] { /* private */ }

    /// Stations whose brand, name, street or town contains the search, ignoring case and accents.
    public static func matching(_ stations: [Station], search: String) -> [Station] { /* private */ }
}
