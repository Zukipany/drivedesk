// Source code is private. This file shows only its types and signatures.

import Foundation
import DDCore

/// Fixed calendar so tests don't depend on the machine's locale or time zone.
nonisolated let berlin: Calendar

nonisolated func day(_ year: Int, _ month: Int, _ day: Int) -> Date { /* private */ }

nonisolated func isClose(_ a: Double?, _ b: Double, tolerance: Double = 0.001) -> Bool { /* private */ }
