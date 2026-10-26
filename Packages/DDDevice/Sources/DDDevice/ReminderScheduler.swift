// Source code is private. This file shows only its types and signatures.

import DDPrices
import DDCore
import Foundation
import UserNotifications

/// Schedules a car's due-date reminders as local notifications. Asks for permission the
/// first time a reminder is set, not at launch.
public enum ReminderScheduler {
    public static func update(carID: String, carName: String, inspectionDue: Date?, serviceDue: Date?) async { /* private */ }

    /// Replaces the car's scheduled reminders with these due dates (one per kind).
    public static func update(carID: String, carName: String, dues: [(ReminderPlan.Kind, Date)]) async { /* private */ }

    /// Replaces every document reminder with these (US-27, on a manager's device). Asks for
    /// permission only when `asking`; otherwise schedules when it's already allowed.
    public static func replaceDocumentNotices(_ notices: [ReminderPlan.Notice], asking: Bool) async { /* private */ }

    /// Whether reminders may already be shown, without asking.
    public static func isAllowed() async -> Bool { /* private */ }

    public static func cancel(carID: String) { /* private */ }
}
