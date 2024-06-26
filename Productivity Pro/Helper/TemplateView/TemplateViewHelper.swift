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
            Text("Hochformat")
                .frame(width: 100)
                .tag(true)
            Text("Querformat").tag(false)
                .frame(width: 100)
                .tag(true)
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
        .padding(.leading, 10)
        .onTapGesture {
            selectedColor = value
        }
    }
    
    @ViewBuilder
    func TemplateView() -> some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal) {
                HStack {
                    TemplateItem(title: "Blanko", value: "blank", view: BackgroundViews().Blank())
                        .id("blank")
                    
                    TemplateItem(title: "Kariert", value: "squared", view: BackgroundViews().Squared())
                        .id("squared")
                    
                    TemplateItem(title: "Liniert Klein", value: "ruled", view: BackgroundViews().Ruled())
                        .id("ruled")
                    
                    TemplateItem(title: "Liniert Groß", value: "ruled.large", view: BackgroundViews().RuledLarge())
                        .id("ruled.large")
                    
                    TemplateItem(title: "Gepunktet", value: "dotted", view: BackgroundViews().Dotted())
                        .id("dotted")
                    
                    TemplateItem(title: "Notentlinien", value: "music", view: BackgroundViews().Music())
                        .id("music")
                }
                .onAppear {
                    reader.scrollTo(preselectedTemplate)
                }
            }
            .safeAreaPadding(8)
        }
        .listRowInsets(EdgeInsets())
    }

    @ViewBuilder
    func TemplateItem(
        title: LocalizedStringKey, value: String, view: some View
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
                        .imageScale(.medium)
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
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
    }
}
