// Source code is private. This file shows only its types and signatures.

#if os(iOS)
    import DDPrices
    import DDCore
    import AVFoundation
    import CoreLocation
    import Observation

    /// Records drives for the consumption engine, when the driver switched "Learn from My
    /// Drives" on (off by default: it's a location history, kept on the iPhone only).
    ///
    /// Which car: the one whose CarPlay or Bluetooth the iPhone is connected to (`CarConnection`,
    /// linked once in the Drive Lab); otherwise the active car.
    /// When: as soon as a recognised car connects; otherwise after 30 seconds above 20 km/h. It ends
    /// when that car disconnects, or after 3 minutes standing still or without a position. Once
    /// started it keeps recording in the background (the blue location indicator shows). The app
    /// isn't woken by the car itself: it's open, or a Shortcuts automation ("When CarPlay connects:
    /// Start Recording a Drive") opens it.
    @MainActor @Observable
    final class RideRecorder {
        static let shared

        static let enabledKey
        /// Above this, for `startAfter`, the iPhone is in a moving car.
        static let startKmh
        static let startAfter: TimeInterval
        /// Standing (or no position) this long ends the drive.
        static let endAfter: TimeInterval
        /// Shorter drives aren't kept.
        static let minimumKm

        private(set) var isRecording
        private(set) var isMonitoring
        private(set) var current: Ride?
        private(set) var lastSpeedKmh: Double?
        private(set) var lastEvent
        /// The current drive's distance so far, for the live card.
        private(set) var currentKm

        var isEnabled: Bool { /* private */ }

        /// The car with this ID, or the driver's assigned car for nil (set by the app).
        @ObservationIgnored var car: @MainActor (_ id: String?) -> RecordingCar?
        /// Each kept drive with its analysis, for the logbook (set by the app).
        @ObservationIgnored var onDrive: @MainActor (Ride, RideAnalysis) -> Void

        @ObservationIgnored private let connection
        @ObservationIgnored private var updates: Task<Void, Never>?
        @ObservationIgnored private var background: CLBackgroundActivitySession?
        @ObservationIgnored private var fastSince: Date?
        @ObservationIgnored private var slowSince: Date?
        @ObservationIgnored private var lastKept: Ride.Point?
        /// Ends a drive when the positions stop coming (the iPhone stands still in a parked car).
        @ObservationIgnored private var watchdog: Task<Void, Never>?
        @ObservationIgnored private var lastUpdate

        private var isTesting: Bool { /* private */ }

        // MARK: Monitoring

        /// Starts watching for drives (when the app becomes active and the switch is on).
        func startMonitoring() { /* private */ }

        func stopMonitoring() { /* private */ }

        // MARK: Car connections

        /// A car connecting starts its drive at once; the one it was recorded for disconnecting ends it.
        private func connectionChanged(from old: CarConnection.Port?, to new: CarConnection.Port?) { /* private */ }

        // MARK: Detection

        private func handle(_ location: CLLocation) { /* private */ }

        /// Starts a drive: from the speed, a car connecting, a Shortcut, or by hand in the Drive Lab.
        /// - Parameter recognition: how the drive started; nil picks the car from the connection.
        func begin(with point: Ride.Point? = nil, recognition: Ride.Recognition? = nil) { /* private */ }

        /// Ends the drive: kept when it was long enough.
        func finish(at date: Date) { /* private */ }
    }
#endif
