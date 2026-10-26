// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Flag queue")
struct FlagsTests {
    private func flag(_ severity: Int, _ status: FlagStatus = .open, age days: Double, member: UUID = Demo.lena) -> FlagDetail { /* private */ }

    @Test("A flag row: its hits in the server's words, its state and dates")
    func decode() throws { /* private */ }

    @Test("The queue: undecided first, then severity, then the oldest")
    func order() { /* private */ }

    @Test("The driver explains their own; a manager decides others' and escalates; the owner takes escalated ones")
    func lifeCycle() async throws { /* private */ }
}
