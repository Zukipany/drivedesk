// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftUI

/// Issuing a virtual card (plan M8): who holds it, whether it's locked to a car, its limits
/// (suggested from the car's tank or battery) and where it pays. `card-issue` makes the
/// person a Stripe cardholder once and sets the limits on the card itself.
struct IssueCardSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var holderID: UUID?
    @State private var vehicleID: UUID?
    @State private var perPayment: Double?
    @State private var daily: Double?
    @State private var monthly: Double?
    @State private var categories: Set<CardCategory>
    @State private var working
    @State private var error: String?

    let member: Member
    let start: IssueStart
    let members: [Member]
    let vehicles: [Vehicle]
    let cards: [CompanyCard]
    let issued: (CompanyCard) -> Void

    init(
        member: Member,
        start: IssueStart,
        members: [Member],
        vehicles: [Vehicle],
        cards: [CompanyCard],
        issued: @escaping (CompanyCard) -> Void
    ) { /* private */ }

    /// Anyone who drives: drivers, managers and the owner; never the accountant.
    private var holders: [Member] { /* private */ }
    private var inService: [Vehicle] { /* private */ }
    private var vehicle: Vehicle? { /* private */ }
    private var suggestion: CardLimits? { /* private */ }

    private var limits: CardLimits { /* private */ }

    private var draft: CardIssue? { /* private */ }

    /// The holder's cards still paying: a second one is allowed (another car), but said.
    private var holderCards: [CompanyCard] { /* private */ }

    var body: some View { /* private */ }

    private func use(_ limits: CardLimits) { /* private */ }

    private func issue() { /* private */ }
}
