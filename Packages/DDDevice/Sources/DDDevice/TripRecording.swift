// Source code is private. This file shows only its types and signatures.

#if os(iOS)
    import CoreLocation
    import DDCore
    import MapKit

    /// A trip the phone recorded, ready for the logbook: when, how far, and where it started and
    /// ended (the two points only; the route stays on the phone and is never uploaded).
    public nonisolated struct RecordedTrip: Equatable, Sendable {
        public let companyID: String?
        public let carID: String
        public let startedAt: Date
        public let endedAt: Date
        public let km: Double
        public let start: Spot?
        public let end: Spot?

        public struct Spot: Equatable, Sendable {
            public let latitude: Double
            public let longitude: Double
        }
    }

    /// The logbook's view of the ride recorder (US-34, plan section 16): it starts when the
    /// phone joins the car's CarPlay or Bluetooth, or by hand, and ends on disconnect or after
    /// standing still. Off until the driver turns it on; GPS distance only, no live position
    /// leaves the phone.
    @MainActor
    public enum TripRecording {
        /// The driver's switch, kept on the phone.
        public static var isEnabled: Bool {
            get { /* private */ }
            set { /* private */ }
        }

        public static var isRecording: Bool { /* private */ }
        public static var currentKm: Double { /* private */ }

        /// Starts watching for trips. `car` names the car for a linked car ID, or the driver's
        /// assigned car for nil; `onTrip` gets every kept trip.
        public static func start(
            car: @escaping @MainActor (_ linkedID: String?) -> (companyID: String?, carID: String, name: String)?,
            onTrip: @escaping @MainActor (RecordedTrip) -> Void
        ) { /* private */ }

        public static func stop() { /* private */ }

        /// A trip started by hand, without CarPlay or Bluetooth.
        public static func beginByHand() { /* private */ }

        public static func finishByHand() { /* private */ }

        /// "Leopoldstraße 8, München": the place at a trip's start or end, looked up on the phone.
        public static func address(of spot: RecordedTrip.Spot) async -> String? { /* private */ }
    }
#endif
