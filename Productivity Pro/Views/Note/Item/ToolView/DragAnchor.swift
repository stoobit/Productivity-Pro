//
//  DragAnchor.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.05.23.
//

import SwiftUI

struct DragAnchor: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .overlay {
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(
                        width: 10,
                        height: 10
                    )
            }
            .foregroundColor(color)
            .frame(width: 12, height: 12)
            .clipShape(Circle())
    }
}
