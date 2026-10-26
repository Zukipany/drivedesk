// Source code is private. This file shows only its types and signatures.

import Foundation

/// Checks a new fill-up against the car's other entries before it's saved.
public nonisolated enum FillUpRules {
    /// The odometer readings a fill-up on a given date can have.
    public struct OdometerBounds: Equatable, Sendable {
        /// The reading of the last entry before the date, or the car's start; nil when none.
        public let lower: Int?
        /// The reading of the first entry after the date; nil for the newest entry.
        public let upper: Int?

        /// Equal readings are fine: a plug-in hybrid charged overnight and fuelled the next
        /// morning shows the same km twice.
        public func contains(_ odometer: Int) -> Bool { /* private */ }

        public init(
            lower: Int?,
            upper: Int?
        ) { /* private */ }
    }

    /// From the entries dated before and after `date`, so a receipt from last week can be
    /// logged after newer ones. If old entries contradict each other (a later date with a
    /// lower reading), only the lower bound is kept, so the form never blocks every value.
    /// - Parameter start: the reading typed in the car form and when the car was added. It
    ///   only limits fill-ups since then: an older receipt from the glovebox has fewer km.
    public static func odometerBounds(
        on date: Date,
        entries: [some FuelEntry],
        start: (odometer: Int, since: Date)? = nil
    ) -> OdometerBounds { /* private */ }

    /// A jump past the previous reading of more than this many full tanks looks like a typo…
    public static let suspiciousTanks
    /// …and never less than this many km.
    public static let suspiciousMinimumKm

    /// True when the reading is so far past the previous one that it's probably a typo
    /// (an extra digit). The form asks to check it, but saving stays possible.
    public static func isSuspiciousJump(km: Int, range: Double?) -> Bool { /* private */ }
}
