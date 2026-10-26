// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// One car as a Wallet-style pass in its own paint colour. In the Garage stack only the
/// top strip (`stripHeight`) of a car behind the front one shows, so the strip carries
/// what tells cars apart: the name and the energy.
public struct CarPass: View {
    /// What the pass shows, as plain values: the driver's assigned car, a car in the desk's
    /// register, or a demo car.
    public struct Car: Equatable, Sendable {
        public var name: String
        public var fuelType: FuelType
        public var isBatteryElectric
        public var isPlugInHybrid
        public var make
        public var modelName
        public var version: String?
        public var year
        /// km on the clock, when known.
        public var odometer: Double?
        /// The company's number plate, shown under the model.
        public var plate: String?
        public var color: CarColor?
        public var bodyType: BodyType?
        /// The cut-out photo (JPEG or PNG).
        public var photo: Data?
        /// The badge on the face: "Active" in a driver's own garage, "Assigned" for a company car.
        public var badge: String

        public init(
            name: String,
            fuelType: FuelType,
            isBatteryElectric: Bool = false,
            isPlugInHybrid: Bool = false,
            make: String = "",
            modelName: String = "",
            version: String? = nil,
            year: Int = 0,
            odometer: Double? = nil,
            plate: String? = nil,
            color: CarColor? = nil,
            bodyType: BodyType? = nil,
            photo: Data? = nil,
            badge: String = String(localized: "Active")
        ) { /* private */ }
    }

    public let vehicle: Car
    /// Shows the photo and details: the front card, and the old one while the new one slides
    /// over it. Cards further back show only their paint below the strip, so the bit of them
    /// that shows for a moment while cards move has no photo or text on it.
    public let showsFace: Bool
    /// Height of the top strip, which is all that shows of a card further back.
    public let stripHeight: Double

    private var paint: CarPaint { /* private */ }

    /// "Diesel", "Electric", "Plug-in Hybrid": the label at the top right, like "Debit" on a bank card.
    private var energyLabel: String { /* private */ }

    public var body: some View { /* private */ }

    private var strip: some View { /* private */ }

    public init(
        vehicle: Car,
        showsFace: Bool,
        stripHeight: Double
    ) { /* private */ }
}

/// The photo and details under the strip. A view of its own, so a card coming to the front
/// only fades it in: the odometer reads every fill-up, and working it out again stalled the
/// start of the slide.
private struct PassFace: View {
    let vehicle: CarPass.Car
    let paint: CarPaint

    private var makeAndModel: String { /* private */ }

    var body: some View { /* private */ }

    /// The cut-out photo, or the body style in the card's ink.
    @ViewBuilder private var picture: some View { /* private */ }

    /// Bottom left, like the name and number on a bank card. The face shows only on the
    /// front card, so it always carries the label: not only the position says it's active.
    private var details: some View { /* private */ }
}

/// The card's colours, worked out from the car's paint.
public struct CarPaint {
    public let rgb: (red: Double, green: Double, blue: Double)
    public let isLight: Bool

    public init(_ color: CarColor?) { /* private */ }

    /// Text and symbols: black on light paints, white on the rest.
    public var ink: Color { /* private */ }

    /// Light falls from the top left like on lacquer, with a soft sheen across the card.
    public var surface: some View { /* private */ }

    /// A light card would melt into a light screen without an edge.
    public var edge: Color { /* private */ }

    private func shade(_ factor: Double) -> Color { /* private */ }
}

extension Image {
    /// An image from JPEG or PNG data, on iPhone, iPad and Mac.
    public init?(data: Data) { /* private */ }
}

extension CarPass.Car {
    /// A diesel estate from the demo company.
    public static let preview
}
