// Source code is private. This file shows only its types and signatures.

#if os(iOS)
    import SwiftUI
    import VisionKit

    /// VisionKit's document camera, from iDrive: edge detection and perspective correction
    /// for free. Not in the Simulator; the capture falls back to the photo library there.
    struct DocumentScanner: UIViewControllerRepresentable {
        /// The first page as a JPEG at full quality; `ReceiptPhoto` shrinks it.
        let onScan: (Data) -> Void
        let onCancel: () -> Void

        static var isAvailable: Bool { /* private */ }

        func makeUIViewController(context: Context) -> VNDocumentCameraViewController { /* private */ }

        func updateUIViewController(_ controller: VNDocumentCameraViewController, context: Context) { /* private */ }

        func makeCoordinator() -> Coordinator { /* private */ }

        final class Coordinator: NSObject, @MainActor VNDocumentCameraViewControllerDelegate {
            let onScan: (Data) -> Void
            let onCancel: () -> Void

            init(onScan: @escaping (Data) -> Void, onCancel: @escaping () -> Void) { /* private */ }

            func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) { /* private */ }

            func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) { /* private */ }

            func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: any Error) { /* private */ }
        }
    }
#endif
