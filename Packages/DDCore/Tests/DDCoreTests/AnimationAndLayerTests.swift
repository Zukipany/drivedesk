// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData
import Testing
@testable import DDCore

@Suite("Tank-fill animation")
struct TankFillTests {
    @Test(
        "A full tank fills the screen; a partial one its share, at least a third",
        arguments: [
            (40.0, 50.0, true, 1.0), (25.0, 50.0, false, 0.5), (5.0, 50.0, false, 0.33),
            (49.0, 50.0, false, 0.9), (10.0, 0.0, false, 0.5)
        ]
    )
    func level(amount: Double, capacity: Double, isFull: Bool, expected: Double) { /* private */ }

    @Test("Charging uses the battery size")
    func charging() { /* private */ }

    @Test("The rise starts at 0, ends at 1 and never goes back")
    func rise() { /* private */ }
}
