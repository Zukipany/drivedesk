// Source code is private. This file shows only its types and signatures.

import Foundation

/// Kilometres the odometer shows between two real readings that no trip accounts for (plan
/// section 16, step 5): "37 km not recorded between 3 and 9 November."
public nonisolated struct TripGap: Equatable, Sendable, Identifiable {
    public var vehicleID: UUID
    public var from: Date
    public var to: Date
    /// What the odometer says was driven between the two readings.
    public var odometerKm: Int
    /// What the trips in between add up to.
    public var recordedKm: Double

    public init(vehicleID: UUID, from: Date, to: Date, odometerKm: Int, recordedKm: Double) { /* private */ }

    public var id: String { /* private */ }
    public var missingKm: Int { /* private */ }
}

/// The electronic logbook's rules on the device (US-34, plan section 16).
public nonisolated enum Logbook {
    /// A gap counts above 2 % of the distance between two readings, and above 5 km, so a
    /// detour to the pump isn't a task.
    public static let gapShare
    public static let gapMinimumKm

    /// A car's real odometer readings: fill-ups with an odometer, oldest first.
    public static func readings(of vehicleID: UUID, in fillUps: [FillUp]) -> [(at: Date, km: Int)] { /* private */ }

    /// Stretches between readings where the trips fall short of the odometer, newest first.
    /// Only from the last reading before the car's first trip on: before that the logbook
    /// wasn't kept.
    public static func gaps(of vehicleID: UUID, fillUps: [FillUp], trips: [LogbookTrip]) -> [TripGap] { /* private */ }

    /// The car's odometer when a trip starts at `date`: the later of the last trip's end and the
    /// last real reading before it; nil when neither is known.
    public static func odometer(at date: Date, of vehicleID: UUID, trips: [LogbookTrip], fillUps: [FillUp]) -> Int? { /* private */ }

    /// A person's trips still to classify, oldest first: they seal after 7 days.
    public static func toClassify(_ trips: [LogbookTrip], of memberID: UUID) -> [LogbookTrip] { /* private */ }

    /// What a classification still lacks: a business trip needs its purpose and the partner.
    public static func problems(type: TripType, purpose: String?, partner: String?) -> [String] { /* private */ }

    /// Kilometres by type, for a month's or a year's summary.
    public static func kilometres(_ trips: [LogbookTrip]) -> [TripType: Double] { /* private */ }

    /// A trip the phone recorded, with its odometer worked out from the last known reading.
    public static func recordedTrip(
        companyID: UUID,
        vehicleID: UUID,
        memberID: UUID,
        startedAt: Date,
        endedAt: Date,
        km: Double,
        startAddress: String?,
        endAddress: String?,
        startOdometerKm: Int?
    ) -> LogbookTrip { /* private */ }
}
