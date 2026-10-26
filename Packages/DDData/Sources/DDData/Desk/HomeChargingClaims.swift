// Source code is private. This file shows only its types and signatures.

import CoreTransferable
import DDCore
import Foundation
import UniformTypeIdentifiers

/// Home-charging claims on the device (US-37, plan section 17): the price the server will set,
/// shown before sending, and whether the kWh fit the car.
public nonisolated enum HomeChargingClaims {
    /// What a claim pays, as `charging_claims_price()` works it out: kWh times the flat rate,
    /// or kWh times the tariff plus the car's share of the base fee (kWh over household plus car).
    public static func amountCents(kwh: Double, method: HomeChargingMethod, flatMilli: Int, tariff: HomeTariff?) -> Int? { /* private */ }

    /// Whether the kWh fit the car: what the month's kilometres need at a generous consumption,
    /// with charging losses, and never more than a full battery every day.
    public struct Plausibility: Equatable, Sendable {
        /// The most the car could have charged; nil when the kilometres aren't known.
        public var expectedMaxKWh: Double?
        public var isPlausible: Bool
    }

    /// kWh per 100 km assumed for the check: an electric car's, and a plug-in hybrid's when
    /// all its kilometres were electric.
    public static let generousPer100km
    public static let chargingLosses

    public static func plausibility(kwh: Double, kilometres: Double?, batteryKWh: Double?, days: Int) -> Plausibility { /* private */ }

    /// The month a claim is due for at `now`: the month before, from the 1st of this month.
    public static func dueMonth(at now: Date) -> Date { /* private */ }

    /// The claims of a month for payroll: approved ones, one line per driver.
    public static func payroll(_ claims: [ChargingClaim], month: Date) -> [ChargingClaim] { /* private */ }
}

extension HomeChargingClaims {
    /// The car's kilometres in a month: the logbook's trips when there are any, otherwise the
    /// span of the month's odometer readings; nil when neither says anything.
    public static func kilometres(of vehicleID: UUID, in month: DateInterval, trips: [LogbookTrip], fillUps: [FillUp]) -> Double? { /* private */ }
}

/// One approved claim on the payroll: tax-free, § 3 Nr. 50 EStG.
public nonisolated struct HomeChargingPayrollLine: Sendable {
    public var personnelNumber: String
    public var name: String
    public var kwh: Double
    public var method: HomeChargingMethod
    public var amountCents: Int

    public init(personnelNumber: String, name: String, kwh: Double, method: HomeChargingMethod, amountCents: Int) { /* private */ }
}

/// A month's approved home-charging claims as CSV for the payroll (plan section 21).
public nonisolated struct HomeChargingPayrollExport: Transferable, Sendable {
    public let month: String
    public let lines: [HomeChargingPayrollLine]
    let decimalSeparator: String

    public init(month: String, lines: [HomeChargingPayrollLine], locale: Locale = .current) { /* private */ }

    private var separator: String { /* private */ }

    public var totalCents: Int { /* private */ }

    public var csv: String { /* private */ }

    public var fileName: String { /* private */ }

    private func escape(_ field: String) -> String { /* private */ }

    public static var transferRepresentation: some TransferRepresentation { /* private */ }
}
