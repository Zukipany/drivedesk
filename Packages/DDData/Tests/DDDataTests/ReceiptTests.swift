// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData
import Testing
@testable import DDData

/// The bucket in memory: what was uploaded where, and the failures to play back.
nonisolated final class FakeReceiptStore: ReceiptFileStore, @unchecked Sendable {
    private let lock
    private var stored: [String: Data]
    var failure: SyncFailure?

    var files: [String: Data] { /* private */ }

    func upload(_ jpeg: Data, to path: String) async throws(SyncFailure) { /* private */ }

    func signedLink(to path: String, seconds: Int) async throws(SyncFailure) -> URL { /* private */ }
}

@Suite("Receipt photos in the bucket")
struct ReceiptUploadTests {
    let store: LocalStore
    let server
    let bucket
    private let photo

    init() throws { /* private */ }

    private func engine() -> SyncEngine { /* private */ }

    private func receiptFillUp() throws -> FillUp { /* private */ }

    @Test("A receipt's path: the company's folder, the Berlin month, the fill-up's ID")
    func path() { /* private */ }

    @Test("The row goes up first, then the photo, then the photo's path on the row, in one sync")
    func uploadsAfterTheRow() async throws { /* private */ }

    @Test("Offline, nothing is uploaded and the photo waits with the row")
    func offline() async throws { /* private */ }

    @Test("The bucket being out of reach leaves the photo for the next sync; the row is already up")
    func bucketOffline() async throws { /* private */ }

    @Test("A photo the bucket refuses stays here without stopping the sync")
    func refused() async throws { /* private */ }

    @Test("A card payment without a photo needs one; a manual entry doesn't")
    func needsReceipt() { /* private */ }
}

@Suite("Checks before saving a fill-up")
struct FillUpCheckTests {
    private let caddy
    private let entries

    @Test("A reading between the fill-ups before and after passes")
    func passes() { /* private */ }

    @Test("A reading below the one before, or above a later one, explains itself")
    func odometer() { /* private */ }

    @Test("More than the tank plus 5 % is flagged; up to that passes")
    func tank() { /* private */ }

    @Test("Other cars' fill-ups and deleted ones don't count")
    func ownCarOnly() { /* private */ }

    @Test("A receipt for a fuel the car doesn't take is flagged")
    func wrongFuel() { /* private */ }
}
