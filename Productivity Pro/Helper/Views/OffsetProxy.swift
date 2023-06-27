//
//  OffsetProxy.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.06.23.
//

import SwiftUI

struct OffsetProxy: View {
    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: OffsetKey.self, value: proxy.frame(in: .global).minX)
        }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
