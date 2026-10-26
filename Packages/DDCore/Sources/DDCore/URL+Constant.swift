// Source code is private. This file shows only its types and signatures.

import Foundation

nonisolated extension URL {
    /// One of the app's fixed API addresses. They're constants, and the API tests build
    /// every request from them, so an invalid one is a programming error.
    public init(constant address: StaticString) { /* private */ }
}
