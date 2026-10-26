// Source code is private. This file shows only its types and signatures.

import Foundation

/// Picks the odometer reading out of OCR text from a dashboard photo.
///
/// A cluster shows more numbers than the odometer: trip meters ("123.4"), time ("12:34"),
/// temperature ("18°"), range ("420 km"). The odometer is the whole number of 3 to 7 digits,
/// usually the largest one. Candidates come back best first so the user can pick if the
/// first one is wrong.
public nonisolated enum OdometerReader {
    public static func candidates(in lines: [String], atLeast minimum: Int? = nil) -> [Int] { /* private */ }
}
