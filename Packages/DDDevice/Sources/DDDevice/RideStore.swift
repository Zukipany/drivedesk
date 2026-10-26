// Source code is private. This file shows only its types and signatures.

import DDPrices
import DDCore
import Foundation
import Observation

/// The recorded drives, on the iPhone only (`rides.json`), newest last.
@MainActor @Observable
final class RideStore {
    static let shared
    /// Kept drives; older ones are dropped.
    static let maxRides

    private(set) var rides: [Ride]
    private let file: URL?

    init(file: URL? = RideStore.defaultFile) { /* private */ }

    nonisolated static var defaultFile: URL? { /* private */ }

    func save(_ ride: Ride) { /* private */ }

    /// Several drives at once (the demo cars' history), in order of their start.
    func save(contentsOf newRides: [Ride]) { /* private */ }

    func delete(_ id: Ride.ID) { /* private */ }

    func deleteAll() { /* private */ }

    /// The car's drives with their analysis, for the engine.
    func analysed(carID: String) -> [(start: Date, km: Double, analysis: RideAnalysis)] { /* private */ }

    private func write() { /* private */ }
}
