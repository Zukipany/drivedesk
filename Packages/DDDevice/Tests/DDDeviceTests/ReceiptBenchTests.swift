// Source code is private. This file shows only its types and signatures.

#if os(iOS)
    import DDCore
    import Foundation
    import Testing
    import UIKit
    @testable import DDDevice

    /// Receipt bench: runs the generated receipt images through the app's real OCR
    /// (`ReceiptScanner` in DDDevice) and parser, prints a score table and saves the OCR lines.
    /// Off by default; tools/receipt-bench/run.sh turns it on by setting RECEIPT_BENCH.
    @Suite("Receipt bench", .enabled(if: ProcessInfo.processInfo.environment["RECEIPT_BENCH"] != nil))
    struct ReceiptBenchTests {
        struct Expected: Decodable {
            let amount: Double
            let price: Double
            let total: Double
            let fuel: String
            let date: String
        }

        @Test("OCR + parser on the bench images")
        func bench() async throws { /* private */ }

        private static let berlin: Calendar

        private func isClose(_ a: Double?, _ b: Double, tolerance: Double) -> Bool { /* private */ }

        private func show(_ value: Double?) -> String { /* private */ }
    }

    /// One bench image's OCR output and ground truth, replayed by the unit tests.
    nonisolated struct ReceiptFixture: Codable {
        let aspectRatio: Double
        let fragments: [ReceiptLayout.Fragment]
        let amount: Double
        let price: Double
        let total: Double
        let fuel: String
        let date: String
    }
#endif
