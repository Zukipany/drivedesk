// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

/// The local store's first schema (plan section 9: SwiftData `VersionedSchema` with a
/// migration plan; the server keeps numbered SQL migrations). It mirrors the subset of
/// Postgres a person may see, so the same model names exist on both sides: Swift `Vehicle`
/// is table `vehicles`. A change to a stored property after the first release goes into a
/// new `DDSchemaV2` with a stage in `DDMigrationPlan`, never into this one.
public enum DDSchemaV1: VersionedSchema {
    public static let versionIdentifier

    public static var models: [any PersistentModel.Type] { /* private */ }
}

/// Every schema the app has shipped, oldest first, and how to move between them.
public enum DDMigrationPlan: SchemaMigrationPlan {
    public static var schemas: [any VersionedSchema.Type] { /* private */ }
    public static var stages: [MigrationStage] { /* private */ }
}

public typealias Company = DDSchemaV1.Company
public typealias Member = DDSchemaV1.Member
public typealias Vehicle = DDSchemaV1.Vehicle
public typealias Assignment = DDSchemaV1.Assignment
public typealias FillUp = DDSchemaV1.FillUp
public typealias Budget = DDSchemaV1.Budget
