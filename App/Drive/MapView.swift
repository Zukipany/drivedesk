// Source code is private. This file shows only its types and signatures.

import CoreLocation
import DDCore
import DDData
import DDDesignSystem
import DDDevice
import MapKit
import SwiftData
import SwiftUI

/// The Map (plan D3): prices around the driver from the server's shared cache, with the
/// company's fuel policy on top. Stations the driver may not use are dimmed with a short
/// reason; the cheapest allowed one within 5 km gets the star. Every station says where its
/// price comes from and how old it is; offline, the last prices stay, clearly marked.
struct MapView: View {
    @Environment(AppSession.self) private var session
    @Query private var assignments: [Assignment]
    @Query private var vehicles: [Vehicle]
    @Query private var policies: [FuelPolicy]
    @Query private var chargingPlans: [CompanyChargingPlan]

    @State private var location
    @State private var authorization
    @State private var area: PriceArea?
    @State private var isLoading
    @State private var loadError: String?
    @State private var fuel: FuelType?
    @State private var camera
    @State private var selectedID: String?
    @State private var showsList
    /// The driver tapped "Use My Location"; the system's answer follows.
    @State private var askedForLocation
    @State private var layerChoice: EnergyLayer?
    @State private var chargePoints: [ChargePoint]
    @State private var chargerSource: ChargePoint.Source?
    @State private var chargeType
    @State private var showsChargerList

    let member: Member

    init(member: Member) { /* private */ }

    /// Munich until the phone knows where it is: the demo company's city.
    static let germany

    private var vehicle: Vehicle? { /* private */ }

    /// The fuels with prices to show: the car's own combustion fuels.
    private var fuels: [FuelType] { /* private */ }
    private var shownFuel: FuelType { /* private */ }
    private var stations: [Station] { /* private */ }

    private var overlay: FuelPolicyCheck.Overlay? { /* private */ }

    private var stats: StationRanking.PriceStats? { /* private */ }

    // MARK: Charging (US-19)

    /// Fuel, charging or both, by what the car takes.
    private var layers: [EnergyLayer] { /* private */ }

    private var layer: EnergyLayer { /* private */ }

    /// The chargers of the chosen kind, priced on the company's cheapest plan where that beats
    /// paying at the pole.
    private var chargers: [ChargePoint] { /* private */ }

    private var cheapestChargerID: String? { /* private */ }

    var body: some View { /* private */ }

    // MARK: Bars

    private var topBar: some View { /* private */ }

    /// Offline, an answer from the server's cache, or no location yet.
    private var banner: (text: String, symbol: String)? { /* private */ }

    @ViewBuilder private var bottomPanel: some View { /* private */ }

    @ViewBuilder private var chargingPanel: some View { /* private */ }

    @ViewBuilder private var fuelPanel: some View { /* private */ }

    // MARK: Loading

    private var needsLocation: Bool { /* private */ }

    /// Asks the system only once the driver has seen why (section 10); starts at once when
    /// the permission is already there.
    private func startIfAllowed() { /* private */ }

    private static func allows(_ status: CLAuthorizationStatus) -> Bool { /* private */ }

    private func load() async { /* private */ }

    private func loadChargers() async { /* private */ }

    private func select(_ station: Station) { /* private */ }

    private func tier(of station: Station) -> StationRanking.Tier? { /* private */ }
}

/// A station on the map: its price badge, dimmed and grey when the policy doesn't allow it,
/// with the star when it's the cheapest allowed one.
private struct StationPin: View {
    let station: Station
    let fuel: FuelType
    let tier: StationRanking.Tier?
    let reason: FuelPolicyCheck.Reason?
    let isStarred: Bool

    var body: some View { /* private */ }
}

/// The selected station: price, why it isn't allowed, where the price comes from and how old
/// it is, and Go to hand the route to Apple Maps.
private struct StationCard: View {
    let station: Station
    let fuel: FuelType
    let reason: FuelPolicyCheck.Reason?
    let isStarred: Bool
    let changedAt: Date?
    let isOffline: Bool
    let close: () -> Void

    var body: some View { /* private */ }

    /// "Tankerkönig · 6 min ago", or offline: "… · kept on this phone".
    private var sourceLine: String { /* private */ }

    private func go() { /* private */ }
}

/// Before the system asks for location: one line on why (section 10).
private struct LocationPrompt: View {
    let isDenied: Bool
    let allow: () -> Void

    var body: some View { /* private */ }
}

/// The stations as a list, cheapest first, with their policy state.
private struct StationList: View {
    let stations: [Station]
    let fuel: FuelType
    let overlay: FuelPolicyCheck.Overlay?
    let area: PriceArea?
    let select: (Station) -> Void

    var body: some View { /* private */ }
}
