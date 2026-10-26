// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

@Suite("Plug-in hybrid driving mix")
struct HybridMixTests {
    /// 800 km: three charges of 20 kWh (at 0,35 €) and one 30 l fill-up (at 1,80 €).
    private let entries

    @Test("kWh ÷ electric consumption gives the electric km; the rest ran on petrol")
    func mix() throws { /* private */ }

    @Test("Without an entry before the stretch, the first one only starts the km")
    func firstEntryStartsTheKm() throws { /* private */ }

    @Test("Electric km never exceed the km driven; too few petrol km aren't measured")
    func limits() throws { /* private */ }

    @Test("One mix per month")
    func monthly() { /* private */ }
}
