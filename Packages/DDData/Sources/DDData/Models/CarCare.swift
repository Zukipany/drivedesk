// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A car's paper (`public.vehicle_documents`): registration, insurance card, leasing
    /// contract, UVV report. The file sits in the private `documents` bucket; once opened it
    /// stays on the phone, so a roadside check or an accident works without signal.
    @Model
    public final class VehicleDocument {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var kindRaw: String
        public var title: String
        /// `company/{company}/documents/{id}.pdf`; nil until the desk uploads the file.
        public var filePath: String?
        /// Insurance cards and leases run out (a date without time, 00:00 UTC).
        public var expiresOn: Date?

        /// The file, kept after it was opened once (not synced).
        @Attribute(.externalStorage) public var fileData: Data?
        /// The `filePath` the kept file came from, so a replaced file is fetched again.
        public var fileDataPath: String?

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            kind: DocumentKind,
            title: String = "",
            filePath: String? = nil,
            expiresOn: Date? = nil,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }

    /// A due date the company sets for a car (`public.vehicle_reminders`): TÜV, service, tyre
    /// change, UVV check. The driver's phone reminds 30 and 7 days ahead; the desk sees them
    /// all.
    @Model
    public final class VehicleReminder {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var kindRaw: String
        /// The day it's due (a date without time, 00:00 UTC).
        public var dueOn: Date
        /// Services also fall due at a reading, whichever comes first.
        public var dueKm: Int?
        public var note: String?
        /// When it was done; done reminders stay for the car's history.
        public var doneAt: Date?

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            kind: ReminderPlan.Kind,
            dueOn: Date,
            dueKm: Int? = nil,
            note: String? = nil,
            doneAt: Date? = nil,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

public typealias VehicleDocument = DDSchemaV1.VehicleDocument
public typealias VehicleReminder = DDSchemaV1.VehicleReminder

/// `public.document_kind`.
public nonisolated enum DocumentKind: String, Codable, CaseIterable, Sendable {
    case registration, insurance, lease
    case uvvReport
    case other

    public var label: String { /* private */ }

    public var symbol: String { /* private */ }
}

extension VehicleDocument: SyncedRecord {
    public var kind: DocumentKind {
        get { /* private */ }
        set { /* private */ }
    }

    /// What the list shows: the title the desk gave it, else the kind.
    public var displayTitle: String { /* private */ }

    /// The kept file is the current one.
    public var hasCurrentFile: Bool { /* private */ }
}

extension VehicleReminder: SyncedRecord {
    public var kind: ReminderPlan.Kind {
        get { /* private */ }
        set { /* private */ }
    }

    public var isDone: Bool { /* private */ }

    /// Whole days until it's due in Berlin; negative when overdue.
    public func daysLeft(now: Date = .now) -> Int { /* private */ }
}

/// What a car needs next (plan D9 and Today's "TÜV in 23 days"): its open reminders, the
/// earliest first, and the ones due within a month.
public nonisolated enum CarCare {
    /// A month ahead: the first reminder goes out 30 days before.
    public static let soonDays

    public static func open(_ reminders: [VehicleReminder], vehicle: UUID) -> [VehicleReminder] { /* private */ }

    /// Open reminders due within `days` (overdue ones included), for the desk and Today.
    public static func dueSoon(_ reminders: [VehicleReminder], within days: Int = soonDays, now: Date = .now) -> [VehicleReminder] { /* private */ }

    /// One date per kind for the phone's notifications: the earliest open one.
    public static func notificationDues(_ reminders: [VehicleReminder], vehicle: UUID) -> [(ReminderPlan.Kind, Date)] { /* private */ }

    /// "in 23 days", "tomorrow", "today", "3 days overdue".
    public static func countdown(_ days: Int) -> String { /* private */ }
}
