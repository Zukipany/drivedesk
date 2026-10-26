// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import SwiftUI

/// A car's logbook as an A4 PDF, book-style (plan section 16, "Exports"): one line per trip,
/// corrections inline, the chain hash on every page, readable without a login or a second
/// file.
enum LogbookPDF {
    /// Trips per page; a page with corrections takes fewer.
    static let linesPerPage

    @MainActor static func render(_ export: LogbookExport, company: String) -> URL? { /* private */ }

    /// Pages of lines, a correction counting as one more line.
    static func paginate(_ lines: [LogbookLine]) -> [[LogbookLine]] { /* private */ }
}

private struct LogbookPage: View {
    let export: LogbookExport
    let company: String
    let lines: [LogbookLine]
    let number: Int
    let of: Int
    let isLast: Bool

    /// The last seal on this page, so each page can be checked against the chain.
    private var pageHash: String? { /* private */ }

    var body: some View { /* private */ }

    private func header(_ title: LocalizedStringKey) -> some View { /* private */ }

    private func odometer(_ line: LogbookLine) -> String { /* private */ }
}
