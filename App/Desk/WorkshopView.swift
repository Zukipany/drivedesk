// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The workshop board (US-41, plan section 19): Open, In workshop and Fixed. Moving a card
/// changes the car's status: in the workshop while one of its issues is there or says do not
/// drive, back in service when none is left. Managers and the owner move cards; everyone on
/// the desk reads.
struct WorkshopView: View {
    @Environment(AppSession.self) private var session
    @Query private var issues: [CarIssue]
    @Query private var vehicles: [Vehicle]
    @Query private var members: [Member]
    @State private var column
    @State private var reportingVehicle: Vehicle?
    @State private var error: String?

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    let member: Member

    init(member: Member) { /* private */ }

    private var canMove: Bool { /* private */ }

    /// A column's cards: worst first, then newest; fixed ones of the last 30 days only.
    private func cards(_ status: IssueStatus) -> [CarIssue] { /* private */ }

    private func car(_ id: UUID) -> String { /* private */ }
    private func name(_ id: UUID) -> String { /* private */ }

    var body: some View { /* private */ }

    /// Moves a card and brings the car's status along.
    private func move(_ issue: CarIssue, to status: IssueStatus) { /* private */ }
}

private struct BoardColumn<Content: View>: View {
    let status: IssueStatus
    let count: Int
    @ViewBuilder let content: Content

    var body: some View { /* private */ }
}

private struct IssueCard: View {
    let issue: CarIssue
    let car: String
    let reporter: String
    let canMove: Bool
    let move: (IssueStatus) -> Void

    var body: some View { /* private */ }
}
