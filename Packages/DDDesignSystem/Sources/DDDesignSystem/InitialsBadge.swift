// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI
import WidgetKit

/// A station's or charger's initials ("A", "JET") on a rounded square, or a symbol for
/// chargers. iDrive draws no brand logos or colours (they're trademarks). Three looks:
/// light and dark follow the appearance; on tinted and clear Home Screens, where a widget is
/// drawn in one tint, it's an outline, since a filled square would hide its own letters.
public struct InitialsBadge: View {
    public let name: String
    public var size: CGFloat
    /// Instead of initials, e.g. "bolt.fill" for a charger.
    public var symbol: String?
    public var symbolColor: Color

    @Environment(\.widgetRenderingMode) private var renderingMode

    private var isTinted: Bool { /* private */ }

    public var body: some View { /* private */ }

    /// "Aral" → "A", "JET" → "JET" (short capitals as they are), "" → "?".
    public nonisolated static func initials(of name: String) -> String { /* private */ }

    public init(
        name: String,
        size: CGFloat = 42,
        symbol: String? = nil,
        symbolColor: Color = .primary
    ) { /* private */ }
}
