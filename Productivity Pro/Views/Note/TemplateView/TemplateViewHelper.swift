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
    
    @ViewBuilder func ColorsView() -> some View {
        FormSpacer {
            HStack {
                
                Text("Color")
                
                Spacer()
                
                Toggle("White", isOn: .constant(true))
                    .toggleStyle(.button)
                
                Toggle("Yellow", isOn: .constant(true))
                    .toggleStyle(.button)
                
                Toggle("Grey", isOn: .constant(true))
                    .toggleStyle(.button)
                
                Toggle("Black", isOn: .constant(true))
                    .toggleStyle(.button)
                
            }
        }
    }
    
    @ViewBuilder func TemplateView() -> some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                
                TemplatePicker("blank", view: BackgroundViews().Blank())
                TemplatePicker("squared", view: BackgroundViews().Squared())
                TemplatePicker("dotted", view: BackgroundViews().Dotted())
                TemplatePicker("ruled", view: BackgroundViews().Ruled())
                TemplatePicker("ruled.large", view: BackgroundViews().RuledLarge())
                TemplatePicker("music", view: BackgroundViews().Music())
                
            }
        }
    }
    
    @ViewBuilder func TemplatePicker(_ value: String, view: some View) -> some View {
        VStack {
            
            view
            
            Image(systemName: selectedTemplate == value ? "checkmark.circle.fill" : "checkmark.circle"
            )
            .font(.title3)
            .foregroundStyle(
                selectedTemplate == value ? Color.accentColor : Color.secondary
            )
            .padding(.top, 10)
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedTemplate = value
        }
        .padding(10)
    }
    
}
