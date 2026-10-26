// Source code is private. This file shows only its types and signatures.

import Foundation
import Supabase

/// The two ways into a company after signing in (US-12): create one and become its owner,
/// or accept an invitation and get the role it was sent with. Both are server functions
/// (`public.create_company`, `public.accept_invitation`), so the membership and the role are
/// written in one step on the server, never by the app.
public protocol CompanySetup: Sendable {
    /// Creates the company and makes the signed-in person its owner; returns the company.
    func createCompany(_ company: NewCompany) async throws(SetupError) -> UUID
    /// Accepts an invitation token; returns the new member row.
    func acceptInvitation(token: String, memberName: String) async throws(SetupError) -> UUID
}

/// What the owner types on the first screen; the address, fleet and team come later.
public nonisolated struct NewCompany: Equatable, Sendable {
    public var name: String
    public var ownerName: String
    public var legalForm: String?
    public var vatID: String?

    public init(name: String, ownerName: String, legalForm: String? = nil, vatID: String? = nil) { /* private */ }

    /// Trimmed, with empty optional fields left out.
    var cleaned: NewCompany { /* private */ }
}

/// Why setting up didn't work, in one line.
public nonisolated enum SetupError: Error, Equatable, Sendable {
    case missingName
    case invalidInvitation
    /// The invitation went to another address than the one signed in.
    case invitationForAnotherAddress
    case offline
    case failed(String)

    public var message: String { /* private */ }
}

/// An invitation as people paste it: the link from the email (https://drivedesk.app/join/…,
/// drivedesk://join/…) or the code alone.
public nonisolated enum InvitationToken {
    public static func parse(_ text: String) -> String? { /* private */ }

    private static func valid(_ token: String) -> String? { /* private */ }
}

/// The server functions through Supabase, as the signed-in person.
public nonisolated struct SupabaseCompanySetup: CompanySetup {
    let client: SupabaseClient

    public init(backend: Backend) { /* private */ }

    public func createCompany(_ company: NewCompany) async throws(SetupError) -> UUID { /* private */ }

    public func acceptInvitation(token: String, memberName: String) async throws(SetupError) -> UUID { /* private */ }

    static func failure(_ error: any Error) -> SetupError { /* private */ }
}
