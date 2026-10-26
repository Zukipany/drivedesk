// Source code is private. This file shows only its types and signatures.

import DDPrices
import DDCore
import CoreLocation
import Observation

/// Current location via `CLLocationUpdate.liveUpdates()`.
///
/// On iPhone and iPad `CLServiceSession` asks for When-In-Use permission the first time `start()` runs,
/// so permission is requested in context (when the map appears), not at launch.
@MainActor @Observable
public final class LocationService {
    public private(set) var location: CLLocation?
    public private(set) var isDenied

    public init() { /* private */ }

    /// Ignore moves smaller than this so GPS jitter doesn't trigger new price requests.
    private let minimumMove: CLLocationDistance
    #if os(iOS)
        private var session: CLServiceSession?
    #endif
    private var updates: Task<Void, Never>?

    public func start() { /* private */ }

    /// The unit tests run inside the app; they must not trigger a permission prompt.
    private static let isRunningTests

    public func stop() { /* private */ }
}
