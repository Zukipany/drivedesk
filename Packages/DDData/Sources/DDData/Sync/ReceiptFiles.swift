// Source code is private. This file shows only its types and signatures.

import Foundation
import Supabase

/// Receipt photos in the private `receipts` bucket (plan section 9): one JPEG per fill-up,
/// uploaded once the fill-up's row is on the server, so the storage policy can check whose
/// fill-up it is. The row may arrive first; the photo follows with the next sync.
public protocol ReceiptFileStore: Sendable {
    /// Stores the photo at `path`. A photo already there counts as uploaded: the path is the
    /// fill-up's own, so it can only be this one.
    func upload(_ jpeg: Data, to path: String) async throws(SyncFailure)
    /// A link to the photo that works for `seconds` (the desk opens receipts this way).
    func signedLink(to path: String, seconds: Int) async throws(SyncFailure) -> URL
}

public nonisolated enum ReceiptPath {
    public static let bucket

    /// `company/{company}/receipts/{yyyy}/{mm}/{fill-up}.jpg`, the month in Berlin time.
    public static func path(company: UUID, fillUp: UUID, filledAt: Date) -> String { /* private */ }
}

/// The bucket through Supabase Storage, as the signed-in person.
public nonisolated struct SupabaseReceiptStore: ReceiptFileStore {
    let client: SupabaseClient

    public init(backend: Backend) { /* private */ }

    public func upload(_ jpeg: Data, to path: String) async throws(SyncFailure) { /* private */ }

    public func signedLink(to path: String, seconds: Int) async throws(SyncFailure) -> URL { /* private */ }

    static func failure(_ error: any Error) -> SyncFailure { /* private */ }
}
