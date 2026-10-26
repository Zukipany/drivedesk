// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

/// Every component of the design system on one screen, for checking the look on iPhone,
/// iPad and Mac in light and dark mode. Debug builds show it in Settings; the previews below
/// show it in both appearances.
public struct DesignCatalogue: View {
    @State private var fuels: Set<FuelType>
    @State private var filterMode
    @State private var tankFill: TankFill?
    @State private var spent
    @State private var ringProgress

    public init() { /* private */ }

    public var body: some View { /* private */ }

    private var catalogue: some View { /* private */ }

    private func section(_ title: String, @ViewBuilder content: () -> some View) -> some View { /* private */ }
}

extension StatusTone {
    fileprivate var sampleLabel: String { /* private */ }
}

/// Sample data for the catalogue and previews.
public enum CatalogueSamples {
    public static let station

    public static let charger

    /// 45 l at 1,689 € where the average nearby was 1,782 €: 4,19 € saved.
    public static let savings

    public static let summary
}

/// A fill-up as plain values, for samples and previews.
public struct SampleFillUp: FuelEntry, Sendable {
    public var date: Date
    public var amount: Double
    public var pricePerUnit: Double
    public var total: Double
    public var odometer: Int
    public var isFullTank: Bool
    public var fuelType: FuelType
    public var tankLevelAfter: Double?
    public var nearbyAveragePrice: Double?

    public init(
        date: Date,
        amount: Double,
        pricePerUnit: Double,
        total: Double,
        odometer: Int,
        isFullTank: Bool,
        fuelType: FuelType,
        tankLevelAfter: Double? = nil,
        nearbyAveragePrice: Double? = nil
    ) { /* private */ }
}
