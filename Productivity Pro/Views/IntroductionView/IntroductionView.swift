//
//  IntroductionView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.05.24.
//

import SwiftUI

struct IntroductionView: View {
    @Binding var showIntro: Bool
    @Binding var index: Int?

    var body: some View {
        VStack {
            VStack {
                Text("Productivity Pro")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .dynamicTypeSize(.xxLarge)
                    
                Text("Productivity. Redefined.")
                    .foregroundStyle(Color.secondary)
                    .font(.title3)
            }
            .padding(.top, 30)
                
            Spacer()
                
            IntroductionLabelView()
                .overlay {}
                
            Spacer()
                
            HStack(spacing: 15) {
                Button(action: { showIntro.toggle() }) {
                    Text("Los geht's  \(Image(systemName: "arrow.right"))")
                        .font(.headline)
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
            }
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
