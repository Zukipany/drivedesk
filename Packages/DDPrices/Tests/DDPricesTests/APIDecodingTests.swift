// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDPrices
import DDCore

@Suite("API decoding")
struct APIDecodingTests {
    /// Shape copied from a real `list.php?type=all` response; prices edited to cover `false` and `null`.
    nonisolated static let tankerkoenigJSON

    @Test("Tankerkönig stations decode; false and null prices become nil")
    func tankerkoenig() throws { /* private */ }

    @Test("Tankerkönig error responses surface their message")
    func tankerkoenigError() { /* private */ }

    @Test("Tankerkönig URL uses type=all, sort=dist and clamps the radius to 25 km")
    func tankerkoenigURL() throws { /* private */ }
}
