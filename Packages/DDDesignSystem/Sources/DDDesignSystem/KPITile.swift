// Source code is private. This file shows only its types and signatures.

import Charts
import SwiftUI

/// One number on the desk overview (plan M1): a title, the value, a line of detail, the
/// change against last period, and a sparkline of the months before. Whether a rise is good
/// depends on the number (savings up is good, spend up isn't), so the tile is told; the
/// arrow and the words carry the meaning, the colour only repeats it.
public struct KPITile: View {
    public let title: String
    public let symbol: String
    public let value: String
    public var detail: String?
    /// The change against last period as a share (0.12 = 12 % more); the tile says "than
    /// last month", so the caller compares like with like (a forecast, a rate).
    public var change: Double?
    /// Whether a rise is good news; nil when neither is.
    public var riseIsGood: Bool?
    public var sparkline: [Double]
    public var tone: StatusTone?

    public var body: some View { /* private */ }

    public init(
        title: String,
        symbol: String,
        value: String,
        detail: String? = nil,
        change: Double? = nil,
        riseIsGood: Bool? = nil,
        sparkline: [Double] = [],
        tone: StatusTone? = nil
    ) { /* private */ }
}

/// "▲ 12 % against last month", green or red when the direction is good or bad news.
private struct ChangeLabel: View {
    let change: Double
    let riseIsGood: Bool?

    private var isGood: Bool? { /* private */ }

    var body: some View { /* private */ }
}
