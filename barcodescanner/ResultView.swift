//
//  ResultView.swift
//  barcodescanner
//
//  Created by George Pearce on 11/01/2026.
//

import SwiftUI

struct ResultView: View {
    let barcode: ScannedBarcode
    let onScanAgain: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)

            Text(barcode.symbologyDisplayName)
                .font(.headline)
                .foregroundColor(.secondary)

            Text(barcode.value)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .textSelection(.enabled)
                .padding(.horizontal)

            HStack {
                Image(systemName: "doc.on.doc.fill")
                Text("Copied to clipboard")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.top, 8)

            Spacer()

            Button(action: onScanAgain) {
                Label("Scan Again", systemImage: "barcode.viewfinder")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
    }
}
