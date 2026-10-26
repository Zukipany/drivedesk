// Source code is private. This file shows only its types and signatures.

import Foundation

/// What happens when an upload finds the server's row at another version (section 9).
public nonisolated enum ConflictRule: Sendable {
    /// Fill-ups: the driver owns amounts and odometer, a manager's edit wins on the
    /// classification (cost centre, car); both edits to the same driver field: ask the manager.
    case fillUp
    /// Vehicles, and every table without a rule of its own: only the fields each side changed
    /// are applied; the same field changed on both sides goes to the last writer, and the
    /// audit trigger keeps both values.
    case fieldMerge
}

/// The decision for one conflicting change.
public nonisolated enum ConflictResolution: Equatable, Sendable {
    /// Send these columns against the server's current version.
    case retry(columns: [String])
    /// Nothing of ours is left to send: take the server's row.
    case serverWins
    /// Someone has to decide between both values of these columns; nothing goes up meanwhile.
    case ask(columns: [String])
}

public nonisolated enum ConflictRules {
    /// Compares, column by column, what this device changed (`ours`, against `base`, the
    /// values it started from) with the server's row now.
    public static func resolve(
        _ rule: ConflictRule,
        changed: [String],
        base: Row,
        ours: Row,
        server: Row,
        editor: MemberRole
    ) -> ConflictResolution { /* private */ }
}
