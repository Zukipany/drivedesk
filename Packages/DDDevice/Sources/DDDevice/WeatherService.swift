// Source code is private. This file shows only its types and signatures.

import DDPrices
import DDCore
import Foundation

/// The forecast along a route from Open-Meteo, in one request (measure 5b).
enum WeatherService {
    /// The samples with their weather, or nil offline or when the forecast fails: the plan
    /// then uses the season, and says so.
    static func forecast(_ samples: [TripWeather.Sample], fetch: HTTP.Fetcher = HTTP.data(for:)) async -> [TripWeather.Sample]? { /* private */ }
}
