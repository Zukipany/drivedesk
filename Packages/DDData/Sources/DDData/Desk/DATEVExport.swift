// Source code is private. This file shows only its types and signatures.

import CoreTransferable
import DDCore
import Foundation
import UniformTypeIdentifiers

/// The company's DATEV numbers (plan section 21, Integrations): the tax advisor's and the
/// client's number, the chart of accounts, and the account fuel-card payments are booked
/// against.
public nonisolated struct DATEVSettings: Codable, Equatable, Sendable {
    public enum Chart: String, Codable, CaseIterable, Sendable {
        case skr03, skr04

        /// Laufende Kfz-Betriebskosten.
        public var vehicleCostAccount: Int { /* private */ }
        /// Geldtransit: where fuel-card settlements wait until the card company's invoice.
        public var defaultContraAccount: Int { /* private */ }
        public var label: String { /* private */ }
    }

    public var consultantNumber: Int?
    public var clientNumber: Int?
    public var chart: Chart
    /// Nil: the chart's Geldtransit account.
    public var contraAccount: Int?
    /// The month the fiscal year starts, 1 = January.
    public var fiscalYearStartMonth

    public init(consultantNumber: Int? = nil, clientNumber: Int? = nil, chart: Chart = .skr03, contraAccount: Int? = nil) { /* private */ }

    public var contra: Int { /* private */ }
}

/// A month's fill-ups as a DATEV booking batch (EXTF Buchungsstapel, format 700, category 21,
/// version 13): one booking per fill-up on the vehicle cost account against the contra
/// account, the 19 % input VAT key only where a receipt backs it, the cost centre as KOST1
/// (US-29, plan section 21).
public nonisolated struct DATEVExport: Transferable, Sendable {
    public struct Booking: Equatable, Sendable {
        public var date: Date
        public var grossCents: Int
        /// The receipt number: the fill-up's short ID, the receipts ZIP names files by it.
        public var receiptNumber: String
        public var text: String
        public var costCentre: String
        /// A receipt (or a VAT-valid card invoice line) backs the input VAT.
        public var hasValidReceipt: Bool

        public init(date: Date, grossCents: Int, receiptNumber: String, text: String, costCentre: String, hasValidReceipt: Bool) { /* private */ }
    }

    public let bookings: [Booking]
    public let settings: DATEVSettings
    /// The month's first and last day in Berlin.
    public let from: Date
    public let until: Date
    public let createdAt: Date
    public let title: String

    public init(bookings: [Booking], settings: DATEVSettings, month: Date, createdAt: Date = .now, title: String) { /* private */ }

    /// The bookings for a month's fill-ups: deleted ones left out, the text from fuel,
    /// quantity and station, the cost centre from the fill-up or else its car's group.
    public static func bookings(_ fillUps: [FillUp], vehicles: [Vehicle], groups: [FleetGroup]) -> [Booking] { /* private */ }

    /// "DD-0192F1A0": the fill-up's ID in eight characters, as Belegfeld 1 and the receipt's
    /// file name.
    public static func receiptNumber(_ id: UUID) -> String { /* private */ }

    /// The fields of a booking row this file fills; DATEV reads the rest as empty.
    static let columns

    /// The BU key that splits 19 % input VAT out of the gross.
    static let inputVATKey

    public var csv: String { /* private */ }

    /// DATEV reads Windows-1252; characters it can't hold become "?".
    public var data: Data { /* private */ }

    /// "EXTF_Buchungsstapel_2026-10.csv"
    public var fileName: String { /* private */ }

    private func quoted(_ text: String) -> String { /* private */ }

    public static var transferRepresentation: some TransferRepresentation { /* private */ }
}
