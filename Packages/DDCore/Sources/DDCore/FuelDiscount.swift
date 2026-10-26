// Source code is private. This file shows only its types and signatures.

import Foundation

/// One way a card, membership or app takes money off the litre: at some brands, for some
/// fuels, for a while.
public nonisolated struct DiscountRule: Codable, Hashable, Sendable {
    /// Station brands, folded ("shell", "esso"), matched against the Tankerkönig brand.
    public var brands: [String]
    public var centsPerLitre: Double
    public var fuels: [FuelType]
    /// First and last day it applies; nil means open-ended.
    public var from: Date?
    public var until: Date?
    /// Paid out as points (PAYBACK, DeutschlandCard), not taken off at the till.
    public var isPoints

    public func applies(brand: String, fuel: FuelType, on date: Date, calendar: Calendar = .current) -> Bool { /* private */ }

    /// "ESSO", "Esso Express" and "esso" all match "esso"; an unbranded station matches nothing.
    public static func matches(_ brand: String, _ brands: [String]) -> Bool { /* private */ }

    public init(
        brands: [String],
        centsPerLitre: Double,
        fuels: [FuelType] = FuelType.publiclyPriced,
        from: Date? = nil,
        until: Date? = nil,
        isPoints: Bool = false
    ) { /* private */ }
}

/// A card the driver added, by name, with its rules.
public nonisolated struct DiscountCard: Hashable, Sendable {
    public let name: String
    public let rules: [DiscountRule]

    public init(
        name: String,
        rules: [DiscountRule]
    ) { /* private */ }
}

/// The discount used at one station for one fuel.
public nonisolated struct AppliedDiscount: Hashable, Sendable {
    public let cardName: String
    public let centsPerLitre: Double
    public let isPoints: Bool

    /// "−2 ct ADAC", "≈ −0,5 ct PAYBACK"
    public var label: String { /* private */ }

    public init(
        cardName: String,
        centsPerLitre: Double,
        isPoints: Bool
    ) { /* private */ }
}

public nonisolated enum FuelDiscounts {
    /// The biggest discount any of the cards gives here. Most can't be combined (Shell
    /// ClubSmart and Lidl Plus exclude each other, for example), so they're never added up:
    /// better to show a little too much than a price the driver won't get.
    public static func best(
        brand: String,
        fuel: FuelType,
        on date: Date = .now,
        cards: [DiscountCard],
        calendar: Calendar = .current
    ) -> AppliedDiscount? { /* private */ }

    /// The pump price minus the discount, still with three decimals like a price board.
    /// A discount as large as the price itself is a typo, never free fuel: it's ignored.
    public static func price(_ pumpPrice: Double, minus discount: AppliedDiscount?) -> Double { /* private */ }
}

/// Programs common in Germany, with their terms as of October 2026 (ADAC, Shell, Aral,
/// Esso; summarised by auto motor und sport, 17 Sep 2026). Stored by id, so an app update
/// can change the terms without the driver adding the card again.
public nonisolated struct FuelCardPreset: Identifiable, Hashable, Sendable {
    public let id: String
    public let name: String
    public let summary: String
    public let rules: [DiscountRule]
    /// Words printed on the card or shown in the app, to recognise it in a photo.
    public let keywords: [String]

    public var card: DiscountCard { /* private */ }

    public static let all: [FuelCardPreset]

    public static func preset(id: String?) -> FuelCardPreset? { /* private */ }

    private static func day(_ year: Int, _ month: Int, _ day: Int) -> Date? { /* private */ }

    public static let adac

    public static let clubSmart

    public static let payback

    public static let deutschlandCard

    /// Presets whose name appears in text read from a photo of a card or app screen.
    public static func recognised(in lines: [String]) -> [FuelCardPreset] { /* private */ }

    /// How a listed brand appears in Tankerkönig's data, folded: Eni stations are often
    /// still "Agip", TotalEnergies ones "Total".
    public static func ruleBrands(_ brand: String) -> [String] { /* private */ }

    /// Brands a custom card can be set for: the big networks in Tankerkönig's data.
    public static let brands

    public init(
        id: String,
        name: String,
        summary: String,
        rules: [DiscountRule],
        keywords: [String]
    ) { /* private */ }
}
