// Source code is private. This file shows only its types and signatures.

import Foundation

/// Bundled list of popular cars sold in Germany, for autocomplete and suggested values.
/// Values are typical, not exact; the form says so and everything stays editable.
public nonisolated struct CarCatalog: Decodable, Sendable {
    public struct Variant: Decodable, Hashable, Sendable {
        public enum Fuel: String, Decodable, Sendable {
            case petrol, diesel, electric, plugInHybrid

            public var label: String { /* private */ }
        }
        /// The exact version ("xDrive40d", "AMG G 63"); nil for a typical value per fuel.
        public let name: String?
        public let fuel: Fuel
        public let tank: Double?
        /// Usable battery, kWh.
        public let battery: Double?
        /// l/100 km, or kWh/100 km for an electric car. A plug-in hybrid's is with an empty battery.
        public let consumption: Double
        /// A plug-in hybrid's WLTP electricity use, kWh/100 km.
        public let electricConsumption: Double?

        /// "Diesel · 80 l · 7,6 l/100 km", or for a plug-in hybrid
        /// "Plug-in hybrid · 69 l + 25,7 kWh · 9,2 l or 25 kWh/100 km"
        public var summary: String { /* private */ }

        public var label: String { /* private */ }

        public init(
            name: String?,
            fuel: Fuel,
            tank: Double?,
            battery: Double?,
            consumption: Double,
            electricConsumption: Double?
        ) { /* private */ }
    }

    public struct Car: Decodable, Hashable, Sendable, Identifiable {
        public let make: String
        public let model: String
        public let generation: String
        public let from: Int
        public let to: Int
        public let body: BodyType
        public let variants: [Variant]

        public var id: String { /* private */ }
        public var years: ClosedRange<Int> { /* private */ }

        public init(
            make: String,
            model: String,
            generation: String,
            from: Int,
            to: Int,
            body: BodyType,
            variants: [Variant]
        ) { /* private */ }
    }

    /// Generations with typical values (CarCatalog.json).
    public let cars: [Car]
    /// Model names per make, for the pickers (CarModels.json). Includes models without specs.
    public var modelNames: [String: [String]]
    /// The most registered makes in Germany, shown first in the make picker.
    public var popularMakes: [String]

    private enum CodingKeys: String, CodingKey { case cars }

    private struct ModelList: Decodable {
        let makes: [String: [String]]
        let popular: [String]
    }

    public static let shared: CarCatalog

    /// Every make, A–Z.
    public var allMakes: [String] { /* private */ }

    /// Every model of a make, A–Z, including ones with typical values.
    public func allModels(of make: String) -> [String] { /* private */ }

    /// Generations with typical values for one model, newest first.
    public func generations(make: String, model: String) -> [Car] { /* private */ }

    public func car(id: String) -> Car? { /* private */ }

    /// Common short names people type.
    private static let makeAliases

    /// Makes matching what the user typed, best match first.
    public func makes(matching text: String) -> [String] { /* private */ }

    /// The make spelled as in the catalog ("vw" → "Volkswagen"), if it's known.
    public func canonicalMake(_ text: String) -> String? { /* private */ }

    /// Model names for a make, filtered by what's typed.
    public func models(of make: String, matching text: String) -> [String] { /* private */ }

    /// The generation for a make, model and year: the one whose years include it, else the newest.
    public func car(make: String, model: String, year: Int?) -> Car? { /* private */ }

    /// Case- and accent-insensitive key: "Škoda" and "skoda" match.
    public static func fold(_ text: String) -> String { /* private */ }

    public init(
        cars: [Car],
        modelNames: [String: [String]] = [:],
        popularMakes: [String] = []
    ) { /* private */ }
}
