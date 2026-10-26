// Source code is private. This file shows only its types and signatures.

#if os(iOS)
    import DDPrices
    import DDCore
    import AVFoundation
    import Observation

    /// Which car the iPhone is in, from what it's connected to. When the iPhone joins a car's
    /// CarPlay (wired or wireless) or its Bluetooth hands-free, iOS routes audio there and tells
    /// apps the port's name ("BMW 41532": BMW puts the VIN's last five digits there) and a stable
    /// id. That's all iOS shares about the car (no VIN, no fuel level), and it's enough.
    ///
    /// Each Garage car gets one connection, linked once and kept until it's removed (with a
    /// confirmation) or the car is deleted: the first time an unknown CarPlay connects, iDrive
    /// asks which car it is. The link is by name, and keeps every id seen with that name: wired
    /// and wireless CarPlay and the hands-free each carry their own id. A connection linked to one
    /// car can't be given to another.
    ///
    /// Needs no permission. CarPlay always means a car; Bluetooth counts only once linked, since it
    /// could be headphones.
    @MainActor @Observable
    final class CarConnection {
        static let shared

        /// One connection, as iOS reports it.
        nonisolated struct Port: Codable, Equatable, Sendable {
            enum Kind: String, Codable, Sendable {
                case carPlay, bluetooth
            }

            let kind: Kind
            let name: String
            let uid: String
        }

        /// A car's own connection, kept on the iPhone.
        nonisolated struct Link: Codable, Equatable, Identifiable, Sendable {
            /// "BMW 41532"
            let name: String
            /// How it first connected.
            let kind: Port.Kind
            /// Every id seen with this name for this car.
            var uids: [String]
            /// The car's ID in the local store.
            let carID: String
            let linkedAt: Date

            var id: String { /* private */ }
        }

        /// Why a link was refused.
        enum LinkError: Error, Equatable {
            /// The car already has its connection.
            case carHasConnection
            /// The connection belongs to another car.
            case connectionTaken
        }

        private static let linksKey
        private static let ignoredKey
        /// Links before one per car (one per port id).
        private static let portLinksKey
        /// The recorder's links before that (uid → car).
        private static let oldLinksKey

        /// What the iPhone is connected to now; nil when it's no car.
        private(set) var port: Port?
        private(set) var links: [Link]
        /// Connections the owner said aren't one of their cars: not asked about again.
        private(set) var ignored: Set<String>
        /// The simulator has no car audio: the Drive Lab can pretend one.
        var simulated: Port? {
            didSet { /* private */ }
        }
        /// Called when a car connects or disconnects (the recorder starts and ends drives).
        @ObservationIgnored var onChange: (_ old: Port?, _ new: Port?) -> Void
        @ObservationIgnored private var observer: NSObjectProtocol?
        @ObservationIgnored private let defaults: UserDefaults

        init(defaults: UserDefaults = .standard) { /* private */ }

        /// Older links: one per port id, then the recorder's uid → car. A car keeps its first one
        /// and the ids that share that one's name.
        private func migrate() { /* private */ }

        /// Watches the audio route from now on.
        func start() { /* private */ }

        /// Reads the route: CarPlay first, then a Bluetooth car audio or hands-free port.
        func refresh() { /* private */ }

        /// The connection counts as a car: CarPlay, or a Bluetooth port linked to one.
        var isCar: Bool { /* private */ }

        /// The car a connection belongs to: by its id, or else by its name when only one car has
        /// that name (two cars both called "MB Bluetooth" are told apart by id only).
        func link(for port: Port) -> Link? { /* private */ }

        func link(forCar carID: String) -> Link? { /* private */ }

        /// The car the current connection is linked to.
        var linkedCarID: String? { /* private */ }

        /// A CarPlay connection no car has yet, not set aside: DriveDesk asks which car it is.
        var unknownCarPlay: Port? { /* private */ }

        /// Links the connection to the car, for good. Refused when the car already has its
        /// connection or the connection's id belongs to another car.
        func link(_ port: Port, toCar carID: String, now: Date = .now) throws(LinkError) { /* private */ }

        /// "Not one of my cars": DriveDesk doesn't ask about this connection again.
        func ignore(_ port: Port) { /* private */ }

        /// Removes the car's link (after the owner confirmed, or when the car is deleted).
        func unlink(carID: String) { /* private */ }

        /// Drops the links of cars that no longer exist.
        func prune(keeping carIDs: Set<String>) { /* private */ }

        /// The same car over another path (wireless instead of wired, or its hands-free) carries
        /// its own id but the same name: remembered with the car's link.
        private func learn(_ port: Port) { /* private */ }

        private func save() { /* private */ }
    }

    /// Guesses which Garage car a connection belongs to, from its name: cars name their CarPlay and
    /// Bluetooth after the brand ("BMW 41532", "VW BT 1234", "MB Bluetooth", "Audi MMI 0815").
    nonisolated enum CarMatcher {
        struct Candidate: Equatable, Sendable {
            let id: String
            let name: String
            let make: String
            let model: String
        }

        /// Short names the cars use for themselves.
        static let aliases: [String: [String]]

        /// The candidate whose make, model or name appears in `portName`; nil when none or a tie.
        static func best(for portName: String, among cars: [Candidate]) -> Candidate? { /* private */ }

        private static func normalized(_ text: String) -> String { /* private */ }
    }
#endif
