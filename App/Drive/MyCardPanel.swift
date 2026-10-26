// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftUI

/// The driver's DriveDesk Card on the Car screen (US-33, plan section 13): its face, limits
/// and state; Freeze at once when the phone is lost or a payment looks strange; or, without a
/// card, asking for one. Only the desk unfreezes. The number is never shown by DriveDesk.
struct MyCardPanel: View {
    @Environment(AppSession.self) private var session
    @State private var cards: [CompanyCard]
    @State private var requests: [CardRequest]
    @State private var loaded
    @State private var working
    @State private var error: String?
    @State private var confirmsFreeze
    @State private var asking
    @State private var explainsWallet

    let member: Member
    let vehicle: Vehicle?

    /// The card for this car, else the person's own for any car; frozen ones too.
    private var card: CompanyCard? { /* private */ }

    private var openRequest: CardRequest? { /* private */ }
    private var declined: CardRequest? { /* private */ }

    var body: some View { /* private */ }

    private func load() async { /* private */ }

    private func freeze() { /* private */ }
}

/// Asking for a card: which car, and a line for the manager.
private struct AskForCardSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var note
    @State private var forThisCar
    @State private var working
    @State private var error: String?

    let member: Member
    let vehicle: Vehicle?
    let asked: (CardRequest) -> Void

    var body: some View { /* private */ }

    private func ask() { /* private */ }
}
