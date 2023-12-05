//
//  PVItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.12.23.
//

import SwiftUI

extension PremiumView {
    @ViewBuilder func PVItemView(with image: String) -> some View {
        Image(systemName: image)
            .font(.title2)
            .foregroundStyle(Color.white.gradient)
            .frame(width: 60, height: 60)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.accentColor.gradient)
            }
            .padding(10)
    }
}
