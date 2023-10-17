//
//  NoteSideMainAction.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.10.23.
//

import SwiftUI

extension NoteSecondaryToolbar {
    @ViewBuilder func MainAction() -> some View {
        if toolManager.activeItem == nil {
            Button("Rechner", systemImage: "x.squareroot") {
                showCalculator.toggle()
            }
            .popover(isPresented: $showCalculator) {
                CalculatorView()
                    .frame(width: 300, height: 400)
                    .presentationCompactAdaptation(.popover)
            }
            
        } else {
            Button("Inspektor", systemImage: "paintbrush.pointed") {
                subviewManager.showInspector.toggle()
            }
        }
    }
    
}
