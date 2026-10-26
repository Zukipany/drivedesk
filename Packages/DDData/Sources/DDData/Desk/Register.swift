// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation

/// Who may do what on the desk's Cars and People screens (plan section 5): the same rules the
/// row-level policies and triggers enforce, so the app offers only what the server accepts.
public nonisolated enum DeskPermissions {
    /// Adds, edits, assigns and retires cars.
    public static func managesCars(_ role: MemberRole) -> Bool { /* private */ }

    /// The roles this role may invite: the owner any, a manager drivers only (least
    /// privilege: higher roles are granted, never assumed).
    public static func invitableRoles(by role: MemberRole) -> [MemberRole] { /* private */ }

    /// Whether `editor` may change `target`'s role or remove them: the owner anyone, a
    /// manager other drivers.
    public static func canManage(_ target: Member, as editor: Member) -> Bool { /* private */ }

    /// The roles `editor` may give `target`; the last owner keeps theirs.
    public static func roles(for target: Member, as editor: Member, among members: [Member]) -> [MemberRole] { /* private */ }

    /// Whether `editor` may remove `target`: never the company's last owner.
    public static func canRemove(_ target: Member, as editor: Member, among members: [Member]) -> Bool { /* private */ }

    /// A company keeps at least one owner (`public.keep_an_owner`).
    public static func isLastOwner(_ member: Member, among members: [Member]) -> Bool { /* private */ }
}

/// The car register's rules (plan M4, M5): who drives a car now, and what a handover changes.
/// A car has one driver at a time; the database's exclusion constraint refuses overlaps, so
/// the old assignment ends at the moment the new one starts.
public nonisolated enum CarRegister {
    /// The assignments running at `date`.
    public static func running(_ assignments: [Assignment], vehicle: UUID? = nil, member: UUID? = nil, at date: Date) -> [Assignment] { /* private */ }

    /// Who has the car at `date`.
    public static func currentAssignment(of vehicle: UUID, in assignments: [Assignment], at date: Date = .now) -> Assignment? { /* private */ }

    /// What giving a car to someone changes: the car's running assignment ends, and for a
    /// company car the person's other company car goes back, so Today shows one car.
    public struct Handover {
        /// Assignments to end at the handover's moment, in the order to send them.
        public let ending: [UUID]
        public let new: Assignment
    }

    /// The handover, or nil when the person already has the car.
    public static func handover(
        of vehicle: Vehicle,
        to member: Member,
        kind: AssignmentKind = .permanent,
        at date: Date,
        assignments: [Assignment]
    ) -> Handover? { /* private */ }
}

/// A car being added or edited on the desk (plan M4), checked as the database would.
public nonisolated struct VehicleDraft: Equatable, Sendable {
    public var plate
    public var name
    public var make
    public var model
    public var year: Int?
    public var vin
    public var groupID: UUID?
    public var fuelTypes: Set<FuelType>
    public var tankLitres: Double?
    public var batteryKWh: Double?
    public var ownership: VehicleOwnership
    /// The last day of the lease or rental (a date without time, 00:00 UTC).
    public var leaseEnd: Date?
    public var isPoolCar
    public var color: CarColor?
    public var bodyType: BodyType?
    public var odometerKm: Int?

    public enum Problem: Hashable, Sendable {
        case plateMissing
        /// Another car in service has this plate.
        case plateTaken
        case vinInvalid
        case noFuel
        case noGroup
        case yearOutOfRange
    }

    public init() { /* private */ }

    public init(_ vehicle: Vehicle) { /* private */ }

    /// "m-eh 1201" and "M-EH1201" are the same plate (`vehicles_plate_idx`).
    public static func plateKey(_ plate: String) -> String { /* private */ }

    /// What stops the draft from being saved; `vehicles` are the company's cars, `editing`
    /// the car being edited.
    public func problems(among vehicles: [Vehicle], editing: UUID? = nil) -> [Problem] { /* private */ }

    private var normalizedVIN: String { /* private */ }

    /// Fuels first, then charging, the order the pass and the map use.
    private var orderedFuels: [FuelType] { /* private */ }

    /// Writes the draft into a car; an electric-only car has no tank, a combustion one no battery.
    public func apply(to vehicle: Vehicle) { /* private */ }

    /// A new car from the draft, or nil while it has problems.
    public func makeVehicle(company: UUID, among vehicles: [Vehicle]) -> Vehicle? { /* private */ }
}
