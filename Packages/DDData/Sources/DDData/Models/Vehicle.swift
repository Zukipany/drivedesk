// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A company car (`public.vehicles`), grown from iDrive's `Vehicle`: it gains the plate,
    /// the group, the list price for the 1 % rule and the lease fields, and its fuels become
    /// the server's `fuel_types` array. A driver's phone holds the cars assigned to them;
    /// managers see the whole fleet.
    @Model
    public final class Vehicle {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        /// Every car belongs to a group from day one ("Site Munich").
        public var groupID: UUID
        public var plate: String
        /// What drivers call it: "Caddy 1".
        public var name: String
        public var vin: String?
        public var make: String
        public var modelName: String
        public var year: Int?
        /// Every fuel and charging type the car takes, the usual one first (`fuel_types`).
        public var fuelTypesRaw: [String]
        public var tankLitres: Double?
        public var batteryKWh: Double?
        /// Gross list price for the 1 % rule, in cents.
        public var listPriceGrossCents: Int?
        public var ownershipRaw: String
        /// The last day of the lease (a date without time, 00:00 UTC).
        public var leaseEnd: Date?
        public var isPoolCar: Bool
        public var statusRaw: String
        /// The Wallet-style pass: DDCore's `CarColor` and `BodyType` raw values.
        public var colorRaw: String?
        public var bodyTypeRaw: String?
        public var lastOdometerKm: Int?
        /// The cut-out photo. It stays on this device until car photos sync.
        @Attribute(.externalStorage) public var photo: Data?

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            groupID: UUID,
            plate: String,
            name: String = "",
            make: String = "",
            modelName: String = "",
            year: Int? = nil,
            fuelTypes: [FuelType],
            tankLitres: Double? = nil,
            batteryKWh: Double? = nil,
            listPriceGrossCents: Int? = nil,
            ownership: VehicleOwnership = .owned,
            leaseEnd: Date? = nil,
            isPoolCar: Bool = false,
            status: VehicleStatus = .active,
            color: CarColor? = nil,
            bodyType: BodyType? = nil,
            lastOdometerKm: Int? = nil,
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

extension Vehicle: SyncedRecord {
    /// The fuels as the server lists them, unknown values left out.
    public var fuelTypes: [FuelType] {
        get { /* private */ }
        set { /* private */ }
    }

    /// Battery-electric: it only charges.
    public var isBatteryElectric: Bool { /* private */ }

    /// Tanks fuel and charges too.
    public var isPlugInHybrid: Bool { /* private */ }

    /// The car's main energy: its usual fuel, or AC charging for a battery-electric car.
    public var fuelType: FuelType { /* private */ }

    /// The fuels this car tanks, the usual one first; empty for battery-electric cars. As in
    /// iDrive, fuels of another kind than the first are dropped, so petrol and diesel never mix.
    public var fuels: [FuelType] { /* private */ }

    /// Everything this car may tank or charge: its fuels, then the charging types. Drives the
    /// default map filter and the fuel choice when logging.
    public var energyTypes: [FuelType] { /* private */ }

    /// The energy this car mostly uses: electric for EVs, fuel otherwise.
    public var mainLayer: EnergyLayer { /* private */ }

    public var ownership: VehicleOwnership {
        get { /* private */ }
        set { /* private */ }
    }

    public var status: VehicleStatus {
        get { /* private */ }
        set { /* private */ }
    }

    public var bodyType: BodyType? {
        get { /* private */ }
        set { /* private */ }
    }

    public var carColor: CarColor? {
        get { /* private */ }
        set { /* private */ }
    }

    /// "Volkswagen Caddy Cargo 2023".
    public var subtitle: String { /* private */ }

    /// Litres for fuel, kWh for charging; nil when not set.
    public func capacity(for fuel: FuelType) -> Double? { /* private */ }

    /// The gross list price in euros, for the 1 % rule.
    public var listPriceGross: Double? { /* private */ }
}
