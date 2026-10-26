// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

/// Edge cases found in the October 2026 review: things real logs do that the happy path
/// doesn't (backdated receipts, typos, forgotten fill-ups, dates on a boundary).
@Suite("Fill-up rules")
struct FillUpRulesTests {
    private let log

    @Test("The newest fill-up needs at least the last reading; the same km is fine")
    func newest() { /* private */ }

    @Test("A receipt from last week fits between the entries before and after it")
    func backdated() { /* private */ }

    @Test("Older than every entry: only the first entry limits it, and 0 never counts")
    func beforeAll() { /* private */ }

    @Test("The car form's reading limits only fill-ups after the car was added")
    func startReading() { /* private */ }

    @Test("Old entries that contradict each other never block every reading")
    func contradictingEntries() { /* private */ }

    @Test("An extra digit is flagged, a long gap between fill-ups isn't")
    func typoJump() { /* private */ }
}

@Suite("Consumption edge cases")
struct ConsumptionEdgeCaseTests {
    private func full(_ dayOfMonth: Int, _ amount: Double, _ odometer: Int) -> Entry { /* private */ }

    private func partial(_ dayOfMonth: Int, _ amount: Double, _ odometer: Int, level: Double) -> FuelMath.Reading { /* private */ }

    @Test("A forgotten fill-up halves one reading; it's left out of the average")
    func forgottenFillUp() throws { /* private */ }

    @Test("Logged twice with a km typo: the 10 km interval is left out")
    func loggedTwice() { /* private */ }

    @Test("Logged twice at the same km counts once")
    func sameKmTwice() { /* private */ }

    @Test("Gauge readings are rough one by one and are never left out")
    func gaugeReadingsStay() { /* private */ }

    @Test("Two readings aren't enough to call one unusual")
    func tooFewToJudge() { /* private */ }

    @Test("A backdated fill-up shows its own reading in the preview")
    func backdatedPreview() throws { /* private */ }

    @Test("A plug-in hybrid's charges never mix into its litres")
    func layersStaySeparate() { /* private */ }
}

@Suite("TÜV and reminder edge cases")
struct InspectionEdgeCaseTests {
    private func at(_ year: Int, _ month: Int, _ dayOfMonth: Int, _ hour: Int) -> Date { /* private */ }

    @Test("More than 8 months late is 60 € and a point, a day after the 8 months")
    func eightMonthsAndADay() throws { /* private */ }

    @Test("Due in less than a week: one reminder the next 9:00 instead of none")
    func dueSoon() throws { /* private */ }

    @Test("No reminder after the due time, none extra when the 7-day one still comes")
    func noExtraReminder() { /* private */ }

    @Test("Cancelling a car removes its 'soon' reminders too")
    func identifiers() { /* private */ }

    @Test("A paper that runs out: 30 days before and on the day, at 9:00, only what's ahead")
    func documentNotices() { /* private */ }
}

@Suite("Spending edge cases")
struct SpendingEdgeCaseTests {
    @Test("On 31 March the running month is compared with all of February")
    func shortPreviousMonth() throws { /* private */ }

    @Test("A fill-up dated in the future doesn't count towards this year")
    func futureEntries() { /* private */ }

    @Test("A month the plug-in hybrid stood still has no driving mix")
    func parkedHybrid() { /* private */ }
}
