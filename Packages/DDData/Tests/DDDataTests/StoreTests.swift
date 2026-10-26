// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData
import Testing
@testable import DDData

@Suite("Device-made IDs")
struct UUIDv7Tests {
    @Test("Version 7 with the RFC variant, carrying the time to the millisecond")
    func layout() throws { /* private */ }

    @Test("Later IDs sort after earlier ones, as Postgres orders them")
    func ordering() { /* private */ }

    @Test("A thousand IDs in the same millisecond are all different")
    func unique() { /* private */ }
}

@Suite("Local store")
struct LocalStoreTests {
    @Test("The versioned schema holds every cached table")
    func schema() { /* private */ }

    @Test("Two in-memory stores never share rows")
    func separateStores() throws { /* private */ }

    @Test("A row saved with an ID that exists replaces it: an upload retried twice stays one row")
    func uniqueIDs() throws { /* private */ }

    @Test("A store on disk keeps its rows when it is opened again")
    func reopens() throws { /* private */ }
}

@Suite("Calendar days")
struct CalendarDaysTests {
    @Test("A budget month is Berlin's: 00:30 on 1 November in Berlin is November")
    func monthStart() { /* private */ }

    @Test("Days are stored as 00:00 UTC, so they never move with the time zone")
    func storage() { /* private */ }

    @Test("The month's interval runs from Berlin midnight to Berlin midnight")
    func interval() { /* private */ }
}
