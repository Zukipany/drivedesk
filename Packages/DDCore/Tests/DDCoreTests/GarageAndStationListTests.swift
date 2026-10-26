// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDCore

nonisolated private func station(
    _ id: String,
    brand: String = "Aral",
    street: String = "Leopoldstr.",
    place: String = "München",
    dist: Double,
    open: Bool = true,
    e10: Double? = nil
) -> Station { /* private */ }

@Suite("Station list: sort and search")
struct StationSortTests {
    private let stations

    @Test("Distance: nearest first")
    func distance() { /* private */ }

    @Test("Open now first, nearest first within open and closed")
    func openFirst() { /* private */ }

    @Test("Price: a closed station doesn't win even when it's cheapest")
    func price() { /* private */ }

    @Test(
        "Search ignores case and accents and looks at brand, street and town",
        arguments: [
            ("shell", ["b"]), ("UNGERER", ["c"]), ("munchen", ["a", "b"]), ("schwabing", ["c"]), ("  ", ["a", "b", "c"])
        ]
    )
    func search(text: String, ids: [String]) { /* private */ }
}

@Suite("Garage order")
struct GarageOrderTests {
    @Test(
        "Moving a car in front of another",
        arguments: [
            (["d"], "a", ["d", "a", "b", "c"]),
            (["a"], nil, ["b", "c", "d", "a"]),
            (["a"], "c", ["b", "a", "c", "d"]),

            (["c", "a"], "d", ["b", "a", "c", "d"])
        ] as [([String], String?, [String])]
    )
    func move(sources: [String], before: String?, expected: [String]) { /* private */ }

    /// Regression: dropping a car on its own place sent it to the end of the list.
    @Test("Dropping a car on its own place leaves the order alone")
    func dropOnItself() { /* private */ }

    @Test("An unknown target moves the car to the end")
    func unknownTarget() { /* private */ }
}

@Suite("TÜV and service reminders")
struct ReminderPlanTests {
    private let now

    @Test("30 and 7 days before, at 9:00")
    func bothNotices() throws { /* private */ }

    @Test("Only notices still in the future")
    func pastNoticesDropped() { /* private */ }

    @Test(
        "Days until due counts calendar days",
        arguments: [
            (day(2026, 10, 10), 1), (day(2026, 10, 9), 0), (day(2026, 10, 1), -8), (day(2027, 10, 9), 365)
        ]
    )
    func daysUntil(due: Date, days: Int) { /* private */ }
}

@Suite("Year forecast")
struct YearForecastTests {
    private let entries

    @Test("Spent per day so far × days in the year")
    func forecast() throws { /* private */ }

    @Test("No forecast in the first 30 days")
    func tooEarly() { /* private */ }

    @Test("No forecast without fill-ups this year")
    func empty() { /* private */ }
}

@Suite("CSV export")
struct FillUpExportTests {
    private let rows

    @Test("German Excel: semicolons and decimal commas, oldest first")
    func german() throws { /* private */ }

    @Test("English: commas and decimal points")
    func english() { /* private */ }

    @Test(
        "File name keeps only safe characters",
        arguments: [
            ("Golf (demo)", "DriveDesk Golf demo fill-ups.csv"), ("???", "DriveDesk car fill-ups.csv")
        ]
    )
    func fileName(car: String, name: String) { /* private */ }
}

nonisolated private final class ManualClock: @unchecked Sendable {
    var now
}
