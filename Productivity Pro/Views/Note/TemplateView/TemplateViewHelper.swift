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
        Button(action: {
            withAnimation(.spring()) {
                isPortrait.toggle()
            }
        }) {
            HStack {
                Text("Format")
                    .foregroundColor(.primary)
                Spacer()
                
                RectangleRotationIcon(isPortrait: isPortrait)
            }
        }
        .frame(height: 30)
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
        .padding(.horizontal, 5)
        .onTapGesture {
            selectedColor = V
        }
    }
    
    @ViewBuilder 
    func TemplateView() -> some View {
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

