// Source code is private. This file shows only its types and signatures.

import CoreGraphics
import DDCore
import Foundation
import ImageIO
import UniformTypeIdentifiers

/// A receipt photo as DriveDesk keeps it (plan section 9): upright, its longer side at most
/// 1,600 px and a JPEG, so a receipt is about 200 KB on the phone and in the bucket. Works on
/// iPhone, iPad and Mac alike, from a camera scan, a photo or a file.
public nonisolated struct ReceiptPhoto {
    /// The longer side, in pixels.
    public static let maxSide

    /// The JPEG that is stored and uploaded.
    public let jpeg: Data
    /// The same picture for text recognition.
    public let image: CGImage

    /// Shrinks and re-encodes any image ImageIO reads (JPEG, HEIC, PNG); nil when the data
    /// isn't an image.
    public init?(data: Data, maxSide: Int = Self.maxSide, quality: Double = 0.7) { /* private */ }

    /// Reads the receipt's text on the device and parses amount, price, total, date and fuel.
    public func parse() async -> ParsedReceiptReading { /* private */ }
}

/// What reading a receipt gave: the parsed values, the text as read (for the VAT check on
/// the buyer's name), and whether the text recognition failed altogether (the form then asks
/// for every value).
public nonisolated struct ParsedReceiptReading: Sendable {
    public let receipt: ParsedReceipt
    public let lines: [String]
    public let failed: Bool
}
