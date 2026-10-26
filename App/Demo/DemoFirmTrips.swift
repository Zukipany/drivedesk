// Source code is private. This file shows only its types and signatures.

#if DEBUG
    import DDCore
    import DDData
    import Foundation
    import SwiftData

    /// The logbook of the firm's company cars for the last six weeks (US-34): between every two
    /// fill-ups the trips add up to what the odometer says, a commute most mornings, customer
    /// visits during the day, now and then a private trip on Saturday. Older trips are
    /// classified, this week's partly not; Lena's Caddy misses 37 km once, so her gap task shows.
    extension DemoFirm {
        private struct Book {
            let car: Car
            let home: String
            let commuteKm: Double
        }

        private static let logbooks: [Book]

        private static func office(_ site: Site) -> String { /* private */ }

        /// Customers and suppliers near each site: where, who, and what for.
        private static func visits(_ site: Site) -> [(place: String, partner: String, purpose: String)] { /* private */ }

        /// Every logbook car's trips between its fill-ups of the last six weeks.
        static func trips(into context: ModelContext, now: Date) { /* private */ }

        /// The workshop board: a tyre warning on the Caddy and a stuck charging flap on the ID.4
        /// waiting, the Sprinter's clutch in the workshop (the car is there), a scratch on the
        /// Polo, and the Transporter's UVV defect and the Model 3's cleaning fixed. Drivers do
        /// the daily check.
        private static func workshop(_ context: ModelContext, now: Date) { /* private */ }

        /// This year's instruction, mostly early in the year: Lena's is due in eight days, so her
        /// Today asks; Julia hasn't been instructed yet.
        private static func instructions(_ context: ModelContext, now: Date) { /* private */ }

        /// Last year's inspection for every car in service, a year before its UVV reminder: the
        /// Caddy's is three days overdue, the i4's due in two days, the eSprinter's in eighteen.
        /// Cars without a reminder yet get one a year after their inspection.
        private static func uvvInspections(_ context: ModelContext, now: Date) { /* private */ }

        /// Licence checks every six months, mostly in order: Jonas is due in nine days, Lukas is
        /// twenty days overdue (so the desk offers the letter) and Julia has never been checked.
        private static func licenceChecks(_ context: ModelContext, now: Date) { /* private */ }

        /// Home charging at the flat rate this year: last month approved for most, Petra's (a
        /// manager's, so the owner's to decide) waiting, Aylin's more than her van needs, David's
        /// rejected; Tom hasn't claimed yet, so his Today asks. The month before is all approved.
        private static func homeCharging(_ context: ModelContext, now: Date) { /* private */ }

        /// This year's lease, insurance and tax for four of the logbook cars; the Ranger's are
        /// still missing, so the comparison asks for them.
        private static func fixedCosts(_ context: ModelContext, now: Date) { /* private */ }

        /// Seals what's older than a week, as the server does nightly, and corrects one of Lena's
        /// sealed trips so the logbook shows a correction inline.
        private static func sealAndCorrect(_ context: ModelContext, now: Date) { /* private */ }

        private struct DayPlan {
            let start: Date
            let km: Double
            let from: String?
            let to: String?
            let type: TripType
            var purpose: String?
            var partner: String?
            var manual
        }

        /// The trips of the days between two fill-ups: weekdays a commute and one to three
        /// visits, Saturdays sometimes a private trip, Sundays nothing.
        private static func dayPlans(from: Date, to: Date, book: Book, dice: inout Dice) -> [DayPlan] { /* private */ }
    }
#endif
