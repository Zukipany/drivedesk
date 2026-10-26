// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData

/// A cached model that syncs with its Postgres table: it turns itself into the row the server
/// stores and takes the server's row back.
public protocol SyncRecord: SyncedRecord {
    static var table: SyncTable { get }
    /// Every column the app writes, without the bookkeeping the server sets itself (version,
    /// created_at, updated_at).
    var row: Row { get }
    /// A row pulled from the server, saved as it is.
    init(row: Row) throws(RowError)
    /// Takes the server's values for every column, and its version and updated_at.
    func apply(_ row: Row) throws(RowError)
    static func find(_ id: UUID, in context: ModelContext) throws -> Self?
    /// The rows of a pulled page that are already here, in one query.
    static func find(_ ids: [UUID], in context: ModelContext) throws -> [Self]
}

extension SyncRecord {
    /// Marks the row as the server's: what it holds is what Postgres holds.
    func adoptServerBookkeeping(_ row: Row) throws(RowError) { /* private */ }
}

/// A synced table: its name in Postgres, its model and its conflict rule (section 9).
public nonisolated struct SyncTable: Hashable, Sendable {
    public let name: String
    public let rule: ConflictRule

    public static let companies
    public static let groups
    public static let members
    public static let vehicles
    public static let assignments
    public static let budgets
    public static let fillUps
    public static let vehicleDocuments
    public static let vehicleReminders
    public static let fuelPolicies
    public static let vehicleCosts
    public static let chargingPlans
    public static let trips
    public static let tripCorrections
    public static let vehicleFixedCosts
    public static let homeChargingYears
    public static let homeTariffs
    public static let chargingClaims
    public static let licenceChecks
    public static let uvvInspections
    public static let instructionCompletions
    public static let issues
    public static let dailyChecks

    /// Pulled in this order, so a car arrives after its group and before its fill-ups, papers
    /// and due dates.
    public static let all: [SyncTable]
}

/// The model behind each table name.
enum SyncRegistry {
    static func model(for table: String) -> (any SyncRecord.Type)? { /* private */ }
}

// MARK: - The tables

extension Company: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> Company? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [Company] { /* private */ }
}

extension FleetGroup: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> FleetGroup? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [FleetGroup] { /* private */ }
}

extension Member: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> Member? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [Member] { /* private */ }
}

extension Vehicle: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> Vehicle? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [Vehicle] { /* private */ }
}

extension Assignment: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> Assignment? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [Assignment] { /* private */ }
}

extension Budget: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> Budget? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [Budget] { /* private */ }
}

extension FillUp: SyncRecord {
    public static let table

    /// What the driver owns: amounts, odometer, fuel, time and place. A manager's edit wins on
    /// the classification (cost centre and car) instead (section 9).
    public static let classificationColumns: Set<String>

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> FillUp? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [FillUp] { /* private */ }
}

extension VehicleDocument: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> VehicleDocument? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [VehicleDocument] { /* private */ }
}

extension VehicleReminder: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> VehicleReminder? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [VehicleReminder] { /* private */ }
}

extension FuelPolicy: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> FuelPolicy? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [FuelPolicy] { /* private */ }
}

extension VehicleCost: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> VehicleCost? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [VehicleCost] { /* private */ }
}

extension CompanyChargingPlan: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    /// `{"operators": [...], "ac_per_kwh": 0.39, "dc_per_kwh": 0.39}`
    static func json(_ rule: ChargingPlanRule) -> JSONValue { /* private */ }

    static func rule(_ value: JSONValue) -> ChargingPlanRule? { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> CompanyChargingPlan? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [CompanyChargingPlan] { /* private */ }
}

extension LogbookTrip: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> LogbookTrip? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [LogbookTrip] { /* private */ }
}

extension TripCorrection: SyncRecord {
    public static let table

    /// The old value and the time are the server's; the app sends what changes and why.
    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> TripCorrection? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [TripCorrection] { /* private */ }
}

extension VehicleFixedCost: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> VehicleFixedCost? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [VehicleFixedCost] { /* private */ }
}

extension ChargingClaim: SyncRecord {
    public static let table

    /// The method, rate, amount and who decided when are the server's.
    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> ChargingClaim? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [ChargingClaim] { /* private */ }
}

extension HomeTariff: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> HomeTariff? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [HomeTariff] { /* private */ }
}

extension HomeChargingYear: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> HomeChargingYear? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [HomeChargingYear] { /* private */ }
}

extension LicenceCheck: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> LicenceCheck? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [LicenceCheck] { /* private */ }
}

extension UVVInspection: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> UVVInspection? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [UVVInspection] { /* private */ }
}

extension InstructionCompletion: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> InstructionCompletion? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [InstructionCompletion] { /* private */ }
}

extension CarIssue: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> CarIssue? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [CarIssue] { /* private */ }
}

extension DailyCheck: SyncRecord {
    public static let table

    public var row: Row { /* private */ }

    public convenience init(row: Row) throws(RowError) { /* private */ }

    public func apply(_ row: Row) throws(RowError) { /* private */ }

    public static func find(_ id: UUID, in context: ModelContext) throws -> DailyCheck? { /* private */ }

    public static func find(_ ids: [UUID], in context: ModelContext) throws -> [DailyCheck] { /* private */ }
}
