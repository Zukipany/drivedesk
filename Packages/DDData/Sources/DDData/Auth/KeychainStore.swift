// Source code is private. This file shows only its types and signatures.

import Auth
import Foundation
import Security

/// The sign-in session in the keychain, under one service name, so signing out can remove
/// every item DriveDesk ever stored there in one call (plan section 9). Items stay on this
/// device only: a backup restored on another phone starts signed out.
public nonisolated struct KeychainStore: AuthLocalStorage {
    public let service: String

    public init(service: String = "com.christo.drivedesk.session") { /* private */ }

    public func store(key: String, value: Data) throws { /* private */ }

    public func retrieve(key: String) throws -> Data? { /* private */ }

    public func remove(key: String) throws { /* private */ }

    /// Every item under this service: the session, its refresh token and the sign-in
    /// link's code verifier.
    public func removeAll() throws { /* private */ }

    /// How many items this service holds; for tests and the sign-out check.
    public func count() throws -> Int { /* private */ }

    private func query(_ key: String) -> [String: Any] { /* private */ }

    private func check(_ status: OSStatus) throws { /* private */ }
}

/// A keychain call that failed, with the OSStatus for the crash report.
public nonisolated struct KeychainFailure: Error, Equatable {
    public let status: OSStatus
}

/// Session storage for tests and previews: never touches the keychain.
public nonisolated final class MemorySessionStore: AuthLocalStorage, @unchecked Sendable {
    private let lock
    private var items: [String: Data]

    public init() { /* private */ }

    public func store(key: String, value: Data) throws { /* private */ }
    public func retrieve(key: String) throws -> Data? { /* private */ }
    public func remove(key: String) throws { /* private */ }
    public func removeAll() { /* private */ }
    public var count: Int { /* private */ }
}
