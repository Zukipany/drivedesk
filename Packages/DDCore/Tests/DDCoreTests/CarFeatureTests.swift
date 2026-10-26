// Source code is private. This file shows only its types and signatures.

import Foundation
import Testing
@testable import DDCore

@Suite("Car catalog")
struct CarCatalogTests {
    let catalog

    @Test("The bundled list loads and every entry is usable")
    func loads() { /* private */ }

    @Test(
        "Makes match short names, case and accents",
        arguments: [
            ("vw", "Volkswagen"), ("mer", "Mercedes-Benz"), ("sko", "Škoda"), ("TES", "Tesla")
        ]
    )
    func makes(typed: String, make: String) { /* private */ }

    @Test("Models: full list per make, A–Z, filtered by what's typed")
    func models() { /* private */ }

    @Test("The model list covers every make and model that has typical values")
    func listCoversCatalog() { /* private */ }

    @Test("Generations for one model, newest first")
    func generations() { /* private */ }

    @Test("The year picks the generation", arguments: [(2018, "Golf 7"), (2022, "Golf 8")])
    func generation(year: Int, generation: String) { /* private */ }

    @Test("Without a year, the newest generation is used")
    func newestGeneration() { /* private */ }
}

@Suite("Odometer reader")
struct OdometerReaderTests {
    @Test("Clock, temperature and trip meter are ignored")
    func ignoresOtherNumbers() { /* private */ }

    @Test(
        "Thousands separators: space, dot or none",
        arguments: [
            ("123 456 km", 123456), ("123.456 km", 123456), ("ODO 98765", 98765)
        ]
    )
    func separators(line: String, value: Int) { /* private */ }

    @Test("Largest first, and readings below the last fill-up are dropped")
    func ordering() { /* private */ }
}

@Suite("Car colour")
struct CarColorTests {
    @Test(
        "Measured photo colours map to paint names",
        arguments: [
            ((0.12, 0.12, 0.13), CarColor.black), ((0.76, 0.77, 0.80), .silver), ((0.96, 0.96, 0.95), .white),
            ((0.45, 0.47, 0.50), .grey), ((0.15, 0.32, 0.65), .blue), ((0.75, 0.12, 0.12), .red),
            ((0.90, 0.47, 0.15), .orange), ((0.18, 0.40, 0.24), .green)
        ] as [((Double, Double, Double), CarColor)]
    )
    func nearest(rgb: (Double, Double, Double), expected: CarColor) { /* private */ }

    @Test("Light paints get an outline on a light card")
    func outline() { /* private */ }
}
