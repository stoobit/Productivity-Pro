//
//  WhatIsNew.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.06.23.
//

import SwiftUI

struct WhatIsNew: View {
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    NewItem(
                        icon: "crown.fill",
                        color: Color.yellow,
                        header: "Premium",
                        text: "Erhalte Zugriff auf exklusive Features mit Productivity Premium."
                    )
                    
                    NewItem(
                        icon: "calendar",
                        color: Color.accentColor,
                        header: "Stundenplan",
                        text: "Erstelle einen Stundenplan und behalte deine Fächer im Überblick."
                    )
                    
                    NewItem(
                        icon: "speedometer",
                        color: Color.green,
                        header: "Performance",
                        text: "Erlebe Productivity Pro flüssiger und schneller als je zuvor."
                    )
                    
                }
            }
            .padding()
            .navigationTitle("Was ist neu?")
            
        }
    }
    
    @ViewBuilder func NewItem(
        icon: String,
        color: Color,
        header: String,
        text: String
    ) -> some View {
        
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
                .font(.system(size: 40))
                .frame(width: 80, alignment: .center)
                .padding(.trailing, 20)
            
            VStack(alignment: .leading) {
                Text(header)
                    .font(.title3.bold())
                    .padding(.bottom, 1)
                
                Text(text)
                    .font(.body)
                    .foregroundStyle(Color.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .padding(.vertical, 10)
    }
    
}

#Preview {
    NavigationStack {
        WhatIsNew()
    }
}
