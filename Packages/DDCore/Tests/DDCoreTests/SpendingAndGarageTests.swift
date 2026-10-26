// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData
import Testing
@testable import DDCore

@Suite("Spending balance")
struct SpendingSummaryTests {
    private let entries

    /// A finished month is compared with the whole previous month.
    private let afterOctober

    @Test("Finished month: total, whole previous month, and change")
    func totals() throws { /* private */ }

    /// Regression: on 10 October the app said "−40 % vs September" because it compared
    /// 10 days of October with all 30 days of September.
    @Test("Running month is compared with the same days of the previous month")
    func monthToDate() { /* private */ }

    @Test("Slices split by energy type, largest first, shares add up to 1")
    func slices() { /* private */ }

    @Test("Budget remaining and progress")
    func budget() { /* private */ }

    @Test("Empty month has no change and no slices")
    func emptyMonth() { /* private */ }
}
