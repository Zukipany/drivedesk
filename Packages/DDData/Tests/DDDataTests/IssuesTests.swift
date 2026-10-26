// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDData

@Suite("Issues and the workshop board")
struct IssuesTests {
    private func issue(_ severity: IssueSeverity, _ status: IssueStatus = .open, car: UUID = Demo.caddy) -> CarIssue { /* private */ }

    @Test("Each no in a daily check becomes an issue")
    func dailyCheck() { /* private */ }

    @Test("The car stays in the workshop while an issue is there or says do not drive")
    func vehicleStatus() { /* private */ }

    @Test("An issue row goes up and comes back the same")
    func row() throws { /* private */ }

    @Test("Company settings come in from the server")
    func settings() throws { /* private */ }
}
