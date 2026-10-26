// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

/// Map pin for a charger with a published price: "⚡ 0,79 €".
/// Same rules as `PriceBadge`: content layer, so no Liquid Glass; the cheapest charger
/// gets a star as well as a green border, so price level doesn't rely on colour alone.
public struct ChargerPriceBadge: View {
    public let charger: ChargePoint
    public let tier: StationRanking.Tier?

    public var body: some View { /* private */ }

    private var borderColor: Color { /* private */ }

    private var accessibilityText: String { /* private */ }

    public init(
        charger: ChargePoint,
        tier: StationRanking.Tier?
    ) { /* private */ }
}
