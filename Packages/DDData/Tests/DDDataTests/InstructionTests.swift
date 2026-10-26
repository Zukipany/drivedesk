// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDData

@Suite("Driver instruction")
struct InstructionTests {
    @Test("A quiz asks eight different questions, shuffled, with the right answer tracked")
    func quiz() { /* private */ }

    @Test("80 % passes: 7 of 8 does, 6 of 8 doesn't")
    func passMark() { /* private */ }

    @Test("A signature survives the trip to the server and back")
    func signature() throws { /* private */ }

    @Test("Due a year after the last instruction, or from joining")
    func status() { /* private */ }
}
