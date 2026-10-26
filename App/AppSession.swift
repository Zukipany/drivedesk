// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import Foundation
import Observation

/// What every window shares: the local store, the backend, who is signed in and the sync
/// engine. Made once at launch; screens read it from the environment.
@Observable
final class AppSession {
    let store: LocalStore
    let backend: Backend
    let auth: AuthService
    let sync: SyncEngine
    let setup: any CompanySetup
    /// The receipts bucket: receipt photos and home-charging meter photos.
    let receiptFiles: any ReceiptFileStore

    /// The first pull after signing in is running, so "no company yet" doesn't flash up for
    /// someone who has one.
    private(set) var isLoadingCompanies
    /// Fuel prices around a point: the server's shared cache, or the demo's stations.
    var prices: any PriceProvider

    /// New fill-ups from the server while the desk is open; nil in the demo, which has no server.
    var live: LiveUpdates?

    /// The desk's numbers: the server's views, or the demo's store.
    var desk: any DeskSource

    /// Chargers for the map: the public feeds, or the demo's.
    var chargers: any ChargerSource

    /// Flags: read from the server and moved on by its functions, or kept in memory in the demo.
    var flags: any FlagService

    /// Invitations: sent by the server's function, or kept in memory in the demo.
    var invitations: any InvitationService

    /// The audit log: the server's trail, or the demo's own changes.
    var audit: any AuditSource

    /// The DriveDesk Card: read from the server and changed by its card functions, or kept
    /// in memory in the demo.
    var cards: any CardService

    /// The tax rules for the 1 % rule comparison: the server's table, or the demo's.
    var benefitRules: any BenefitRuleSource

    /// The documents bucket: Supabase Storage, or memory in the demo.
    var documentFiles: any DocumentFileStore

    /// Fetches car documents once and keeps them on the phone.
    var documentKeeper: DocumentKeeper { /* private */ }

    /// The tank-fill animation after saving a fill-up, drawn above the whole app.
    let tankFill

    /// An invitation link that opened the app; the company setup or a sheet accepts it.
    var pendingInvitation: String?
    /// Any other link that opened the app, followed once someone is signed in.
    var pendingLink: DeepLink?

    /// The company the person works in now; someone in two companies switches on Today.
    var selectedCompanyID: UUID? {
        didSet { /* private */ }
    }

    private let defaults: UserDefaults
    private static let companyKey

    init(
        configuration: BackendConfiguration = BackendConfiguration(bundle: .main) ?? .localDevelopment,
        storeLocation: LocalStore.Location = .standard,
        sessionStore: KeychainStore = KeychainStore(),
        defaults: UserDefaults = .standard
    ) { /* private */ }

    /// The store on disk. If it can't be opened (a damaged file), it starts again empty: it
    /// is only a cache of the server, and unsent changes can't be read from it either way.
    private static func openStore(_ location: LocalStore.Location) -> LocalStore { /* private */ }

    private var started

    /// Follows the kept session and asks the server which sign-in methods it offers.
    func start() async { /* private */ }

    /// Right after signing in: pull the person's companies before deciding what to show.
    func loadCompanies() async { /* private */ }

    /// App start, back to the foreground, pull to refresh (section 9).
    func refresh() async { /* private */ }

    /// A link that opened the app (the deep-link router, section 10): the email link finishes
    /// signing in, an invitation waits to be accepted, and any other link waits for the
    /// navigation to follow it. Returns false for a link that isn't DriveDesk's.
    @discardableResult
    func open(_ url: URL) async throws(SignInError) -> Bool { /* private */ }

    func createCompany(_ company: NewCompany) async throws(SetupError) { /* private */ }

    func acceptInvitation(_ token: String, memberName: String) async throws(SetupError) { /* private */ }

    /// Saves a new row on this device at once and syncs it when the network allows (section 9).
    func log<R: SyncRecord>(_ record: R, by role: MemberRole) throws { /* private */ }

    /// Edits a row on this device and queues the change.
    func update<R: SyncRecord>(_ record: R, by role: MemberRole, _ edit: (R) -> Void) throws { /* private */ }

    private func afterLocalChange() { /* private */ }

    func signOut() async { /* private */ }
}

extension AppSession {
    /// Previews and screenshots: an in-memory store, nobody signed in.
    static func preview() -> AppSession { /* private */ }
}
