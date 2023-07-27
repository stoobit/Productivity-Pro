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
        ViewThatFits(in: .horizontal) {
            HStack {
                Text("Color")
                Spacer()
                
                ColorView("pagewhite")
                ColorView("pageyellow")
                ColorView("pagegray")
                ColorView("pageblack")
                
            }
            
            HStack {
                ColorView("pagewhite")
                ColorView("pageyellow")
                ColorView("pagegray")
                ColorView("pageblack")
            }
        }
        .padding(.top, 5)
    }
    
    @ViewBuilder func ColorView(_ color: String) -> some View {
        VStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .stroke(Color.secondary, lineWidth: 5)
                    .frame(width: 50, height: 50)
                
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .foregroundStyle(Color(color))
                    .frame(width: 50, height: 50)
            }
            
            
            Image(systemName: selectedColor == color ? "checkmark.circle.fill" : "checkmark.circle"
            )
            .font(.title3)
            .foregroundStyle(
                selectedColor == color ? Color.accentColor : Color.secondary
            )
            .padding(.top, 10)
            
        }
        .onTapGesture {
            selectedColor = color
        }
        .padding(.horizontal, 10)
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
