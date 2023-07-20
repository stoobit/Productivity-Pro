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
    
    @State var showPicker: Bool = false
    
    var hsc: UserInterfaceSizeClass?
    var size: CGSize
    
    var body: some View {
        Button(action: {
            if selectedColor != color {
                selectedColor = color
            } else {
                showPicker = true
            }
        }) {
                
            Image(
                systemName: color == selectedColor ? "square.fill" : "square"
            )
            .foregroundStyle(color)
            .font(.title3)
            .frame(width: 40, height: 40)
            .background(Color.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 9))
            
        }
        .popover(isPresented: $showPicker) {
            PPColorPicker(
                color: $color,
                isPresented: $showPicker,
                hsc: hsc,
                size: size
            )
        }
        .onChange(of: color) { color in
            selectedColor = color
        }

    }
}
