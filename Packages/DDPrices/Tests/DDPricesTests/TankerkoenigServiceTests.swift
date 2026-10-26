// Source code is private. This file shows only its types and signatures.

import CoreLocation
import Foundation
import Testing
@testable import DDPrices
import DDCore

/// Counts network calls instead of hitting Tankerkönig.
private actor FakeNetwork {
    private(set) var calls

    func respond() -> Data { /* private */ }
}

/// Mutable time for tests. Only changed between awaited calls, never concurrently.
nonisolated private final class TestClock: @unchecked Sendable {
    var now
    func advance(_ seconds: TimeInterval) { /* private */ }
}

@Suite("Tankerkönig fair use")
struct TankerkoenigServiceTests {
    private let munich
    private let network
    private let clock

    private func makeService() -> TankerkoenigService { /* private */ }

    @Test("A second call within 5 minutes is served from cache")
    func cachesFiveMinutes() async throws { /* private */ }

    @Test("Pull-to-refresh within 60 s doesn't hit the network (1 request/minute)")
    func rateLimitsForcedRefresh() async throws { /* private */ }

    @Test("Expired cache fetches again")
    func cacheExpires() async throws { /* private */ }

    /// Regression: the first version rounded to a 0.01° grid, and these two points
    /// (~50 m apart) landed in different cells and caused a second request.
    @Test("Small GPS moves reuse the cache, even across a grid line")
    func smallMovesReuseCache() async throws { /* private */ }

    @Test("Moving more than 500 m fetches the new area")
    func bigMoveFetches() async throws { /* private */ }
}
