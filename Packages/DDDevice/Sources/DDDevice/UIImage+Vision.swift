// Source code is private. This file shows only its types and signatures.

#if canImport(UIKit)
    import DDPrices
    import DDCore
    import ImageIO
    import UIKit

    extension UIImage {
        /// The orientation Vision needs to read the image upright.
        var cgOrientation: CGImagePropertyOrientation { /* private */ }

        /// A copy whose longer side is at most `maxSide` points, drawn upright.
        public func downscaled(maxSide: CGFloat) -> UIImage { /* private */ }
    }
#endif
