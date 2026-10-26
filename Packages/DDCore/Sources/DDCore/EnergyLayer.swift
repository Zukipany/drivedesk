// Source code is private. This file shows only its types and signatures.

import Foundation

/// A plug-in hybrid logs litres and kWh. Each energy is its own chart layer, so litres
/// and kWh are never added together.
public nonisolated enum EnergyLayer: String, CaseIterable, Identifiable, Sendable {
    case fuel, electric

    public var id: Self { /* private */ }

    public var other: EnergyLayer { /* private */ }

    public func contains(_ fuel: FuelType) -> Bool { /* private */ }

    public static func entries<E: FuelEntry>(_ entries: [E], in layer: EnergyLayer) -> [E] { /* private */ }

    /// Scales values into 0…1 so two lines in different units (l and kWh) can share one
    /// plot. A flat or single-value series sits in the middle.
    public static func normalized(_ values: [Double]) -> [Double] { /* private */ }
}
