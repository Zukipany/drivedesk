// Source code is private. This file shows only its types and signatures.

import Foundation

extension UUID {
    /// A time-ordered UUID (version 7, RFC 9562): 48 bits of Unix milliseconds, then random
    /// bits. Rows get their ID on the device, so a fill-up logged offline already has its
    /// final ID and a retried upload can't create a duplicate (ADR 006).
    public nonisolated static func v7(at date: Date = .now) -> UUID { /* private */ }

    /// The UUID's version number: 7 for the IDs made here, 4 for random ones.
    public nonisolated var rfcVersion: Int { /* private */ }

    /// When a version 7 UUID was made, to the millisecond; nil for other versions.
    public nonisolated var v7Date: Date? { /* private */ }
}
