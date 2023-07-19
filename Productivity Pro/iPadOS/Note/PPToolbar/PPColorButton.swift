//
//  PPColorButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

struct PPColorButton: View {
    
    var color: Color
    @Binding var selectedColor: Color
    
    var body: some View {
        Button(action: { selectedColor = color }) {
                
            if color == selectedColor {
                RoundedRectangle(cornerRadius: 9)
                    .foregroundStyle(color)
                    .frame(width: 40, height: 40)
            } else {
                RoundedRectangle(cornerRadius: 9)
                    .strokeBorder(
                        lineWidth: 6, antialiased: true
                    )
                    .foregroundStyle(color)
                    .frame(width: 40, height: 40)
            }
            
        }
    }
}

struct ColorButton_Preview: PreviewProvider {
    static var previews: some View {
        PPColorButton(color: .accentColor, selectedColor: .constant(.accentColor))
    }
}

