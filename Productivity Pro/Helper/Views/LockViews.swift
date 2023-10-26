//
//  LockScreen.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 06.10.23.
//

import SwiftUI

struct LockScreen: ViewModifier {
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    
    func body(content: Content) -> some View {
        if isSubscribed {
            content
        } else {
            content
                .allowsHitTesting(false)
                .blur(radius: 20)
                .overlay {
                    Label("Premium", systemImage: "crown.fill")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Color.accentColor.gradient)
                }
        }
    }
}

struct LockButton: ViewModifier {
    @AppStorage("ppisunlocked")
    var isSubscribed: Bool = false
    
    func body(content: Content) -> some View {
        if isSubscribed {
            content
        } else {
            content
                .disabled(true)
        }
    }
}
