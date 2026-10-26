// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

/// Price pin on the map. Pins are content, so no Liquid Glass (HIG: use it sparingly,
/// never in the content layer). Price level is shown by colour *and* a symbol for the
/// cheapest station, so it works with Differentiate Without Color.
public struct PriceBadge: View {
    public let station: Station
    public let fuel: FuelType
    public let tier: StationRanking.Tier?
    /// A small dot instead of the price, so dense areas stay readable.
    public var isCompact

    public var body: some View { /* private */ }

    private var badge: some View { /* private */ }

    private var borderColor: Color { /* private */ }

    private var accessibilityText: String { /* private */ }

    public init(
        station: Station,
        fuel: FuelType,
        tier: StationRanking.Tier?,
        isCompact: Bool = false
    ) { /* private */ }
}
