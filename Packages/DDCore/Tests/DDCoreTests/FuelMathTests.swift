// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

@Suite("Fuel maths")
struct FuelMathTests {
    @Test("Consumption is litres per 100 km")
    func consumption() { /* private */ }

    /// Plan example: P 120,000 km full · partial 20 l at 120,300 · C 32 l at 120,650 full.
    @Test("Full-to-full counts partial fills in between")
    func fullToFullWithPartial() throws { /* private */ }

    @Test("Partial fills before the first full tank are ignored")
    func partialBeforeFirstFull() { /* private */ }

    @Test("Entries are sorted by odometer, not by insertion order")
    func unsortedInput() { /* private */ }

    @Test("Averages are weighted by distance")
    func weightedAverages() throws { /* private */ }

    @Test("Spending is grouped per calendar month")
    func spendingPerMonth() { /* private */ }

    @Test("Percent change, plan example −11.1 %")
    func percentChange() { /* private */ }

    @Test("Any two of amount, price and total give the third")
    func deriveThird() { /* private */ }

    @Test("Consistency check allows receipt rounding")
    func consistency() { /* private */ }
}
