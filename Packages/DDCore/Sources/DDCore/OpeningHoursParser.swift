// Source code is private. This file shows only its types and signatures.

import Foundation

/// Opening hours from the price sources, for "open when you get there" (measure 3a).
public nonisolated enum OpeningHoursParser {
    /// E-Control: one entry per day ("MO" … "SO", "FE" for holidays), "07:00"–"19:00".
    /// "00:00"–"00:00" means closed that day, "00:00"–"24:00" all day.
    public static func eControl(_ days: [(day: String, from: String, to: String)]) -> Trip.OpeningHours? { /* private */ }

    /// Spain's "Horario": "L-D: 24H", "L-D: 06:00-22:00", "L-V: 07:00-21:30; S: 08:00-14:00".
    /// Days: L M X J V S D (Monday … Sunday). Anything else stays unknown.
    public static func spain(_ text: String?) -> Trip.OpeningHours? { /* private */ }

    /// German motorway service stations (Tank & Rast "BAB", "Rastanlage") and truck stops
    /// ("Autohof") are open day and night; Tankerkönig's list has no hours for the rest.
    public static func isMotorwayStation(name: String, brand: String) -> Bool { /* private */ }

    /// "07:00" or "7.30" → minutes after midnight; "24:00" is 1,440.
    public static func minutes(_ text: String) -> Int? { /* private */ }
}
