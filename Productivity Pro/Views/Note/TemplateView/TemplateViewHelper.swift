//
//  TemplateViewHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.07.23.
//

import SwiftUI

extension TemplateView {
    
    @ViewBuilder 
    func OrientationView() -> some View {
        HStack {
            Text("Format")
                .foregroundColor(.primary)
            Spacer()
            
            RectangleRotationIcon(isPortrait: isPortrait)
        }
        .foregroundStyle(Color.accentColor)
        .frame(height: 30)
        .onTapGesture {
            withAnimation(.bouncy) {
                isPortrait.toggle()
            }
        }
    }
    
    @ViewBuilder 
    func ColorsView() -> some View {
        HStack {
            Text("Farbe")
            Spacer()
            
            ColorView(V: "pagewhite", style: Color("pagewhite"))
            ColorView(V: "pageyellow", style: Color("pageyellow"))
            ColorView(V: "pagegray", style: Color("pagegray"))
            ColorView(V: "pageblack", style: Color("pageblack"))

        }
        .frame(height: 30)
    }
    
    @ViewBuilder 
    func ColorView(V: String, style: some ShapeStyle) -> some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(
                    selectedColor == V ? Color.accentColor : .secondary
                )
            
            Circle()
                .frame(width: 25, height: 25)
                .foregroundStyle(style)
        }
        .padding(.leading, 10)
        .onTapGesture {
            selectedColor = V
        }
    }
    
    @ViewBuilder 
    func TemplateView() -> some View {
        ScrollView(.horizontal) {
            HStack {
                TemplateItem(title: "Blanko", value: "blank")
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Kariert", value: "dotted")
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Liniert Klein", value: "ruled")
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Liniert Groß", value: "ruled.large")
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Gepunktet", value: "dotted")
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Notentlinien", value: "music")
                    .padding(30)
            }
        }
        .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    func TemplateItem(
        title: String, value: String
    ) -> some View {
        VStack {
            Spacer()
            
            ZStack {
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 9,
                    bottomTrailingRadius: 9,
                    topTrailingRadius: 0,
                    style: .circular
                )
                .foregroundStyle(.thickMaterial)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundStyle(Color.secondary)
                        .textCase(.uppercase)
                    
                    Text("Hoch- & Querformat")
                        .textCase(.uppercase)
                        .foregroundStyle(Color.secondary)
                        .font(.caption2)
                    
                    Spacer()
                    
                    Text("Productivity Pro")
                        .foregroundStyle(Color.accentColor.secondary)
                        .font(.caption)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .padding(10)
                
                Image(systemName: "checkmark.circle")
                    .font(.title3)
                    .foregroundStyle(
                        selectedTemplate == value ? .green : .secondary
                    )
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottomTrailing
                    )
                    .padding(10)
            }
            .frame(width: 250, height: 125)
        }
        .frame(width: 250, height: 350)
        .overlay {
            RoundedRectangle(cornerRadius: 9)
                .stroke(Color.accentColor, lineWidth: 2)
                .frame(width: 251, height: 350)
        }
        .onTapGesture {
            selectedTemplate = value
        }
        
    }
    
}

#Preview {
    Text("Hi")
        .sheet(isPresented: .constant(true)) {
            TemplateView(
                isPresented: .constant(true),
                isPortrait: .constant(false),
                selectedColor: .constant("pagewhite"),
                selectedTemplate: .constant("dotted"),
                viewType: .create,
                title: "Add Page"
            ) {
                
            }
        }
}

