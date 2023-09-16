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
            Spacer()
            
            Menu(isPortrait ? "Hochformat" : "Querformat") {
                Picker("Format", selection: $isPortrait) {
                    Text("Hochformat")
                        .frame(width: 100)
                        .tag(true)
                    Text("Querformat").tag(false)
                        .frame(width: 100)
                        .tag(true)
                }
                
            }
            .foregroundStyle(Color.secondary)
        }
        .frame(height: 30)
    }
    
    @ViewBuilder 
    func ColorsView() -> some View {
        HStack {
            Text("Farbe")
            Spacer()
            
           
            ColorView(value: "pagewhite")
            ColorView(value: "pageyellow")
            ColorView(value: "pagegray")
            ColorView(value: "pageblack")
            
        }
        .frame(height: 30)
    }
    
    @ViewBuilder func ColorView(value: String) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(Color(value))
            
            Circle()
                .stroke(
                    selectedColor == value ? Color.accentColor : .secondary,
                    lineWidth: 2
                )
        }
        .frame(width: 30, height: 30, alignment: .trailing)
        .padding(.leading, 5)
        .onTapGesture {
            selectedColor = value
        }
    }
    
    @ViewBuilder 
    func TemplateView() -> some View {
        ScrollView(.horizontal) {
            HStack {
                TemplateItem(title: "Blanko", value: "blank", view: BackgroundViews().Blank())
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Kariert", value: "squared", view: BackgroundViews().Squared())
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Liniert Klein", value: "ruled", view: BackgroundViews().Ruled())
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Liniert Groß", value: "ruled.large", view: BackgroundViews().RuledLarge())
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Gepunktet", value: "dotted", view:BackgroundViews().Dotted())
                    .padding([.leading, .vertical], 30)
                TemplateItem(title: "Notentlinien", value: "music", view:BackgroundViews().Music())
                    .padding(30)
            }
        }
        .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    func TemplateItem(
        title: String, value: String, view: some View
    ) -> some View {
        ZStack {
            
            VStack {
                view
                    .frame(width: 250, height: 225)
                Spacer()
            }
            .frame(width: 250, height: 350)
            
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
                .frame(width: 250, height: 125, alignment: .bottom)
            }
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
                viewType: .create
            ) {
                
            }
        }
}

