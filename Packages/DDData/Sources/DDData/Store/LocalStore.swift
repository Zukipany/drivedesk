// Source code is private. This file shows only its types and signatures.

import Foundation
import Observation
import SwiftData

/// The SwiftData store on this device: a cache of the rows the signed-in person may see in
/// each of their companies. Every screen reads it, never the network (plan section 9).
@Observable
public final class LocalStore {
    /// Where the store lives.
    public enum Location: Equatable, Sendable {
        /// Tests and previews.
        case inMemory
        case file(URL)

        /// Application Support/DriveDesk/Cache.store, inside the app's sandbox on the Mac.
        public static var standard: Location { /* private */ }
    }

    /// Replaced by a new, empty container when the store is wiped, so views that read it
    /// through the environment start again from nothing.
    public internal(set) var container: ModelContainer
    public let location: Location

    public var context: ModelContext { /* private */ }

    public init(_ location: Location = .standard) throws { /* private */ }

    public static let schema

    static func makeContainer(_ location: Location) throws -> ModelContainer { /* private */ }
}
