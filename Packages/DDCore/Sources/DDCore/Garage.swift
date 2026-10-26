// Source code is private. This file shows only its types and signatures.

import Foundation

/// Garage rules that touch several vehicles at once. The SwiftData side (saving the order,
/// activating a car, deleting one) lives with the local store in the app.
public enum Garage {
    /// The order after moving `sources` in front of `before` (nil: to the end). Pure, so
    /// it's easy to test; the app applies it to the cars.
    public nonisolated static func reordered<ID: Equatable>(_ ids: [ID], moving sources: [ID], before: ID?) -> [ID] { /* private */ }
}
