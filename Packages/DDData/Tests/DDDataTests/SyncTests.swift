// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Supabase
import SwiftData
import Testing
@testable import DDData

@Suite("Outbox and sync engine")
struct SyncEngineTests {
    let store: LocalStore
    let server

    init() throws { /* private */ }

    private var outbox: Outbox { /* private */ }
    private func engine() -> SyncEngine { /* private */ }

    private func fillUps() throws -> [FillUp] { /* private */ }

    /// A fill-up the server has at version 1, pulled to this phone.
    private func syncedFillUp() async throws -> FillUp { /* private */ }

    // MARK: US-10

    @Test("A fill-up logged offline waits in the outbox and lands once when the network returns")
    func offlineThenOnline() async throws { /* private */ }

    @Test("An upload whose answer was lost is never stored twice")
    func lostAnswer() async throws { /* private */ }

    @Test("Changes go up first in, first out; edits before a sync merge into one upload")
    func fifo() async throws { /* private */ }

    @Test("When the network drops mid-way nothing overtakes the change that failed")
    func stopsInOrder() async throws { /* private */ }

    @Test("A change the server refuses is set aside, with later edits to that row; the rest goes up")
    func refused() async throws { /* private */ }

    @Test("An edit made while its upload is on the way goes up next time, against the new version")
    func editInFlight() async throws { /* private */ }

    // MARK: Conflict rules

    @Test("Fill-up: the driver's amounts and the manager's cost centre both survive")
    func fillUpMerge() async throws { /* private */ }

    @Test("Fill-up: driver and manager changed the odometer, so the manager has to decide")
    func fillUpAsk() async throws { /* private */ }

    @Test(
        "Fill-up: on the cost centre a manager's edit wins, whoever wrote last",
        arguments: [(MemberRole.driver, "KST 200"), (.manager, "KST 100")]
    )
    func fillUpClassification(editor: MemberRole, winner: String) async throws { /* private */ }

    @Test("Vehicle: each side's fields are merged; the same field goes to the last writer")
    func vehicleMerge() async throws { /* private */ }

    @Test("Both sides made the same change: nothing is left to send")
    func sameChange() async throws { /* private */ }

    // MARK: Pull

    @Test("Pulls in pages of 500, oldest first; rows sharing one updated_at all arrive once")
    func pages() async throws { /* private */ }

    @Test("A pull never overwrites a row with unsent changes; the outbox settles it")
    func pullKeepsLocalEdits() async throws { /* private */ }

    @Test("A synced row takes the server's newer version")
    func pullUpdates() async throws { /* private */ }
}

@Suite("Conflict rules")
struct ConflictRuleTests {
    private let base: Row

    @Test("Only the fields each side changed count")
    func onlyChangedFields() { /* private */ }

    @Test("Fill-ups: the same driver field changed on both sides asks; vehicles take the last writer")
    func sameField() { /* private */ }

    @Test("A number or a time written differently is still the same value")
    func sameMeaning() { /* private */ }
}

@Suite("Rows the server sends")
struct RowTests {
    private func fixture(_ name: String) throws -> Row { /* private */ }

    @Test("A fill-up from PostgREST: cents, milli-euro, microsecond times")
    func fillUp() throws { /* private */ }

    @Test("A plug-in hybrid from PostgREST, with its fuel_types array")
    func vehicle() throws { /* private */ }

    @Test("A row without its ID or a required column is refused, not half-saved")
    func missingColumns() { /* private */ }

    @Test("Postgres times and dates, in the formats it writes and the app writes")
    func times() throws { /* private */ }

    @Test("PostgREST's errors in sync's terms")
    func failures() throws { /* private */ }
}
