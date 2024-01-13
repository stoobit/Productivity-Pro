//
//  MDTIntro.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.01.24.
//

import SwiftUI

struct MDTIntro: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Markdown")
                .font(.system(size: 40, weight: .bold))

            Text("Mit Markdown kannst du Text formatieren, ohne deinen Schreibfluss zu unterbrechen. Dazu musst du lediglich verschiedene Zeichen miteinander kombinieren. Klingt erstmal schwer, ist aber ganz leicht."
            )
            .font(.headline)
        }
        .foregroundStyle(Color.white)
        .padding(75)
    }
}

#Preview {
    MarkdownTutorialView()
}
