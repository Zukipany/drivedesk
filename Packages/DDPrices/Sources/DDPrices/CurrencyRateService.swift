// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import WidgetKit

/// Keeps `UnitSettings.rates` current with the European Central Bank's euro reference rates
/// (free, no key, about 2 KB). They change once a working day around 16:00 CET, so this asks
/// at most every 6 hours, and only while a currency other than the euro is chosen.
public enum CurrencyRateService {
    public static let url
    public static let minimumInterval: TimeInterval
    private static let lastAttemptKey

    public static func refreshIfNeeded(now: Date = .now, session: URLSession = .shared) async { /* private */ }

    /// "2026-10-16" in Frankfurt, where the reference day is.
    private static func today(_ now: Date) -> String { /* private */ }
}
