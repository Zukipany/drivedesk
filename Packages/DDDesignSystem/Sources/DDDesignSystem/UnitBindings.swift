// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

extension Binding where Value == Int? {
    /// An odometer stored in km, shown and typed in the driver's unit (km or miles).
    public var inDriverDistance: Binding<Int?> { /* private */ }
}

extension Binding where Value == Double? {
    /// A stored amount shown and typed in the driver's units (see `Units.Conversion`).
    public func converted(_ conversion: Units.Conversion) -> Binding<Double?> { /* private */ }
}

extension FuelMath.Field {
    /// Litres, € per litre and € are stored; the field shows the driver's units (gallons, £ …).
    public func conversion(electric: Bool) -> Units.Conversion { /* private */ }
}
