// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The yearly driver instruction on Today (US-40): from 14 days before it's due.
struct InstructionDueCard: View {
    @Query private var completions: [InstructionCompletion]
    @State private var instructing
    let member: Member

    init(member: Member) { /* private */ }

    private var status: InstructionStatus { /* private */ }

    var body: some View { /* private */ }
}

/// Cards, quiz, signature, certificate.
struct InstructionFlow: View {
    private enum Step: Equatable {
        case card(Int)
        case question(Int)
        case result
        case signature
        case done
    }

    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @Query private var companies: [Company]
    @State private var step
    @State private var quiz: [InstructionModule.QuizQuestion]
    @State private var answers: [Int?]
    @State private var strokes: [[SignaturePoint]]
    @State private var certificate: URL?
    @State private var error: String?

    let member: Member
    private let module

    init(member: Member) { /* private */ }

    private var correct: Int { /* private */ }
    private var passed: Bool { /* private */ }

    var body: some View { /* private */ }

    private var progress: Double { /* private */ }

    @ViewBuilder private var content: some View { /* private */ }

    @ViewBuilder private var footer: some View { /* private */ }

    private func finish() { /* private */ }
}

/// Drawing a signature with a finger or Apple Pencil: strokes of points between 0 and 1.
struct SignaturePad: View {
    @Binding var strokes: [[SignaturePoint]]
    @State private var current: [SignaturePoint]

    var body: some View { /* private */ }
}

/// A signature's strokes drawn in any frame.
nonisolated struct SignatureShape: Shape {
    let strokes: [[SignaturePoint]]

    func path(in rect: CGRect) -> Path { /* private */ }
}

/// The certificate: name, date, module version, the quiz result and the signature, as A4 PDF.
enum InstructionCertificate {
    @MainActor static func render(completion: InstructionCompletion, person: String, company: String) -> URL? { /* private */ }
}

private struct InstructionCertificatePage: View {
    let completion: InstructionCompletion
    let person: String
    let company: String

    var body: some View { /* private */ }
}
