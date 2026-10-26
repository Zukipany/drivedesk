// Source code is private. This file shows only its types and signatures.

import Foundation

/// Where a driver's licence check stands (US-38): what `v_licence_status` says on the server,
/// worked out on the device for the desk and the driver's Today.
public nonisolated struct LicenceStatus: Equatable, Sendable, Identifiable {
    public enum State: Equatable, Sendable {
        case valid
        /// Due within 14 days.
        case dueSoon(days: Int)
        case overdue(days: Int)
        /// Never checked.
        case never
    }

    public var memberID: UUID
    public var lastCheckedOn: Date?
    public var dueOn: Date
    public var state: State
    public var classes: [String]
    public var restrictions: [String]

    public var id: UUID { /* private */ }

    /// From 14 days overdue the desk offers the letter withdrawing permission to drive.
    public var needsWithdrawalLetter: Bool { /* private */ }

    public var needsAttention: Bool { /* private */ }

    public static let defaultIntervalMonths
    /// Reminders before the due date (days), as `remind_licence_checks()` sends them.
    public static let reminderDays

    /// The member's status on `today` (a stored calendar day): the last valid check plus the
    /// interval, never after the licence card expires; joined day when never checked.
    public static func of(
        member: UUID,
        joinedOn: Date,
        checks: [LicenceCheck],
        today: Date,
        intervalMonths: Int = defaultIntervalMonths
    ) -> LicenceStatus { /* private */ }

    /// The classes a check can record, in the order the licence lists them.
    public static let allClasses

    /// Common restriction codes and what they mean.
    public static let commonRestrictions: [(code: String, meaning: String)]
}
