// Source code is private. This file shows only its types and signatures.

import DDCore
import SwiftUI

/// Floating fuel chips over the map. These are controls, so Liquid Glass is correct here.
/// Selection is shown by a checkmark as well as the tint (Differentiate Without Color),
/// labels stay `.primary` for contrast, and every chip is a real Button with 44 pt height.
///
/// Three sizes: none (collapsed), the active car's fuels, or every fuel in a scrolling row.
/// The chips morph between them. The car's row also keeps any other fuel picked from the
/// full row, so a choice made there stays in view after closing it (`MapScreen` resets the
/// choice to the car's fuels after 5 minutes or when another car becomes active). Collapsed, the
/// summary chip is drawn by the map's top bar, between the trip and location buttons, and the
/// chips' row shrinks away (`MapTopBar`).
public struct FuelFilterBar: View {
    public enum Mode {
        case compact, car, all
    }

    @Binding public var selected: Set<FuelType>
    /// The active car's fuels and charging; empty without a car.
    public let carFuels: [FuelType]
    /// Every chip the map offers here (Premium only where its price is reported), in order.
    public var available: [FuelType]
    @Binding public var mode: Mode
    /// The chips' own width, so the map's top bar can tell whether the location button fits
    /// next to them.
    public var onContentWidth: (CGFloat) -> Void

    @Namespace private var namespace

    /// The car's row: its fuels plus any other fuel that's selected.
    private var carRow: [FuelType] { /* private */ }

    /// "Your car" only means something when the car doesn't already use every fuel.
    private var effectiveMode: Mode { /* private */ }

    /// Compact: none (the map's top bar shows the summary chip). Car: its row. All: every one.
    private var shownFuels: [FuelType] { /* private */ }

    public var body: some View { /* private */ }

    // MARK: Chips

    private func chip(_ fuel: FuelType) -> some View { /* private */ }

    /// "+ 3": the fuels not in the car's row. Short, so an electric car's [‹] [AC] [DC] [+ 4]
    /// or a diesel car's row leaves room for the location button in the corner.
    private var moreChip: some View { /* private */ }

    private func collapseButton(to target: Mode) -> some View { /* private */ }

    private func setMode(_ newMode: Mode) { /* private */ }

    /// Keeps at least one fuel selected so the map is never empty by accident.
    private func toggle(_ fuel: FuelType) { /* private */ }

    public init(
        selected: Binding<Set<FuelType>>,
        carFuels: [FuelType],
        available: [FuelType] = FuelType.mapFilters,
        mode: Binding<Mode>,
        onContentWidth: @escaping (CGFloat) -> Void = { _ in }
    ) { /* private */ }
}

/// Symbol and title closer together than `Label`'s default, for the compact "+ 3" chip.
private struct TightLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View { /* private */ }
}

/// The selected fuels in one chip: "Diesel + Premium". Tapping shows the chips again.
public struct FuelSummaryChip: View {
    public let selected: Set<FuelType>
    public let expand: () -> Void

    public var body: some View { /* private */ }

    public init(
        selected: Set<FuelType>,
        expand: @escaping () -> Void
    ) { /* private */ }
}
