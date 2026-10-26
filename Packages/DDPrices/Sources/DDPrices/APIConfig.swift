// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation

/// API keys injected at build time: Config.xcconfig / Secrets.xcconfig → Info.plist → here.
/// A key inside an app binary can still be extracted. That's acceptable for a course app;
/// a public release should route requests through a small backend.
public nonisolated enum APIConfig {
    public static let tankerkoenigDemoKey

    public static var tankerkoenigKey: String { /* private */ }
    public static var openChargeMapKey: String { /* private */ }
    /// Optional: without it, US and Canadian chargers use NREL's DEMO_KEY (10 requests an hour).
    public static var nrelKey: String { /* private */ }

    /// The demo key returns fake prices; the UI says so.
    public static var usesTankerkoenigDemoKey: Bool { /* private */ }

    public static func value(for key: String) -> String { /* private */ }
}
