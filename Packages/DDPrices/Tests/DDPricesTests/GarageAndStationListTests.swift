// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDPrices
import DDCore

/// Answers requests from a script, recording them.
private actor ScriptedNetwork {
    private var responses: [Swift.Result<Data, URLError>]
    private(set) var requests: [URLRequest]

    init(_ responses: [Swift.Result<Data, URLError>]) { /* private */ }

    func respond(_ request: URLRequest) throws -> Data { /* private */ }
}

nonisolated private final class ManualClock: @unchecked Sendable {
    var now
}

nonisolated private let pricesJSON

@Suite("Tankerkönig offline and favourites")
struct TankerkoenigOfflineTests {
    private let munich
    private let clock

    private func service(_ network: ScriptedNetwork) -> TankerkoenigService { /* private */ }

    @Test("Offline: older prices stand in, marked with why")
    func staleFallback() async throws { /* private */ }

    @Test("Offline with nothing cached is an error")
    func noFallback() async { /* private */ }

    @Test("Favourite prices share the one-request-per-minute limit")
    func pricesRateLimit() async throws { /* private */ }

    @Test("At most 10 stations per prices request")
    func pricesCap() async throws { /* private */ }
}
