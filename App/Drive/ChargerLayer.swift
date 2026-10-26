// Source code is private. This file shows only its types and signatures.

import CoreLocation
import DDCore
import DDDesignSystem
import DDPrices
import MapKit
import SwiftUI

/// Where the map's chargers come from (plan section 15): the country's official feed
/// (MobiData BW in Germany) with Open Charge Map and OpenStreetMap behind it, or the demo's.
protocol ChargerSource: Sendable {
    func chargers(near coordinate: CLLocationCoordinate2D, radiusKm: Double) async throws -> ChargeMapService.Result
}

/// iDrive's charger service, straight from the public feeds.
struct LiveChargers: ChargerSource {
    let service

    func chargers(near coordinate: CLLocationCoordinate2D, radiusKm: Double) async throws -> ChargeMapService.Result { /* private */ }
}

/// A charger on the map: its price on the company's plan when that beats the card at the
/// pole, the star for the cheapest.
struct ChargerPin: View {
    let charger: ChargePoint
    let isCheapest: Bool

    var body: some View { /* private */ }
}

/// The selected charger: what it costs on the company's plan against paying at the pole,
/// its power and free points, and Go.
struct ChargerCard: View {
    let charger: ChargePoint
    let isCheapest: Bool
    let close: () -> Void

    var body: some View { /* private */ }

    /// "EnBW · 150 kW · 0.8 km"
    private var details: String { /* private */ }

    private func go() { /* private */ }
}

/// The chargers as a list, cheapest first on the company's plans.
struct ChargerList: View {
    let chargers: [ChargePoint]
    let cheapestID: String?
    let select: (ChargePoint) -> Void

    var body: some View { /* private */ }
}

#if DEBUG
    /// The demo's chargers around wherever the map is: the networks a Munich driver meets,
    /// with ad-hoc prices as their AFIR feeds published them in October 2026.
    struct DemoChargers: ChargerSource {
        private static let sites:
            [(operator: String, site: String, north: Double, east: Double, kW: Double, dc: Bool, price: Double, free: Int, total: Int)]

        func chargers(near coordinate: CLLocationCoordinate2D, radiusKm: Double) async throws -> ChargeMapService.Result { /* private */ }
    }
#endif
