// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDPrices

/// The server price cache (supabase/functions/prices-area) answers in Tankerkönig's list.php
/// shape, so the app decodes it with the same Station type. Both sides test against the same
/// fixture in fixtures/api.
@Suite("Server price cache contract")
struct PricesAreaContractTests {
    private static let fixture: URL

    @Test("The prices-area answer decodes as stations, nearest first, with missing prices nil")
    func decodes() throws { /* private */ }
}
