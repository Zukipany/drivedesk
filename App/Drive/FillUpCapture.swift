// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import DDDevice
import PhotosUI
import SwiftUI
import UniformTypeIdentifiers

/// What the fill-up form starts with: empty, or the values and photo of a receipt.
struct FillUpDraft: Identifiable {
    let id
    var receipt: ParsedReceipt?
    /// The receipt shrunk to 1,600 px, as stored and uploaded.
    var photo: Data?
    /// Text recognition found nothing: every value is the driver's to type.
    var readingFailed
    /// The receipt's text as read, for the VAT check above 250 €.
    var receiptLines: [String]
}

/// The ways to log a fill-up (plan D6 to D8): scan the receipt with the document camera,
/// pick a photo or a file, or type it in. Shared by Today's Fuel up button and the Log.
@MainActor @Observable
final class FillUpCapture {
    var draft: FillUpDraft?
    var showsCamera
    var showsPhotoPicker
    var showsFileImporter
    var photoItem: PhotosPickerItem?
    var isReadingReceipt
    var savedCount
    var error: String?

    /// The document camera where there is one, else the photo library.
    func startScan() { /* private */ }

    func enterManually() { /* private */ }

    /// Shrinks the photo, reads its text on the device, and opens the form with what it found.
    func read(_ data: Data) { /* private */ }

    func readPicked() { /* private */ }

    func readFile(_ result: Result<URL, any Error>) { /* private */ }
}

/// The ways to log a fill-up, as menu items: a menu closes at once, so the camera, picker
/// or form it opens never collides with another presentation.
struct FillUpChoices: View {
    let capture: FillUpCapture

    var body: some View { /* private */ }
}

extension View {
    /// The camera, photo picker, "Reading receipt…" overlay and form for `capture`.
    func fillUpCapture(_ capture: FillUpCapture, vehicle: Vehicle?, member: Member) -> some View { /* private */ }
}

private struct FillUpCaptureModifier: ViewModifier {
    @Environment(AppSession.self) private var session
    @Bindable var capture: FillUpCapture
    let vehicle: Vehicle?
    let member: Member

    func body(content: Content) -> some View { /* private */ }
}
