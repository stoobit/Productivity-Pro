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
                .multilineTextAlignment(.center)
                .font(.largeTitle.bold())
                .padding(.top)
                
                Spacer()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        NewItem(
                            icon: "pencil.tip",
                            color: Color.accentColor,
                            header: "Apple Pencil",
                            text: "Use your Apple Pencil with the tools you know from other apps to capture your thoughts and highlight important information."
                        )
                        
                        NewItem(
                            icon: "square.on.circle.fill",
                            color: Color.green,
                            header: "Shapes",
                            text: "Enhance your note taking experience by adding shapes to visually represent and structure your notes."
                        )
                        
                        NewItem(
                            icon: "character.textbox",
                            color: .orange,
                            header: "Markdown",
                            text: "Use Markdown to easily write text and add style on the go without interrupting your typing flow."
                        )
                        
                        NewItem(
                            icon: "ellipsis.circle",
                            color: .primary,
                            header: "And much more...",
                            text: "Just get started and discover what else Productivity Pro has to offer."
                        )
                        
                    }
                }
                
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
                .padding(.vertical)
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
        color: Color,
        header: String,
        text: String
    ) -> some View {
        
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
                .font(.system(size: 50))
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
        }
        .padding()
        .padding(.vertical, 10)
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



