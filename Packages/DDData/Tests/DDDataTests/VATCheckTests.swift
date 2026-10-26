// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Input VAT checks")
struct VATCheckTests {
    private let invoice

    @Test("Up to 250 € a receipt counts as it is; above, it needs the company's name and address")
    func recipient() { /* private */ }

    @Test("Card payments without a receipt lose their VAT: the receipt's, else 19 % of the gross")
    func lost() { /* private */ }
}
