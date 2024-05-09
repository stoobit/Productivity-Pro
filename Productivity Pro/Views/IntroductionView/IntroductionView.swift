//
//  IntroductionView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.05.24.
//

import SwiftUI

struct IntroductionView: View {
    @State var index: Int = 1

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)

            if index == 1 {
                IntroductionFirstView(index: $index)
                    .transition(.push(from: .trailing))
            } else if index == 2 {
                IntroductionFirstView(index: $index)
                    .transition(.push(from: .trailing))
            }
        }
    }
}

#Preview {
    IntroductionView()
}
