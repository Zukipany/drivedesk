// Source code is private. This file shows only its types and signatures.

import Foundation

nonisolated extension OpenMeteoAPI {
    /// Days are counted in UTC, so a day means the same everywhere in the cache.
    public static let calendar: Calendar

    public static func dayString(_ date: Date) -> String { /* private */ }
}
