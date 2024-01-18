//
//  MDTBasic.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.01.24.
//

import MarkdownUI
import SwiftUI

struct MDTBold: View {
    var body: some View {
        Markdown(
            """
            #### Fett `&` *Kursiv*
            Damit ein Wort, ein Satz oder ein ganzer Text **fett** ist,
            """
        )
        .markdownTheme(.productivitypro(
            name: UIFont.systemFont(ofSize: 9).familyName,
            size: 18.6 / 2,
            color: Color.white.data(),
            code: false
        ))
        .padding(50)
    }
}

#Preview {
    MarkdownTutorialView()
}
