// Source code is private. This file shows only its types and signatures.

#if DEBUG
    import CoreLocation
    import DDCore
    import DDData
    import Foundation

    /// Stations around wherever the map asks, as the server's cache would answer: one
    /// clearly above the local average, one closed, one far out.
    struct DemoPrices: PriceProvider {
        private static let stations:
            [(brand: String, street: String, north: Double, east: Double, e5: Double, e10: Double, diesel: Double, open: Bool)]

        func prices(latitude: Double, longitude: Double, radiusKm: Double) async throws(SyncFailure) -> PriceArea { /* private */ }
    }
#endif
