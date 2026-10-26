// Source code is private. This file shows only its types and signatures.

import Foundation

/// How a plug-in hybrid was driven over a stretch of time.
///
/// It runs on electricity, on petrol, or on both, and the app can't see which. What it does
/// know: the km on the odometer, the kWh charged and the litres filled. The car uses the
/// battery first, so the kWh charged ÷ its electric consumption ≈ the km driven on
/// electricity; the rest ran on petrol. From that follow the real petrol consumption while
/// on petrol, the cost of every km, and what charging saved compared with petrol only.
public nonisolated struct HybridMix: Equatable, Sendable {
    public let km: Double
    public let kWh: Double
    public let litres: Double
    /// € for all fuel and charging in the stretch.
    public let cost: Double
    /// Estimated; at most `km`.
    public let electricKm: Double
    /// € per litre paid on average in the stretch, nil without a fill-up.
    public let petrolPrice: Double?
    /// l/100 km on petrol, used when the stretch has too few petrol km to measure it.
    public let fallbackPetrolPer100km: Double

    public var petrolKm: Double { /* private */ }
    public var electricShare: Double { /* private */ }
    public var costPer100km: Double { /* private */ }

    /// Litres per 100 km while running on petrol; measured from at least 100 petrol km.
    public var petrolPer100km: Double? { /* private */ }

    /// What the same km would have cost on petrol only, at the price paid for petrol.
    public var petrolOnlyCost: Double? { /* private */ }

    /// Charging's saving against petrol only; negative if charging cost more.
    public var savedByCharging: Double? { /* private */ }

    /// The mix between `start` and `end` (nil: from the first or to the last entry).
    /// - Parameters:
    ///   - electricPer100km: the car's electric consumption, kWh/100 km (WLTP is from the
    ///     grid, as a wallbox counts it).
    ///   - petrolPer100km: the car's petrol consumption with an empty battery.
    public init?(
        _ entries: [some FuelEntry],
        electricPer100km: Double,
        petrolPer100km: Double,
        from start: Date? = nil,
        to end: Date? = nil
    ) { /* private */ }

    /// One mix per calendar month, oldest first, for the last `months` months.
    public static func monthly(
        _ entries: [some FuelEntry],
        electricPer100km: Double,
        petrolPer100km: Double,
        months: Int = 6,
        now: Date = .now,
        calendar: Calendar = .current
    ) -> [(month: Date, mix: HybridMix)] { /* private */ }
}
