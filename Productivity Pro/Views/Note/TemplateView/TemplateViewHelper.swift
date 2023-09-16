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
        Picker("Format", selection: $isPortrait) {
            Text("Hochformat").tag(true)
            Text("Querformat").tag(false)
        }
        .frame(height: 30)
    }
    
    @ViewBuilder 
    func ColorsView() -> some View {
        Picker("Farbe", selection: $selectedColor) {
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 30, height: 30)
                .foregroundStyle(Color("pagewhite"))
                .tag("pagewhite")
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.accentColor, lineWidth: 2.0)
                }
            
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 30, height: 30)
                .foregroundStyle(Color("pageyellow"))
                .tag("pageyellow")
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.accentColor, lineWidth: 2.0)
                }
            
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 30, height: 30)
                .foregroundStyle(Color("pagegray"))
                .tag("pagegray")
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.accentColor, lineWidth: 2.0)
                }
            
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 30, height: 30)
                .foregroundStyle(Color("pageblack"))
                .tag("pageblack")
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.accentColor, lineWidth: 2.0)
                }
        }
        .pickerStyle(.navigationLink)
        .frame(height: 30)
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
                viewType: .create,
                title: "Add Page"
            ) {
                
            }
        }
}

