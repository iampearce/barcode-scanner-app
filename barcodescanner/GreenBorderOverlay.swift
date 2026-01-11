//
//  GreenBorderOverlay.swift
//  barcodescanner
//
//  Created by George Pearce on 11/01/2026.
//

import SwiftUI

struct GreenBorderOverlay: View {
    let isVisible: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .stroke(Color.green, lineWidth: 8)
            .ignoresSafeArea()
            .opacity(isVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.15), value: isVisible)
    }
}
