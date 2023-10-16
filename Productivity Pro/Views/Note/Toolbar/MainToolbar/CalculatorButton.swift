//
//  CalculatorButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.10.23.
//

import SwiftUI

extension NoteMainToolbar {
    
    @ViewBuilder func CalculatorButton() -> some View {
        Button(action: { subviewManager.showCalculator.toggle() }) {
            Label("Rechner", systemImage: "x.squareroot")
                .modifier(PremiumBadge())
        }
    }
    
}
