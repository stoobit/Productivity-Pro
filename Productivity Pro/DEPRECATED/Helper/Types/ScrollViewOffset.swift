//
//  ScrollView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.11.22.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
