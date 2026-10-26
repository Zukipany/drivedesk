// Source code is private. This file shows only its types and signatures.

import SwiftUI

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// DriveDesk's design tokens (plan section 22). Fuel colours stay the main colour language
/// (`FuelType.color`); the semantic colours below say how something went.
public enum Tokens {
    /// The 4-point spacing grid.
    public enum Spacing {
        public static let xxs
        public static let xs
        public static let s
        public static let m
        public static let l
        public static let xl
    }

    /// Continuous corner radii. Chips and buttons are capsules.
    public enum Radius {
        public static let card
        public static let input
        /// Wallet-style car passes, as in iDrive.
        public static let pass
    }

    /// HIG minimum hit target.
    public static let minTapTarget
}

/// iDrive's layout constants, kept for the ported components. Cards now use the plan's 20.
public enum Theme {
    public static let cornerRadius
    /// 8 / 16 / 24 spacing grid.
    public static let spacing
    /// HIG minimum hit target.
    public static let minTapTarget
}

/// How something went: an approved payment, a budget at 80 %, a declined card, a hint.
/// Colour never carries the meaning alone, so every tone has a symbol and a word.
public enum StatusTone: CaseIterable, Sendable {
    case success, warning, critical, info

    /// sRGB 0…255 for light and dark appearance. Each passes WCAG AA (4.5:1) as text on
    /// a card: white in light mode, #1C1C1E in dark mode (`TokensTests`).
    public var light: (red: Double, green: Double, blue: Double) { /* private */ }

    public var dark: (red: Double, green: Double, blue: Double) { /* private */ }

    public var color: Color { /* private */ }

    public var symbol: String { /* private */ }
}

extension Color {
    /// A colour with its own value in light and dark appearance (sRGB 0…255).
    public static func dynamic(
        light: (red: Double, green: Double, blue: Double),
        dark: (red: Double, green: Double, blue: Double)
    ) -> Color { /* private */ }

    /// WCAG relative luminance of an sRGB colour (0…255).
    public nonisolated static func luminance(_ rgb: (red: Double, green: Double, blue: Double)) -> Double { /* private */ }

    /// WCAG contrast ratio between two sRGB colours, 1…21.
    public nonisolated static func contrast(
        _ a: (red: Double, green: Double, blue: Double),
        _ b: (red: Double, green: Double, blue: Double)
    ) -> Double { /* private */ }
}
