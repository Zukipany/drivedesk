// Source code is private. This file shows only its types and signatures.

import CoreGraphics
import Foundation
import ImageIO
import Testing
import UniformTypeIdentifiers
@testable import DDDevice

@Suite("Receipt photos")
struct ReceiptPhotoTests {
    /// A plain PNG of the given size, as a camera or file would hand it over.
    private func png(width: Int, height: Int) throws -> Data { /* private */ }

    @Test("A large photo shrinks to 1,600 px on its longer side and becomes a JPEG")
    func shrinks() throws { /* private */ }

    @Test("A small photo keeps its size")
    func keepsSmall() throws { /* private */ }

    @Test("Data that isn't an image is refused")
    func refusesNonImages() { /* private */ }
}
