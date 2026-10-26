// Source code is private. This file shows only its types and signatures.

import Foundation
import SwiftData

extension DDSchemaV1 {
    /// A passed yearly driver instruction (`public.instruction_completions`, US-40, DGUV
    /// Vorschrift 1): the module version, the quiz result and the signature.
    @Model
    public final class InstructionCompletion {
        @Attribute(.unique) public var id: UUID
        public var companyID: UUID
        public var memberID: UUID
        public var moduleVersion: String
        public var completedAt: Date
        public var correct: Int
        public var questions: Int
        /// The signature's strokes as JSON: `[[[x, y], …], …]`, points between 0 and 1.
        public var signatureJSON: String

        public var version: Int
        public var updatedAt: Date?
        public var syncStateRaw: String

        public init(
            id: UUID = .v7(),
            companyID: UUID,
            memberID: UUID,
            moduleVersion: String,
            completedAt: Date = .now,
            correct: Int,
            questions: Int,
            signature: [[SignaturePoint]],
            version: Int = 0,
            updatedAt: Date? = nil,
            syncState: SyncState = .pending
        ) { /* private */ }
    }
}

/// A point of a signature, both coordinates between 0 and 1.
public nonisolated struct SignaturePoint: Codable, Equatable, Sendable {
    public var x: Double
    public var y: Double

    public init(x: Double, y: Double) { /* private */ }
}

/// Signatures as stored: strokes of `[x, y]` pairs rounded to a thousandth.
public nonisolated enum Signature {
    public static func json(_ strokes: [[SignaturePoint]]) -> String { /* private */ }

    public static func strokes(_ json: String) -> [[SignaturePoint]] { /* private */ }

    static func value(_ json: String) -> JSONValue { /* private */ }

    static func json(from value: JSONValue?) -> String { /* private */ }
}

extension InstructionCompletion: SyncedRecord {
    public var signature: [[SignaturePoint]] { /* private */ }
    public var passedShare: Double { /* private */ }
}

public typealias InstructionCompletion = DDSchemaV1.InstructionCompletion
