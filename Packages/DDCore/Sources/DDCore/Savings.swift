// Source code is private. This file shows only its types and signatures.

import Foundation

/// What choosing the station saved: the price paid against the average board price in
/// the map's radius at the time, times the litres or kWh. Negative means it cost more.
///
/// The average is the last map search's, not the station's: a fill-up far away (another
/// city, another country) within the 12 hours would compare with the wrong place. So a
/// price more than 25 % off the average isn't compared; prices within a city differ by
/// about 10 %, and a motorway station by about 20 %.
public nonisolated struct Savings: Equatable, Sendable {
    public static let maxDeviation

    /// €; negative when the fill-ups cost more than the average would have.
    public let amount: Double
    /// What the same fill-ups would have cost at the average price.
    public let atAverage: Double
    /// How many fill-ups had a price to compare with.
    public let count: Int

    /// Saved as a share of the average cost: 0.03 is 3 % below average.
    public var share: Double { /* private */ }

    /// Nil when none of the entries has an average to compare with.
    public init?(_ entries: [some FuelEntry]) { /* private */ }

    /// One fill-up's saving per unit, in cents: 3.1 means 3,1 ct/l below average.
    public static func cents(_ entry: some FuelEntry) -> Double? { /* private */ }

    /// The entry's nearby average, when its price is close enough to compare with it.
    public static func comparableAverage(_ entry: some FuelEntry) -> Double? { /* private */ }
}
