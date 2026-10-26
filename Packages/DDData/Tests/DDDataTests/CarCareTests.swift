// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData
import Testing
@testable import DDData

/// The documents bucket in memory, counting downloads.
nonisolated final class FakeDocumentStore: DocumentFileStore, @unchecked Sendable {
    private let lock
    private var downloads: [String]
    var files: [String: Data]
    var isOffline

    var requested: [String] { /* private */ }

    func download(_ path: String) async throws(SyncFailure) -> Data { /* private */ }

    func upload(_ pdf: Data, to path: String) async throws(SyncFailure) { /* private */ }
}

@Suite("Car documents and reminders")
struct CarCareTests {
    private let now

    private func reminder(_ kind: ReminderPlan.Kind, _ year: Int, _ month: Int, _ day: Int, done: Bool = false, vehicle: UUID = Demo.caddy)
        -> VehicleReminder
    { /* private */ }

    @Test("Days left count Berlin days; overdue is negative")
    func daysLeft() { /* private */ }

    @Test("Open reminders of the car, earliest first; done ones and other cars left out")
    func openReminders() { /* private */ }

    @Test("Due soon: within 30 days, overdue included, across the fleet for the desk")
    func dueSoon() { /* private */ }

    @Test("Notifications: the earliest open date per kind")
    func notificationDues() { /* private */ }

    @Test("Countdowns read naturally")
    func countdown() { /* private */ }

    @Test("Rows from PostgREST: a document and a reminder, and back")
    func rows() throws { /* private */ }

    @Test("A document's file is fetched once, kept, and fetched again when the desk replaces it")
    func keepsFiles() async throws { /* private */ }

    @Test("Keeping all of a car's files skips the ones without a file and stops offline")
    func keepAll() async throws { /* private */ }
}
