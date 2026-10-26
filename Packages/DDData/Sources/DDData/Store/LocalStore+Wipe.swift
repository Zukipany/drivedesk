// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension LocalStore {
    /// Signing out: every company's rows leave this device. The store's files are deleted,
    /// not only its rows, so nothing is left in the database's free pages (section 9).
    public func wipe() throws { /* private */ }

    /// Removed from one company: that company's rows leave this device, the others stay.
    public func wipe(companyID: UUID) throws { /* private */ }
}
