// Source code is private. This file shows only its types and signatures.

import SwiftUI

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// The system colours iDrive used through UIKit, with their closest Mac equivalents, so the
/// same components draw on iPhone, iPad and Mac.
extension Color {
    /// Card surface on a grouped background (iOS: secondarySystemGroupedBackground).
    public static var cardBackground: Color { /* private */ }

    /// The screen behind cards (iOS: systemGroupedBackground), so a card stands out in light
    /// and dark mode.
    public static var groupedBackground: Color { /* private */ }

    /// The empty part of a ring or bar (iOS: tertiarySystemFill).
    public static var trackFill: Color { /* private */ }

    /// Hairlines and neutral borders (iOS: separator).
    public static var separatorLine: Color { /* private */ }
}
