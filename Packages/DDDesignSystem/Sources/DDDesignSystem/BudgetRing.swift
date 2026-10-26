// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

/// Budget spent against budget left, grown from iDrive's `SpendingRing`. Its colour says how
/// far the month has gone: the accent while there's room, warning from 80 %, critical from
/// 100 % (animation A11: the ring moves to the new value in 0.6 s and the colour crossfades;
/// Reduce Motion changes it at once). The centre shows what's left, never colour alone.
public struct BudgetRing: View {
    public let spent: Double
    public let budget: Double
    /// Draws the ring in from 0 to 1 (`revealOnScroll`).
    public var progress
    public var lineWidth

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// How far the budget has gone.
    public enum Level: Equatable, Sendable {
        case withinBudget, nearLimit, overBudget

        /// 80 % of the budget: the warning threshold.
        public nonisolated static let warningShare

        public nonisolated init(spent: Double, budget: Double) { /* private */ }

        public var tone: StatusTone? { /* private */ }

        public var label: String { /* private */ }
    }

    private var level: Level { /* private */ }
    private var share: Double { /* private */ }
    private var ringColor: Color { /* private */ }

    public var body: some View { /* private */ }

    public init(
        spent: Double,
        budget: Double,
        progress: Double = 1.0,
        lineWidth: Double = 14.0
    ) { /* private */ }
}

private struct BudgetLabelStyle: LabelStyle {
    let showsIcon: Bool

    func makeBody(configuration: Configuration) -> some View { /* private */ }
}
