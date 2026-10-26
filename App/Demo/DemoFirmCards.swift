// Source code is private. This file shows only its types and signatures.

#if DEBUG
    import DDCore
    import DDData
    import Foundation
    import SwiftData

    /// The firm's DriveDesk Cards: a virtual card for most drivers, locked to their car, one
    /// for Petra's pool cars, Julia's frozen since she lost her phone, David's old Touran card
    /// cancelled with the car; Sofia asking for one. The balance is topped up by transfer each
    /// month, and every card payment of the last 60 days took from it.
    extension DemoFirm {
        private struct Issued {
            let suffix: String
            let person: Person
            let car: Car?
            let last4: String
            let limits: CardLimits
            var status: CardStatus
            var categories: [CardCategory]
            let issuedDaysAgo: Double
        }

        private static let issued: [Issued]

        private static func limits(_ payment: Int, _ day: Int, _ month: Int) -> CardLimits { /* private */ }

        static func cards(now: Date) -> [CompanyCard] { /* private */ }

        /// The cards in memory as one of the firm's people, with the balance and its history.
        static func cardService(in context: ModelContext, now: Date, as member: Member) -> LocalCardService { /* private */ }

        /// Every card payment of the last 60 days as an approval taken from the balance, the
        /// monthly top-ups, and the balance they leave.
        private static func balance(cards: [CompanyCard], in context: ModelContext, now: Date) -> (CardBalance, [BalanceMovement]) { /* private */ }
    }
#endif
