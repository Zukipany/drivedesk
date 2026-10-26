// Source code is private. This file shows only its types and signatures.

import DDCore
import Charts
import SwiftUI

extension ChartContent {
    /// Rounds a bar or ring segment. This is Swift Charts' own mark modifier, not the
    /// deprecated `View.cornerRadius(_:)` that the course lint rule looks for.
    public func roundedCorners(_ radius: CGFloat = 6) -> some ChartContent { /* private */ }
}
