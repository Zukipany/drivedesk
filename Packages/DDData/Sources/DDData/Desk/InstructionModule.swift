// Source code is private. This file shows only its types and signatures.

import Foundation

/// The yearly driver instruction (US-40, plan section 18): a ten-minute module of short cards
/// and a quiz drawn from its questions. The text must be reviewed by an occupational safety
/// specialist before launch (section 30); a changed module gets a new version, and records
/// keep the version each driver completed.
public nonisolated struct InstructionModule: Sendable {
    public struct Card: Sendable, Identifiable {
        public let id: String
        public let symbol: String
        public let title: String
        public let text: String
    }

    public struct Question: Sendable, Identifiable {
        public let id: String
        public let prompt: String
        /// The first option is the right one; the quiz shuffles them.
        public let options: [String]
    }

    public let version: String
    public let cards: [Card]
    public let questions: [Question]

    /// How many questions a quiz asks, and the share to pass.
    public static let quizLength
    public static let passShare

    public static func passed(correct: Int, of questions: Int) -> Bool { /* private */ }

    /// A quiz: eight questions in a new order each try, their options shuffled too.
    public func quiz(seed: UInt64) -> [QuizQuestion] { /* private */ }

    public struct QuizQuestion: Sendable, Identifiable, Equatable {
        public let id: String
        public let prompt: String
        public let options: [String]
        public let answer: Int
    }

    /// The module as it stands for 2026.
    public static let current
}

/// The driver's instruction status (US-40): due a year after the last, from joining when never.
public nonisolated struct InstructionStatus: Equatable, Sendable {
    public var lastCompletedAt: Date?
    public var moduleVersion: String?
    public var dueOn: Date
    /// Days until due; negative when overdue.
    public var daysLeft: Int

    public var isDue: Bool { /* private */ }

    public static func of(member: UUID, joinedOn: Date, completions: [InstructionCompletion], today: Date) -> InstructionStatus { /* private */ }
}

/// A small seeded generator, so a quiz's order is reproducible in tests.
public nonisolated struct SeededGenerator: RandomNumberGenerator {
    var state: UInt64

    public init(state: UInt64) { /* private */ }

    public mutating func next() -> UInt64 { /* private */ }
}
