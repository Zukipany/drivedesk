// Source code is private. This file shows only its types and signatures.

import Foundation

/// Where a link into the app leads (plan section 10): `drivedesk://today`,
/// `drivedesk://map?fuel=e10`, `drivedesk://fillup/<id>`, `/flag/<id>`, `/task/<id>`,
/// `/car/<id>`, `/desk` and invitations (`/join/<token>`, `invite?token=<token>`), and the same paths as universal
/// links under drivedesk.app. Every push notification opens one of these.
public nonisolated enum DeepLink: Equatable, Sendable {
    case today
    case map(fuel: FuelType?)
    case log
    /// The car screen; with an ID, that car (a manager's desk detail later).
    case car(UUID?)
    case fillUp(UUID)
    case flag(UUID)
    case task(UUID)
    case desk
    case settings
    case join(token: String)

    public static let scheme
    public static let webHosts: Set<String>

    public init?(url: URL) { /* private */ }

    /// An invitation token: at least 8 URL-safe characters.
    static func isToken(_ text: String) -> Bool { /* private */ }
}
