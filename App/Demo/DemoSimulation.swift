// Source code is private. This file shows only its types and signatures.

#if DEBUG
    import DDCore
    import DDData
    import Foundation
    import SwiftData
    import SwiftUI

    /// The fleet moving by itself while the demo is open: every 18 to 30 seconds a card
    /// payment or a charge arrives from one of the drivers, as the card feed would deliver it,
    /// and now and then the rules flag it. The ledger and the desk follow on their own.
    @MainActor
    struct DemoSimulation {
        let session: AppSession

        func run() async { /* private */ }

        private func event(_ dice: inout DemoFirm.Dice) async { /* private */ }

        private func show(_ message: String) { /* private */ }
    }
#endif
