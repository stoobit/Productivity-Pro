//
//  PremiumBadge.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI

struct PremiumBadge: ViewModifier {
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    @AppStorage("ppispurchased") var isPurchased: Bool = false
    
    func body(content: Content) -> some View {
        if isSubscribed || isPurchased {
            content
        } else {
            content
                .badge(Text("Premium"))
        }
    }
}
