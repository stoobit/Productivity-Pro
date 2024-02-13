//
//  iPhoneInteraction.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.02.23.
//

import SwiftUI

struct iPhoneInteraction: ViewModifier {
    func body(content: Content) -> some View {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            content
                .disabled(true)
                .allowsHitTesting(false)
        } else {
            content
        }
    }
}
