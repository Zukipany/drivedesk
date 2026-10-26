// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A problem with a car (`public.issues`, US-41): what it is, how bad, who reported it,
    /// and where it is on the workshop board.
    @Model
    public final class CarIssue {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var reportedBy: UUID
        public var categoryRaw: String
        public var severityRaw: String
        public var details: String
        public var photoPaths: [String]
        /// Photos on this device until they're uploaded.
        @Attribute(.externalStorage) public var photos: [Data]
        public var sourceRaw: String
        public var sourceID: UUID?
        public var statusRaw: String
        public var fixedAt: Date?
        public var fixedBy: UUID?
        public var createdAt: Date

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            reportedBy: UUID,
            category: IssueCategory,
            severity: IssueSeverity,
            details: String,
            source: IssueSource = .driver,
            sourceID: UUID? = nil,
            status: IssueStatus = .open,
            createdAt: Date = .now,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }

    /// A driver's check before the first trip (`public.daily_checks`, US-41).
    @Model
    public final class DailyCheck {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var memberID: UUID
        public var checkedAt: Date
        public var lights: Bool
        public var tyres: Bool
        public var fluids: Bool
        public var noDamage: Bool
        public var loadSecured: Bool
        public var note: String

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            memberID: UUID,
            checkedAt: Date = .now,
            lights: Bool,
            tyres: Bool,
            fluids: Bool,
            noDamage: Bool,
            loadSecured: Bool,
            note: String = "",
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

public nonisolated enum IssueCategory: String, Codable, CaseIterable, Sendable {
    case warningLight
    case tyres, noise, damage, cleanliness, other

    public var label: String { /* private */ }

    public var symbol: String { /* private */ }
}

public nonisolated enum IssueSeverity: String, Codable, CaseIterable, Sendable, Comparable {
    case canDrive
    case driveCarefully
    case doNotDrive

    public var label: String { /* private */ }

    private var order: Int { /* private */ }
    public static func < (a: Self, b: Self) -> Bool { /* private */ }
}

public nonisolated enum IssueStatus: String, Codable, CaseIterable, Sendable {
    case open
    case inWorkshop
    case fixed

    public var label: String { /* private */ }
}

public nonisolated enum IssueSource: String, Codable, CaseIterable, Sendable {
    case driver
    case dailyCheck
    case uvv
    case damageReport
}

extension CarIssue: SyncedRecord {
    public var category: IssueCategory { /* private */ }
    public var severity: IssueSeverity { /* private */ }
    public var source: IssueSource { /* private */ }
    public var status: IssueStatus {
        get { /* private */ }
        set { /* private */ }
    }
}

extension DailyCheck: SyncedRecord {}

public typealias CarIssue = DDSchemaV1.CarIssue
public typealias DailyCheck = DDSchemaV1.DailyCheck

/// The workshop board's rules (US-41).
public nonisolated enum WorkshopBoard {
    /// The issues a daily check raises: one for each "no".
    public static func issues(from check: DailyCheck) -> [(IssueCategory, String)] { /* private */ }

    /// The car's status once an issue moves: in the workshop while any of its issues is there
    /// or says do not drive; back in service when none is left.
    public static func vehicleStatus(for vehicleID: UUID, issues: [CarIssue], current: VehicleStatus) -> VehicleStatus { /* private */ }

    /// Has the member done today's check for the car (Berlin's day)?
    public static func checkedToday(_ checks: [DailyCheck], member: UUID, vehicle: UUID, now: Date = .now) -> Bool { /* private */ }
}
