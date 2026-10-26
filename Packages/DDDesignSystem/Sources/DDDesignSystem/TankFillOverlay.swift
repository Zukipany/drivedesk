// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

/// Shows the tank-fill animation above the whole app (including the tab bar).
@MainActor @Observable
public final class TankFillPresenter {
    public var current: TankFill?

    public func show(_ fill: TankFill) { /* private */ }

    public init() { /* private */ }
}

/// After saving a fill-up the screen fills like a tank: two waves rise in the fuel's
/// colour (blue or purple for charging) while a card counts up what was added. A full
/// tank fills the screen, a partial one its share. About 3 s; a tap ends it early.
/// With Reduce Motion the liquid doesn't rise or wave; the card just fades in and out.
public struct TankFillOverlay: View {
    public let fill: TankFill
    public let onFinish: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var start

    public var body: some View { /* private */ }

    // MARK: Liquid

    private var colors: (back: Color, front: Color) { /* private */ }

    private func liquid(level: Double, time: Double, height: CGFloat) -> some View { /* private */ }

    // MARK: Card

    private func card(progress: Double) -> some View { /* private */ }

    private func amountText(_ value: Double) -> String { /* private */ }

    private var caption: String { /* private */ }

    private var spokenSummary: String { /* private */ }

    public init(
        fill: TankFill,
        onFinish: @escaping () -> Void
    ) { /* private */ }
}

/// The liquid's surface: a sine wave, filled down to the bottom.
nonisolated private struct Wave: Shape {
    var surface: CGFloat
    var amplitude: Double
    var wavelength: Double
    var phase: Double

    func path(in rect: CGRect) -> Path { /* private */ }
}
