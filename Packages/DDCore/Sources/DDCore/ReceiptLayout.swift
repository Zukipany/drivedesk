// Source code is private. This file shows only its types and signatures.

import Foundation

/// Rebuilds a receipt's printed rows from OCR text boxes.
///
/// Apple's document OCR returns a receipt's columns one after the other: first every
/// label ("Energie", "Preis/kWh", "Gesamtbetrag"), then every value ("38,560 kWh",
/// "0,59 €", "22,75 €"). Reading that in order separates each label from its value.
/// This puts fragments that sit on the same printed line back together, left to right,
/// after undoing the tilt of a hand-held photo.
public nonisolated enum ReceiptLayout {
    public struct Point: Codable, Hashable, Sendable {
        public var x: Double
        public var y: Double

        public init(
            x: Double,
            y: Double
        ) { /* private */ }
    }

    /// One piece of recognised text and its corners, normalised to 0…1 with the origin
    /// at the bottom left (Vision's convention).
    public struct Fragment: Codable, Hashable, Sendable {
        public var text: String
        public var topLeft: Point
        public var topRight: Point
        public var bottomRight: Point
        public var bottomLeft: Point

        public init(
            text: String,
            topLeft: Point,
            topRight: Point,
            bottomRight: Point,
            bottomLeft: Point
        ) { /* private */ }
    }

    /// Printed rows, top to bottom. `aspectRatio` is image width ÷ height; normalised
    /// coordinates stretch angles otherwise.
    public static func rows(_ fragments: [Fragment], aspectRatio: Double) -> [String] { /* private */ }

    /// Median angle of the text baselines, from fragments wide enough to measure.
    public static func skew(_ fragments: [Fragment], aspectRatio: Double) -> Double { /* private */ }
}
