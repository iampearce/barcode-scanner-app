//
//  ContentView.swift
//  barcodescanner
//
//  Created by George Pearce on 11/01/2026.
//

import SwiftUI
import SwiftData

enum AppViewState: Equatable {
    case scanning
    case showingResult(ScannedBarcode)

    static func == (lhs: AppViewState, rhs: AppViewState) -> Bool {
        switch (lhs, rhs) {
        case (.scanning, .scanning):
            return true
        case (.showingResult(let a), .showingResult(let b)):
            return a.id == b.id
        default:
            return false
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewState: AppViewState = .scanning
    @State private var cameraId = UUID()
    @State private var showSuccessBorder = false
    @State private var showHistory = false

    var body: some View {
        ZStack {
            switch viewState {
            case .scanning:
                ScannerView(
                    cameraId: $cameraId,
                    showSuccessBorder: showSuccessBorder,
                    onBarcodeScanned: handleBarcodeScan,
                    onHistoryTapped: { showHistory = true }
                )

            case .showingResult(let barcode):
                ResultView(
                    barcode: barcode,
                    onScanAgain: returnToScanner
                )
            }
        }
        .sheet(isPresented: $showHistory) {
            HistoryView()
        }
    }

    private func handleBarcodeScan(value: String, symbology: String) {
        showSuccessBorder = true
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        UIPasteboard.general.string = value

        let barcode = ScannedBarcode(value: value, symbology: symbology)
        modelContext.insert(barcode)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showSuccessBorder = false
            viewState = .showingResult(barcode)
        }
    }

    private func returnToScanner() {
        cameraId = UUID()
        viewState = .scanning
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ScannedBarcode.self, inMemory: true)
}
