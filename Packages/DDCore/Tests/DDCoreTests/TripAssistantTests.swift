// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

@Suite("Trips said to the assistant")
struct TripRequestParserTests {
    private let wednesday

    private func parse(_ text: String) -> TripRequest? { /* private */ }

    private func parts(_ date: Date) -> (Int, Int, Int) { /* private */ }

    @Test("'Tomorrow morning I'm heading to Milan': Milan, tomorrow 8:00, from here")
    func english() throws { /* private */ }

    @Test("German, with a start: 'Morgen früh fahre ich von Augsburg nach Mailand'")
    func german() throws { /* private */ }

    @Test("Times, weekdays and 'from my location'")
    func times() throws { /* private */ }

    @Test("Questions that aren't trips go to Apple Intelligence")
    func notTrips() { /* private */ }
}

@Suite("Choosing a station on the trip map")
struct StationChoiceTests {
    @Test("A chosen station is always a stop; a swapped-out one never")
    func chosenAndAvoided() throws { /* private */ }

    @Test("A chosen station out of reach gives no plan rather than skipping it")
    func unreachableChoice() { /* private */ }
}
