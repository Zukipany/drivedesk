// Source code is private. This file shows only its types and signatures.

import Foundation

/// When to remind about a car's due dates (main inspection TÜV/HU, service, tyre change,
/// UVV check): 30 days and 7 days before, at 9:00. A date set less than a week ahead gets one reminder the next 9:00
/// instead, so it's never silent. Pure, so it's easy to test; `ReminderScheduler` hands it
/// to the system.
public nonisolated enum ReminderPlan {
    public enum Kind: String, CaseIterable, Sendable {
        case inspection, service, tyres, uvv

        public var label: String { /* private */ }

        public var symbol: String { /* private */ }
    }

    public struct Notice: Equatable, Sendable {
        public let identifier: String
        public let fireDate: Date
        public let title: String
        public let body: String

        public init(
            identifier: String,
            fireDate: Date,
            title: String,
            body: String
        ) { /* private */ }
    }

    public static let daysBefore

    /// Every identifier a car's reminders can have, to replace or cancel them all.
    public static func identifiers(carID: String) -> [String] { /* private */ }

    /// The notices still in the future for one due date.
    public static func notices(
        carID: String,
        carName: String,
        kind: Kind,
        due: Date,
        now: Date = .now,
        calendar: Calendar = .current
    ) -> [Notice] { /* private */ }

    /// 9:00 today if that's still ahead, otherwise tomorrow.
    private static func nextMorning(after now: Date, calendar: Calendar) -> Date? { /* private */ }

    private static func plannedNotices(
        carID: String,
        carName: String,
        kind: Kind,
        due: Date,
        now: Date,
        calendar: Calendar
    ) -> [Notice] { /* private */ }

    /// Every notice identifier for documents starts with this, to replace them all at once.
    public static let documentPrefix

    /// A manager's reminders that a car's paper runs out (US-27): 30 days before and on the
    /// day, at 9:00, the ones still ahead.
    public static func documentNotices(
        documentID: String,
        carName: String,
        title: String,
        expires: Date,
        now: Date = .now,
        calendar: Calendar = .current
    ) -> [Notice] { /* private */ }

    /// Whole days from today until `due`; negative when overdue.
    public static func daysUntil(_ due: Date, now: Date = .now, calendar: Calendar = .current) -> Int { /* private */ }
}
