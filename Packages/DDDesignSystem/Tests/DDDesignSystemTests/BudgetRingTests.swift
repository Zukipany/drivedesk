// Source code is private. This file shows only its types and signatures.

import Testing
@testable import DDDesignSystem

@Suite("Budget ring")
struct BudgetRingTests {
    @Test(
        "Within budget below 80 %, nearly used up from 80 %, over budget from 100 %",
        arguments: [
            (0.0, BudgetRing.Level.withinBudget),
            (319.99, .withinBudget),
            (320, .nearLimit),
            (399.99, .nearLimit),
            (400, .overBudget),
            (512, .overBudget)
        ]
    )
    func level(spent: Double, expected: BudgetRing.Level) { /* private */ }

    @Test("Without a budget, any spend counts as over it and none as within it")
    func noBudget() { /* private */ }

    @Test("Warning and critical levels carry a tone with a symbol; within budget has none")
    func tones() { /* private */ }
}
