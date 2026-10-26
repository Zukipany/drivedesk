// Source code is private. This file shows only its types and signatures.

import Foundation

/// Spending so far this calendar year and where it's heading: what was spent per day so
/// far, over the whole year. Needs a few weeks of data to mean something.
public nonisolated struct YearForecast: Equatable, Sendable {
    public let year: Int
    public let spentSoFar: Double
    /// Nil until 30 days of the year have passed or no fill-up was logged this year.
    public let forecast: Double?
    public let fillUpCount: Int

    public init(entries: [some FuelEntry], now: Date = .now, calendar: Calendar = .current) { /* private */ }
}
