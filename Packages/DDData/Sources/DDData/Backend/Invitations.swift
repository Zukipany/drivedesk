// Source code is private. This file shows only its types and signatures.

import Foundation
import Supabase

/// An invitation that hasn't been accepted yet (plan M6). The person gets a link by email,
/// `drivedesk://invite?token=…`, valid for 14 days.
public nonisolated struct InvitationRow: Equatable, Sendable, Identifiable {
    public var id: UUID
    public var email: String
    public var role: MemberRole
    public var createdAt: Date
    public var expiresAt: Date

    public init(id: UUID, email: String, role: MemberRole, createdAt: Date, expiresAt: Date) { /* private */ }

    init(row: Row) throws(RowError) { /* private */ }

    public func isExpired(at date: Date = .now) -> Bool { /* private */ }
}

/// What the server answers once the email is on its way.
public nonisolated struct SentInvitation: Equatable, Sendable {
    public var invitationID: UUID
    public var expiresAt: Date

    public init(invitationID: UUID, expiresAt: Date) { /* private */ }

    /// `{"invitationId": "…", "expiresAt": "…"}`; snake case is read too.
    static func decode(_ data: Data) -> SentInvitation? { /* private */ }
}

public nonisolated enum InvitationError: Error, Equatable, Sendable {
    case invalidEmail
    /// The role may not invite this role, or the person isn't in the company any more.
    case notAllowed
    /// The address already belongs to someone in the company, or has a waiting invitation.
    case alreadyThere
    case offline
    case server(String)
}

/// Sending, listing and taking back invitations. The email goes out from the server's
/// `invitations` function, which makes the token; the app never sees it.
public protocol InvitationService: Sendable {
    func invite(company: UUID, email: String, role: MemberRole) async throws(InvitationError) -> SentInvitation
    func pending(company: UUID) async throws(InvitationError) -> [InvitationRow]
    func revoke(_ id: UUID) async throws(InvitationError)
}

public nonisolated enum InvitationEmail {
    /// The address as the database keeps it, lowercased and trimmed; nil unless it looks like
    /// one: something, an @, a domain with a dot.
    public static func normalized(_ text: String) -> String? { /* private */ }
}

/// The invitations through Supabase, as the signed-in person: the function sends, the
/// table's policies decide who sees and deletes what.
public nonisolated struct SupabaseInvitations: InvitationService {
    let client: SupabaseClient

    public init(backend: Backend) { /* private */ }

    public func invite(company: UUID, email: String, role: MemberRole) async throws(InvitationError) -> SentInvitation { /* private */ }

    public func pending(company: UUID) async throws(InvitationError) -> [InvitationRow] { /* private */ }

    public func revoke(_ id: UUID) async throws(InvitationError) { /* private */ }

    private struct Request: Encodable, Sendable {
        let companyId: String
        let email: String
        let role: String
    }

    static func failure(_ error: any Error) -> InvitationError { /* private */ }
}

/// Invitations kept in memory: the demo and tests.
public actor LocalInvitations: InvitationService {
    private var rows: [UUID: (company: UUID, row: InvitationRow)]
    private let members: @Sendable (UUID) -> Set<String>

    /// `members` gives a company's addresses already in it.
    public init(_ seed: [(company: UUID, row: InvitationRow)] = [], members: @escaping @Sendable (UUID) -> Set<String> = { _ in }) { /* private */ }

    public func invite(company: UUID, email: String, role: MemberRole) async throws(InvitationError) -> SentInvitation { /* private */ }

    public func pending(company: UUID) async throws(InvitationError) -> [InvitationRow] { /* private */ }

    public func revoke(_ id: UUID) async throws(InvitationError) { /* private */ }
}
