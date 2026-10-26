// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The signed-in app: tabs on compact width, a sidebar on regular width (iPad, Mac). The
/// same selection drives both, so rotating an iPad or resizing a window keeps the place.
struct AdaptiveRootView: View {
    @Environment(AppSession.self) private var session
    let member: Member
    let user: AuthUser

    @State private var selection: AppSection
    /// The role's first screen is chosen once, when the app opens.
    @State private var choseHome
    @State private var showsSettings

    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var sizeClass
        private var isCompact: Bool { /* private */ }
    #else
        private let isCompact
    #endif

    private var sections: [AppSection] { /* private */ }

    /// An invitation link to another company, opened while signed in.
    private var joinsCompany: Binding<Bool> { /* private */ }

    var body: some View { /* private */ }

    private var tabs: some View { /* private */ }

    /// ⌘1 to ⌘9 open the sections in order (section 10), on the Mac and an iPad keyboard.
    private var sectionShortcuts: some View { /* private */ }

    /// Opens a deep link's section; the link waits in the session until someone is signed in.
    private func follow(_ link: DeepLink?) { /* private */ }
}

/// The sidebar: the driver sections, the desk for managers, and settings at the bottom.
private struct SidebarNavigation: View {
    @Environment(AppSession.self) private var session
    @Query private var companies: [Company]
    /// Undecided flags, as the sidebar's counter (US-26).
    @State private var openFlags
    let member: Member
    let user: AuthUser
    @Binding var selection: AppSection

    private var driveSections: [AppSection] { /* private */ }

    private var companyName: String { /* private */ }

    var body: some View { /* private */ }
}

/// The screen behind a section.
struct SectionScreen: View {
    let section: AppSection
    let member: Member
    let user: AuthUser

    var body: some View { /* private */ }
}

/// Who is signed in, in what role and at which site: the top of the sidebar, so a driver's
/// and a manager's app never look alike.
private struct WhoIAm: View {
    @Query private var groups: [FleetGroup]
    let member: Member

    init(member: Member) { /* private */ }

    private var site: String? { /* private */ }

    var body: some View { /* private */ }
}
