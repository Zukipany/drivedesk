// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A fill-up or a charge (`public.fillups`), grown from iDrive's `FillUp`: where every
    /// euro ends up. Money is integer cents and prices are milli-euro (1.759 €/l is 1759), as
    /// on the server, so nothing is lost to floating point on the way. It points at its car
    /// and member by ID: a driver's phone may hold fill-ups of a pool car it no longer sees.
    @Model
    public final class FillUp {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var vehicleID: UUID
        public var memberID: UUID
        public var filledAt: Date
        public var fuelTypeRaw: String
        /// Litres or kWh.
        public var quantity: Double
        /// €/l or €/kWh in milli-euro.
        public var unitPriceMilli: Int?
        public var amountGrossCents: Int
        public var vatCents: Int?
        public var odometerKm: Int?
        public var isFullTank: Bool
        /// How full the tank or battery was afterwards, 0…1; nil when unknown.
        public var levelAfter: Double?
        public var stationID: String?
        public var stationName: String?
        public var stationBrand: String?
        /// The one position DriveDesk keeps: where the fill-up happened (ADR 005).
        public var latitude: Double?
        public var longitude: Double?
        /// The average price nearby when it was logged, in milli-euro, for savings.
        public var nearbyAverageMilli: Int?
        public var sourceRaw: String
        /// The receipt in the company's private bucket, once uploaded.
        public var receiptPath: String?
        /// The receipt photo until it is uploaded (section 9: files go separately).
        @Attribute(.externalStorage) public var receiptImage: Data?
        public var costCentre: String?
        public var note: String?
        /// Soft delete: rows with money meaning are never removed, so exports stay reproducible.
        public var deletedAt: Date?

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            vehicleID: UUID,
            memberID: UUID,
            filledAt: Date,
            fuelType: FuelType,
            quantity: Double,
            unitPriceMilli: Int? = nil,
            amountGrossCents: Int,
            vatCents: Int? = nil,
            odometerKm: Int? = nil,
            isFullTank: Bool = true,
            levelAfter: Double? = nil,
            stationID: String? = nil,
            stationName: String? = nil,
            stationBrand: String? = nil,
            latitude: Double? = nil,
            longitude: Double? = nil,
            nearbyAverageMilli: Int? = nil,
            source: FillUpSource = .manual,
            receiptPath: String? = nil,
            costCentre: String? = nil,
            note: String? = nil,
            deletedAt: Date? = nil,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

extension FillUp: SyncedRecord {
    public var fuelType: FuelType {
        get { /* private */ }
        set { /* private */ }
    }

    /// A charge is electric, a fill-up isn't (the server checks the same).
    public var kind: FillUpKind { /* private */ }

    public var source: FillUpSource {
        get { /* private */ }
        set { /* private */ }
    }

    public var isDeleted: Bool { /* private */ }
}

/// The ported maths (consumption, savings, spending) works on any `FuelEntry`, in euros.
extension FillUp: FuelEntry {
    public var date: Date { /* private */ }
    public var amount: Double { /* private */ }
    public var total: Double { /* private */ }
    /// The stored price, or the total over the quantity, to three decimals as in MTS-K.
    public var pricePerUnit: Double { /* private */ }
    public var odometer: Int { /* private */ }
    public var tankLevelAfter: Double? { /* private */ }
    public var nearbyAveragePrice: Double? { /* private */ }
}
