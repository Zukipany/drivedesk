// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

/// Where every local change starts (section 9, step 1): the row is saved in SwiftData at
/// once, with its final UUIDv7, and a `PendingChange` waits for the network. Screens never
/// wait for the server; the sync engine drains the outbox when it can.
public struct Outbox {
    let store: LocalStore

    public init(store: LocalStore) { /* private */ }

    private var context: ModelContext { /* private */ }

    /// Saves a row made on this device and queues its upload.
    public func insert<R: SyncRecord>(_ record: R, by editor: MemberRole) throws { /* private */ }

    /// Applies an edit to a row and queues the columns it changed. Edits before the next
    /// sync merge into the change already waiting, so a row goes up once.
    public func update<R: SyncRecord>(_ record: R, by editor: MemberRole, _ edit: (R) -> Void) throws { /* private */ }

    /// Every change still to send or to decide, first in first out.
    public func changes() throws -> [PendingChange] { /* private */ }

    /// How many changes wait for the network: "Offline · 3 changes waiting".
    public func waitingCount() throws -> Int { /* private */ }

    func change(for rowID: UUID) throws -> PendingChange? { /* private */ }

    private func nextSequence() throws -> Int { /* private */ }
}
