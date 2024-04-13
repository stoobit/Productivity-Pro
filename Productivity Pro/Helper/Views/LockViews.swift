//
//  LockScreen.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 06.10.23.
//

import SwiftUI

struct LockScreen: ViewModifier {
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    @State var showPremium: Bool = false

    func body(content: Content) -> some View {
        if isUnlocked {
            content
        } else {
            content
                .allowsHitTesting(false)
                .blur(radius: 20)
                .overlay {
                    Button(action: { showPremium.toggle() }) {
                        Label("Premium", systemImage: "crown.fill")
                            .font(.largeTitle.bold())
                            .foregroundStyle(Color.accentColor.gradient)
                    }
                }
        }
    }
}

struct LockButton: ViewModifier {
    @AppStorage("ppisunlocked")
    var isUnlocked: Bool = false

    func body(content: Content) -> some View {
        if isUnlocked {
            content
        } else {
            content
                .disabled(true)
        }
    }
}
