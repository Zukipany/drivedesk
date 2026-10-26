// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftUI

/// The company's fuel rules for the driver's car, on Today (US-24): which fuels, premium,
/// how far above the local average, how much a day, and when.
struct RulesCard: View {
    let policy: FuelPolicy?
    let vehicle: Vehicle
    /// The company's active charging cards, for a car that charges (US-19).
    let cards: [String]

    /// Everything the card says; empty when there's nothing to say.
    static func rules(policy: FuelPolicy?, vehicle: Vehicle, cards: [String]) -> [FuelPolicy.Rule] { /* private */ }

    var body: some View { /* private */ }
}

extension FuelPolicy {
    struct Rule {
        let text: String
        let symbol: String
    }

    /// The rules in words: "Diesel only", "No premium", "At most 5 ct above the local
    /// average", "Up to 80 l a day", "Mon–Fri, 06:00–20:00".
    func rules(for vehicle: Vehicle) -> [Rule] { /* private */ }

    /// "Mon–Fri, 06:00–20:00", "Every day, 06:00–22:00", "Mon, Wed, Fri"; nil without limits.
    static func when(weekdays: [Int]?, from: String?, until: String?) -> String? { /* private */ }

    /// ISO weekdays as "Mon–Fri" for a run of three or more, else listed.
    private static func dayList(_ days: [Int]) -> String { /* private */ }
}
