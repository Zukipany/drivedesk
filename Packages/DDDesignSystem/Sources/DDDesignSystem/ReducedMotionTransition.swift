// Source code is private. This file shows only its types and signatures.

import SwiftUI

extension View {
    /// With Reduce Motion on, a pushed page cross-fades in (iOS 27) instead of sliding
    /// across the screen; otherwise the standard push.
    public func reducedMotionTransition() -> some View { /* private */ }
}

private struct ReducedMotionTransition: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View { /* private */ }
}
