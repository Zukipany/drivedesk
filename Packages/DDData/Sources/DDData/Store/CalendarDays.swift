// Source code is private. This file shows only its types and signatures.

import Foundation

/// Dates without a time (a lease end, a budget's month, a TÜV due date) are Postgres `date`
/// values. Locally they are stored as 00:00 UTC of that day, so a day never moves when the
/// phone changes time zone; "today" and "this month" are Berlin's (plan section 8: times are
/// UTC, the app shows Europe/Berlin).
public nonisolated enum CalendarDays {
    /// Gregorian in UTC: how date-only values are stored.
    public static let storage: Calendar

    /// Gregorian in Europe/Berlin: what "today" and "this month" mean for the company.
    public static let berlin: Calendar

    /// The stored value of a calendar day.
    public static func day(year: Int, month: Int, day: Int) -> Date { /* private */ }

    /// The stored value of the day `date` falls on in `calendar`.
    public static func day(of date: Date, in calendar: Calendar = berlin) -> Date { /* private */ }

    /// The stored value of the first day of the month `date` falls in: what a budget's
    /// `month` holds.
    public static func monthStart(of date: Date, in calendar: Calendar = berlin) -> Date { /* private */ }

    /// The moments the month containing `date` starts and ends in `calendar`, for summing up
    /// that month's fill-ups.
    public static func monthInterval(containing date: Date, in calendar: Calendar = berlin) -> DateInterval { /* private */ }
}
