// Source code is private. This file shows only its types and signatures.

import Foundation

/// The German main inspection (Hauptuntersuchung, "TÜV"): when it's due, what the
/// sticker on the rear number plate looks like, and what being late costs.
/// Terms as of 2026 (StVZO § 29, Bußgeldkatalog; costs from TÜV, DEKRA and ADAC).
public nonisolated enum InspectionGuide {
    /// A new car's first inspection is due after 36 months, then every 24.
    public static let firstIntervalMonths
    public static let intervalMonths

    /// The sticker's colour repeats every six years: orange 2025, blue 2026, yellow 2027…
    public enum StickerColor: String, CaseIterable, Sendable {
        case orange, blue, yellow, brown, pink, green

        public static func forYear(_ year: Int) -> StickerColor { /* private */ }
    }

    /// What going late costs, by how many whole months the due month has passed.
    public struct Overdue: Equatable, Sendable {
        public let months: Int
        /// € fine; 0 within the first two months.
        public let fine: Int
        /// A point in Flensburg after eight months.
        public let point: Bool
        /// More than two months late: a stricter inspection, about 20 % dearer.
        public let extendedInspection: Bool

        public init(
            months: Int,
            fine: Int,
            point: Bool,
            extendedInspection: Bool
        ) { /* private */ }
    }

    /// The bracket for being more than `months` whole months late. The catalogue says "more
    /// than 2 / 4 / 8 months", so exactly 8 months and a day is already the 60 € bracket:
    /// the whole months of `monthsOverdue` (8) pick it, not the next number (9).
    public static func overdue(months: Int) -> Overdue { /* private */ }

    /// What being late costs on `now`, from the dates (a day past 8 months counts as more than 8).
    public static func overdue(due: Date, now: Date = .now, calendar: Calendar = .current) -> Overdue { /* private */ }

    /// Whole months after the end of the due month (0 while it's still the due month).
    public static func monthsOverdue(due: Date, now: Date = .now, calendar: Calendar = .current) -> Int { /* private */ }

    /// The inspection is due by the end of the sticker's month: the last day, at noon.
    public static func dueDate(month: Int, year: Int, calendar: Calendar = .current) -> Date? { /* private */ }

    /// The next due month after an inspection passed on `date`.
    public static func nextDue(afterInspectionOn date: Date, firstInspection: Bool = false, calendar: Calendar = .current) -> Date? { /* private */ }

    /// Typical price range, €, with the emissions test (AU) unless electric.
    public static func costRange(isElectric: Bool) -> ClosedRange<Int> { /* private */ }
}
