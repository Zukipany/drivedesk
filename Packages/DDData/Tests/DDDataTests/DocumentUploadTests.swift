// Source code is private. This file shows only its types and signatures.

import CoreGraphics
import Foundation
import ImageIO
import Testing
import UniformTypeIdentifiers
@testable import DDData

@Suite("Uploading car documents")
struct DocumentUploadTests {
    /// A small PNG drawn on the spot.
    private func png(width: Int = 40, height: Int = 60) throws -> Data { /* private */ }

    @Test("A replaced file gets the next path, so a kept copy of the old one never passes for it")
    func paths() { /* private */ }

    @Test("A PDF goes up as it is; a photo becomes one A4 page; anything else is refused")
    func pdf() throws { /* private */ }

    @Test("The uploader puts the PDF at the document's next path")
    func upload() async throws { /* private */ }
}
