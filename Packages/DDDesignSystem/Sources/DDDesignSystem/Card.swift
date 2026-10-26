// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

/// Content-layer card. HIG (Materials): Liquid Glass is for controls and navigation
/// only, so cards use the grouped background colour, which adapts to dark mode and
/// Increase Contrast automatically.
public struct CardStyle: ViewModifier {
    @ScaledMetric(relativeTo: .body) private var padding

    public func body(content: Content) -> some View { /* private */ }
}

extension View {
    public func cardStyle() -> some View { /* private */ }
}
