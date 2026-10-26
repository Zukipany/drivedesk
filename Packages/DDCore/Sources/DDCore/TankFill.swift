// Source code is private. This file shows only its types and signatures.

import Foundation

/// The tank-fill animation after a fill-up or charge is saved: the screen fills like a
/// tank, in the colour of the fuel.
public nonisolated struct TankFill: Identifiable, Equatable, Sendable {
    public let id
    public let fuel: FuelType
    public let amount: Double
    public let total: Double
    public let isFull: Bool
    /// 0…1: how high the liquid rises.
    public let level: Double
    /// l/100 km (or kWh/100 km) this fill-up showed, if it gave a reading.
    public var consumption: Double?

    public init(fuel: FuelType, amount: Double, total: Double, isFull: Bool, capacity: Double?, consumption: Double? = nil) { /* private */ }

    /// A full tank fills the whole screen. A partial fill rises to its share of the tank
    /// (or battery), at least a third so it's visible and never quite to the top.
    public static func level(amount: Double, capacity: Double?, isFull: Bool) -> Double { /* private */ }

    /// Timeline of the animation, in seconds after it starts.
    public enum Timing {
        /// Lets the form sheet slide away first.
        public static let delay
        public static let rise
        public static let hold
        public static let fade
        public static var total: Double { /* private */ }
    }

    /// Ease-in-out: starts gently, rises steadily, settles at the top, so the rise is
    /// visible (an ease-out did 80 % of it in the first third).
    public static func easedRise(_ t: Double) -> Double { /* private */ }
}
