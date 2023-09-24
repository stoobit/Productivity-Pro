//
//  PremiumBadge.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI

struct PremiumBadge: ViewModifier {
    @AppStorage("ppisunlocked")
    var isSubscribed: Bool = false
    
    func body(content: Content) -> some View {
        content
            .badge(Text("Premium"))
    }
}

#Preview {
    TabView {
        Text("hi")
            .modifier(PremiumBadge())
            .tabItem {
                Image(systemName: "house")
            }
    }
}
