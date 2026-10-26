// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Supabase

/// `public.flag_status` (US-26): open → explained by the driver → resolved, dismissed or
/// escalated to the owner.
public nonisolated enum FlagStatus: String, Codable, CaseIterable, Sendable {
    case open, explained, resolved, dismissed, escalated

    /// Someone still has to act.
    public var isUndecided: Bool { /* private */ }
}

/// One rule that fired, in the server's words ("Litres above the registered tank size").
public nonisolated struct FlagHit: Equatable, Sendable {
    public var code: String
    public var points: Int
    public var sentence: String

    public init(code: String, points: Int, sentence: String) { /* private */ }
}

/// A flag with everything the queue and its inspector show (plan M9, section 14).
public nonisolated struct FlagDetail: Identifiable, Equatable, Sendable {
    public var id: UUID
    public var companyID: UUID
    public var fillupID: UUID?
    public var vehicleID: UUID?
    public var memberID: UUID?
    public var score: Int
    /// 2 medium, 3 high; 1 when a correction took it below the threshold.
    public var severity: Int
    public var status: FlagStatus
    public var hits: [FlagHit]
    public var driverReason: String?
    public var driverNote: String?
    public var explainedAt: Date?
    public var resolvedAt: Date?
    public var resolutionNote: String?
    public var repaymentCents: Int?
    public var escalatedAt: Date?
    public var createdAt: Date

    public init(
        id: UUID = .v7(),
        companyID: UUID,
        fillupID: UUID? = nil,
        vehicleID: UUID? = nil,
        memberID: UUID? = nil,
        score: Int,
        severity: Int,
        status: FlagStatus = .open,
        hits: [FlagHit] = [],
        driverReason: String? = nil,
        driverNote: String? = nil,
        explainedAt: Date? = nil,
        resolvedAt: Date? = nil,
        resolutionNote: String? = nil,
        repaymentCents: Int? = nil,
        escalatedAt: Date? = nil,
        createdAt: Date
    ) { /* private */ }

    static let columns

    init(row: Row) throws(RowError) { /* private */ }

    /// As the desk overview counts it.
    public var row: FlagRow { /* private */ }
}

public nonisolated enum FlagError: Error, Equatable, Sendable {
    /// The server refused the step, with its reason ("A flag about you goes to the owner").
    case refused(String)
    case offline
    case server(String)
}

/// The flag queue's reads and the two steps of the life cycle, which only the server's
/// functions may take (`explain_flag`, `decide_flag`).
public protocol FlagService: Sendable {
    /// The company's flags the signed-in person may see, newest first; decided ones too when
    /// asked.
    func flags(company: UUID, includeDecided: Bool) async throws(FlagError) -> [FlagDetail]
    func explain(_ flag: UUID, reason: String, note: String?) async throws(FlagError)
    func decide(_ flag: UUID, as decision: FlagStatus, note: String?, repaymentCents: Int?) async throws(FlagError)
}

/// The queue order (plan M9): severity, then age, decided ones last.
public nonisolated enum FlagQueue {
    public static func sorted(_ flags: [FlagDetail]) -> [FlagDetail] { /* private */ }

    /// The reasons a driver picks from; anything else goes in the note.
    public static let reasons
}

/// Flags through PostgREST and the life-cycle functions, as the signed-in person.
public nonisolated struct SupabaseFlagService: FlagService {
    let client: SupabaseClient

    public init(backend: Backend) { /* private */ }

    public func flags(company: UUID, includeDecided: Bool) async throws(FlagError) -> [FlagDetail] { /* private */ }

    public func explain(_ flag: UUID, reason: String, note: String?) async throws(FlagError) { /* private */ }

    public func decide(_ flag: UUID, as decision: FlagStatus, note: String?, repaymentCents: Int?) async throws(FlagError) { /* private */ }

    static func failure(_ error: any Error) -> FlagError { /* private */ }
}

/// Flags in memory, with the server's rules: the demo and tests.
public actor LocalFlagService: FlagService {
    private var stored: [UUID: FlagDetail]
    /// Who is asking: their member ID and role.
    private let me: UUID
    private let role: MemberRole

    public init(_ flags: [FlagDetail], me: UUID, role: MemberRole) { /* private */ }

    /// A new flag, as the rules would raise it (the demo's live simulation).
    public func add(_ flag: FlagDetail) { /* private */ }

    public func flags(company: UUID, includeDecided: Bool) async throws(FlagError) -> [FlagDetail] { /* private */ }

    public func explain(_ flag: UUID, reason: String, note: String?) async throws(FlagError) { /* private */ }

    public func decide(_ flag: UUID, as decision: FlagStatus, note: String?, repaymentCents: Int?) async throws(FlagError) { /* private */ }
}
