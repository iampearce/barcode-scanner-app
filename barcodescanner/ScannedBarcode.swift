//
//  ScannedBarcode.swift
//  barcodescanner
//
//  Created by George Pearce on 11/01/2026.
//

import Foundation
import SwiftData

@Model
final class ScannedBarcode {
    var value: String
    var symbology: String
    var timestamp: Date

    init(value: String, symbology: String, timestamp: Date = Date()) {
        self.value = value
        self.symbology = symbology
        self.timestamp = timestamp
    }

    var symbologyDisplayName: String {
        switch symbology {
        case "VNBarcodeSymbologyQR": return "QR Code"
        case "VNBarcodeSymbologyMicroQR": return "Micro QR"
        case "VNBarcodeSymbologyEAN13": return "EAN-13"
        case "VNBarcodeSymbologyEAN8": return "EAN-8"
        case "VNBarcodeSymbologyUPCE": return "UPC-E"
        case "VNBarcodeSymbologyCode128": return "Code 128"
        case "VNBarcodeSymbologyCode39": return "Code 39"
        case "VNBarcodeSymbologyCode39Checksum": return "Code 39"
        case "VNBarcodeSymbologyCode39FullASCII": return "Code 39"
        case "VNBarcodeSymbologyCode39FullASCIIChecksum": return "Code 39"
        case "VNBarcodeSymbologyCode93": return "Code 93"
        case "VNBarcodeSymbologyCode93i": return "Code 93i"
        case "VNBarcodeSymbologyAztec": return "Aztec"
        case "VNBarcodeSymbologyDataMatrix": return "Data Matrix"
        case "VNBarcodeSymbologyPDF417": return "PDF417"
        case "VNBarcodeSymbologyMicroPDF417": return "Micro PDF417"
        case "VNBarcodeSymbologyITF14": return "ITF-14"
        case "VNBarcodeSymbologyI2of5": return "Interleaved 2 of 5"
        case "VNBarcodeSymbologyI2of5Checksum": return "Interleaved 2 of 5"
        case "VNBarcodeSymbologyCodabar": return "Codabar"
        case "VNBarcodeSymbologyGS1DataBar": return "GS1 DataBar"
        case "VNBarcodeSymbologyGS1DataBarExpanded": return "GS1 DataBar Expanded"
        case "VNBarcodeSymbologyGS1DataBarLimited": return "GS1 DataBar Limited"
        case "VNBarcodeSymbologyMSIPlessey": return "MSI Plessey"
        default:
            return symbology.replacingOccurrences(of: "VNBarcodeSymbology", with: "")
        }
    }
}
