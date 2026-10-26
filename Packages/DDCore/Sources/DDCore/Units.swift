// Source code is private. This file shows only its types and signatures.

import Foundation
import Observation
import Synchronization

/// How the driver wants amounts shown and typed: distance, volume and currency. Everything is
/// stored in km, litres and euros; these change only what the screens and widgets show.
public nonisolated struct UnitPreferences: Codable, Equatable, Sendable {
    public enum Distance: String, Codable, CaseIterable, Identifiable, Sendable {
        case kilometers, miles

        public var id: Self { /* private */ }
        /// km in one of these.
        public var kilometers: Double { /* private */ }
        public var symbol: String { /* private */ }
    }

    public enum Volume: String, Codable, CaseIterable, Identifiable, Sendable {
        case liters, usGallons, imperialGallons

        public var id: Self { /* private */ }
        /// Litres in one of these.
        public var liters: Double { /* private */ }
        public var symbol: String { /* private */ }
    }

    public var distance
    public var volume
    /// ISO 4217: "EUR", "USD", "GBP" …
    public var currency

    public init(
        distance: Distance = Distance.kilometers,
        volume: Volume = Volume.liters,
        currency: String = "EUR"
    ) { /* private */ }
}

/// The European Central Bank's euro reference rates: how many of each currency one euro buys.
/// Published on working days around 16:00 CET (`CurrencyRateService` keeps them current).
public nonisolated struct CurrencyRates: Codable, Equatable, Sendable {
    public var perEuro: [String: Double]
    /// The ECB's reference day.
    public var day: String

    /// The currencies the Settings offer: Europe's, and a few drivers bring from elsewhere.
    public static let offered

    /// Shipped with the app for the first launch offline: the ECB's rates of 15 Oct 2026.
    public static let bundled

    /// Units of `currency` per euro; nil for one the ECB doesn't publish.
    public func rate(_ currency: String) -> Double? { /* private */ }

    /// The ECB's daily file (eurofxref-daily.xml): `<Cube time='…'>` and `<Cube currency='USD' rate='1.12'/>`.
    public static func parse(_ xml: String) -> CurrencyRates? { /* private */ }

    public init(
        perEuro: [String: Double],
        day: String
    ) { /* private */ }
}

/// The driver's units and the latest rates, readable from any thread. SwiftUI views that format
/// through `Units` redraw when either changes (Observation tracks the reads).
public nonisolated final class UnitSettings: Observable, Sendable {
    /// The driver's, in the App Group. The unit tests run inside the app: they get their own,
    /// so a simulator set to miles doesn't change what they expect.
    public static let shared

    private struct State: Sendable {
        var preferences: UnitPreferences
        var rates: CurrencyRates
    }

    private static let preferencesKey
    private static let ratesKey

    private let registrar
    private let state: Mutex<State>
    /// The App Group, so the widgets show the same units; tests pass their own suite.
    private let suiteName: String
    private var defaults: UserDefaults? { /* private */ }

    public init(suiteName: String = PriceSnapshot.appGroup) { /* private */ }

    public var preferences: UnitPreferences {
        get { /* private */ }
        set { /* private */ }
    }

    public var rates: CurrencyRates {
        get { /* private */ }
        set { /* private */ }
    }

    /// Picks up what the app wrote since (the widget's process reads at each reload).
    public func reload() { /* private */ }
}

nonisolated extension UnitSettings {
    /// Tests and previews run with their own settings, never touching the driver's.
    @TaskLocal public static var override: UnitSettings?

    /// What `Units` formats with.
    public static var current: UnitSettings { /* private */ }
}
