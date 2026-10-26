// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import Testing
@testable import DDData

@Suite("Budgets and fuel policy")
struct PolicyTests {
    private let october
    private let november
    private let sites

    private func row(vehicle: UUID, member: UUID, group: UUID?, euros: Int, month: Date? = nil) -> SpendRow { /* private */ }

    @Test("Spent per scope: the company, a group, a car or a person, in the budget's month")
    func spent() { /* private */ }

    @Test("Next month copies this month's budgets, unused money on top when it carries over")
    func copies() { /* private */ }

    @Test("A policy draft round-trips; times are Berlin wall-clock strings")
    func draft() { /* private */ }

    @Test("The preview counts last month's fill-ups the draft would have flagged")
    func preview() { /* private */ }
}
