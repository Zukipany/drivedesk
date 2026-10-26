// Source code is private. This file shows only its types and signatures.

import Foundation
@testable import DDCore

/// A fill-up without SwiftData, for testing the maths in isolation.
struct Entry: FuelEntry {
    var date: Date
    var amount: Double
    var pricePerUnit: Double
    var total: Double
    var odometer: Int
    var isFullTank: Bool
    var fuelType: FuelType
    var nearbyAveragePrice: Double?

    init(
        _ date: Date,
        amount: Double,
        price: Double,
        odometer: Int,
        full: Bool = true,
        fuel: FuelType = .e10,
        average: Double? = nil
    ) { /* private */ }
}

/// Fixed calendar so tests don't depend on the machine's locale or time zone.
nonisolated let berlin: Calendar

nonisolated func day(_ year: Int, _ month: Int, _ day: Int) -> Date { /* private */ }

nonisolated func isClose(_ a: Double?, _ b: Double, tolerance: Double = 0.001) -> Bool { /* private */ }
