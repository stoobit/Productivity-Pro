//
//  WhatIsNew.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.06.23.
//

import SwiftUI

struct WhatIsNew: View {
    
    @Environment(\.horizontalSizeClass) private var hsc
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Group {
                    Text("What's possible in ") +
                    Text("Productivity Pro")
                        .foregroundColor(
                            Color.accentColor
                        )
                }
                .font(.largeTitle.bold())
                .padding(.top)
                
                Spacer()
                
                NewItem(
                    icon: "app.gift",
                    iconColor: Color.accentColor,
                    header: "Everything",
                    text: "This is the first release of Productivity Pro, so basically everything is new."
                )
                
                NewItem(
                    icon: "app.gift",
                    iconColor: Color.accentColor,
                    header: "Everything",
                    text: "This is the first release of Productivity Pro, so basically everything is new."
                )
                
                NewItem(
                    icon: "app.gift",
                    iconColor: Color.accentColor,
                    header: "Everything",
                    text: "This is the first release of Productivity Pro, so basically everything is new."
                )
                
                NewItem(
                    icon: "app.gift",
                    iconColor: Color.accentColor,
                    header: "Everything",
                    text: "This is the first release of Productivity Pro, so basically everything is new."
                )
                
                Spacer()
                
                Button(action: { isPresented = false }) {
                    Text("Continue")
                        .font(.title2.bold())
                        .foregroundStyle(Color.white)
                        .frame(
                            width: buttonSize(size: proxy.size),
                            height: 60
                        )
                        .background(Color.accentColor)
                        .cornerRadius(16)
                }
                .padding(.bottom)
            }
            .padding()
            .position(
                x: proxy.size.width / 2,
                y: proxy.size.height / 2
            )
        }
    }
    
    @ViewBuilder func NewItem(
        icon: String,
        iconColor: Color,
        header: String,
        text: String
    ) -> some View {
        
        
        HStack {
            Image(systemName: icon)
                .foregroundStyle(iconColor)
                .font(.system(size: 60))
            
            VStack(alignment: .leading) {
                Text(header)
                    .font(.title3.bold())
                    .padding(.bottom, 1)
                
                Text(text)
                    .font(.body)
                    .foregroundStyle(Color.secondary)
            }
            .padding(.leading, 7)
            
        }
        .padding()
        
    }
    
    func buttonSize(size: CGSize) -> CGFloat {
        var width: CGFloat = .zero
        
        if hsc == .compact {
            width = size.width / 1.5
        } else {
            width = size.width / 1.8
        }
        
        return width
    }
    
}

struct win_Previews: PreviewProvider {
    static var previews: some View {
        Spacer()
            .sheet(isPresented: .constant(true)) {
                WhatIsNew(isPresented: .constant(true))
            }
    }
}



