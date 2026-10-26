// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

/// A fuel price with its currency sign and two decimals, per litre or per gallon as the
/// Settings say: "2,07 €". (No tenth-of-a-cent digit: it rarely decides anything.)
public struct PriceText: View {
    public let price: Double?
    /// Shown as "≈2,41 €" and read as "about …".
    public var isEstimate
    /// A kWh's price: never converted to gallons.
    public var isElectric

    public var body: some View { /* private */ }

    /// VoiceOver: "2,07 €" reads as euros and cents.
    public static func spoken(_ price: Double) -> String { /* private */ }

    public init(
        price: Double?,
        isEstimate: Bool = false,
        isElectric: Bool = false
    ) { /* private */ }
}

nonisolated extension Double {
    /// Euros in the driver's currency: "90,95 €".
    public var money: String { /* private */ }

    /// Kilometres as road distance in the driver's unit: "410 m", "1,3 km", "0.8 mi".
    public var roadDistance: String { /* private */ }
}
