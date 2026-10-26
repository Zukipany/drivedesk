// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

@Suite("Deep links")
struct DeepLinkTests {
    private let id

    private func link(_ text: String) -> DeepLink? { /* private */ }

    @Test("Every path of section 10, in the app's scheme")
    func appScheme() { /* private */ }

    @Test("The map takes a fuel to filter by; an unknown fuel shows the car's own")
    func map() { /* private */ }

    @Test("The same paths as universal links under drivedesk.app")
    func universalLinks() { /* private */ }

    @Test(
        "Anything else is not a link into the app",
        arguments: [
            "drivedesk://auth-callback?code=abc", "drivedesk://fillup", "drivedesk://fillup/not-an-id",
            "drivedesk://join/short", "drivedesk://invite?token=short", "drivedesk://invite", "https://example.com/today", "mailto:a@b.de",
            "drivedesk://"
        ]
    )
    func notLinks(text: String) { /* private */ }
}
