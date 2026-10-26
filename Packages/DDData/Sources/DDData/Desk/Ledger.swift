// Source code is private. This file shows only its types and signatures.

import CoreTransferable
import DDCore
import Foundation
import UniformTypeIdentifiers

/// The ledger's filters (plan M2): month, group, car, driver, fuel, source and flag state.
/// Nil means "any".
public nonisolated struct LedgerFilter: Equatable, Sendable {
    /// The month's first day as stored (00:00 UTC), or nil for every month.
    public var month: Date?
    public var groupID: UUID?
    public var vehicleID: UUID?
    public var memberID: UUID?
    public var fuel: FuelType?
    public var source: FillUpSource?
    public var flag: FlagState?

    public enum FlagState: String, CaseIterable, Sendable {
        /// An undecided flag: open, explained or escalated.
        case flagged
        /// No undecided flag.
        case clear
    }

    public init(
        month: Date? = nil,
        groupID: UUID? = nil,
        vehicleID: UUID? = nil,
        memberID: UUID? = nil,
        fuel: FuelType? = nil,
        source: FillUpSource? = nil,
        flag: FlagState? = nil
    ) { /* private */ }

    /// How many filters are set, for the toolbar's badge.
    public var count: Int { /* private */ }

    /// The entries the filter lets through. `groups` maps cars to their group; `flagged` holds
    /// the fill-ups with an undecided flag.
    public func apply(_ fillUps: [FillUp], groups: [UUID: UUID], flagged: Set<UUID>) -> [FillUp] { /* private */ }
}

/// The filtered ledger as a CSV file (plan section 21): semicolons and decimal commas for
/// German Excel, every free-text field neutralised against formula injection (OWASP CSV
/// injection), one row per entry.
public nonisolated struct LedgerExport: Transferable, Sendable {
    public struct Line: Equatable, Sendable {
        public var date: Date
        public var driver: String
        public var car: String
        public var plate: String
        public var station: String
        public var fuel: String
        public var quantity: Double
        public var unit: String
        public var unitPrice: Double?
        public var grossCents: Int
        public var vatCents: Int?
        public var source: String
        public var costCentre: String
        public var note: String

        public init(
            date: Date,
            driver: String,
            car: String,
            plate: String,
            station: String,
            fuel: String,
            quantity: Double,
            unit: String,
            unitPrice: Double?,
            grossCents: Int,
            vatCents: Int?,
            source: String,
            costCentre: String,
            note: String
        ) { /* private */ }
    }

    public let lines: [Line]
    public let title: String
    let decimalSeparator: String

    public init(lines: [Line], title: String, locale: Locale = .current) { /* private */ }

    private var separator: String { /* private */ }

    public var csv: String { /* private */ }

    public var fileName: String { /* private */ }

    private func number(_ value: Double, _ digits: Int) -> String { /* private */ }

    /// Quotes a field holding the separator, a quote or a line break.
    private func escape(_ field: String) -> String { /* private */ }

    public static var transferRepresentation: some TransferRepresentation { /* private */ }
}
