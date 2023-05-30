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
    
    var body: some View {
        NavigationStack {
            Group {
                if hsc == .compact {
                    CompactCalculatorView()
                } else if hsc == .regular {
                    
                }
            }
            .toolbarRole(.editor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigation) {
                    Group {
                        Text("Powered by ") +
                        Text("Turtle Maths")
                            .foregroundColor(.pink)
                    }
                }
            }
        }
    }
}

struct CalculatorContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorContainerView()
    }
}
