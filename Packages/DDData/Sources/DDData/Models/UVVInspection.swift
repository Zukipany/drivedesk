// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A yearly vehicle inspection by a competent person (`public.uvv_inspections`, US-39, DGUV
    /// Vorschrift 70): when, by whom, the result and its defects, the report among the car's
    /// documents, and when the next one is due.
    @Model
    public final class UVVInspection {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var inspectedOn: Date
        public var inspector: String
        public var workshop: String
        public var resultRaw: String
        public var defects: [String]
        public var documentID: UUID?
        public var nextDueOn: Date
        public var note: String
        public var recordedBy: UUID

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            inspectedOn: Date,
            inspector: String,
            workshop: String = "",
            result: UVVResult,
            defects: [String] = [],
            documentID: UUID? = nil,
            nextDueOn: Date,
            note: String = "",
            recordedBy: UUID,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

public nonisolated enum UVVResult: String, Codable, CaseIterable, Sendable {
    case passed, defects, failed

    public var label: String { /* private */ }
}

extension UVVInspection: SyncedRecord {
    public var result: UVVResult { /* private */ }
}

public typealias UVVInspection = DDSchemaV1.UVVInspection

/// The yearly inspection's due dates (US-39).
public nonisolated enum UVVPlan {
    /// A year after the inspection, or the car's next service when that comes within the three
    /// months before, so the car visits the workshop once.
    public static func nextDue(after inspectedOn: Date, serviceDue: Date?, alignWithService: Bool) -> Date { /* private */ }

    /// Where a car stands: the open UVV reminder's date and the last inspection.
    public struct Status: Equatable, Sendable {
        public var lastInspection: Date?
        public var lastResult: UVVResult?
        public var dueOn: Date?
        /// Days until due; negative when overdue; nil without any date.
        public var daysLeft: Int?
    }

    public static func status(of vehicleID: UUID, inspections: [UVVInspection], reminders: [VehicleReminder], today: Date) -> Status { /* private */ }
}
