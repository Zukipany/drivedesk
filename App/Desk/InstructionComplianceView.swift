// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The yearly driver instruction on the desk (US-40): each person's last instruction, its
/// version and result, the next due date and the certificate.
struct InstructionComplianceView: View {
    @Environment(AppSession.self) private var session
    @Query private var members: [Member]
    @Query private var completions: [InstructionCompletion]
    @Query private var companies: [Company]
    @State private var certificate: URL?

    let member: Member

    init(member: Member) { /* private */ }

    private var rows: [(person: Member, status: InstructionStatus)] { /* private */ }

    var body: some View { /* private */ }
}

struct SharedFile: Identifiable {
    let url: URL
    var id: URL { /* private */ }
}

private struct InstructionStateLabel: View {
    let status: InstructionStatus

    var body: some View { /* private */ }
}

/// One PDF per year with every licence check, vehicle inspection and driver instruction, with
/// dates and evidence, for the insurer or the Berufsgenossenschaft after an incident.
enum YearlyProof {
    struct Line: Identifiable {
        let id
        let date: Date
        let subject: String
        let detail: String
    }

    @MainActor static func render(year: Int, company: String, licences: [Line], inspections: [Line], instructions: [Line]) -> URL? { /* private */ }
}

private struct YearlyProofPage: View {
    let year: Int
    let company: String
    let sections: [(LocalizedStringKey, [YearlyProof.Line])]
    let number: Int
    let of: Int

    var body: some View { /* private */ }
}
