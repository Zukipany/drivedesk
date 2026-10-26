// Source code is private. This file shows only its types and signatures.

import SwiftUI

#if os(iOS)
    import UIKit
#endif

extension View {
    /// Number and decimal pads have no return key, so without this the keyboard can't be
    /// closed (and covers the rest of the form). Adds "Done" above the keyboard and lets
    /// scrolling dismiss it. The Mac keyboard has a return key and covers nothing.
    @ViewBuilder
    public func keyboardDoneButton() -> some View { /* private */ }
}
