//
//  PVScrollView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.12.23.
//

import SwiftUI

struct InfiniteScroller<Content: View>: View {
    var contentWidth: CGFloat
    var isReverse: Bool
    
    var content: (() -> Content)
    
    @State var xOffset: CGFloat = 0
    
    var body: some View {
        let degrees: CGFloat = isReverse ? 180 : 0
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                content()
                    .rotation3DEffect(
                        .degrees(degrees), axis: (x: 0, y: 1, z: 0)
                    )
                
                content()
                    .rotation3DEffect(
                        .degrees(degrees), axis: (x: 0, y: 1, z: 0)
                    )
                
                content()
                    .rotation3DEffect(
                        .degrees(degrees), axis: (x: 0, y: 1, z: 0)
                    )
            }
            .offset(x: xOffset, y: 0)
        }
        .scrollClipDisabled()
        .scrollDisabled(true)
        .onAppear {
            withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                xOffset = -contentWidth
            }
        }
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
    }
}

