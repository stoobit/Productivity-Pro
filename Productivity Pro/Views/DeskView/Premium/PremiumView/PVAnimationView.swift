//
//  PVAnimationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.12.23.
//

import SwiftUI

extension PremiumView {
    @ViewBuilder func PVAnimationView() -> some View {
        VStackLayout(spacing: 0) {
            InfiniteScroller(
                contentWidth: CGFloat(images.count * (80)), isReverse: false
            ) {
                ForEach(images, id: \.self) { image in
                    PVItemView(with: image)
                }
            }
            .padding(5)
            
            InfiniteScroller(
                contentWidth: CGFloat(images.count * (80)), isReverse: true
            ) {
                ForEach(images.sorted(by: { $0 < $1 }), id: \.self) { image in
                    PVItemView(with: image)
                }
            }
        }
    }
}
