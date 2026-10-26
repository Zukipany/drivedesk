// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation

/// Shared networking for all APIs.
/// - Sends a User-Agent: OpenStreetMap's Overpass servers reject anonymous clients (HTTP 406).
/// - Turns non-2xx responses into `HTTPError`, so a 403 from Open Charge Map shows
///   "The server rejected the API key" instead of a JSON decoding error.
public nonisolated enum HTTP {
    public typealias Fetcher = @Sendable (URLRequest) async throws -> Data

    public static let userAgent: String

    public static func data(for request: URLRequest) async throws -> Data { /* private */ }
}

public nonisolated struct HTTPError: LocalizedError, Equatable {
    public let status: Int
    /// First 300 bytes of the response, for debugging. Never shown to users.
    public let body: String

    public var errorDescription: String? { /* private */ }

    public init(
        status: Int,
        body: String
    ) { /* private */ }
}
