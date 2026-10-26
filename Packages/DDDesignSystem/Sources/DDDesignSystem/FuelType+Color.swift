// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

extension FuelType {
    /// One system colour per fuel, used for fills and symbols only.
    /// Never use it as text colour: system green/teal/orange on white are below 4.5:1.
    public var color: Color { /* private */ }
}

extension CarColor {
    public var color: Color { /* private */ }
}
