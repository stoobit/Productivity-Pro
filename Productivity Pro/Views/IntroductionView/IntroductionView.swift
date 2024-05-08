//
//  IntroductionView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 08.05.24.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)

            IntroductionFirstView()
        }
    }
}

#Preview {
    IntroductionView()
}
