// Source code is private. This file shows only its types and signatures.

import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

/// The driver's licence check on Today (US-38): from 14 days before it's due until a manager
/// has seen the licence.
struct LicenceDueCard: View {
    @Query private var checks: [LicenceCheck]
    let member: Member

    init(member: Member) { /* private */ }

    private var status: LicenceStatus { /* private */ }

    var body: some View { /* private */ }
}
