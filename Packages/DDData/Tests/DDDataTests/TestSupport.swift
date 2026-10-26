// Source code is private. This file shows only its types and signatures.

import Foundation
@testable import DDData

/// The demo company's IDs (supabase/seed.sql), so tests read like the seeded data.
nonisolated enum Demo {
    static let company
    static let munich
    static let lena
    static let marco
    static let caddy
    static let id4
    static let other
}

/// A moment in Berlin, for readable dates in tests.
nonisolated func berlin(_ year: Int, _ month: Int, _ day: Int, _ hour: Int = 12, _ minute: Int = 0) -> Date { /* private */ }

extension Vehicle {
    /// Lena's Caddy as seeded: a leased diesel van that also takes premium diesel.
    static func caddy(id: UUID = Demo.caddy) -> Vehicle { /* private */ }
}

extension FillUp {
    /// A diesel fill-up for Lena's Caddy.
    static func diesel(
        _ date: Date,
        litres: Double,
        priceMilli: Int,
        odometer: Int,
        full: Bool = true,
        vehicle: UUID = Demo.caddy,
        member: UUID = Demo.lena
    ) -> FillUp { /* private */ }
}
