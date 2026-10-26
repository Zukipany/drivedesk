// Source code is private. This file shows only its types and signatures.

#if DEBUG
    import CoreGraphics
    import CoreText
    import DDCore
    import DDData
    import Foundation
    import SwiftData

    /// The simulated firm behind every demo and screenshot: Elektro Huber GmbH, an electrical
    /// contractor with three sites around Munich, 16 vehicles of every kind (small car,
    /// saloon, estate, SUV, van, pickup, coupé and convertible; petrol, diesel, premium
    /// diesel, electric and plug-in hybrid; company cars, pool cars, one in the workshop and
    /// one retired) and 13 people in every role, with 13 months of fill-ups and charges.
    /// Deterministic, so screenshots look the same every time.
    enum DemoFirm {
        static func id(_ suffix: String) -> UUID { /* private */ }

        static let company
        static let name

        // MARK: Sites

        struct Site {
            let id: UUID
            let name: String
            let costCentre: String
            let city: String
        }

        static let munich
        static let augsburg
        static let rosenheim
        static let sites

        // MARK: People

        struct Person {
            let id: UUID
            let user: UUID
            let name: String
            let role: MemberRole
            let site: UUID?
            let joinedDaysAgo: Double
            let personnelNumber: String
        }

        static let sabine
        static let marco
        static let petra
        static let kanzlei
        static let lena
        static let tom
        static let sofia
        static let david
        static let jonas
        static let aylin
        static let maxSchneider
        static let lukas
        static let julia

        static let people

        static func drivers(at site: UUID) -> [Person] { /* private */ }

        // MARK: Vehicles

        struct Car {
            let id: UUID
            let name: String
            let plate: String
            let make: String
            let model: String
            let year: Int
            let body: BodyType
            let color: CarColor
            let fuels: [FuelType]
            let tank: Double?
            let battery: Double?
            let site: Site
            /// Nil for a pool car.
            let driver: Person?
            let status: VehicleStatus
            let ownership: VehicleOwnership
            let leaseEnd: (Int, Int)?
            let startKm: Int
            let monthlyKm: Int
            /// l or kWh per 100 km.
            let consumption: Double
            let listPrice: Int

            var isPool: Bool { /* private */ }
            var charges: Bool { /* private */ }
            var burns: FuelType? { /* private */ }
        }

        static let caddy
        static let passat
        static let id4
        static let x5
        static let model3
        static let i4
        static let fiat
        static let touran
        static let transporter
        static let esprinter
        static let golf
        static let enyaq
        static let ranger
        static let sprinter
        static let polo
        static let mini

        static let cars

        // MARK: Seeding

        /// A small linear congruential generator: the same "random" numbers on every launch.
        struct Dice {
            var state: UInt64

            mutating func next() -> Double { /* private */ }

            mutating func between(_ low: Double, _ high: Double) -> Double { /* private */ }

            mutating func pick<T>(_ items: [T]) -> T { /* private */ }
        }

        static func stations(at site: Site) -> [String] { /* private */ }

        static func chargers(at site: Site) -> [String] { /* private */ }

        /// Seeds the whole firm into an empty store.
        static func seed(into context: ModelContext, now: Date) { /* private */ }

        /// Fill-ups and charges month by month for 13 months: as many as the car's distance and
        /// consumption need, spread over the month, this month up to now.
        private static func history(of car: Car, now: Date, dice: inout Dice, into context: ModelContext) { /* private */ }

        /// Lena's three fill-ups this month, as Today and the receipt checks show them; the last
        /// one still waits to upload.
        private static func lenasMonth(now: Date, into context: ModelContext) { /* private */ }

        /// Pool cars lent out this month, one of them right now.
        private static func poolBookings(now: Date, into context: ModelContext) { /* private */ }

        private static func budgets(now: Date, into context: ModelContext) { /* private */ }

        /// Due dates and papers: some soon, some overdue, the workshop car's service late.
        private static func careAndPapers(day: (Int) -> Date, into context: ModelContext) { /* private */ }

        private static func costs(day: (Int) -> Date, into context: ModelContext) { /* private */ }

        private static func chargingCards(into context: ModelContext) { /* private */ }

        /// The seeded rows are the server's: a change made in the demo is an edit, not a new row.
        static func markSynced(_ context: ModelContext) { /* private */ }

        /// A one-page PDF with a title and a few lines, so demo documents open offline.
        static func samplePDF(title: String, lines: [String]) -> Data { /* private */ }
    }
#endif
