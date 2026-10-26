// Source code is private. This file shows only its types and signatures.

import Foundation

/// The official fuel price databases the map can read, one per country. Each is free,
/// keyless (except Tankerkönig) and run or mandated by that country's government; the UK's
/// are its retailers' own feeds under the CMA's scheme.
///
/// Checked on 16 Oct 2026; see docs/api-research.md for the ones left out (the UK's Fuel
/// Finder with a developer registration, Romania's Monitorul Prețurilor, unreachable…).
public nonisolated enum FuelPriceSource: String, CaseIterable, Sendable {
    /// Germany: Tankerkönig, a free relay of the MTS-K (Bundeskartellamt), live, key needed.
    case tankerkoenig
    /// Austria: E-Control's Spritpreisrechner, live. By law it lists the cheapest stations
    /// near a point (10 per fuel, prices for the cheapest 5).
    case eControl
    /// France: prix-carburants (Ministère de l'Économie), updated every 10 minutes.
    case prixCarburants
    /// Spain: Geoportal Gasolineras (Ministerio para la Transición Ecológica), every 30 minutes.
    case minetur
    /// Italy: MIMIT's Osservaprezzi Carburanti, live.
    case mimit
    /// Portugal: DGEG's Preços dos Combustíveis Online, per district.
    case dgeg
    /// Slovenia: goriva.si.
    case goriva
    /// Croatia: the Ministry of Economy's national price file.
    case croatia
    /// The UK: Asda's, Esso's, MFG's and JET's open price feeds (a part of the stations).
    case ukRetailers

    /// The source for a country (ISO 3166 region code), or nil where the app has none.
    public init?(regionCode: String) { /* private */ }

    public static let supportedRegions

    /// False when the list holds only some stations (Austria's cheapest, the UK's retailers
    /// with a feed). Its average would mislead, so fill-ups don't compare against it.
    public var listsAllStations: Bool { /* private */ }

    /// True where stations report a real premium diesel price. Elsewhere (Germany, Austria,
    /// France) it could only be estimated, so the map doesn't offer it there.
    public var reportsPremiumDiesel: Bool { /* private */ }

    /// Fuel cards in the app are German programs (ADAC, Shell ClubSmart in Germany…).
    public var appliesFuelCards: Bool { /* private */ }

    /// Required attribution, linked under the list and on each station.
    public var attribution: String { /* private */ }

    public var shortAttribution: String { /* private */ }

    public var url: URL { /* private */ }

    /// A short note on what the list leaves out, shown under it; nil when nothing.
    public var note: String? { /* private */ }

    /// "Germany, Austria, France, Spain, …" in the user's language.
    public static var supportedCountries: String { /* private */ }
}
