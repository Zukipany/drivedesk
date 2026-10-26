// Source code is private. This file shows only its types and signatures.

import Foundation

/// One JSON value as PostgREST sends and takes it. Rows travel as plain dictionaries, so the
/// outbox can send just the fields that changed and the conflict rules can compare field by
/// field.
public nonisolated enum JSONValue: Hashable, Sendable {
    case null
    case bool(Bool)
    case int(Int)
    case double(Double)
    case string(String)
    case array([JSONValue])
    case object([String: JSONValue])

    /// Whether two values mean the same: 50 and 50.0 are one number, and two timestamps for
    /// the same millisecond are one moment, however the server formatted them.
    public func means(_ other: JSONValue) -> Bool { /* private */ }

    public var doubleValue: Double? { /* private */ }
}

extension JSONValue: Codable {
    public init(from decoder: any Decoder) throws { /* private */ }

    public func encode(to encoder: any Encoder) throws { /* private */ }
}

/// A table row: column name to value.
public typealias Row = [String: JSONValue]

/// A row the server sent that the app can't read: a missing ID, a wrong type.
public nonisolated struct RowError: Error, Equatable, Sendable {
    public let table: String
    public let column: String
}

extension Dictionary where Key == String, Value == JSONValue {
    nonisolated func string(_ column: String) -> String? { /* private */ }

    nonisolated func int(_ column: String) -> Int? { /* private */ }

    nonisolated func double(_ column: String) -> Double? { /* private */ }

    nonisolated func bool(_ column: String) -> Bool? { /* private */ }

    nonisolated func uuid(_ column: String) -> UUID? { /* private */ }

    nonisolated func time(_ column: String) -> Date? { /* private */ }

    nonisolated func day(_ column: String) -> Date? { /* private */ }

    nonisolated func ints(_ column: String) -> [Int]? { /* private */ }

    nonisolated func strings(_ column: String) -> [String]? { /* private */ }

    /// A column the row can't do without.
    nonisolated func required<T>(_ value: T?, _ column: String, in table: String) throws(RowError) -> T { /* private */ }

    /// The same row with only these columns.
    nonisolated func only(_ columns: some Sequence<String>) -> Row { /* private */ }
}

extension JSONValue {
    nonisolated static func optional(_ value: String?) -> JSONValue { /* private */ }
    nonisolated static func optional(_ value: Int?) -> JSONValue { /* private */ }
    nonisolated static func optional(_ value: Double?) -> JSONValue { /* private */ }
    nonisolated static func optional(_ value: UUID?) -> JSONValue { /* private */ }
    nonisolated static func id(_ value: UUID) -> JSONValue { /* private */ }
    nonisolated static func time(_ value: Date?) -> JSONValue { /* private */ }
    nonisolated static func day(_ value: Date?) -> JSONValue { /* private */ }
}

/// Postgres `timestamptz` and `date` as text. The server writes microseconds and an offset
/// ("2026-10-07T15:21:02.871509+00:00"); the app writes UTC with milliseconds.
public nonisolated enum ServerTime {
    public static func date(from text: String) -> Date? { /* private */ }

    private static func offsetSeconds(_ zone: String?) -> Int { /* private */ }

    public static func string(from date: Date) -> String { /* private */ }

    public static func day(from text: String) -> Date? { /* private */ }

    public static func dayString(from date: Date) -> String { /* private */ }
}
