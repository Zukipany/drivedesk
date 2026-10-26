// Source code is private. This file shows only its types and signatures.

import SwiftUI
import Testing
@testable import DDDesignSystem

@Suite("Design tokens")
struct TokensTests {
    private let white
    /// iOS secondarySystemGroupedBackground in dark mode: the card behind status text.
    private let darkCard

    @Test("Every status colour passes WCAG AA as text on a card", arguments: StatusTone.allCases)
    func contrast(tone: StatusTone) { /* private */ }

    @Test("Contrast maths matches WCAG's reference values")
    func reference() { /* private */ }

    @Test("Spacing is a 4-point grid")
    func spacing() { /* private */ }

    @Test("Every status tone has its own symbol, so colour never carries the meaning alone")
    func symbols() { /* private */ }
}
