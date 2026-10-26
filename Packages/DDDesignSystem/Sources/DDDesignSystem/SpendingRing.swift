// Source code is private. This file shows only its types and signatures.

import DDCore
import Charts
import SwiftUI

/// The month as a ring: by energy type, or budget spent vs left. `progress` draws it in.
public struct SpendingRing: View {
    public let summary: SpendingSummary
    public let budget: Double
    public var progress
    public let lineWidth: Double

    public var body: some View { /* private */ }

    public init(
        summary: SpendingSummary,
        budget: Double,
        progress: Double = 1.0,
        lineWidth: Double
    ) { /* private */ }
}

/// "Saved 4,20 € vs the average nearby", or what it cost more. Not colour alone: the
/// words and the arrow say which way it went.
public struct SavingsLabel: View {
    public let savings: Savings

    public var body: some View { /* private */ }

    public init(
        savings: Savings
    ) { /* private */ }
}
