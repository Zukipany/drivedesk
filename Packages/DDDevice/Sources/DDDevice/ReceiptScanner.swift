// Source code is private. This file shows only its types and signatures.

import DDPrices
import DDCore
import CoreGraphics
import ImageIO
import Vision

#if canImport(UIKit)
    import UIKit
#endif

/// On-device OCR for receipts. Nothing leaves the device: the iPhone's camera, or on the Mac
/// a photo or Continuity Camera scan.
public enum ReceiptScanner {
    /// The receipt's printed rows, rebuilt from the OCR boxes (see `ReceiptLayout`).
    public static func lines(in image: CGImage, orientation: CGImagePropertyOrientation = .up) async throws -> [String] { /* private */ }

    public static func parse(_ image: CGImage, orientation: CGImagePropertyOrientation = .up) async throws -> ParsedReceipt { /* private */ }

    #if canImport(UIKit)
        public static func lines(in image: UIImage) async throws -> [String] { /* private */ }

        public static func parse(_ image: UIImage) async throws -> ParsedReceipt { /* private */ }

        static func fragments(in image: UIImage) async throws -> (fragments: [ReceiptLayout.Fragment], aspectRatio: Double) { /* private */ }
    #endif

    /// Every text fragment with its corners, from `RecognizeDocumentsRequest` (iOS 26).
    static func fragments(
        in cgImage: CGImage,
        orientation: CGImagePropertyOrientation
    ) async throws -> (fragments: [ReceiptLayout.Fragment], aspectRatio: Double) { /* private */ }
}

private extension ReceiptLayout.Point {
    init(_ point: NormalizedPoint) { /* private */ }
}
