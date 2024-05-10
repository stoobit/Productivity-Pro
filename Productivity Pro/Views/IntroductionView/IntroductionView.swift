//
//  IntroductionView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.05.24.
//

import SwiftUI

struct IntroductionView: View {
    @Binding var showIntro: Bool
    @State var index: Int? = 1

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)

            IntroductionFirstView(showIntro: $showIntro, index: $index)
                .containerRelativeFrame(.horizontal)
                .id(1)
        }
    }
}
