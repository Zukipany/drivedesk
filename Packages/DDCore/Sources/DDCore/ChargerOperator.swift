// Source code is private. This file shows only its types and signatures.

import Foundation

/// Charging operator names as the sources write them.
public nonisolated enum ChargerOperator {
    /// "MOON POWER GmbH" → "MOON POWER", "Tesla, Inc." → "Tesla".
    public static func shortName(_ name: String) -> String { /* private */ }
}
