// Source code is private. This file shows only its types and signatures.

#if canImport(UIKit)
    import DDPrices
    import DDCore
    import CoreImage
    import UIKit
    import Vision

    /// Turns a car photo into a card image: cuts the car out of the background (the same
    /// subject lifting as long-press in Photos) and measures its paint colour.
    enum CarPhotoProcessor {
        struct Result {
            /// PNG with a transparent background when the car was found, else a JPEG of the photo.
            let data: Data
            let image: UIImage
            /// The paint colour measured on the car's pixels only; nil if no car was found.
            let color: CarColor?
            /// False when Vision found no subject; the photo is then kept as it is.
            var isCutOut: Bool { /* private */ }
        }

        static func process(_ photo: UIImage) async -> Result { /* private */ }

        /// The subject covering the most pixels. Vision lifts every foreground object (other
        /// cars, people, a bike); a photo of your car has your car as the biggest one.
        private static func largestInstance(in observation: InstanceMaskObservation) -> IndexSet { /* private */ }

        /// Pixels inside a one-channel mask (float or 8-bit).
        private static func coveredPixels(_ mask: CVPixelBuffer) -> Int { /* private */ }

        private static func fallback(_ image: UIImage) -> Result { /* private */ }

        /// Average of the car's pixels. The cut-out is transparent around the car, so the
        /// premultiplied average is divided by the average alpha.
        private static func averageColor(of image: CIImage, context: CIContext) -> CarColor? { /* private */ }
    }

    /// On-device OCR for short codes and numbers, like the odometer on a dashboard. Language
    /// correction is off; it would turn codes into words.
    enum TextScanner {
        static func lines(in photo: UIImage) async -> [String] { /* private */ }

        static func odometerReadings(in photo: UIImage, atLeast minimum: Int?) async -> [Int] { /* private */ }
    }
#endif
