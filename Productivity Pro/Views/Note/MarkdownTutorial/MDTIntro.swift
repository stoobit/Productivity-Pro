//
//  MDTIntro.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.01.24.
//

import MarkdownUI
import SwiftUI

struct MDTIntro: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .foregroundStyle(Color.yellow.gradient)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(alignment: .leading) {
                Text("Markdown")
                    .font(.system(size: 40, weight: .bold))
                
                Text("Mit Markdown kannst du Text formatieren, ohne deinen Schreibfluss zu unterbrechen. Dazu musst du lediglich verschiedene Zeichen miteinander kombinieren. Klingt erstmal schwer, ist aber ganz leicht."
                )
            }
            .foregroundStyle(Color.yellow)
            .padding(75)
        }
    }
}

#Preview {
    MarkdownTutorialView()
}
