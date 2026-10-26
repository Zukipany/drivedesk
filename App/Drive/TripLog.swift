// Source code is private. This file shows only its types and signatures.

import DDCore
import DDData
import DDDesignSystem
import SwiftData
import SwiftUI

#if os(iOS)
    import DDDevice
#endif

/// The driver's trips (US-34, plan section 16): the recorder's state, kilometres the odometer
/// shows but no trip covers, the trips still to classify, then every trip by month. A trip is
/// classified with a swipe or a tap; a business trip needs its purpose and partner, a private
/// one keeps only date and kilometres.
struct TripLogView: View {
    @Environment(AppSession.self) private var session
    @Query private var trips: [LogbookTrip]
    @Query private var fillUps: [FillUp]
    @Query private var vehicles: [Vehicle]
    @Query private var corrections: [TripCorrection]
    @State private var classifying: LogbookTrip?
    @State private var correcting: LogbookTrip?
    @State private var adding: TripDraftStart?
    @State private var error: String?

    let member: Member
    let vehicle: Vehicle?

    init(member: Member, vehicle: Vehicle?) { /* private */ }

    /// The trip as the logbook shows it: a sealed trip with its corrections applied.
    private func corrected(_ trip: LogbookTrip) -> CorrectedTrip { /* private */ }

    private var toClassify: [LogbookTrip] { /* private */ }

    private var classified: [LogbookTrip] { /* private */ }

    private var gaps: [TripGap] { /* private */ }

    private var months: [(start: Date, trips: [LogbookTrip])] { /* private */ }

    private func carName(_ id: UUID) -> String { /* private */ }

    var body: some View { /* private */ }

    /// An open trip is classified; a sealed one only corrected, with a reason.
    private func open(_ trip: LogbookTrip) { /* private */ }

    private func kilometres(_ trips: [LogbookTrip]) -> [TripType: Double] { /* private */ }

    private func classify(_ trip: LogbookTrip, as type: TripType) { /* private */ }
}

/// Where the add sheet starts: empty, or filling a gap.
struct TripDraftStart: Identifiable {
    let id
    var vehicleID: UUID?
    var from: Date?
    var to: Date?
    var km: Int?
}

struct TripRow: View {
    let item: CorrectedTrip
    let car: String

    private var trip: LogbookTrip { /* private */ }

    /// "Leopoldstr. 8" from "Leopoldstr. 8, München": the street is enough in a row.
    private func street(_ address: String?) -> String? { /* private */ }

    private var places: String { /* private */ }

    var body: some View { /* private */ }
}

/// The type, with a lock in front once the trip is sealed.
private struct SealedLabelStyle: LabelStyle {
    let isSealed: Bool

    func makeBody(configuration: Configuration) -> some View { /* private */ }
}

private struct TripMonthHeader: View {
    let start: Date
    let km: [TripType: Double]

    var body: some View { /* private */ }
}

private struct GapRow: View {
    let gap: TripGap
    let add: () -> Void

    var body: some View { /* private */ }
}

/// Classifying a trip: business with purpose and partner, commute, or private.
struct ClassifyTripSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var type: TripType
    @State private var purpose: String
    @State private var partner: String
    @State private var detour: String
    @State private var error: String?

    let trip: LogbookTrip
    let member: Member
    let car: String

    init(trip: LogbookTrip, member: Member, car: String) { /* private */ }

    private var problems: [String] { /* private */ }
    private var isMine: Bool { /* private */ }

    var body: some View { /* private */ }

    private func save() { /* private */ }
}

/// Correcting a sealed trip (US-35): the trip never changes; each changed field becomes a
/// correction with the reason, shown in every export.
struct CorrectTripSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var type: TripType
    @State private var purpose: String
    @State private var partner: String
    @State private var detour: String
    @State private var reason
    @State private var error: String?

    let item: CorrectedTrip
    let member: Member
    let car: String

    init(item: CorrectedTrip, member: Member, car: String) { /* private */ }

    private func clean(_ text: String) -> String? { /* private */ }

    /// Each field that differs from the trip as corrected so far, with its new value.
    private var changes: [(TripCorrectionField, String?)] { /* private */ }

    private var problems: [String] { /* private */ }

    var body: some View { /* private */ }

    private func save() { /* private */ }
}

/// A trip by hand (phone forgotten, or a gap to fill): marked manual in every export.
struct AddTripSheet: View {
    @Environment(AppSession.self) private var session
    @Environment(\.dismiss) private var dismiss
    @State private var vehicleID: UUID?
    @State private var startedAt: Date
    @State private var endedAt: Date
    @State private var km: Double?
    @State private var from
    @State private var to
    @State private var type
    @State private var purpose
    @State private var partner
    @State private var error: String?

    let member: Member
    let vehicles: [Vehicle]
    let trips: [LogbookTrip]
    let fillUps: [FillUp]
    private let bounds: ClosedRange<Date>?

    init(member: Member, start: TripDraftStart, vehicles: [Vehicle], trips: [LogbookTrip], fillUps: [FillUp]) { /* private */ }

    private var problems: [String] { /* private */ }

    var body: some View { /* private */ }

    private func add() { /* private */ }
}

#if os(iOS)
    /// Trip recording on this phone: the switch, a trip running now, and starting one by hand.
    private struct RecorderCard: View {
        @Environment(AppSession.self) private var session
        @State private var isOn
        @State private var isRecording
        @State private var km
        let member: Member

        var body: some View { /* private */ }
    }

    /// Turns the phone's recorded trips into logbook trips for the driver's assigned car.
    @MainActor
    enum TripLogger {
        private static var started

        static func start(session: AppSession, member: Member) { /* private */ }

        private static func assignedVehicle(of member: Member, in context: ModelContext) -> Vehicle? { /* private */ }

        private static func log(_ recorded: RecordedTrip, session: AppSession, member: Member) async { /* private */ }
    }
#endif
