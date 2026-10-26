// Source code is private. This file shows only its types and signatures.

#if DEBUG
    import DDCore
    import DDData
    import DDDesignSystem
    import SwiftData
    import SwiftUI

    /// Who you are in the demo company: drivers see the driver app, managers and the owner the
    /// desk on top, the accountant the books only (plan section 5, "What each role sees first").
    enum DemoProfile: String, CaseIterable, Identifiable {
        case lena, tom, max, marco, sabine, accountant

        var id: Self { /* private */ }

        var person: DemoFirm.Person { /* private */ }

        var symbol: String { /* private */ }

        var line: LocalizedStringKey { /* private */ }

        /// What this person sees, in a few words.
        var sees: LocalizedStringKey { /* private */ }

        /// The launch arguments of earlier screenshots: `-DDDemoRole manager`, `owner`, …
        init?(argument: String?) { /* private */ }
    }

    /// Whether the app runs the demo company, as whom, and whether the fleet moves by itself.
    @MainActor @Observable
    final class DemoState {
        static let shared

        /// Nil: the real app.
        var profile: DemoProfile?
        /// New fill-ups and charges arrive every few seconds.
        var simulates
        /// The latest simulated event, shown for a moment.
        var lastEvent: String?

        private init() { /* private */ }
    }

    /// The demo company in a session of its own, in memory, as one of its people.
    enum DemoSession {
        static func make(as profile: DemoProfile, now: Date = .now) -> (AppSession, Member)? { /* private */ }
    }

    /// The app as one person of the demo company, with the fleet moving by itself.
    struct DemoAppView: View {
        @State private var demo: (session: AppSession, member: Member)?
        @State private var state
        let profile: DemoProfile

        var body: some View { /* private */ }

        @ViewBuilder private var eventBanner: some View { /* private */ }
    }

    /// "Explore the demo company": pick who you are.
    struct DemoProfilePicker: View {
        @Environment(\.dismiss) private var dismiss
        var current: DemoProfile?

        var body: some View { /* private */ }
    }

    /// The demo's controls in Settings: who you are, whether the fleet moves, and the way out.
    struct DemoSettingsSection: View {
        @State private var state
        @State private var picks

        var body: some View { /* private */ }
    }
#endif
