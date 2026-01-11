//
//  HistoryView.swift
//  barcodescanner
//
//  Created by George Pearce on 11/01/2026.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \ScannedBarcode.timestamp, order: .reverse) private var barcodes: [ScannedBarcode]

    var body: some View {
        NavigationStack {
            Group {
                if barcodes.isEmpty {
                    ContentUnavailableView(
                        "No Scan History",
                        systemImage: "barcode.viewfinder",
                        description: Text("Scanned barcodes will appear here")
                    )
                } else {
                    List {
                        ForEach(barcodes) { barcode in
                            Button {
                                UIPasteboard.general.string = barcode.value
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(barcode.value)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                        .lineLimit(1)

                                    HStack {
                                        Text(barcode.symbologyDisplayName)
                                        Text("•")
                                        Text(barcode.timestamp, format: .dateTime)
                                    }
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
                if !barcodes.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(barcodes[index])
            }
        }
    }
}
