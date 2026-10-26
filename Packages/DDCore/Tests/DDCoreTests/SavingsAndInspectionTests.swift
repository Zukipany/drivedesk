// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData
import Testing
@testable import DDCore

@Suite("TÜV inspection rules")
struct InspectionGuideTests {
    @Test(
        "Sticker colours repeat every six years",
        arguments: [
            (2025, InspectionGuide.StickerColor.orange), (2026, .blue), (2027, .yellow), (2028, .brown),
            (2029, .pink), (2030, .green), (2031, .orange), (2024, .green)
        ]
    )
    func stickerColour(year: Int, colour: InspectionGuide.StickerColor) { /* private */ }

    @Test(
        "Fines by months late",
        arguments: [(0, 0, false), (1, 0, false), (2, 15, false), (3, 15, false), (4, 25, false), (7, 25, false), (8, 60, true), (9, 60, true)]
    )
    func fines(months: Int, fine: Int, point: Bool) { /* private */ }

    @Test("Due by the last day of the sticker month; next one 24 months after passing")
    func dueDates() throws { /* private */ }

    @Test("Late only after the due month has ended")
    func monthsOverdue() throws { /* private */ }
}
