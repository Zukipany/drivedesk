// Source code is private. This file shows only its types and signatures.

import Foundation

/// The fields the maths needs from a fill-up. `FillUp` conforms, and tests use plain structs.
public nonisolated protocol FuelEntry {
    var date: Date { get }
    var amount: Double { get }
    var pricePerUnit: Double { get }
    var total: Double { get }
    var odometer: Int { get }
    var isFullTank: Bool { get }
    var fuelType: FuelType { get }
    /// How full the tank (or battery) was after filling, 0…1. Full tanks are 1; nil when
    /// a partial fill's level is unknown.
    var tankLevelAfter: Double? { get }
    /// The average price nearby (€/l or €/kWh) when it was logged, to tell what it saved.
    var nearbyAveragePrice: Double? { get }
}

nonisolated extension FuelEntry {
    public var tankLevelAfter: Double? { /* private */ }
    public var nearbyAveragePrice: Double? { /* private */ }
}

public nonisolated enum FuelMath {
    /// l/100 km (or kWh/100 km). Nil when no distance was driven.
    public static func consumption(amount: Double, km: Double) -> Double? { /* private */ }

    public struct ConsumptionPoint: Equatable, Sendable {
        public let date: Date
        public let per100km: Double
        public let km: Int
        public let amount: Double
        public let cost: Double
        /// From one full tank to the next: complete on its own. Intervals between gauge
        /// readings are rough one by one and only add up right together.
        public var isFullToFull
        /// When the stretch began (the previous known level), for the weather while driving it.
        public var startDate: Date?

        public init(
            date: Date,
            per100km: Double,
            km: Int,
            amount: Double,
            cost: Double,
            isFullToFull: Bool = false,
            startDate: Date? = nil
        ) { /* private */ }
    }

    /// Consumption per fill-up, from the tank: fuel in the tank after the previous known
    /// level, plus everything tanked since, minus what's in the tank now, over the km
    /// driven. A full tank is a known level (100 %); a partial fill counts when its level
    /// after filling is known ("¾ full", "charged to 80 %") and the tank or battery size
    /// is set. Partial fills with an unknown level are carried to the next known level,
    /// so two full tanks give the classic full-to-full figure. Fills before the first
    /// known level are skipped, and an interval that would use less than nothing (a
    /// misread gauge) is dropped.
    public static func consumptionSeries<E: FuelEntry>(_ entries: [E], capacity: Double? = nil) -> [ConsumptionPoint] { /* private */ }

    /// True for a full-to-full reading under half or over twice the usual (the median of the
    /// series, from 3 readings on): a fill-up missing in between halves the figure, one
    /// logged twice doubles it. Driving style moves it by a third at most.
    /// Gauge-based readings never count: they're rough one by one and balance out in pairs.
    public static func isOutlier(_ point: ConsumptionPoint, among series: [ConsumptionPoint]) -> Bool { /* private */ }

    /// A reading under this share of the median is left out (a forgotten fill-up)…
    public static let outlierLowShare
    /// …and over this one (a fill-up logged twice).
    public static let outlierHighShare
    /// Readings needed before any counts as unusual.
    public static let outlierMinimumReadings

    /// The series without readings that are most likely logging mistakes (see `isOutlier`).
    public static func withoutOutliers(_ series: [ConsumptionPoint]) -> [ConsumptionPoint] { /* private */ }

    /// The reading a new fill-up would give, for the form's live preview: the point of the
    /// series that the draft closes. A backdated draft closes a point in the middle.
    public static func reading<E: FuelEntry>(adding draft: Reading, to entries: [E], capacity: Double?) -> ConsumptionPoint? { /* private */ }

    /// A plain fill-up value, for previews and mixing saved and unsaved entries.
    public struct Reading: FuelEntry, Sendable {
        public var date: Date
        public var amount: Double
        public var pricePerUnit: Double
        public var total: Double
        public var odometer: Int
        public var isFullTank: Bool
        public var fuelType: FuelType
        public var tankLevelAfter: Double?

        public init(
            date: Date,
            amount: Double,
            pricePerUnit: Double,
            total: Double,
            odometer: Int,
            isFullTank: Bool,
            fuelType: FuelType,
            tankLevelAfter: Double?
        ) { /* private */ }

        public init(_ entry: some FuelEntry) { /* private */ }
    }

    /// How full the tank was before a full fill: (tank size − litres added) ÷ tank size.
    /// Nil without a tank size or when more was added than the tank holds.
    public static func levelBeforeFilling(added: Double, capacity: Double?) -> Double? { /* private */ }

    /// Estimated level after a partial fill: the previous known level plus fuel added
    /// since, minus what the km since then used at the average consumption, plus what's
    /// added now.
    public static func estimatedLevelAfter(
        previousLevel: Double,
        addedSince: Double = 0,
        kmSince: Int,
        per100km: Double,
        added: Double,
        capacity: Double
    ) -> Double? { /* private */ }

    /// Distance one full tank (or battery) covers at this consumption.
    public static func range(capacity: Double?, per100km: Double) -> Double? { /* private */ }

    public struct Averages: Equatable, Sendable {
        /// l/100 km over all measured intervals, weighted by distance.
        public let per100km: Double
        /// €/km over all measured intervals.
        public let costPerKm: Double
        public let km: Int

        public init(
            per100km: Double,
            costPerKm: Double,
            km: Int
        ) { /* private */ }
    }

    /// Distance-weighted averages, so a short trip doesn't count as much as a long one.
    public static func averages(of series: [ConsumptionPoint]) -> Averages? { /* private */ }

    public struct PeriodTotal: Equatable, Sendable {
        public let period: Date
        public let total: Double

        public init(
            period: Date,
            total: Double
        ) { /* private */ }
    }

    /// Spending per calendar period (month by default; use `.weekOfYear` or `.year`).
    public static func spending<E: FuelEntry>(
        _ entries: [E],
        by component: Calendar.Component = .month,
        calendar: Calendar = .current
    ) -> [PeriodTotal] { /* private */ }

    /// Percentage change from `old` to `new`. Nil when there is nothing to compare with.
    public static func percentChange(from old: Double, to new: Double) -> Double? { /* private */ }

    // MARK: Amount × price = total

    public enum Field: Hashable, Sendable { case amount, price, total }

    /// Rounds a euro value to whole cents.
    public static func cents(_ value: Double) -> Double { /* private */ }

    /// Computes `field` from the other two values, or nil if they're missing.
    public static func derive(_ field: Field, amount: Double?, price: Double?, total: Double?) -> Double? { /* private */ }

    /// Receipts round the total, so allow a few cents of difference.
    public static func isConsistent(amount: Double, price: Double, total: Double, tolerance: Double = 0.05) -> Bool { /* private */ }
}
