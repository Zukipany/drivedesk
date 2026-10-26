// Source code is private. This file shows only its types and signatures.

import DDCore
import Shimmer
import SwiftUI

extension View {
    /// A light sweep while something loads or searches (SwiftUI-Shimmer). Off with
    /// Reduce Motion: the placeholder stays, without the movement.
    public func loadingShimmer(_ active: Bool = true) -> some View { /* private */ }
}

private struct LoadingShimmer: ViewModifier {
    let active: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View { /* private */ }
}

/// Grey rows shaped like station rows, shimmering while prices load.
public struct PlaceholderRows: View {
    public var count

    public var body: some View { /* private */ }

    public init(
        count: Int = 4
    ) { /* private */ }
}
