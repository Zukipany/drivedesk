// Source code is private. This file shows only its types and signatures.

import DDPrices
import DDCore
import Foundation

/// The car a drive is recorded for, as the app knows it: whose it is and which one.
nonisolated struct RecordingCar: Equatable, Sendable {
    /// The company the car belongs to; nil for a private car.
    var companyID: String?
    /// The car's ID in the local store (a vehicle row ID).
    var carID: String
    var name: String
}

extension Ride {
    /// A new drive for `car`, carrying its company and car IDs into the logbook. Without a
    /// car (none assigned, nothing linked) the drive is kept but belongs to no car.
    nonisolated static func started(
        for car: RecordingCar?,
        recognition: Recognition,
        audioPort: String? = nil,
        audioUID: String? = nil,
        at point: Point? = nil
    ) -> Ride { /* private */ }
}
