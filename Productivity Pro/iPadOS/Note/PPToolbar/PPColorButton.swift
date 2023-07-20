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
    
    @Binding var selectedValue: Int
    var value: Int
    
    @State var showPicker: Bool = false
    
    var hsc: UserInterfaceSizeClass?
    var size: CGSize
    
    var body: some View {
        Button(action: {
            if selectedColor == color && selectedValue == value {
                showPicker = true
            } else {
                selectedColor = color
                selectedValue = value
            }
        }) {
                
            Image(
                systemName: isSelected() ? "square.fill" : "square"
            )
            .foregroundStyle(color)
            .font(.title3)
            .frame(width: 40, height: 40)
            .background(Color.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 9))
            
        }
        .colorPickerSheet(
            isPresented: $showPicker,
            selection: $color,
            supportsAlpha: true
        )
        .onChange(of: color) { color in
            selectedColor = color
        }

    }
    
    func isSelected() -> Bool {
        return color == selectedColor && selectedValue == value
    }
}
