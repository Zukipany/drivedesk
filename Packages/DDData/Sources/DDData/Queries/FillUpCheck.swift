// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation

/// The checks before a fill-up is saved (plan D7, from iDrive's FillUpRules): the odometer
/// must fit between the car's readings before and after the date, the amount must fit the
/// tank plus 5 %, and a receipt's fuel must be one the car takes (the picker only offers
/// those). A failed check explains itself in one line; the driver corrects it or saves with
/// a note for the desk.
public nonisolated enum FillUpCheck {
    public enum Issue: Equatable, Sendable {
        /// The last reading before this date was higher.
        case odometerBelow(Int)
        /// A later fill-up has a lower reading.
        case odometerAbove(Int)
        /// More than the tank holds, plus 5 %.
        case exceedsTank(Double)
        /// The receipt shows a fuel the car doesn't take (also a fraud signal for the desk).
        case fuelNotForCar(FuelType)

        public var message: String { /* private */ }
    }

    /// The share above the tank's size a fill-up may have: tanks hold a little more than
    /// the brochure says, and the filler neck takes some.
    public static let tankTolerance

    public static func issues(
        fuel: FuelType,
        quantity: Double,
        odometer: Int?,
        on date: Date,
        vehicle: Vehicle,
        entries: [FillUp],
        receiptFuel: FuelType? = nil
    ) -> [Issue] { /* private */ }
}

/// Where a fill-up's receipt is: on the server, on its way, or still missing.
public nonisolated enum ReceiptStatus: Equatable, Sendable {
    /// Nothing to show and nothing asked for.
    case none
    /// Photographed here and waiting for the next sync.
    case uploading
    /// In the bucket.
    case attached
    /// A card payment without a photo yet (plan D6: "Needs receipt").
    case needed
}

extension FillUp {
    public var receiptStatus: ReceiptStatus { /* private */ }
}
