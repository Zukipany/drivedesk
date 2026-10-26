// Source code is private. This file shows only its types and signatures.

import CoreGraphics
import Foundation
import ImageIO

/// A car's paper as the bucket keeps it: always a PDF. A PDF comes through as it is; a photo
/// or scan (JPEG, PNG, HEIC) becomes one A4 page with the image fitted in.
public nonisolated enum DocumentPDF {
    /// A4 in points.
    static let page

    public static func make(from data: Data) -> Data? { /* private */ }
}

/// Puts a document's file in the bucket (US-27): the desk uploads, then saves the path on the
/// row. Uploading needs the network; the row goes up through the outbox as usual.
public struct DocumentUploader {
    let files: any DocumentFileStore

    public init(files: any DocumentFileStore) { /* private */ }

    /// Uploads the file for `document` and returns the path to keep on its row, with the PDF
    /// kept on this device as well.
    public func upload(_ data: Data, for document: VehicleDocument) async throws(SyncFailure) -> (path: String, pdf: Data) { /* private */ }
}

/// The documents bucket in memory: the demo. Links point at a temporary file.
public final class LocalDocumentStore: DocumentFileStore, @unchecked Sendable {
    private let lock
    private var files: [String: Data]

    public init(files: [String: Data] = [:]) { /* private */ }

    public func download(_ path: String) async throws(SyncFailure) -> Data { /* private */ }

    public func upload(_ pdf: Data, to path: String) async throws(SyncFailure) { /* private */ }

    public func link(to path: String, validFor seconds: Int) async throws(SyncFailure) -> URL { /* private */ }
}
