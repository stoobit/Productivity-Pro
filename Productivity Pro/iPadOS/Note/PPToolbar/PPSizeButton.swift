//
//  PPSizeButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.07.23.
//

import SwiftUI

struct PPSizeButton: View {
    @Environment(\.colorScheme) var cs
    
    @Binding var width: CGFloat
    @Binding var selectedWidth: CGFloat 
    
    var body: some View {
        
        Button(action: { selectedWidth = width }) {
            Circle()
                .frame(width: width, height: width)
                .foregroundStyle(
                    width == selectedWidth ? Color.accentColor : deselectedColor()
                )
                .font(.title3)
                .frame(width: 40, height: 40)
                .background(Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 9))
        }
    }
    
    func deselectedColor() -> Color {
        return cs == .dark ? .white : .black
    }
}
