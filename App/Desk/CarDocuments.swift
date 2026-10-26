// Source code is private. This file shows only its types and signatures.

import CoreTransferable
import DDCore
import DDData
import DDDesignSystem
import DDDevice
import SwiftData
import SwiftUI
import UniformTypeIdentifiers

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

/// A PDF or photo dropped onto a car on the desk, from Finder or Files.
struct DroppedDocument: Transferable {
    let data: Data
    let name: String

    static var transferRepresentation: some TransferRepresentation { /* private */ }
}

/// A car's papers on the desk (US-27): add one by picking or dropping a PDF or photo, replace
/// its file, change its expiry, open it, and copy a link that works for five minutes.
struct DeskDocuments: View {
    @Environment(AppSession.self) private var session
    @Query private var documents: [VehicleDocument]
    @State private var importing
    @State private var preview: URL?
    @State private var busy: UUID?
    @State private var note: String?
    @State private var editing: DocumentForm.Target?
    @Binding var dropped: DroppedDocument?

    let vehicle: Vehicle
    let member: Member

    init(vehicle: Vehicle, member: Member, dropped: Binding<DroppedDocument?>) { /* private */ }

    private var canEdit: Bool { /* private */ }
    private var sorted: [VehicleDocument] { /* private */ }

    var body: some View { /* private */ }

    private func open(_ document: VehicleDocument) { /* private */ }

    private func copyLink(_ document: VehicleDocument) { /* private */ }
}

private struct DeskDocumentRow: View {
    let document: VehicleDocument
    let isBusy: Bool

    private var expiryDays: Int? { /* private */ }

    var body: some View { /* private */ }
}

/// Adding a document, editing its details, or replacing its file.
struct DocumentForm: View {
    enum Target: Identifiable {
        case new(DroppedDocument)
        case edit(VehicleDocument, file: DroppedDocument?)
        case replace(VehicleDocument)

        var id: String { /* private */ }
    }

    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var kind
    @State private var title
    @State private var expires
    @State private var expiry
    @State private var file: DroppedDocument?
    @State private var importing
    @State private var saving
    @State private var error: String?

    let target: Target
    let vehicle: Vehicle
    let member: Member

    private var existing: VehicleDocument? { /* private */ }

    var body: some View { /* private */ }

    private func load() { /* private */ }

    private func fill(from document: VehicleDocument) { /* private */ }

    private func save() { /* private */ }

    private func store(_ document: VehicleDocument, uploaded: (path: String, pdf: Data)?, expiresOn: Date?) throws(SyncFailure) { /* private */ }
}

/// The manager's reminders before papers run out (US-27): 30 days ahead and on the day, for
/// every car of the company, as notifications on this device.
enum DocumentReminders {
    @MainActor static func schedule(store: LocalStore, company: UUID, asking: Bool) async { /* private */ }
}
