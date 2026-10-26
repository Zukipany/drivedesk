// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftUI

/// Today's "your answer is needed" (plan section 14): the driver's flags still open or
/// waiting for a decision, each with what the rules saw and a way to explain.
struct FlagsToAnswerCard: View {
    let flags: [FlagDetail]
    let answer: (FlagDetail) -> Void

    var body: some View { /* private */ }
}

/// The driver's answer to a flag: a reason and, if it helps, a note.
struct ExplainFlagSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var reason: String?
    @State private var note
    @State private var sending
    @State private var error: String?

    let flag: FlagDetail
    let sent: () async -> Void

    var body: some View { /* private */ }

    private func send() { /* private */ }
}
