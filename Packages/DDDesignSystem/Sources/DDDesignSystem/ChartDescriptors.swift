// Source code is private. This file shows only its types and signatures.

import DDCore
import Accessibility
import SwiftUI
import Foundation

/// Describes the monthly spending bars to VoiceOver, so its Audio Graph can play and
/// summarise them (Accessibility > VoiceOver > Audio Graphs).
public struct MonthlySpendingDescriptor: AXChartDescriptorRepresentable {
    public let months: [(period: Date, total: Double)]

    public func makeChartDescriptor() -> AXChartDescriptor { /* private */ }

    private var summary: String? { /* private */ }

    public init(
        months: [(period: Date, total: Double)]
    ) { /* private */ }
}

/// Describes the consumption line to VoiceOver.
public struct ConsumptionDescriptor: AXChartDescriptorRepresentable {
    public let points: [(date: Date, value: Double)]
    /// "l/100 km" or "kWh/100 km".
    public let unit: String

    public func makeChartDescriptor() -> AXChartDescriptor { /* private */ }

    public init(
        points: [(date: Date, value: Double)],
        unit: String
    ) { /* private */ }
}
