//
//  LTabIndicator.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct LTabIndicator: View {
    @Environment(\.horizontalSizeClass) var hsc
    @Binding var selection: String
    
    var body: some View {
        HStack {
            Item(title: "Grammatik", image: "text.word.spacing")
               
            Item(title: "Vokabeln", image: "textformat.abc")
            
            Item(title: "Geschichte", image: "clock")
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(.thinMaterial)
        }
    }
    
    @ViewBuilder func Item(title: String, image: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11.5)
                .foregroundStyle(.background)
            
            if hsc == .regular {
                Label(title, systemImage: image)
                    .foregroundStyle(selection == title ? Color.accentColor : Color.primary)
            } else {
                Image(systemName: image)
                    .foregroundStyle(selection == title ? Color.accentColor : Color.primary)
            }
        }
        .frame(width: hsc == .regular ? 180 : 45, height: 45)
        .onTapGesture(perform: {
            selection = title
        })
    }
}

#Preview {
    LTabIndicator(selection: .constant("Geschichte"))
}
