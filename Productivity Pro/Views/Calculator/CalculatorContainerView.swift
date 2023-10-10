//
//  CalculatorContainerView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.05.23.
//

import SwiftUI

struct CalculatorContainerView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var hsc
    
    @State var calculator = Calculator()
    
    var body: some View {
        NavigationStack {
            Group {
                if hsc == .compact {
                    CompactCalculatorView(calculator: calculator) { size in
                        SolutionView(with: size)
                    }
                } else if hsc == .regular {
                    RegularCalculatorView(calculator: calculator) { size in
                        SolutionView(with: size)
                    }
                }
            }
            .toolbarRole(.editor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") { dismiss() }
                        .keyboardShortcut(
                            .return, modifiers: [.command]
                        )
                }
                
                ToolbarItem(placement: .navigation) {
                    Group {
                        Text("Powered by ") +
                        Text("Pi")
                            .foregroundColor(.accentColor)
                    }
                }
                
            }
        }
    }
    
    @ViewBuilder func SolutionView(with size: CGSize) -> some View {
        
    }
    
}

struct CalculatorContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorContainerView()
    }
}
