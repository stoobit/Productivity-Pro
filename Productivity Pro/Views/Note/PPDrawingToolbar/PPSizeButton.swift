//
//  PPSizeButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.07.23.
//

import SwiftUI

struct PPSizeButton: View {
    @Environment(\.colorScheme) var cs
    
    @Binding var width: Double
    @Binding var selectedWidth: Double
    
    @Binding var selectedValue: Int
    var value: Int
    
    @State var showPicker: Bool = false
    
    var body: some View {
        
        Button(action: {
            if selectedWidth == width && selectedValue == value {
                showPicker = true
            } else {
                selectedWidth = width
                selectedValue = value
            }
        }) {
            Circle()
                .frame(width: width * 1.5, height: width * 1.5)
                .foregroundStyle(
                    isSelected() ? Color.accentColor : deselectedColor()
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
    
    func isSelected() -> Bool {
        return width == selectedWidth && value == selectedValue
    }
}
