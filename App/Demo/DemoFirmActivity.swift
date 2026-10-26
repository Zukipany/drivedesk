// Source code is private. This file shows only its types and signatures.

#if DEBUG
    import DDCore
    import DDData
    import Foundation
    import SwiftData

    /// What happened in the firm lately: flags in every state, invitations waiting and the
    /// weeks before the demo opens as the audit log has them.
    extension DemoFirm {
        /// The cars' latest fill-up, for flags about it.
        private static func latest(_ car: Car, in context: ModelContext) -> UUID? { /* private */ }

        /// Flags in every state of the life cycle: open, explained, escalated to the owner, one
        /// about a manager (the owner's to decide), and decided ones for the history.
        static func flags(in context: ModelContext, now: Date) -> [FlagDetail] { /* private */ }

        /// Two invitations waiting: a driver Marco invited, a manager Sabine invited.
        static func invitations(now: Date) -> [(company: UUID, row: InvitationRow)] { /* private */ }

        /// The weeks before the demo opens, as the audit log has them.
        static func auditHistory(now: Date) -> [AuditEntry] { /* private */ }
    }
#endif
