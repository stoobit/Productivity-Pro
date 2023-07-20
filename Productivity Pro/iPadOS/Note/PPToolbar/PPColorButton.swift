//
//  PPColorButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.07.23.
//

import SwiftUI

struct PPColorButton: View {
    
    @Binding var color: Color
    @Binding var selectedColor: Color
    
    var body: some View {
        Button(action: { selectedColor = color }) {
                
            Image(
                systemName: color == selectedColor ? "square.fill" : "square"
            )
            .foregroundStyle(color)
            .font(.title3)
            .frame(width: 40, height: 40)
            .background(Color.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 9))
            
        }
    }
}

struct ColorButton_Preview: PreviewProvider {
    static var previews: some View {
        PPColorButton(
            color: .constant(.accentColor),
            selectedColor: .constant(.accentColor)
        )
    }
}

