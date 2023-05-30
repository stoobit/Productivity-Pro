//
//  OrientationUpdater.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.11.22.
//

import SwiftUI

struct OrientationUpdater: ViewModifier {
    
    @Binding var isPortrait: Bool
    
    func body(content: Content) -> some View {
        if isPortrait {
            content
        } else {
            content
        }
    }
}

