// Source code is private. This file shows only its types and signatures.

import Foundation
import Supabase

/// Live rows (plan section 9, A12): while the desk is open, a change to the company's
/// fill-ups on the server starts a sync, so the new row slides into the ledger. Realtime
/// applies row-level security per subscriber; a short pause gathers a burst of changes
/// (a card import, a month's re-scoring) into one sync.
public final class LiveUpdates {
    private let client: SupabaseClient
    private var channel: RealtimeChannelV2?
    private var listening: Task<Void, Never>?

    public init(backend: Backend) { /* private */ }

    /// Listens to the company's fill-ups and calls `changed` once per burst of changes.
    public func start(company: UUID, changed: @escaping @MainActor () async -> Void) { /* private */ }

    public func stop() { /* private */ }

    deinit { /* private */ }
}
