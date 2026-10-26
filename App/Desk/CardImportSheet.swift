// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI
import UniformTypeIdentifiers

/// Importing a fuel card's monthly CSV (US-28, plan feature 7): pick the file, check the
/// columns (the common German cards map themselves, and the mapping is kept per company),
/// see what each row would become, then import. Imported fill-ups have source import and
/// reach the server's fraud rules like any other.
struct CardImportSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @Query private var vehicles: [Vehicle]
    @Query private var assignments: [Assignment]
    @Query private var fillUps: [FillUp]
    @State private var csv: CardCSV?
    @State private var fileName
    @State private var mapping
    @State private var choosing
    @State private var error: String?
    let member: Member

    init(member: Member) { /* private */ }

    private var lines: [ImportLine] { /* private */ }

    var body: some View { /* private */ }

    @ViewBuilder private func summary(_ lines: [ImportLine]) -> some View { /* private */ }

    private func column(_ field: CardColumnMapping.Field) -> Binding<String?> { /* private */ }

    private func label(_ field: CardColumnMapping.Field) -> LocalizedStringKey { /* private */ }

    private func open(_ url: URL) { /* private */ }

    private func run(_ lines: [ImportLine]) { /* private */ }
}

private struct ImportRow: View {
    let line: ImportLine

    private var status: (symbol: String, color: Color, text: String) { /* private */ }

    var body: some View { /* private */ }
}

/// The column mapping per company on this device.
enum CardMappingStore {
    private static func key(_ company: UUID) -> String { /* private */ }

    static func load(company: UUID) -> CardColumnMapping? { /* private */ }

    static func save(_ mapping: CardColumnMapping, company: UUID) { /* private */ }
}
