//
//  VCardView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct VCardView: View {
    var proxy: GeometryProxy
    var vocab: VocabModel

    @State var showBack: Bool = false
    @Binding var active: VocabModel

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

            Text(string)
                .font(.title3)
        }
        .frame(
            width: proxy.size.width * 0.7,
            height: proxy.size.height * 0.7
        )
    }
}
