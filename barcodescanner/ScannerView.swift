//
//  ScannerView.swift
//  barcodescanner
//
//  Created by George Pearce on 11/01/2026.
//

import SwiftUI
import VisionKit

struct ScannerView: View {
    @Binding var cameraId: UUID
    let showSuccessBorder: Bool
    let onBarcodeScanned: (String, String) -> Void
    let onHistoryTapped: () -> Void

    var body: some View {
        ZStack {
            if DataScannerViewController.isSupported {
                if DataScannerViewController.isAvailable {
                    DataScannerRepresentable(onBarcodeScanned: onBarcodeScanned)
                        .id(cameraId)
                        .ignoresSafeArea()
                } else {
                    cameraUnavailableView
                }
            } else {
                unsupportedDeviceView
            }

            VStack {
                HStack {
                    Button {
                        onHistoryTapped()
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.title2)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }

                    Spacer()

                    Button {
                        cameraId = UUID()
                    } label: {
                        Image(systemName: "camera.rotate")
                            .font(.title2)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                }
                .padding()

                Spacer()
            }

            GreenBorderOverlay(isVisible: showSuccessBorder)
        }
    }

    private var cameraUnavailableView: some View {
        VStack(spacing: 16) {
            Image(systemName: "camera.fill")
                .font(.system(size: 60))
                .foregroundColor(.secondary)

            Text("Camera Access Required")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Please allow camera access in Settings to scan barcodes.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
    }

    private var unsupportedDeviceView: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange)

            Text("Device Not Supported")
                .font(.title2)
                .fontWeight(.semibold)

            Text("This device does not support barcode scanning.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}
