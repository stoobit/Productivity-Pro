//
//  VCardView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct VCardView: View {
    var proxy: GeometryProxy
    var vocab: PPVocabularyModel

    @State var showBack: Bool = false
    @Binding var active: PPVocabularyModel?
    
    var index: String
    var body: some View {
        ZStack {
            CardView(string: vocab.word)
                .modifier(FlipOpacity(percentage: showBack ? 0 : 1))
                .rotation3DEffect(Angle.degrees(showBack ? 180 : 360), axis: (1, 0, 0))

            CardView(string: vocab.translation)
                .modifier(FlipOpacity(percentage: showBack ? 1 : 0))
                .rotation3DEffect(Angle.degrees(showBack ? 0 : 180), axis: (1, 0, 0))
        }
        .onTapGesture {
            withAnimation {
                showBack.toggle()
            }
        }
        .onChange(of: active) {
            showBack = false
        }
    }

    @ViewBuilder func CardView(string: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(.background)

            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.accentColor, lineWidth: 3)

            HStack {
                Text(string)
                    .font(.title3)
            }
            
            Text(index)
                .foregroundStyle(Color.secondary)
                .font(.caption)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
        }
        .frame(
            width: proxy.size.width * 0.7,
            height: proxy.size.height * 0.7
        )
    }
}
