// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import PhotosUI
import SwiftData
import SwiftUI

/// The car's open issues and Report a Problem, on the Car screen (US-41).
struct CarIssuesPanel: View {
    @Query private var issues: [CarIssue]
    @State private var reporting
    let member: Member
    let vehicle: Vehicle

    init(member: Member, vehicle: Vehicle) { /* private */ }

    var body: some View { /* private */ }
}

struct IssueLine: View {
    let issue: CarIssue

    var body: some View { /* private */ }
}

struct SeverityTag: View {
    let severity: IssueSeverity

    var body: some View { /* private */ }
}

/// Reporting a problem: what, how bad, a line about it, and photos.
struct ReportIssueSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var category
    @State private var severity
    @State private var details
    @State private var picks: [PhotosPickerItem]
    @State private var photos: [Data]
    @State private var error: String?
    let member: Member
    let vehicle: Vehicle

    var body: some View { /* private */ }

    private func send() { /* private */ }
}

/// Issue photos go to the receipts bucket; the issue keeps their paths once they're there.
enum IssuePhotos {
    @MainActor static func upload(_ photos: [Data], for issue: CarIssue, session: AppSession, member: Member) async { /* private */ }
}

/// The daily check before the first trip (US-41), when the company turned it on.
struct DailyCheckCard: View {
    @Environment(AppSession.self) private var session
    @Query private var checks: [DailyCheck]
    @State private var lights
    @State private var tyres
    @State private var fluids
    @State private var noDamage
    @State private var loadSecured
    @State private var error: String?
    let member: Member
    let vehicle: Vehicle

    init(member: Member, vehicle: Vehicle) { /* private */ }

    var body: some View { /* private */ }

    private func save() { /* private */ }
}
