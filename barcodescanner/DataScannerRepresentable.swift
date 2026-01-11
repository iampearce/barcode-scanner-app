//
//  DataScannerRepresentable.swift
//  barcodescanner
//
//  Created by George Pearce on 11/01/2026.
//

import SwiftUI
import VisionKit
import Vision

struct DataScannerRepresentable: UIViewControllerRepresentable {
    let onBarcodeScanned: (String, String) -> Void

    static var supportedSymbologies: [VNBarcodeSymbology] {
        [
            // 1D Barcodes
            .ean8,
            .ean13,
            .upce,
            .code39,
            .code39Checksum,
            .code39FullASCII,
            .code39FullASCIIChecksum,
            .code93,
            .code93i,
            .code128,
            .itf14,
            .i2of5,
            .i2of5Checksum,
            .codabar,
            .gs1DataBar,
            .gs1DataBarExpanded,
            .gs1DataBarLimited,
            .msiPlessey,
            // 2D Barcodes
            .qr,
            .aztec,
            .dataMatrix,
            .pdf417,
            .microPDF417,
            .microQR,
        ]
    }

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let scanner = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: Self.supportedSymbologies)],
            qualityLevel: .balanced,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        scanner.delegate = context.coordinator
        return scanner
    }

    func updateUIViewController(_ scanner: DataScannerViewController, context: Context) {
        if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
            if !scanner.isScanning {
                try? scanner.startScanning()
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onBarcodeScanned: onBarcodeScanned)
    }

    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        let onBarcodeScanned: (String, String) -> Void
        private var hasScanned = false

        init(onBarcodeScanned: @escaping (String, String) -> Void) {
            self.onBarcodeScanned = onBarcodeScanned
        }

        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            guard !hasScanned else { return }
            guard let item = addedItems.first else { return }

            if case .barcode(let barcode) = item {
                guard let value = barcode.payloadStringValue, !value.isEmpty else { return }
                let symbology = barcode.observation.symbology.rawValue

                hasScanned = true
                dataScanner.stopScanning()

                DispatchQueue.main.async {
                    self.onBarcodeScanned(value, symbology)
                }
            }
        }

        func reset() {
            hasScanned = false
        }
    }
}
