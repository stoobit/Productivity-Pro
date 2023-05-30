//
//  PagingModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.04.23.
//

import SwiftUI

struct TabViewPagingModifier: ViewModifier {
    
    let isPagingEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(isPagingEnabled ? false : true)
    }
}
