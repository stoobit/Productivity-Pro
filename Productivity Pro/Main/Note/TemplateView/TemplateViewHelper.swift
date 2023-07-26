//
//  TemplateViewHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.07.23.
//

import SwiftUI

extension TemplateView {
    
    @ViewBuilder func OrientationView() -> some View {
        FormSpacer {
            Button(action: {
                withAnimation(.spring()) {
                    isPortrait.toggle()
                }
            }) {
                HStack {
                    Text("Orientation")
                        .foregroundColor(.primary)
                    Spacer()
                    
                    RectangleRotationIcon(isPortrait: isPortrait)
                }
            }
        }
    }
    
    @ViewBuilder func ColorView() -> some View {
        Picker("", selection: $selectedColor) {
            Circle()
                .frame(width: 25, height: 28)
                .foregroundColor(Color("pagewhite"))
                .tag("pagewhite")
                .padding(.vertical, 5)
                .overlay {
                    Circle()
                        .stroke(
                            Color.secondary,
                            lineWidth: 3
                        )
                }
            
            Circle()
                .frame(width: 25, height: 28)
                .foregroundColor(Color("pageyellow"))
                .tag("pageyellow")
                .padding(.vertical, 5)
                .overlay {
                    Circle()
                        .stroke(
                            Color.secondary,
                            lineWidth: 3
                        )
                }
            
            Circle()
                .frame(width: 25, height: 28)
                .foregroundColor(Color("pagegray"))
                .tag("pagegray")
                .padding(.vertical, 5)
                .overlay {
                    Circle()
                        .stroke(
                            Color.secondary,
                            lineWidth: 3
                        )
                }
            
            Circle()
                .frame(width: 25, height: 28)
                .foregroundColor(Color("pageblack"))
                .tag("pageblack")
                .padding(.vertical, 5)
                .overlay {
                    Circle()
                        .stroke(
                            Color.secondary,
                            lineWidth: 3
                        )
                }
        }
        .pickerStyle(.inline)
        .labelsHidden()
    }
    
    @ViewBuilder func TemplateView() -> some View {
        
    }
    
}
