// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData
import Supabase

/// Car documents in the private `documents` bucket (plan D9): the desk uploads them, a
/// driver opens the ones of their car. Once opened, a file stays on the phone, so the
/// registration shows at a roadside check without signal.
public protocol DocumentFileStore: Sendable {
    func download(_ path: String) async throws(SyncFailure) -> Data
    /// Puts a PDF at `path`; a path is never overwritten, a new file gets a new path.
    func upload(_ pdf: Data, to path: String) async throws(SyncFailure)
    /// A link to the file that works for `seconds`, to send it on (US-27: five minutes).
    func link(to path: String, validFor seconds: Int) async throws(SyncFailure) -> URL
}

extension DocumentFileStore {
    public func upload(_ pdf: Data, to path: String) async throws(SyncFailure) { /* private */ }
    public func link(to path: String, validFor seconds: Int) async throws(SyncFailure) -> URL { /* private */ }
}

public nonisolated enum DocumentPath {
    public static let bucket

    /// `company/{company}/documents/{document}.pdf`, or `{document}-{version}.pdf` for a
    /// replacement, so a copy kept of the old file is never taken for the new one.
    public static func path(company: UUID, document: UUID, version: Int = 0) -> String { /* private */ }

    /// The next path for a document whose file is replaced.
    public static func next(after path: String?, company: UUID, document: UUID) -> String { /* private */ }
}

/// Five minutes: long enough to open a link sent to the tax advisor, short enough not to
/// leave the papers lying around.
public let documentLinkSeconds

/// The bucket through Supabase Storage, as the signed-in person.
public nonisolated struct SupabaseDocumentStore: DocumentFileStore {
    let client: SupabaseClient

    public init(backend: Backend) { /* private */ }

    public func download(_ path: String) async throws(SyncFailure) -> Data { /* private */ }

    public func upload(_ pdf: Data, to path: String) async throws(SyncFailure) { /* private */ }

    public func link(to path: String, validFor seconds: Int) async throws(SyncFailure) -> URL { /* private */ }
}

/// Keeps a car's documents on the phone.
public struct DocumentKeeper {
    let store: LocalStore
    let files: any DocumentFileStore

    public init(store: LocalStore, files: any DocumentFileStore) { /* private */ }

    /// The document's file: the kept one when it's current, else fetched and kept.
    public func file(for document: VehicleDocument) async throws(SyncFailure) -> Data { /* private */ }

    /// Fetches every file of the car not kept yet, so the papers are there before they're
    /// needed. Stops quietly when the network goes.
    public func keepAll(of vehicle: UUID) async { /* private */ }
}
