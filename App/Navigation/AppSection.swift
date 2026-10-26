// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import SwiftUI

/// The top level of the app (section 10): tabs on narrow screens, the sidebar on iPad and
/// Mac. A person sees the sections their role allows.
enum AppSection: String, CaseIterable, Identifiable, Hashable {
    case today, map, log, car, desk, ledger, flags, cars, people, cards, logbook, homeCharging, compliance, workshop, costs, reports, policy, settings

    var id: Self { /* private */ }

    var title: LocalizedStringKey { /* private */ }

    var symbol: String { /* private */ }

    /// The driver app's sections, then the desk, for this role. Settings is reached from the
    /// account button on narrow screens and sits at the bottom of the sidebar.
    static func sections(for role: MemberRole) -> [AppSection] { /* private */ }

    /// The desk's screens behind the overview: the sidebar lists them, the overview links
    /// to them on iPhone.
    static func deskScreens(for role: MemberRole) -> [AppSection] { /* private */ }

    /// Where each role starts (plan section 5, "What each role sees first"): a driver on Today;
    /// a manager on Today with the desk pulse on iPhone and on the desk overview on iPad and
    /// Mac; the owner on the desk; the accountant on the ledger, or the desk on iPhone.
    static func home(for role: MemberRole, compact: Bool) -> AppSection { /* private */ }

    /// Everything this role can open.
    static func reachable(for role: MemberRole) -> [AppSection] { /* private */ }

    /// Where a link leads for this role; nil when the role can't open it.
    static func destination(of link: DeepLink, for role: MemberRole) -> AppSection? { /* private */ }
}
